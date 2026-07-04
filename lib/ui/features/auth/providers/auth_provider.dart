import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../data/repositories/firebase_auth_repository_impl.dart';
import '../../../../data/providers.dart';
import '../../../../domain/models/user_profile.dart';
import '../../../../domain/repositories/user_repository.dart';

// Provides the auth state directly from Firebase
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

// Provides the AuthRepository instance
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepositoryImpl();
});

// AsyncNotifier for handling login/register actions
class AuthNotifier extends AsyncNotifier<void> {
  late final AuthRepository _authRepository;
  late final UserRepository _userRepository;

  @override
  FutureOr<void> build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _userRepository = ref.watch(userRepositoryProvider);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepository.loginWithEmail(email, password);
    });
  }

  Future<void> register(String email, String password, String name) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final userCred = await _authRepository.registerWithEmail(email, password, name);
      if (userCred.user != null) {
        try {
          await _initializeFirestoreProfile(userCred.user!, name: name);
          // Force logout after registration to require manual login
          await FirebaseAuth.instance.signOut();
        } catch (e) {
          // ROLLBACK: Delete Auth user because Firestore initialization failed
          await userCred.user!.delete();
          throw Exception('Pendaftaran gagal saat menyiapkan database profil. Transaksi dibatalkan. Pastikan perangkat Anda terhubung ke internet.');
        }
      }
    });
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepository.signOut();
      await FacebookAuth.instance.logOut();
      await GoogleSignIn.instance.signOut();
    });
  }

  Future<void> loginWithGoogle({required bool isLoginMode}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final googleUser = await GoogleSignIn.instance.authenticate();
      
      final googleAuth = googleUser.authentication;
      
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCred = await _authRepository.signInWithGoogleCredential(credential);
      await _enforceLoginSignUpRules(userCred, isLoginMode);
    });
  }

  Future<void> loginWithFacebook({required bool isLoginMode}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken!.tokenString;
        final userCred = await _authRepository.signInWithFacebook(accessToken);
        await _enforceLoginSignUpRules(userCred, isLoginMode);
      } else {
        throw Exception(result.message ?? 'Gagal login dengan Facebook');
      }
    });
  }

  Future<void> _enforceLoginSignUpRules(UserCredential credential, bool isLoginMode) async {
    final isNewUser = credential.additionalUserInfo?.isNewUser ?? false;

    if (isLoginMode && isNewUser) {
      // User is trying to login, but account was just created because it didn't exist
      await credential.user?.delete();
      await FirebaseAuth.instance.signOut();
      throw Exception('Akun tidak ditemukan. Silakan Daftar (Sign Up) terlebih dahulu.');
    } else if (!isLoginMode && !isNewUser) {
      // User is trying to register, but account already exists
      await FirebaseAuth.instance.signOut();
      throw Exception('Akun sudah terdaftar. Silakan masuk (Login) menggunakan metode ini.');
    } else if (!isLoginMode && isNewUser) {
      // User successfully registered via social/phone
      if (credential.user != null) {
        try {
          await _initializeFirestoreProfile(credential.user!);
        } catch (e) {
          // ROLLBACK
          await credential.user!.delete();
          await FirebaseAuth.instance.signOut();
          throw Exception('Pendaftaran via sosial gagal saat menyiapkan database profil. Transaksi dibatalkan. Silakan coba lagi nanti.');
        }
      }
    }
  }

  Future<void> _initializeFirestoreProfile(User user, {String? name}) async {
    final displayName = name ?? user.displayName ?? 'Pengguna Hondaku';
    final email = user.email ?? '';
    final phone = user.phoneNumber ?? '-';

    String initials = '';
    final names = displayName.trim().split(' ');
    if (names.isNotEmpty && names[0].isNotEmpty) {
      initials += names[0][0].toUpperCase();
      if (names.length > 1 && names[1].isNotEmpty) {
        initials += names[1][0].toUpperCase();
      }
    } else {
      initials = 'PH';
    }

    final newProfile = UserProfile(
      nama: displayName,
      username: email.isNotEmpty ? email.split('@').first : user.uid.substring(0, 5),
      email: email,
      phone: phone,
      nik: '-',
      avatarPath: user.photoURL ?? 'assets/images/profile.png',
      isCustomAvatar: user.photoURL != null,
      initials: initials,
    );

    await _userRepository.saveUserProfile(user.uid, newProfile);
  }

  Future<void> sendOtp({
    required String phoneNumber,
    required bool isLoginMode,
    required Function(String) onCodeSent,
    required Function(String) onError,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _authRepository.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-resolution on Android
          state = await AsyncValue.guard(() async {
            final userCred = await FirebaseAuth.instance.signInWithCredential(credential);
            await _enforceLoginSignUpRules(userCred, isLoginMode);
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          state = AsyncValue.error(e, StackTrace.current);
          onError(e.message ?? 'Gagal mengirim OTP');
        },
        codeSent: (String verificationId, int? resendToken) {
          state = const AsyncValue.data(null); // Reset state to non-loading
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Timeout
        },
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      onError('Terjadi gangguan saat memproses OTP. Silakan coba lagi nanti.');
    }
  }

  Future<void> verifyOtp({
    required String verificationId,
    required String smsCode,
    required bool isLoginMode,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final userCred = await _authRepository.signInWithPhoneCredential(verificationId, smsCode);
      await _enforceLoginSignUpRules(userCred, isLoginMode);
    });
  }
}

// Provider for AuthNotifier
final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, void>(() {
  return AuthNotifier();
});

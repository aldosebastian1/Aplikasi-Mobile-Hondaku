import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepositoryImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Gets the currently signed-in user, if any.
  User? get currentUser => _firebaseAuth.currentUser;

  /// Signs in a user with their [email] and [password].
  Future<UserCredential> loginWithEmail(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Gagal login: $e');
    }
  }

  /// Registers a new user with their [email], [password], and [name].
  Future<UserCredential> registerWithEmail(String email, String password, String name) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(name);
      return credential;
    } catch (e) {
      throw Exception('Gagal registrasi: $e');
    }
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Signs in a user using Google.
  Future<UserCredential> signInWithGoogleCredential(AuthCredential credential) async {
    try {
      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('Gagal verifikasi Google: $e');
    }
  }

  /// Signs in a user using Facebook.
  Future<UserCredential> signInWithFacebook(String accessToken) async {
    try {
      final AuthCredential credential = FacebookAuthProvider.credential(accessToken);
      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('Gagal verifikasi Facebook: $e');
    }
  }

  /// Starts the phone number verification process.
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  /// Signs in a user with a phone auth credential (verificationId + smsCode).
  Future<UserCredential> signInWithPhoneCredential(String verificationId, String smsCode) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('Gagal verifikasi OTP: $e');
    }
  }
}

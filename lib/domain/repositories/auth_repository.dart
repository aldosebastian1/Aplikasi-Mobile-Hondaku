import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  Future<UserCredential> loginWithEmail(String email, String password);
  Future<UserCredential> registerWithEmail(String email, String password, String name);
  Future<void> signOut();
  Future<UserCredential> signInWithGoogleCredential(AuthCredential credential);
  Future<UserCredential> signInWithFacebook(String accessToken);
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  });
  Future<UserCredential> signInWithPhoneCredential(String verificationId, String smsCode);
}

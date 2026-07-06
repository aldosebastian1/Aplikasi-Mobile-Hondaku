import 'package:firebase_auth/firebase_auth.dart';

class AppErrorHandler {
  static String getMessage(Object? error) {
    if (error == null) return 'Terjadi kesalahan tidak terduga.';
    
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'Email ini sudah terdaftar. Silakan gunakan email lain atau masuk.';
        case 'invalid-email':
          return 'Format email tidak valid.';
        case 'missing-email':
        case 'channel-error': // Sometimes thrown by firebase web/platforms for empty fields
          return 'Email tidak boleh kosong. Silakan masukkan email Anda.';
        case 'missing-password':
          return 'Kata sandi tidak boleh kosong. Silakan masukkan kata sandi.';
        case 'operation-not-allowed':
          return 'Operasi tidak diizinkan. Hubungi dukungan.';
        case 'weak-password':
          return 'Kata sandi terlalu lemah. Gunakan kata sandi yang lebih kuat.';
        case 'user-disabled':
          return 'Akun pengguna telah dinonaktifkan.';
        case 'user-not-found':
          return 'Akun tidak ditemukan. Silakan daftar terlebih dahulu.';
        case 'wrong-password':
          return 'Kata sandi salah. Silakan coba lagi.';
        case 'invalid-credential':
          return 'Email atau kata sandi yang Anda masukkan salah.';
        case 'network-request-failed':
          return 'Koneksi jaringan gagal. Periksa koneksi internet Anda.';
        case 'too-many-requests':
          return 'Terlalu banyak percobaan. Silakan coba lagi nanti.';
        default:
          return 'Terjadi kesalahan: ${error.message}';
      }
    }
    
    // For generic exception
    final errorStr = error.toString();
    if (errorStr.contains('Exception:')) {
      return errorStr.replaceAll('Exception:', '').trim();
    }
    return errorStr;
  }
}
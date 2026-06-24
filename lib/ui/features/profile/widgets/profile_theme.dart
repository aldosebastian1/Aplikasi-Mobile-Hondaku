import 'package:flutter/material.dart';

class ProfileThemeColors {
  final bool isDark;
  ProfileThemeColors(this.isDark);

  Color get red => isDark ? const Color(0xFFFF3E3E) : const Color(0xFFC40000);
  Color get background => isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5);
  Color get surface => isDark ? const Color(0xFF1E1E1E) : Colors.white;
  Color get textPrimary => isDark ? const Color(0xFFF5F5F5) : const Color(0xFF1F1F1F);
  Color get textSecondary => isDark ? const Color(0xFF9E9E9E) : const Color(0xFF757575);
  Color get border => isDark ? const Color(0xFF2E2E2E) : const Color(0xFFE9E9E9);
  Color get cardBorder => isDark ? const Color(0xFF2E2E2E) : const Color(0xFFEBEBEB);
  Color get tileBg => isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F3F3);
}

class ProfileLocalizations {
  final String language;
  ProfileLocalizations(this.language);

  bool get isEn => language == 'English';

  String get profileTitle => isEn ? 'Profile' : 'Profil';
  String get personalInfo => isEn ? 'Personal Information' : 'Informasi Pribadi';
  String get paymentMethods => isEn ? 'Payment Methods' : 'Metode Pembayaran';
  String get helpSupport => isEn ? 'Help & Support' : 'Bantuan & Dukungan';
  String get settings => isEn ? 'Settings' : 'Pengaturan';
  String get myGarage => isEn ? 'My Garage' : 'Garasi Saya';
  String get emptyGarage => isEn ? 'No vehicles yet' : 'Belum Ada Motor';
  String get activeOrder => isEn ? 'ACTIVE ORDER' : 'PESANAN AKTIF';
  String get startExploring => isEn ? 'Start exploring now' : 'Mulai eksplorasi sekarang';
  String get logout => isEn ? 'Log Out' : 'Keluar';
  
  // Personal Info
  String get fullName => isEn ? 'Full Name' : 'Nama Lengkap';
  String get username => isEn ? 'Username' : 'Username';
  String get email => isEn ? 'Email' : 'Email';
  String get phoneNumber => isEn ? 'Phone Number' : 'Nomor HP';
  String get nationalId => isEn ? 'National ID (NIK)' : 'NIK KTP';
  String get saveChanges => isEn ? 'Save Changes' : 'Simpan Perubahan';
  String get profileUpdated => isEn ? 'Profile successfully updated!' : 'Profil berhasil diperbarui!';
  
  // Payment
  String get savedPayment => isEn ? 'Saved Payment Methods' : 'Metode Pembayaran Tersimpan';
  String get addPayment => isEn ? 'Add Payment Method' : 'Tambah Metode Pembayaran';
  String get setAsDefault => isEn ? 'Set as Primary' : 'Jadikan Utama';
  String get remove => isEn ? 'Remove' : 'Hapus';
  
  // Help & Support
  String get contactUs => isEn ? 'Contact Our Support' : 'Hubungi Layanan Kami';
  String get popularFaq => isEn ? 'Popular Questions (FAQ)' : 'Pertanyaan Populer (FAQ)';
  String get searchFaqHint => isEn ? 'Search FAQ...' : 'Cari FAQ...';
  String get ticketTitle => isEn ? 'Submit a Support Ticket' : 'Kirim Tiket Bantuan';
  String get ticketCategory => isEn ? 'Category' : 'Kategori';
  String get ticketDescription => isEn ? 'Describe your issue...' : 'Jelaskan kendala Anda...';
  String get submitTicket => isEn ? 'Submit Ticket' : 'Kirim Tiket';
  
  // Settings
  String get appAndAccount => isEn ? 'App & Account' : 'Aplikasi & Akun';
  String get appNotifications => isEn ? 'App Notifications' : 'Notifikasi Aplikasi';
  String get notificationsDesc => isEn ? 'Receive real-time order status updates' : 'Dapatkan pemberitahuan status pesanan secara real-time';
  String get biometricLogin => isEn ? 'Biometric Login' : 'Login Biometrik';
  String get biometricDesc => isEn ? 'Use Face ID or Fingerprint to sign in' : 'Gunakan Face ID atau Sidik Jari untuk masuk';
  String get darkMode => isEn ? 'Dark Mode' : 'Mode Gelap (Dark Mode)';
  String get darkModeDesc => isEn ? 'Switch interface to dark theme' : 'Ubah tampilan antarmuka ke tema gelap';
  String get localization => isEn ? 'Localization' : 'Lokalisasi';
  String get languageLabel => isEn ? 'Language' : 'Bahasa';
}

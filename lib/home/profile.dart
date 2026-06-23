import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/aktivitas_item.dart';
import '../ui/features/home/view_models/aktivitas_view_model.dart';
import 'aktivitas_store.dart';
import '../data/garage_data.dart';
import '../booking/status_pesanan_page.dart';
import '../auth/login_screen.dart';
import 'user_store.dart';
import '../ui/core/toast/hondaku_toast.dart';


// ─────────────────────────────────────────────────────────────
// DESIGN SCHEMES & LOCALIZATION
// ─────────────────────────────────────────────────────────────

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

// ─────────────────────────────────────────────────────────────
// PROFILE MAIN SCREEN
// ─────────────────────────────────────────────────────────────

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppSettings>(
      valueListenable: UserStore.settings,
      builder: (context, appSettings, _) {
        final isDark = appSettings.darkModeEnabled;
        final loc = ProfileLocalizations(appSettings.selectedLanguage);
        final theme = ProfileThemeColors(isDark);

        return Scaffold(
          backgroundColor: theme.background,
          body: SafeArea(
            top: false,
            child: Consumer(
              builder: (context, ref, _) {
                final allItems = ref.watch(aktivitasViewModelProvider);
                final activeOrders = allItems
                    .where((i) => i.status != StatusAktivitas.selesai && i.status != StatusAktivitas.ditolak)
                    .toList();
                final completedOrders = allItems
                    .where((e) => e.status == StatusAktivitas.selesai)
                    .toList();
                final myVehicle = completedOrders.isNotEmpty
                    ? GarageItem(
                        id: completedOrders.first.id,
                        name: completedOrders.first.namaMotor,
                        type: completedOrders.first.tipeUnit,
                        imagePath: completedOrders.first.imagePath,
                        category: 'DAILY RIDE',
                      )
                    : null;

                return ValueListenableBuilder<UserProfile>(
                  valueListenable: UserStore.profile,
                  builder: (context, profileData, _) {

                    return Column(
                      children: [
                        _buildHeader(theme, loc),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 26),
                                _buildProfileHero(context, theme, profileData, loc),
                                const SizedBox(height: 32),
                                if (activeOrders.isNotEmpty) ...[
                                  _buildActiveOrderCard(context, theme, activeOrders.first, loc),
                                  const SizedBox(height: 20),
                                ],
                                if (myVehicle != null) ...[
                                  _buildGarageSection(context, theme, myVehicle, loc),
                                  const SizedBox(height: 24),
                                ],
                                _buildMenuSection(theme, loc),
                                const SizedBox(height: 14),
                                _buildLogoutButton(context, theme, loc),
                                const SizedBox(height: 14),
                                Text(
                                  'MEDAN V1.1.1 (BUILD 1082)',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isDark ? Colors.grey.shade600 : Colors.grey.shade500,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(ProfileThemeColors theme, ProfileLocalizations loc) {
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        border: Border(bottom: BorderSide(color: theme.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
          child: Row(
            children: [
              Text(
                'Hondaku',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: theme.red,
                  letterSpacing: -0.9,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: theme.isDark ? const Color(0xFF252525) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.isDark ? const Color(0xFF333333) : Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on, size: 12, color: theme.red),
                    const SizedBox(width: 4),
                    Text(
                      'OTR MEDAN',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: theme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              UserStore.buildReactiveAvatar(radius: 20, fontSize: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHero(BuildContext context, ProfileThemeColors theme, UserProfile profile, ProfileLocalizations loc) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showAvatarPicker(context, theme, loc),
          child: SizedBox(
            width: 124,
            height: 124,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.surface,
                    border: Border.all(color: theme.surface, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: theme.isDark ? 0.4 : 0.16),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: UserStore.buildReactiveAvatar(radius: 58, fontSize: 32),
                ),
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: theme.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.edit, size: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 22),
        Text(
          profile.nama,
          style: TextStyle(
            fontSize: 30,
            height: 1.0,
            fontWeight: FontWeight.w800,
            color: theme.textPrimary,
            letterSpacing: -1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '@${profile.username}',
          style: TextStyle(
            fontSize: 16,
            color: theme.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveOrderCard(BuildContext context, ProfileThemeColors theme, AktivitasItem order, ProfileLocalizations loc) {
    String statusText = '';
    double progressFactor = 0.1;
    Color statusBgColor = theme.isDark ? const Color(0xFF3E2D12) : const Color(0xFFFFF2DF);
    Color statusTextColor = theme.isDark ? const Color(0xFFFFB03A) : const Color(0xFFD97D00);

    switch (order.status) {
      case StatusAktivitas.bookingBerhasil:
        statusText = loc.isEn ? 'BOOKING SUCCESSFUL' : 'BOOKING BERHASIL';
        progressFactor = 0.20;
        break;
      case StatusAktivitas.verifikasiSales:
        statusText = loc.isEn ? 'SALES VERIFICATION' : 'VERIFIKASI SALES';
        progressFactor = 0.40;
        break;
      case StatusAktivitas.persiapanUnit:
        statusText = loc.isEn ? 'PREPARING UNIT' : 'PERSIAPAN UNIT';
        progressFactor = 0.60;
        break;
      case StatusAktivitas.pengiriman:
        statusText = loc.isEn ? 'DELIVERY' : 'PENGIRIMAN';
        progressFactor = 0.80;
        break;
      case StatusAktivitas.selesai:
        statusText = loc.isEn ? 'FINISHED' : 'SELESAI';
        progressFactor = 1.0;
        statusBgColor = theme.isDark ? const Color(0xFF143E24) : const Color(0xFFE5F6ED);
        statusTextColor = theme.isDark ? const Color(0xFF55C78A) : const Color(0xFF2B8F5C);
        break;
      case StatusAktivitas.ditolak:
        statusText = loc.isEn ? 'REJECTED' : 'DITOLAK';
        progressFactor = 1.0;
        statusBgColor = theme.isDark ? const Color(0xFF3F191D) : const Color(0xFFFDECEE);
        statusTextColor = theme.isDark ? const Color(0xFFFF6B76) : const Color(0xFFD32F2F);
        break;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => StatusPesananPage(item: order)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        decoration: BoxDecoration(
          color: theme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.cardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: theme.isDark ? 0.3 : 0.04),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.activeOrder,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: theme.textPrimary,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              order.namaMotor,
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: theme.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: order.tipe == TipeTransaksi.cash
                                  ? (theme.isDark ? const Color(0xFF142B3F) : Colors.blue.shade50)
                                  : (theme.isDark ? const Color(0xFF3F191D) : Colors.red.shade50),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              order.tipe == TipeTransaksi.cash ? 'CASH' : 'KREDIT',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: order.tipe == TipeTransaksi.cash
                                    ? (theme.isDark ? Colors.blue.shade400 : Colors.blue.shade700)
                                    : theme.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        order.tipeUnit,
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: statusTextColor,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.isDark ? const Color(0xFF222222) : const Color(0xFFFDFDFD),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: theme.border),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/Beat 1.png',
                    width: 74,
                    height: 58,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.local_shipping_outlined,
                    size: 20,
                    color: theme.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      order.status == StatusAktivitas.ditolak
                          ? (loc.isEn ? 'Order Cancelled' : 'Pesanan Dibatalkan')
                          : order.status == StatusAktivitas.bookingBerhasil
                          ? (loc.isEn ? 'Waiting for Payment' : 'Menunggu Pembayaran')
                          : (loc.isEn ? 'Delivery Estimate:\n2-3 Days' : 'Estimasi Pengiriman:\n2-3 Hari'),
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.15,
                        color: theme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: SizedBox(
                height: 6,
                child: Stack(
                  children: [
                    Container(color: theme.isDark ? const Color(0xFF333333) : const Color(0xFFE3E3E3)),
                    FractionallySizedBox(
                      widthFactor: progressFactor,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        color: order.status == StatusAktivitas.ditolak
                            ? Colors.grey
                            : theme.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'No. Ref: ${order.id}',
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.textSecondary,
                      fontFamily: 'monospace',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 44,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StatusPesananPage(item: order),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: Text(
                      loc.isEn ? 'Order Detail' : 'Detail Pesanan',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGarageSection(
    BuildContext context,
    ProfileThemeColors theme,
    GarageItem? item,
    ProfileLocalizations loc,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.myGarage,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: theme.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: item != null ? () => _showDigitalWarrantySheet(context, theme, item, loc) : null,
            child: Container(
              height: 164,
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: theme.isDark ? 0.3 : 0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  Expanded(
                    flex: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: theme.isDark ? const Color(0xFF3A1F25) : const Color(0xFFF7E9EC),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              item?.category ?? 'KOSONG',
                              style: TextStyle(
                                color: theme.isDark ? const Color(0xFFFF6688) : const Color(0xFFD61B43),
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item != null ? item.name : loc.emptyGarage,
                            style: TextStyle(
                              fontSize: 20,
                              height: 1.1,
                              fontWeight: FontWeight.w800,
                              color: theme.textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item != null ? item.type : loc.startExploring,
                            style: TextStyle(
                              fontSize: 13,
                              color: theme.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: theme.isDark
                              ? [const Color(0xFF111111), const Color(0xFF1E0A0A)]
                              : [const Color(0xFF1A1A1A), const Color(0xFF2D0B0B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: item != null
                              ? Image.asset(
                                  item.imagePath,
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center,
                                )
                              : Opacity(
                                  opacity: 0.3,
                                  child: Image.asset(
                                    'assets/images/Beat 1.png',
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDigitalWarrantySheet(
    BuildContext context,
    ProfileThemeColors theme,
    GarageItem item,
    ProfileLocalizations loc,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: theme.isDark ? const Color(0xFF444444) : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      loc.isEn ? 'Digital Service & Warranty Book' : 'Buku Servis & Garansi Digital',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: theme.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: theme.textSecondary,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.isDark ? const Color(0xFF252525) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.border),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        item.imagePath,
                        width: 70,
                        height: 56,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: theme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.type,
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                loc.isEn ? 'Vehicle Specifications' : 'Informasi Kendaraan',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: theme.textPrimary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 10),
              _buildSpecRow(theme, loc.isEn ? 'Plate Number' : 'Nomor Polisi', 'BK 1234 AAB'),
              _buildSpecRow(theme, loc.isEn ? 'Chassis Number' : 'Nomor Rangka', 'MH1JM811xKxxxxxxx'),
              _buildSpecRow(theme, loc.isEn ? 'Engine Number' : 'Nomor Mesin', 'JM81E1xxxxxx'),
              _buildSpecRow(
                theme,
                loc.isEn ? 'Warranty Period' : 'Masa Garansi',
                loc.isEn ? 'Active (Until June 2029)' : 'Aktif (s.d Juni 2029)',
                valueColor: Colors.green,
              ),
              const SizedBox(height: 24),
              Text(
                loc.isEn ? 'Periodic Service Coupon (KPB)' : 'Kupon Perawatan Berkala (KPB)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: theme.textPrimary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              _buildKpbTimelineItem(
                theme,
                loc.isEn ? 'KPB 1 (1,000 km / 2 Months)' : 'KPB 1 (1.000 km / 2 Bulan)',
                loc.isEn ? 'Completed on June 20, 2026' : 'Selesai pada 20 Juni 2026',
                isCompleted: true,
                isLast: false,
              ),
              _buildKpbTimelineItem(
                theme,
                loc.isEn ? 'KPB 2 (4,000 km / 4 Months)' : 'KPB 2 (4.000 km / 4 Bulan)',
                loc.isEn ? 'Available (Recommended: Sept 2026)' : 'Tersedia (Saran: Sept 2026)',
                isActive: true,
                isLast: false,
              ),
              _buildKpbTimelineItem(
                theme,
                loc.isEn ? 'KPB 3 (8,000 km / 8 Months)' : 'KPB 3 (8.000 km / 8 Bulan)',
                loc.isEn ? 'Not yet active' : 'Belum aktif',
                isLast: true,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    HondakuToastHelper.showInfo(
                      context,
                      loc.isEn ? 'Service booking feature is coming soon!' : 'Fitur booking servis segera hadir!',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.build_circle_outlined, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        loc.isEn ? 'Book Service Now' : 'Booking Servis Sekarang',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpecRow(ProfileThemeColors theme, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: theme.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: valueColor ?? theme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpbTimelineItem(
    ProfileThemeColors theme,
    String title,
    String subtitle, {
    bool isCompleted = false,
    bool isActive = false,
    bool isLast = false,
  }) {
    Color dotColor = Colors.grey.shade400;
    Widget dotChild = const SizedBox();
    if (isCompleted) {
      dotColor = Colors.green;
      dotChild = const Icon(Icons.check, size: 10, color: Colors.white);
    } else if (isActive) {
      dotColor = theme.red;
      dotChild = Container(
        width: 6,
        height: 6,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
                child: Center(child: dotChild),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? Colors.green.shade200 : Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: theme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.textSecondary,
                  ),
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(ProfileThemeColors theme, ProfileLocalizations loc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: theme.isDark ? 0.3 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _MenuTile(
            icon: Icons.person_outline,
            title: loc.personalInfo,
            destination: const InformasiPribadiPage(),
            theme: theme,
          ),
          _MenuTile(
            icon: Icons.payments_outlined,
            title: loc.paymentMethods,
            destination: const MetodePembayaranPage(),
            theme: theme,
          ),
          _MenuTile(
            icon: Icons.support_agent_outlined,
            title: loc.helpSupport,
            destination: const BantuanDukunganPage(),
            theme: theme,
          ),
          _MenuTile(
            icon: Icons.settings_outlined,
            title: loc.settings,
            destination: const PengaturanPage(),
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, ProfileThemeColors theme, ProfileLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.isDark ? const Color(0xFF3A1C1C) : const Color(0xFFF8ECEC),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          icon: Icon(Icons.logout, color: theme.red, size: 20),
          label: Text(
            loc.logout,
            style: TextStyle(
              color: theme.red,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  static void _showAvatarPicker(BuildContext context, ProfileThemeColors theme, ProfileLocalizations loc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loc.isEn ? 'Change Profile Photo' : 'Ubah Foto Profil',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: theme.textSecondary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.isDark ? const Color(0xFF2C2C2C) : const Color(0xFFFFF2F2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.photo_library, color: theme.red),
                  ),
                  title: Text(
                    loc.isEn ? 'Choose from Gallery' : 'Pilih dari Galeri',
                    style: TextStyle(fontWeight: FontWeight.bold, color: theme.textPrimary),
                  ),
                  subtitle: Text(
                    loc.isEn ? 'Simulate image selection & upload' : 'Simulasikan unggah foto dari Galeri',
                    style: TextStyle(fontSize: 12, color: theme.textSecondary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _showGalleryUploadSimulation(context);
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF3F4F6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.image, color: Colors.blue),
                  ),
                  title: Text(
                    loc.isEn ? 'Default Avatar' : 'Avatar Default',
                    style: TextStyle(fontWeight: FontWeight.bold, color: theme.textPrimary),
                  ),
                  subtitle: Text(
                    loc.isEn ? 'Use default app avatar profile' : 'Gunakan avatar default Hondaku',
                    style: TextStyle(fontSize: 12, color: theme.textSecondary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    UserStore.updateProfile(
                      nama: UserStore.profile.value.nama,
                      username: UserStore.profile.value.username,
                      email: UserStore.profile.value.email,
                      phone: UserStore.profile.value.phone,
                      nik: UserStore.profile.value.nik,
                      avatarPath: 'assets/images/profile.png',
                      isCustomAvatar: false,
                    );
                    HondakuToastHelper.showSuccess(
                      context,
                      loc.isEn ? 'Changed to default avatar' : 'Avatar diubah ke default',
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  loc.isEn ? 'Or Choose Custom Color Initial' : 'Atau Pilih Inisial Warna',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: theme.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildPresetOption(context, const Color(0xFFC40000), 'Crimson'),
                      _buildPresetOption(context, const Color(0xFF1E3A8A), 'Navy'),
                      _buildPresetOption(context, const Color(0xFF10B981), 'Emerald'),
                      _buildPresetOption(context, const Color(0xFFF59E0B), 'Amber'),
                      _buildPresetOption(context, const Color(0xFF8B5CF6), 'Purple'),
                      _buildPresetOption(context, const Color(0xFF6B7280), 'Slate'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildPresetOption(BuildContext context, Color color, String name) {
    final initials = UserStore.profile.value.initials;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          UserStore.updateProfile(
            nama: UserStore.profile.value.nama,
            username: UserStore.profile.value.username,
            email: UserStore.profile.value.email,
            phone: UserStore.profile.value.phone,
            nik: UserStore.profile.value.nik,
            avatarPath: '',
            isCustomAvatar: true,
            avatarBgColor: color,
          );
          HondakuToastHelper.showSuccess(context, 'Avatar warna $name diaktifkan!');
        },
        child: CircleAvatar(
          radius: 26,
          backgroundColor: color,
          child: Text(
            initials,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }

  static void _showGalleryUploadSimulation(BuildContext context) {
    final isDark = UserStore.settings.value.darkModeEnabled;
    final theme = ProfileThemeColors(isDark);
    final loc = ProfileLocalizations(UserStore.settings.value.selectedLanguage);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GalleryUploadDialog(theme: theme, loc: loc),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CUSTOM GALLERY UPLOAD STATEFUL DIALOG
// ─────────────────────────────────────────────────────────────

class GalleryUploadDialog extends StatefulWidget {
  final ProfileThemeColors theme;
  final ProfileLocalizations loc;

  const GalleryUploadDialog({
    super.key,
    required this.theme,
    required this.loc,
  });

  @override
  State<GalleryUploadDialog> createState() => _GalleryUploadDialogState();
}

class _GalleryUploadDialogState extends State<GalleryUploadDialog> {
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (mounted) {
        setState(() {
          _progress += 0.1;
          if (_progress >= 1.0) {
            _progress = 1.0;
            timer.cancel();
            UserStore.updateProfile(
              nama: UserStore.profile.value.nama,
              username: UserStore.profile.value.username,
              email: UserStore.profile.value.email,
              phone: UserStore.profile.value.phone,
              nik: UserStore.profile.value.nik,
              avatarPath: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=250&q=80',
              isCustomAvatar: false,
            );
            Navigator.pop(context);
            HondakuToastHelper.showSuccess(
              context,
              widget.loc.isEn ? 'Avatar uploaded successfully!' : 'Avatar berhasil diunggah!',
            );
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.theme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        widget.loc.isEn ? 'Simulating Upload' : 'Simulasi Unggah',
        style: TextStyle(color: widget.theme.textPrimary, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            value: _progress,
            backgroundColor: widget.theme.border,
            valueColor: AlwaysStoppedAnimation<Color>(widget.theme.red),
          ),
          const SizedBox(height: 16),
          Text(
            '${(_progress * 100).toInt()}%',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: widget.theme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.loc.isEn ? 'Reading file and uploading...' : 'Membaca file dan mengunggah...',
            style: TextStyle(color: widget.theme.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// MENU TILE COMPONENT
// ─────────────────────────────────────────────────────────────

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.title,
    required this.destination,
    required this.theme,
  });

  final IconData icon;
  final String title;
  final Widget destination;
  final ProfileThemeColors theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: theme.border)),
        ),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => destination),
            );
          },
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: theme.tileBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: theme.textPrimary, size: 21),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: theme.textPrimary,
            ),
          ),
          trailing: Icon(Icons.chevron_right, color: theme.textSecondary),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SUB-PAGE: PERSONAL INFORMATION (INFORMASI PRIBADI)
// ─────────────────────────────────────────────────────────────

class InformasiPribadiPage extends StatefulWidget {
  const InformasiPribadiPage({super.key});

  @override
  State<InformasiPribadiPage> createState() => _InformasiPribadiPageState();
}

class _InformasiPribadiPageState extends State<InformasiPribadiPage> {
  late TextEditingController _namaController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _nikController;

  @override
  void initState() {
    super.initState();
    final profile = UserStore.profile.value;
    _namaController = TextEditingController(text: profile.nama);
    _usernameController = TextEditingController(text: profile.username);
    _emailController = TextEditingController(text: profile.email);
    _phoneController = TextEditingController(text: profile.phone);
    _nikController = TextEditingController(text: profile.nik);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nikController.dispose();
    super.dispose();
  }

  void _saveProfile(ProfileLocalizations loc) {
    final nama = _namaController.text.trim();
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final nik = _nikController.text.trim();

    if (nama.isEmpty) {
      _showError(loc.isEn ? 'Name cannot be empty!' : 'Nama tidak boleh kosong!');
      return;
    }
    if (username.isEmpty) {
      _showError(loc.isEn ? 'Username cannot be empty!' : 'Username tidak boleh kosong!');
      return;
    }
    if (email.isEmpty || !email.contains('@')) {
      _showError(loc.isEn ? 'Please enter a valid email!' : 'Harap masukkan email yang valid!');
      return;
    }
    if (phone.isEmpty || phone.length < 9) {
      _showError(loc.isEn ? 'Please enter a valid phone number!' : 'Harap masukkan nomor HP yang valid!');
      return;
    }
    if (nik.length != 16) {
      _showError(loc.isEn ? 'NIK must be 16 digits!' : 'NIK harus berukuran 16 digit!');
      return;
    }

    UserStore.updateProfile(
      nama: nama,
      username: username,
      email: email,
      phone: phone,
      nik: nik,
      avatarPath: UserStore.profile.value.avatarPath,
      isCustomAvatar: UserStore.profile.value.isCustomAvatar,
      avatarBgColor: UserStore.profile.value.avatarBgColor,
    );

    HondakuToastHelper.showSuccess(context, loc.profileUpdated);
    Navigator.pop(context);
  }

  void _showError(String message) {
    HondakuToastHelper.showError(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppSettings>(
      valueListenable: UserStore.settings,
      builder: (context, settingsVal, _) {
        final isDark = settingsVal.darkModeEnabled;
        final theme = ProfileThemeColors(isDark);
        final loc = ProfileLocalizations(settingsVal.selectedLanguage);

        return Scaffold(
          backgroundColor: theme.background,
          appBar: AppBar(
            backgroundColor: theme.surface,
            elevation: 0.5,
            iconTheme: IconThemeData(color: theme.textPrimary),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: theme.textPrimary, size: 22),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              loc.personalInfo,
              style: TextStyle(color: theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ValueListenableBuilder<UserProfile>(
              valueListenable: UserStore.profile,
              builder: (context, userProfile, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: theme.surface, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: UserStore.buildReactiveAvatar(radius: 50, fontSize: 28),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () => ProfilePage._showAvatarPicker(context, theme, loc),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: theme.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildFieldLabel(loc.fullName, theme),
                    _buildTextField(_namaController, loc.fullName, theme),
                    const SizedBox(height: 16),
                    _buildFieldLabel(loc.username, theme),
                    _buildTextField(_usernameController, loc.username, theme),
                    const SizedBox(height: 16),
                    _buildFieldLabel(loc.email, theme),
                    _buildTextField(_emailController, loc.email, theme, keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 16),
                    _buildFieldLabel(loc.phoneNumber, theme),
                    _buildPhoneField(theme),
                    const SizedBox(height: 16),
                    _buildFieldLabel(loc.nationalId, theme),
                    _buildTextField(_nikController, loc.nationalId, theme, keyboardType: TextInputType.number),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _saveProfile(loc),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          elevation: 0,
                        ),
                        child: Text(
                          loc.saveChanges,
                          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldLabel(String label, ProfileThemeColors theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 2),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: theme.textSecondary,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    ProfileThemeColors theme, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 14, color: theme.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: theme.textSecondary.withValues(alpha: 0.5)),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildPhoneField(ProfileThemeColors theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: theme.border)),
            ),
            child: Text(
              '+62',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.textPrimary),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(fontSize: 14, color: theme.textPrimary),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SUB-PAGE: PAYMENT METHODS (METODE PEMBAYARAN)
// ─────────────────────────────────────────────────────────────

class MetodePembayaranPage extends StatelessWidget {
  const MetodePembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppSettings>(
      valueListenable: UserStore.settings,
      builder: (context, appSettings, _) {
        final isDark = appSettings.darkModeEnabled;
        final theme = ProfileThemeColors(isDark);
        final loc = ProfileLocalizations(appSettings.selectedLanguage);

        return Scaffold(
          backgroundColor: theme.background,
          appBar: AppBar(
            backgroundColor: theme.surface,
            elevation: 0.5,
            iconTheme: IconThemeData(color: theme.textPrimary),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: theme.textPrimary, size: 22),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              loc.paymentMethods,
              style: TextStyle(color: theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ValueListenableBuilder<List<PaymentMethodItem>>(
              valueListenable: UserStore.paymentMethods,
              builder: (context, methodsList, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.savedPayment,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.textPrimary),
                    ),
                    const SizedBox(height: 14),
                    if (methodsList.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Text(
                            loc.isEn ? 'No payment methods saved' : 'Belum ada metode pembayaran tersimpan',
                            style: TextStyle(color: theme.textSecondary),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: methodsList.length,
                          itemBuilder: (context, idx) {
                            final item = methodsList[idx];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildCardTile(context, item, theme, loc),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: theme.surface,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                            ),
                            builder: (context) {
                              return AddPaymentMethodSheet(theme: theme, loc: loc);
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: Text(
                          loc.addPayment,
                          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardTile(
    BuildContext context,
    PaymentMethodItem item,
    ProfileThemeColors theme,
    ProfileLocalizations loc,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.isDefault ? theme.red : theme.border,
          width: item.isDefault ? 1.8 : 1.0,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 52,
          height: 36,
          decoration: BoxDecoration(
            color: theme.isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.all(4),
          child: Image.asset(item.logoPath, fit: BoxFit.contain),
        ),
        title: Text(
          item.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: theme.textPrimary),
        ),
        subtitle: Text(
          item.isDefault ? (loc.isEn ? 'Primary Payment Method' : 'Metode Utama') : item.subtitle,
          style: TextStyle(fontSize: 12, color: item.isDefault ? theme.red : theme.textSecondary),
        ),
        trailing: item.isDefault
            ? Icon(Icons.check_circle, color: theme.red)
            : IconButton(
                icon: Icon(Icons.more_vert, color: theme.textSecondary),
                onPressed: () => _showPaymentOptions(context, item, theme, loc),
              ),
        onTap: () {
          if (!item.isDefault) {
            _showPaymentOptions(context, item, theme, loc);
          }
        },
      ),
    );
  }

  void _showPaymentOptions(
    BuildContext context,
    PaymentMethodItem item,
    ProfileThemeColors theme,
    ProfileLocalizations loc,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  item.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: theme.textPrimary),
                ),
              ),
              Divider(height: 1, color: theme.border),
              ListTile(
                leading: Icon(Icons.check_circle_outline, color: theme.red),
                title: Text(loc.setAsDefault, style: TextStyle(color: theme.textPrimary)),
                onTap: () {
                  UserStore.setDefaultPayment(item.id);
                  Navigator.pop(context);
                  HondakuToastHelper.showSuccess(
                    context,
                    loc.isEn ? 'Primary payment method updated!' : 'Metode pembayaran utama diperbarui!',
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: Text(loc.remove, style: const TextStyle(color: Colors.red)),
                onTap: () {
                  UserStore.removePaymentMethod(item.id);
                  Navigator.pop(context);
                  HondakuToastHelper.showSuccess(
                    context,
                    loc.isEn ? 'Payment method deleted!' : 'Metode pembayaran dihapus!',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// STATEFUL WIDGET: ADD PAYMENT METHOD SHEET
// ─────────────────────────────────────────────────────────────

class AddPaymentMethodSheet extends StatefulWidget {
  final ProfileThemeColors theme;
  final ProfileLocalizations loc;

  const AddPaymentMethodSheet({
    super.key,
    required this.theme,
    required this.loc,
  });

  @override
  State<AddPaymentMethodSheet> createState() => _AddPaymentMethodSheetState();
}

class _AddPaymentMethodSheetState extends State<AddPaymentMethodSheet> {
  String _selectedType = 'VA';
  String _selectedBank = 'BCA';
  final TextEditingController _numberController = TextEditingController();
  bool _isDefault = false;

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _submit() {
    final number = _numberController.text.trim();
    final loc = widget.loc;
    if (number.isEmpty) {
      _showErr(loc.isEn ? 'Account or Card number is required!' : 'Nomor kartu/VA wajib diisi!');
      return;
    }
    if (_selectedType == 'VA' && number.length < 8) {
      _showErr(loc.isEn ? 'Virtual Account number is too short!' : 'Nomor Virtual Account terlalu pendek!');
      return;
    }
    if (_selectedType == 'CARD' && number.length < 15) {
      _showErr(loc.isEn ? 'Credit Card number is invalid!' : 'Nomor kartu kredit tidak valid!');
      return;
    }

    String title = '';
    String logoPath = 'assets/payments/bca.png';
    if (_selectedType == 'VA') {
      title = '$_selectedBank Virtual Account';
      if (_selectedBank == 'MANDIRI') {
        logoPath = 'assets/payments/mandiri.png';
      } else if (_selectedBank == 'BSI') {
        logoPath = 'assets/payments/bsi.png';
      }
    } else {
      final last4 = number.substring(number.length - 4);
      title = 'Visa Ending in $last4';
      logoPath = 'assets/payments/bca.png';
    }

    final id = 'PM-${DateTime.now().millisecondsSinceEpoch}';
    final newItem = PaymentMethodItem(
      id: id,
      title: title,
      subtitle: _selectedType == 'VA' ? 'Bank $_selectedBank' : 'Credit/Debit Card',
      logoPath: logoPath,
      isDefault: _isDefault,
      type: _selectedType,
    );

    UserStore.addPaymentMethod(newItem);
    Navigator.pop(context);
    HondakuToastHelper.showSuccess(
      context,
      loc.isEn ? 'New payment method added!' : 'Metode pembayaran berhasil ditambahkan!',
    );
  }

  void _showErr(String msg) {
    HondakuToastHelper.showError(context, msg);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final loc = widget.loc;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  loc.addPayment,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textPrimary),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: theme.textSecondary),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTypeCard('VA', 'Virtual Account', Icons.account_balance),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTypeCard('CARD', loc.isEn ? 'Credit Card' : 'Kartu Kredit', Icons.credit_card),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_selectedType == 'VA') ...[
              Text(
                loc.isEn ? 'Select Bank' : 'Pilih Bank',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: theme.textSecondary),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedBank,
                    dropdownColor: theme.surface,
                    style: TextStyle(color: theme.textPrimary, fontSize: 14),
                    icon: Icon(Icons.keyboard_arrow_down, color: theme.textSecondary),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'BCA', child: Text('Bank BCA')),
                      DropdownMenuItem(value: 'MANDIRI', child: Text('Bank Mandiri')),
                      DropdownMenuItem(value: 'BSI', child: Text('Bank BSI')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedBank = val);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                loc.isEn ? 'Virtual Account Number' : 'Nomor Virtual Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: theme.textSecondary),
              ),
            ] else ...[
              Text(
                loc.isEn ? 'Card Number' : 'Nomor Kartu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: theme.textSecondary),
              ),
            ],
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 14, color: theme.textPrimary),
                decoration: InputDecoration(
                  hintText: _selectedType == 'VA' ? 'e.g. 800012345678' : 'e.g. 4111222233334444',
                  hintStyle: TextStyle(color: theme.textSecondary.withValues(alpha: 0.5)),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              activeThumbColor: theme.red,
              title: Text(
                loc.isEn ? 'Set as primary payment method' : 'Jadikan metode pembayaran utama',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.textPrimary),
              ),
              value: _isDefault,
              onChanged: (val) => setState(() => _isDefault = val),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 0,
                ),
                child: Text(
                  loc.isEn ? 'Save Payment' : 'Simpan Metode',
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeCard(String type, String title, IconData icon) {
    final theme = widget.theme;
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (theme.isDark ? const Color(0xFF3E1C1C) : const Color(0xFFFFF2F2))
              : theme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? theme.red : theme.border,
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? theme.red : theme.textSecondary, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? theme.red : theme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SUB-PAGE: HELP & SUPPORT (BANTUAN & DUKUNGAN)
// ─────────────────────────────────────────────────────────────

class BantuanDukunganPage extends StatefulWidget {
  const BantuanDukunganPage({super.key});

  @override
  State<BantuanDukunganPage> createState() => _BantuanDukunganPageState();
}

class _BantuanDukunganPageState extends State<BantuanDukunganPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, String>> _allFaqs = [
    {
      'q_id': 'Bagaimana cara membatalkan booking unit?',
      'q_en': 'How do I cancel my booking?',
      'a_id': 'Uang booking fee dapat dikembalikan penuh jika pembatalan diajukan sebelum proses persiapan unit selesai. Silakan hubungi Sales Consultant Anda.',
      'a_en': 'The booking fee can be fully refunded if the cancellation is submitted before unit preparation is complete. Please contact your Sales Consultant.',
    },
    {
      'q_id': 'Berapa lama proses pengiriman motor?',
      'q_en': 'How long does the motorcycle delivery take?',
      'a_id': 'Pengiriman untuk wilayah Medan biasanya memakan waktu 1-3 hari kerja setelah dokumen kredit diverifikasi atau pembayaran tunai diterima.',
      'a_en': 'Delivery for the Medan area usually takes 1-3 business days after credit documents are verified or cash payment is received.',
    },
    {
      'q_id': 'Apakah data KTP saya aman?',
      'q_en': 'Is my ID (KTP) data secure?',
      'a_id': 'Ya, seluruh informasi identitas Anda dilindungi dengan standar enkripsi perbankan dan hanya digunakan untuk keperluan pengurusan surat jalan STNK/BPKB.',
      'a_en': 'Yes, all your identity information is protected with banking-grade encryption standards and only used for processing STNK/BPKB registration.',
    },
    {
      'q_id': 'Bagaimana cara membayar Virtual Account?',
      'q_en': 'How do I pay via Virtual Account?',
      'a_id': 'Salin nomor Virtual Account yang tertera di detail pesanan Anda, buka aplikasi Mobile Banking Anda, pilih menu Transfer VA, tempel nomor, dan selesaikan pembayaran.',
      'a_en': 'Copy the Virtual Account number shown in your order details, open your Mobile Banking app, select Transfer VA, paste the number, and complete the payment.',
    },
    {
      'q_id': 'Bagaimana cara mendaftarkan motor ke garasi?',
      'q_en': 'How do I add a motorcycle to my garage?',
      'a_id': 'Motor yang Anda beli melalui aplikasi Hondaku akan secara otomatis terdaftar di garasi setelah status pengiriman selesai.',
      'a_en': 'Motorcycles purchased via the Hondaku app will be automatically registered to your garage once the delivery is marked as completed.',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _filteredFaqs(bool isEn) {
    if (_searchQuery.isEmpty) return _allFaqs;
    final query = _searchQuery.toLowerCase();
    return _allFaqs.where((faq) {
      final q = (isEn ? faq['q_en'] : faq['q_id'])!.toLowerCase();
      final a = (isEn ? faq['a_en'] : faq['a_id'])!.toLowerCase();
      return q.contains(query) || a.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppSettings>(
      valueListenable: UserStore.settings,
      builder: (context, appSettings, _) {
        final isDark = appSettings.darkModeEnabled;
        final theme = ProfileThemeColors(isDark);
        final loc = ProfileLocalizations(appSettings.selectedLanguage);
        final faqs = _filteredFaqs(loc.isEn);

        return Scaffold(
          backgroundColor: theme.background,
          appBar: AppBar(
            backgroundColor: theme.surface,
            elevation: 0.5,
            iconTheme: IconThemeData(color: theme.textPrimary),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: theme.textPrimary, size: 22),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              loc.helpSupport,
              style: TextStyle(color: theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(loc.contactUs, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.textPrimary)),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _buildContactCard(
                        context,
                        icon: Icons.phone_in_talk,
                        title: 'Call Center',
                        subtitle: '1-500-989',
                        onTap: () => _showDialerMock(context, '1-500-989', theme, loc),
                        theme: theme,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildContactCard(
                        context,
                        icon: Icons.chat,
                        title: 'WhatsApp Chat',
                        subtitle: '+62 812-3456-7890',
                        onTap: () => _showWhatsAppChatMock(context, theme, loc),
                        theme: theme,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(loc.popularFaq, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.textPrimary)),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: theme.surface,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          builder: (context) {
                            return SupportTicketSheet(theme: theme, loc: loc);
                          },
                        );
                      },
                      child: Text(
                        loc.isEn ? 'Submit Ticket' : 'Kirim Tiket',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: theme.red),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Custom Search Bar
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.border),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) => setState(() => _searchQuery = val),
                    style: TextStyle(color: theme.textPrimary, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: loc.searchFaqHint,
                      hintStyle: TextStyle(color: theme.textSecondary.withValues(alpha: 0.5), fontSize: 14),
                      prefixIcon: Icon(Icons.search, size: 18, color: theme.textSecondary),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (faqs.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Text(
                        loc.isEn ? 'No matching questions' : 'Pertanyaan tidak ditemukan',
                        style: TextStyle(color: theme.textSecondary),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: faqs.length,
                    itemBuilder: (context, idx) {
                      final item = faqs[idx];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _buildFaqItem(
                          loc.isEn ? item['q_en']! : item['q_id']!,
                          loc.isEn ? item['a_en']! : item['a_id']!,
                          theme,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required ProfileThemeColors theme,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: theme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: theme.isDark ? 0.2 : 0.02),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: theme.red, size: 32),
            const SizedBox(height: 12),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: theme.textPrimary)),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(fontSize: 11, color: theme.textSecondary), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer, ProfileThemeColors theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.border),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: theme.red,
          collapsedIconColor: theme.textSecondary,
          title: Text(
            question,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: theme.textPrimary),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                answer,
                style: TextStyle(fontSize: 12, color: theme.textSecondary, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialerMock(BuildContext context, String number, ProfileThemeColors theme, ProfileLocalizations loc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                backgroundColor: theme.red,
                child: const Icon(Icons.support_agent, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 20),
              const Text(
                'Hondaku Care',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                number,
                style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                loc.isEn ? 'Dialing...' : 'Menghubungi...',
                style: const TextStyle(color: Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.call_end, color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showWhatsAppChatMock(BuildContext context, ProfileThemeColors theme, ProfileLocalizations loc) {
    final messageController = TextEditingController();
    final listScrollController = ScrollController();
    final List<Map<String, dynamic>> mockMessages = [
      {
        'sender': 'agent',
        'text': loc.isEn
            ? 'Hello! Welcome to Hondaku Care Medan. How can we help you today?'
            : 'Halo! Selamat datang di Customer Care Hondaku Medan. Ada yang bisa kami bantu hari ini?',
        'time': 'Just now',
      }
    ];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setChatState) {
            return Dialog(
              backgroundColor: theme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: SizedBox(
                height: 450,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: const BoxDecoration(
                        color: Color(0xFF075E54),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.support_agent, color: Color(0xFF075E54)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hondaku Care Support',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                Text(
                                  loc.isEn ? 'Online' : 'Aktif',
                                  style: const TextStyle(color: Colors.greenAccent, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white, size: 20),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: theme.isDark ? const Color(0xFF151515) : const Color(0xFFECE5DD),
                        padding: const EdgeInsets.all(12),
                        child: ListView.builder(
                          controller: listScrollController,
                          itemCount: mockMessages.length,
                          itemBuilder: (context, index) {
                            final msg = mockMessages[index];
                            final isAgent = msg['sender'] == 'agent';
                            return Align(
                              alignment: isAgent ? Alignment.centerLeft : Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isAgent
                                      ? (theme.isDark ? const Color(0xFF242424) : Colors.white)
                                      : const Color(0xFFDCF8C6),
                                  borderRadius: BorderRadius.circular(12).copyWith(
                                    topLeft: isAgent ? Radius.zero : const Radius.circular(12),
                                    topRight: isAgent ? const Radius.circular(12) : Radius.zero,
                                  ),
                                ),
                                child: Text(
                                  msg['text'],
                                  style: TextStyle(
                                    color: isAgent && theme.isDark ? Colors.white : Colors.black87,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.surface,
                        border: Border(top: BorderSide(color: theme.border)),
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              style: TextStyle(color: theme.textPrimary, fontSize: 13),
                              decoration: InputDecoration(
                                hintText: loc.isEn ? 'Type a message...' : 'Ketik pesan...',
                                hintStyle: TextStyle(color: theme.textSecondary.withValues(alpha: 0.5), fontSize: 13),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send, color: Color(0xFF075E54)),
                            onPressed: () {
                              final text = messageController.text.trim();
                              if (text.isNotEmpty) {
                                setChatState(() {
                                  mockMessages.add({
                                    'sender': 'user',
                                    'text': text,
                                    'time': 'Just now',
                                  });
                                  messageController.clear();
                                });
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  if (listScrollController.hasClients) {
                                    listScrollController.animateTo(
                                      listScrollController.position.maxScrollExtent,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeOut,
                                    );
                                  }
                                });
                                Future.delayed(const Duration(milliseconds: 1200), () {
                                  if (context.mounted) {
                                    setChatState(() {
                                      mockMessages.add({
                                        'sender': 'agent',
                                        'text': loc.isEn
                                            ? 'Thank you for contacting us. An consultant will connect with you shortly.'
                                            : 'Terima kasih telah menghubungi. Consultant kami akan segera membalas chat Anda.',
                                        'time': 'Just now',
                                      });
                                    });
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      if (listScrollController.hasClients) {
                                        listScrollController.animateTo(
                                          listScrollController.position.maxScrollExtent,
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                        );
                                      }
                                    });
                                  }
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// STATEFUL WIDGET: SUBMIT SUPPORT TICKET
// ─────────────────────────────────────────────────────────────

class SupportTicketSheet extends StatefulWidget {
  final ProfileThemeColors theme;
  final ProfileLocalizations loc;

  const SupportTicketSheet({
    super.key,
    required this.theme,
    required this.loc,
  });

  @override
  State<SupportTicketSheet> createState() => _SupportTicketSheetState();
}

class _SupportTicketSheetState extends State<SupportTicketSheet> {
  String _category = 'Booking';
  final TextEditingController _descController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  void _submitTicket() {
    final desc = _descController.text.trim();
    if (desc.isEmpty) {
      HondakuToastHelper.showError(
        context,
        widget.loc.isEn ? 'Please describe your issue!' : 'Harap jelaskan kendala Anda!',
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: widget.theme.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  widget.loc.isEn ? 'Ticket Submitted' : 'Tiket Dikirim',
                  style: TextStyle(color: widget.theme.textPrimary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Text(
              widget.loc.isEn
                  ? 'Your support ticket has been submitted. Our team will contact you within 24 hours.'
                  : 'Tiket bantuan Anda telah terkirim. Tim Customer Care kami akan segera menghubungi Anda dalam 24 jam.',
              style: TextStyle(color: widget.theme.textPrimary),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK', style: TextStyle(color: widget.theme.red, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final loc = widget.loc;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                loc.ticketTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textPrimary),
              ),
              if (!_isSubmitting)
                IconButton(
                  icon: Icon(Icons.close, color: theme.textSecondary),
                  onPressed: () => Navigator.pop(context),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (_isSubmitting) ...[
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: CircularProgressIndicator(),
              ),
            ),
          ] else ...[
            Text(
              loc.ticketCategory,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: theme.textSecondary),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.border),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _category,
                  dropdownColor: theme.surface,
                  style: TextStyle(color: theme.textPrimary, fontSize: 14),
                  icon: Icon(Icons.keyboard_arrow_down, color: theme.textSecondary),
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(value: 'Booking', child: Text(loc.isEn ? 'Booking & Order' : 'Pemesanan & Booking')),
                    DropdownMenuItem(value: 'Pembayaran', child: Text(loc.isEn ? 'Payments' : 'Pembayaran')),
                    DropdownMenuItem(value: 'Pengiriman', child: Text(loc.isEn ? 'Unit Delivery' : 'Pengiriman Unit')),
                    DropdownMenuItem(value: 'Lainnya', child: Text(loc.isEn ? 'Others' : 'Pertanyaan Lainnya')),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _category = val);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              loc.isEn ? 'Description' : 'Deskripsi Masalah',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: theme.textSecondary),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _descController,
                maxLines: 4,
                style: TextStyle(fontSize: 14, color: theme.textPrimary),
                decoration: InputDecoration(
                  hintText: loc.ticketDescription,
                  hintStyle: TextStyle(color: theme.textSecondary.withValues(alpha: 0.5)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitTicket,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 0,
                ),
                child: Text(
                  loc.submitTicket,
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SUB-PAGE: SETTINGS (PENGATURAN)
// ─────────────────────────────────────────────────────────────

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppSettings>(
      valueListenable: UserStore.settings,
      builder: (context, appSettings, _) {
        final isDark = appSettings.darkModeEnabled;
        final theme = ProfileThemeColors(isDark);
        final loc = ProfileLocalizations(appSettings.selectedLanguage);

        return Scaffold(
          backgroundColor: theme.background,
          appBar: AppBar(
            backgroundColor: theme.surface,
            elevation: 0.5,
            iconTheme: IconThemeData(color: theme.textPrimary),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: theme.textPrimary, size: 22),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              loc.settings,
              style: TextStyle(color: theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                loc.appAndAccount,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.textSecondary),
              ),
              const SizedBox(height: 10),
              _buildSwitchTile(
                title: loc.appNotifications,
                subtitle: loc.notificationsDesc,
                value: appSettings.notifEnabled,
                onChanged: (v) {
                  UserStore.updateSettings(notifEnabled: v);
                },
                theme: theme,
              ),
              const SizedBox(height: 10),
              _buildSwitchTile(
                title: loc.biometricLogin,
                subtitle: loc.biometricDesc,
                value: appSettings.biometricEnabled,
                onChanged: (v) {
                  UserStore.updateSettings(biometricEnabled: v);
                  HondakuToastHelper.showSuccess(
                    context,
                    v
                        ? (loc.isEn ? 'Biometric login enabled!' : 'Login biometrik diaktifkan!')
                        : (loc.isEn ? 'Biometric login disabled!' : 'Login biometrik dinonaktifkan!'),
                  );
                },
                theme: theme,
              ),
              const SizedBox(height: 10),
              _buildSwitchTile(
                title: loc.darkMode,
                subtitle: loc.darkModeDesc,
                value: appSettings.darkModeEnabled,
                onChanged: (v) {
                  UserStore.updateSettings(darkModeEnabled: v);
                },
                theme: theme,
              ),
              const SizedBox(height: 24),
              Text(
                loc.localization,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.textSecondary),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: theme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.border),
                ),
                child: ListTile(
                  title: Text(loc.languageLabel, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: theme.textPrimary)),
                  subtitle: Text(appSettings.selectedLanguage, style: TextStyle(fontSize: 12, color: theme.textSecondary)),
                  trailing: Icon(Icons.chevron_right, color: theme.textSecondary),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: theme.surface,
                      builder: (context) {
                        return SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text('Bahasa Indonesia', style: TextStyle(color: theme.textPrimary)),
                                trailing: appSettings.selectedLanguage == 'Bahasa Indonesia' ? Icon(Icons.check, color: theme.red) : null,
                                onTap: () {
                                  UserStore.updateSettings(selectedLanguage: 'Bahasa Indonesia');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: Text('English', style: TextStyle(color: theme.textPrimary)),
                                trailing: appSettings.selectedLanguage == 'English' ? Icon(Icons.check, color: theme.red) : null,
                                onTap: () {
                                  UserStore.updateSettings(selectedLanguage: 'English');
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required ProfileThemeColors theme,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.border),
      ),
      child: SwitchListTile(
        activeThumbColor: theme.red,
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: theme.textPrimary)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: theme.textSecondary)),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

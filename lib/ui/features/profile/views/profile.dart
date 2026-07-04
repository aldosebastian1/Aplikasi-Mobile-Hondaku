import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/aktivitas_item.dart';
import '../../../../domain/models/garage_item.dart';
import '../../aktivitas/view_models/aktivitas_view_model.dart';
import '../view_models/profile_view_model.dart';
import '../../../core/widgets/hondaku_avatar.dart';
import 'package:hondaku/ui/core/widgets/hondaku_toast.dart';
import 'package:go_router/go_router.dart';
import '../widgets/profile_theme.dart';
import '../../auth/providers/auth_provider.dart';

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// PROFILE MAIN SCREEN
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final profileData = ref.watch(userProfileProvider);
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

    final isDark = false;
    final loc = ProfileLocalizations(appSettings.selectedLanguage);
    final theme = ProfileThemeColors(isDark);

    return Scaffold(
      backgroundColor: theme.background,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            _buildHeader(theme, loc),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 26),
                    _buildProfileHero(context, theme, profileData, loc, ref),
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
                    _buildLogoutButton(context, theme, loc, ref),
                    const SizedBox(height: 14),
                    Text(
                      'MEDAN V1.1.1 (BUILD 1082)',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
              const HondakuAvatar(radius: 20, fontSize: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHero(
    BuildContext context,
    ProfileThemeColors theme,
    UserProfile profile,
    ProfileLocalizations loc,
    WidgetRef ref,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => showAvatarPicker(context, theme, loc, ref),
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
                  child: const HondakuAvatar(radius: 58, fontSize: 32),
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
        context.push('/status-pesanan', extra: order);
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
                      context.push('/status-pesanan', extra: order);
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
                    HondakuToast.showInfo(
                      context,
                      loc.isEn ? 'Service booking feature is coming soon!' : 'Fitur booking servis segera hadir!',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    loc.isEn ? 'Book Service Now' : 'Booking Servis Sekarang',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
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
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? Colors.green
                        : isActive
                            ? theme.red
                            : (theme.isDark ? const Color(0xFF333333) : Colors.grey.shade300),
                    border: Border.all(
                      color: theme.surface,
                      width: 2,
                    ),
                  ),
                  child: isCompleted
                      ? const Icon(Icons.check, size: 8, color: Colors.white)
                      : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isCompleted
                          ? Colors.green
                          : (theme.isDark ? const Color(0xFF333333) : Colors.grey.shade300),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isActive ? theme.red : theme.textPrimary,
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
            path: '/profile/personal-info',
            theme: theme,
          ),
          _MenuTile(
            icon: Icons.favorite_border_rounded,
            title: 'Wishlist Motor',
            path: '/profile/favorites',
            theme: theme,
          ),
          _MenuTile(
            icon: Icons.payments_outlined,
            title: loc.paymentMethods,
            path: '/profile/payment-methods',
            theme: theme,
          ),
          _MenuTile(
            icon: Icons.support_agent_outlined,
            title: loc.helpSupport,
            path: '/profile/help',
            theme: theme,
          ),
          _MenuTile(
            icon: Icons.settings_outlined,
            title: loc.settings,
            path: '/profile/settings',
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, ProfileThemeColors theme, ProfileLocalizations loc, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton.icon(
          onPressed: () async {
            await ref.read(authNotifierProvider.notifier).signOut();
            if (context.mounted) {
              context.go('/login');
            }
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

  static void showAvatarPicker(BuildContext context, ProfileThemeColors theme, ProfileLocalizations loc, WidgetRef ref) {
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
                    _showGalleryUploadSimulation(context, ref);
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
                    final currentProfile = ref.read(userProfileProvider);
                    ref.read(userProfileProvider.notifier).updateProfile(
                      nama: currentProfile.nama,
                      username: currentProfile.username,
                      email: currentProfile.email,
                      phone: currentProfile.phone,
                      nik: currentProfile.nik,
                      avatarPath: 'assets/images/profile.png',
                      isCustomAvatar: false,
                    );
                    HondakuToast.showSuccess(
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
                      _buildPresetOption(context, const Color(0xFFC40000), 'Crimson', ref),
                      _buildPresetOption(context, const Color(0xFF1E3A8A), 'Navy', ref),
                      _buildPresetOption(context, const Color(0xFF10B981), 'Emerald', ref),
                      _buildPresetOption(context, const Color(0xFFF59E0B), 'Amber', ref),
                      _buildPresetOption(context, const Color(0xFF8B5CF6), 'Purple', ref),
                      _buildPresetOption(context, const Color(0xFF6B7280), 'Slate', ref),
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

  static Widget _buildPresetOption(BuildContext context, Color color, String name, WidgetRef ref) {
    final initials = ref.read(userProfileProvider).initials;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          final currentProfile = ref.read(userProfileProvider);
          ref.read(userProfileProvider.notifier).updateProfile(
            nama: currentProfile.nama,
            username: currentProfile.username,
            email: currentProfile.email,
            phone: currentProfile.phone,
            nik: currentProfile.nik,
            avatarPath: '',
            isCustomAvatar: true,
            avatarBgColor: color,
          );
          HondakuToast.showSuccess(context, 'Avatar warna $name diaktifkan!');
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

  static void _showGalleryUploadSimulation(BuildContext context, WidgetRef ref) {
    final appSettings = ref.read(appSettingsProvider);
    final isDark = false;
    final theme = ProfileThemeColors(isDark);
    final loc = ProfileLocalizations(appSettings.selectedLanguage);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GalleryUploadDialog(theme: theme, loc: loc),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// CUSTOM GALLERY UPLOAD STATEFUL DIALOG
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class GalleryUploadDialog extends ConsumerStatefulWidget {
  final ProfileThemeColors theme;
  final ProfileLocalizations loc;

  const GalleryUploadDialog({
    super.key,
    required this.theme,
    required this.loc,
  });

  @override
  ConsumerState<GalleryUploadDialog> createState() => _GalleryUploadDialogState();
}

class _GalleryUploadDialogState extends ConsumerState<GalleryUploadDialog> {
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
            final currentProfile = ref.read(userProfileProvider);
            ref.read(userProfileProvider.notifier).updateProfile(
              nama: currentProfile.nama,
              username: currentProfile.username,
              email: currentProfile.email,
              phone: currentProfile.phone,
              nik: currentProfile.nik,
              avatarPath: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=250&q=80',
              isCustomAvatar: false,
            );
            Navigator.pop(context);
            HondakuToast.showSuccess(
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

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// MENU TILE COMPONENT
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.title,
    required this.path,
    required this.theme,
  });

  final IconData icon;
  final String title;
  final String path;
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
          onTap: () => context.push(path),
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
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: theme.textPrimary,
            ),
          ),
          trailing: Icon(Icons.chevron_right, color: theme.textSecondary, size: 20),
        ),
      ),
    );
  }
}

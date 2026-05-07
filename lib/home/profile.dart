import 'package:flutter/material.dart';
import 'aktivitas_store.dart';
import '../data/garage_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const Color _red = Color(0xFFC40000);
  static const Color _background = Color(0xFFF5F5F5);
  static const Color _surface = Colors.white;
  static const Color _textPrimary = Color(0xFF1F1F1F);
  static const Color _textSecondary = Color(0xFF7A5E5E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        top: false,
        child: ValueListenableBuilder<List<AktivitasItem>>(
          valueListenable: AktivitasStore.items,
          builder: (context, allItems, _) {
            // Data aktif: Transaksi yang belum selesai
            final activeOrders = allItems.where((i) => i.status != StatusAktivitas.selesai).toList();
            // Data Garasi: Diambil dari store terpisah (hanya satu data sesuai instruksi)
            final myVehicle = GarageStore.myVehicle;

            return Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 26),
                        _buildProfileHero(),
                        const SizedBox(height: 32),
                        if (activeOrders.isNotEmpty) ...[
                          _buildActiveOrderCard(activeOrders.first),
                          const SizedBox(height: 20),
                        ],
                        _buildGarageSection(myVehicle),
                        const SizedBox(height: 24),
                        _buildMenuSection(),
                        const SizedBox(height: 14),
                        _buildLogoutButton(),
                        const SizedBox(height: 14),
                        Text(
                          'OTR JAKARTA V2.4.1 (BUILD 1082)',
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: _surface,
        border: Border(bottom: BorderSide(color: Color(0xFFE9E9E9))),
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
                  color: _red,
                  letterSpacing: -0.9,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on, size: 12, color: Color(0xFFC40000)),
                    const SizedBox(width: 4),
                    Text(
                      'OTR MEDAN',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFE9E9E9),
                backgroundImage: const AssetImage('assets/images/profile.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHero() {
    return Column(
      children: [
        SizedBox(
          width: 124,
          height: 124,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.16),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 58,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
              ),
              Positioned(
                right: 4,
                bottom: 4,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: _red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, size: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Alex Rider',
          style: TextStyle(
            fontSize: 34,
            height: 1.0,
            fontWeight: FontWeight.w800,
            color: _textPrimary,
            letterSpacing: -1.2,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'alex.rider',
          style: TextStyle(
            fontSize: 18,
            color: _textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveOrderCard(AktivitasItem order) {
    String statusText = '';
    double progressFactor = 0.1;
    Color statusBgColor = const Color(0xFFFFF2DF);
    Color statusTextColor = const Color(0xFFD97D00);

    switch (order.status) {
      case StatusAktivitas.menunggu:
        statusText = 'MENUNGGU';
        progressFactor = 0.15;
        break;
      case StatusAktivitas.diproses:
        statusText = 'DIPROSES';
        progressFactor = 0.35;
        break;
      case StatusAktivitas.diverifikasi:
        statusText = 'VERIFIKASI';
        progressFactor = 0.55;
        break;
      case StatusAktivitas.disetujui:
        statusText = 'DISETUJUI';
        progressFactor = 0.8;
        statusBgColor = const Color(0xFFE5F6ED);
        statusTextColor = const Color(0xFF2B8F5C);
        break;
      case StatusAktivitas.ditolak:
        statusText = 'DITOLAK';
        progressFactor = 1.0;
        statusBgColor = const Color(0xFFFDECEE);
        statusTextColor = const Color(0xFFD32F2F);
        break;
      default:
        statusText = 'PROSES';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF0E4E1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 7),
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
                    const Text(
                      'PESANAN AKTIF',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1A1A1A),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.namaMotor,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2B2B2B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      order.tipeUnit,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6A6A6A),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 12,
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
              color: const Color(0xFFFDFDFD),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF0F0F0)),
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
                const Icon(
                  Icons.local_shipping_outlined,
                  size: 20,
                  color: Color(0xFF8A8A8A),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    order.status == StatusAktivitas.ditolak 
                      ? 'Pesanan Dibatalkan'
                      : 'Estimasi Pengiriman:\n2-3 Hari',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.15,
                      color: Color(0xFF6A6A6A),
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
                  Container(color: const Color(0xFFE3E3E3)),
                  FractionallySizedBox(
                    widthFactor: progressFactor,
                    alignment: Alignment.centerLeft,
                    child: Container(color: order.status == StatusAktivitas.ditolak ? Colors.grey : _red),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _red,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: const Text(
                'Lacak Detail Pesanan',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGarageSection(GarageItem? item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Garasi Saya',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(), // Removed 'Lihat Semua' as requested
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 164,
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
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
                            color: const Color(0xFFF7E9EC),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            item?.category ?? 'KOSONG',
                            style: const TextStyle(
                              color: Color(0xFFD61B43),
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item?.name ?? 'Belum Ada\nMotor',
                          style: const TextStyle(
                            fontSize: 20,
                            height: 1.1,
                            fontWeight: FontWeight.w800,
                            color: _textPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item?.type ?? 'Mulai eksplorasi sekarang',
                          style: const TextStyle(
                            fontSize: 13,
                            color: _textSecondary,
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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1A1A1A), Color(0xFF2D0B0B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(18),
                        bottomRight: Radius.circular(18),
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
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Column(
        children: [
          _MenuTile(icon: Icons.person_outline, title: 'Informasi Pribadi'),
          _MenuTile(icon: Icons.payments_outlined, title: 'Metode Pembayaran'),
          _MenuTile(
            icon: Icons.support_agent_outlined,
            title: 'Bantuan & Dukungan',
          ),
          _MenuTile(icon: Icons.settings_outlined, title: 'Pengaturan'),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton.icon(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF8ECEC),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          icon: const Icon(Icons.logout, color: _red, size: 20),
          label: const Text(
            'Keluar',
            style: TextStyle(
              color: _red,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFF2F2F2))),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F3F3),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF1F1F1F), size: 21),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1F1F1F),
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Color(0xFF9A7F76)),
        ),
      ),
    );
  }
}

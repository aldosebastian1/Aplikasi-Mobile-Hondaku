import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../domain/models/aktivitas_item.dart';
import '../view_models/aktivitas_view_model.dart';
import '../../profile/stores/user_store.dart';


class AktivitasPage extends StatefulWidget {
  final VoidCallback? onProfileClick;
  final VoidCallback? onStartShopping;
  const AktivitasPage({super.key, this.onProfileClick, this.onStartShopping});

  @override
  State<AktivitasPage> createState() => _AktivitasPageState();
}

class _AktivitasPageState extends State<AktivitasPage>
    with SingleTickerProviderStateMixin {
  static const _red = Color(0xFFC40000);

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatTanggal(DateTime date) {
    const bulan = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return '${date.day} ${bulan[date.month]} ${date.year}';
  }

  _StatusStyle _getStatusStyle(StatusAktivitas status) {
    switch (status) {
      case StatusAktivitas.bookingBerhasil:
        return const _StatusStyle(
          'Booking Berhasil',
          Color(0xFFFFF3E0),
          Color(0xFFE65100),
        );
      case StatusAktivitas.verifikasiSales:
        return const _StatusStyle(
          'Verifikasi Sales',
          Color(0xFFE3F2FD),
          Color(0xFF0D47A1),
        );
      case StatusAktivitas.persiapanUnit:
        return const _StatusStyle(
          'Persiapan Unit (PDI)',
          Color(0xFFE3F2FD),
          Color(0xFF0D47A1),
        );
      case StatusAktivitas.pengiriman:
        return const _StatusStyle(
          'Sedang Dikirim',
          Color(0xFFE8EAF6),
          Color(0xFF1A237E),
        );
      case StatusAktivitas.selesai:
        return const _StatusStyle(
          'Selesai',
          Color(0xFFE8F5E9),
          Color(0xFF1B5E20),
        );
      case StatusAktivitas.ditolak:
        return const _StatusStyle(
          'Ditolak',
          Color(0xFFFFEBEE),
          Color(0xFFB71C1C),
        );
    }
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE9E9E9))),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
          child: Row(
            children: [
              const Text(
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
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on, size: 12, color: _red),
                    SizedBox(width: 4),
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
              GestureDetector(
                onTap: widget.onProfileClick,
                child: const HondakuAvatar(radius: 20, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _buildHeader(),
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: _red,
              unselectedLabelColor: Colors.grey.shade500,
              indicatorColor: _red,
              indicatorWeight: 3,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade500,
              ),
              tabs: const [
                Tab(text: 'Semua'),
                Tab(text: 'Cash'),
                Tab(text: 'Kredit'),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 0.5, color: Color(0xFFE9E9E9)),
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final allItems = ref.watch(aktivitasViewModelProvider);
                final cash = allItems
                    .where((e) => e.tipe == TipeTransaksi.cash)
                    .toList(growable: false);
                final kredit = allItems
                    .where((e) => e.tipe == TipeTransaksi.kredit)
                    .toList(growable: false);

                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildList(ref, allItems),
                    _buildList(ref, cash),
                    _buildList(ref, kredit),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(WidgetRef ref, List<AktivitasItem> list) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 800));
        final _ = ref.refresh(aktivitasViewModelProvider);
      },
      color: _red,
      backgroundColor: Colors.white,
      child: list.isEmpty
          ? SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 250,
                child: _buildEmptyState(),
              ),
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              itemBuilder: (_, i) => _buildCard(list[i]),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 48,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Belum ada aktivitas',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Riwayat pembelian dan pengajuan kredit kamu akan muncul di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (widget.onStartShopping != null) {
                  widget.onStartShopping!();
                } else {
                  context.go('/catalog');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Mulai Belanja',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(AktivitasItem item) {
    final statusStyle = _getStatusStyle(item.status);
    final isKredit = item.tipe == TipeTransaksi.kredit;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            context.push('/status-pesanan', extra: item);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Transaction Badge & Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isKredit ? Colors.blue.shade50 : Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isKredit ? 'Kredit' : 'Cash',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isKredit
                              ? Colors.blue.shade700
                              : Colors.green.shade700,
                        ),
                      ),
                    ),
                    Text(
                      _formatTanggal(item.tanggal),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Middle Row: Motor Image & Info
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Image.asset(
                        item.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.namaMotor,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.tipeUnit,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF757575),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Divider(height: 1, thickness: 0.5, color: Colors.grey.shade200),
                const SizedBox(height: 12),

                // Bottom Row: ID & Status Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.id,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF757575),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusStyle.bgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        statusStyle.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: statusStyle.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusStyle {
  final String label;
  final Color bgColor;
  final Color textColor;

  const _StatusStyle(this.label, this.bgColor, this.textColor);
}

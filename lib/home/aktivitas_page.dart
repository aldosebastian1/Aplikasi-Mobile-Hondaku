import 'package:flutter/material.dart';
import 'aktivitas_store.dart';
import 'catalog_page.dart';

class AktivitasPage extends StatefulWidget {
  const AktivitasPage({super.key});

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
      case StatusAktivitas.menunggu:
        return const _StatusStyle('Menunggu Konfirmasi', Colors.orange);
      case StatusAktivitas.diproses:
        return const _StatusStyle('Diproses', Colors.blue);
      case StatusAktivitas.diverifikasi:
        return const _StatusStyle('Dokumen Diverifikasi', Colors.blue);
      case StatusAktivitas.disetujui:
        return const _StatusStyle('Disetujui', Colors.green);
      case StatusAktivitas.ditolak:
        return const _StatusStyle('Ditolak', Colors.red);
      case StatusAktivitas.selesai:
        return const _StatusStyle('Selesai', Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Aktivitas',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFE9E9E9),
              backgroundImage: const AssetImage('assets/images/profile.png'),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: _red,
          unselectedLabelColor: Colors.grey,
          indicatorColor: _red,
          indicatorWeight: 2,
          labelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'Semua'),
            Tab(text: 'Cash'),
            Tab(text: 'Kredit'),
          ],
        ),
      ),
      body: ValueListenableBuilder<List<AktivitasItem>>(
        valueListenable: AktivitasStore.items,
        builder: (context, allItems, _) {
          final cash = allItems
              .where((e) => e.tipe == TipeTransaksi.cash)
              .toList(growable: false);
          final kredit = allItems
              .where((e) => e.tipe == TipeTransaksi.kredit)
              .toList(growable: false);

          return TabBarView(
            controller: _tabController,
            children: [
              _buildList(allItems),
              _buildList(cash),
              _buildList(kredit),
            ],
          );
        },
      ),
    );
  }

  Widget _buildList(List<AktivitasItem> list) {
    if (list.isEmpty) return _buildEmptyState();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (_, i) => _buildCard(list[i]),
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
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HalamanKatalog()),
                  (route) => route.isFirst,
                );
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
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isKredit ? Colors.blue.shade50 : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isKredit ? 'Kredit' : 'Cash',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isKredit
                        ? Colors.blue.shade700
                        : Colors.green.shade700,
                  ),
                ),
              ),
              Text(
                _formatTanggal(item.tanggal),
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            item.namaMotor,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            item.tipeUnit,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, thickness: 0.5),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.id,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusStyle.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusStyle.label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusStyle.color,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusStyle {
  final String label;
  final Color color;

  const _StatusStyle(this.label, this.color);
}

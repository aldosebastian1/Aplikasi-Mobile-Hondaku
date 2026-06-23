import 'package:flutter/material.dart';
import '../home/aktivitas_store.dart';
import '../core/hondaku_app.dart';

class KonfirmasiPesananPage extends StatefulWidget {
  final AktivitasItem item;

  const KonfirmasiPesananPage({super.key, required this.item});

  @override
  State<KonfirmasiPesananPage> createState() => _KonfirmasiPesananPageState();
}

class _KonfirmasiPesananPageState extends State<KonfirmasiPesananPage> {
  static const _red = Color(0xFFC40000);
  int _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Konfirmasi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Penerimaan unit dikonfirmasi otomatis saat unit telah sampai di lokasi Anda.'),
                  backgroundColor: _red,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(),
            const SizedBox(height: 24),
            _buildEstimasiDokumen(),
            const SizedBox(height: 24),
            _buildKelengkapanUnit(),
            const SizedBox(height: 24),
            _buildBeriPenilaian(),
            const SizedBox(height: 40),
            _buildBottomButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade300,
        image: DecorationImage(
          image: AssetImage(widget.item.imagePath),
          fit: BoxFit.contain, // Motor image usually has transparent bg, but let's use contain to not crop
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
            stops: const [0.4, 1.0],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check_circle, color: Colors.white, size: 14),
                  SizedBox(width: 6),
                  Text('Unit Diterima', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Selamat! Motor Anda Telah Tiba',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstimasiDokumen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Estimasi Dokumen', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        _buildDocCard('STNK & Plat Nomor', 'Proses pendaftaran', '7 Hari', Icons.description_outlined),
        const SizedBox(height: 12),
        _buildDocCard('BPKB Motor', 'Estimasi pengiriman', '20 Hari', Icons.menu_book_outlined),
      ],
    );
  }

  Widget _buildDocCard(String title, String subtitle, String days, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: _red, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(days, style: const TextStyle(color: _red, fontWeight: FontWeight.bold, fontSize: 14)),
              const Text('Kerja', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKelengkapanUnit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Kelengkapan Unit', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: [
            _buildGridItem('Unit Mulus & Tanpa\nLecet', Icons.verified_outlined),
            _buildGridItem('Buku Servis &\nGaransi', Icons.menu_book_outlined),
            _buildGridItem('Helm Honda\nGenuine', Icons.sports_motorsports_outlined),
            _buildGridItem('Jaket Exclusive\nHonda', Icons.checkroom_outlined),
          ],
        ),
      ],
    );
  }

  Widget _buildGridItem(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _red, size: 24),
          const Spacer(),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey.shade800, height: 1.3)),
        ],
      ),
    );
  }

  Widget _buildBeriPenilaian() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Text('Beri Penilaian', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                'Bagaimana pengalaman pembelian Anda dengan\nDealer Honda Medan?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600, height: 1.4),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final isFilled = index < _rating;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(
                        Icons.star,
                        color: isFilled ? Colors.amber : const Color(0xFFE0E0E0),
                        size: 38,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade50),
                ),
                child: TextField(
                  controller: _feedbackController,
                  maxLines: 3,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Tuliskan pesan untuk sales kami...',
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 20,
          child: Icon(Icons.thumb_up_alt_outlined, color: Colors.grey.shade300, size: 40),
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final message = _rating > 0
                    ? 'Terima kasih atas penilaian $_rating bintang! Pesanan Anda telah selesai dikonfirmasi.'
                    : 'Terima kasih! Pesanan Anda telah selesai dikonfirmasi.';

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HondakuApp(initialIndex: 0)),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text('Selesaikan Pesanan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Dengan menekan tombol, Anda mengonfirmasi unit telah\nditerima dengan baik.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600, height: 1.4),
          ),
        ],
      ),
    );
  }
}

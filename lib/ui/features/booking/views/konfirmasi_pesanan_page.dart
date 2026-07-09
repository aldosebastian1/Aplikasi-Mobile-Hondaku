import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hondaku/ui/core/widgets/hondaku_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/aktivitas_item.dart';
import '../view_models/review_view_model.dart';
import '../../../../domain/models/review.dart';

class KonfirmasiPesananPage extends ConsumerStatefulWidget {
  final AktivitasItem item;

  const KonfirmasiPesananPage({super.key, required this.item});

  @override
  ConsumerState<KonfirmasiPesananPage> createState() => _KonfirmasiPesananPageState();
}

class _KonfirmasiPesananPageState extends ConsumerState<KonfirmasiPesananPage> {
  static const _red = Color(0xFFC40000);
  int _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final reviewAsync = ref.watch(getReviewProvider(widget.item.id));
    final submittedReview = reviewAsync.value;
    final hasReviewed = submittedReview != null;

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
              HondakuToast.showInfo(context, 'Penerimaan unit dikonfirmasi otomatis saat unit telah sampai di lokasi Anda.');
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
            _buildBeriPenilaian(submittedReview),
            const SizedBox(height: 40),
            _buildBottomButton(hasReviewed),
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
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
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

  Widget _buildBeriPenilaian(Review? submittedReview) {
    if (submittedReview != null) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ulasan Anda', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  children: List.generate(5, (index) {
                    final isFilled = index < submittedReview.rating;
                    return Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.star,
                        color: isFilled ? Colors.amber : const Color(0xFFE0E0E0),
                        size: 24,
                      ),
                    );
                  }),
                ),
                if (submittedReview.komentar.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade50),
                    ),
                    child: Text(
                      submittedReview.komentar,
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 20,
            child: Icon(Icons.thumb_up_alt, color: Colors.green.shade400, size: 40),
          ),
        ],
      );
    }

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

  Widget _buildBottomButton(bool hasReviewed) {
    if (hasReviewed) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text('Kembali ke Halaman Utama', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      );
    }

    final submitState = ref.watch(reviewViewModelProvider);
    final isLoading = submitState.isLoading;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : () async {
                if (_rating == 0) {
                  HondakuToast.showInfo(context, 'Mohon berikan penilaian bintang terlebih dahulu');
                  return;
                }
                
                final success = await ref.read(reviewViewModelProvider.notifier).submitReview(
                      pesananId: widget.item.id,
                      motorId: widget.item.namaMotor,
                      namaMotor: widget.item.namaMotor,
                      rating: _rating,
                      komentar: _feedbackController.text,
                    );

                if (success && mounted) {
                  HondakuToast.showSuccess(context, 'Terima kasih atas penilaian $_rating bintang! Pesanan Anda telah selesai dikonfirmasi.');
                } else if (!success && mounted) {
                  HondakuToast.showError(context, 'Gagal mengirimkan ulasan, periksa koneksi internet Anda atau coba lagi.');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Text('Selesaikan Pesanan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
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

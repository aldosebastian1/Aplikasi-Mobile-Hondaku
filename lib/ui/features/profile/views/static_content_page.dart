import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StaticContentPage extends StatelessWidget {
  final String title;

  const StaticContentPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final isPrivacy = title.contains('Privasi');
    final sections = _getSections(isPrivacy);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Color(0xFF111111)),
          onPressed: () => context.pop(),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF111111),
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFFF0F0F0),
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isPrivacy ? 'Kebijakan Privasi' : 'Syarat & Ketentuan',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111111),
                letterSpacing: -0.5,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Terakhir Diperbarui: Juli 2026',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 40),
            ...sections.map((section) => _buildSection(section)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(_SectionData section) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
              letterSpacing: -0.3,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            section.content,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xFF444444),
              height: 1.7,
              letterSpacing: -0.1,
            ),
          ),
        ],
      ),
    );
  }

  List<_SectionData> _getSections(bool isPrivacy) {
    if (isPrivacy) {
      return [
        _SectionData(
          '1. Pengumpulan Data Pribadi',
          'Kami mengumpulkan informasi identitas Anda saat Anda mendaftar, melakukan pemesanan (booking), atau mengajukan kredit kendaraan. Data ini meliputi: Nama Lengkap (sesuai KTP), NIK, Alamat, Nomor Telepon, Email, dan Foto Dokumen.',
        ),
        _SectionData(
          '2. Penggunaan Informasi',
          'Data yang dikumpulkan secara eksklusif digunakan untuk keperluan administratif seperti memproses pembelian kendaraan bermotor, pengurusan surat-surat kendaraan (STNK & BPKB) ke pihak SAMSAT, serta pengajuan kelayakan kredit kendaraan kepada perusahaan pembiayaan (Leasing) rekanan.',
        ),
        _SectionData(
          '3. Pembagian Data ke Pihak Ketiga',
          'Hondaku berkomitmen penuh untuk tidak menjual data Anda. Namun, untuk memproses transaksi Anda, kami meneruskan data kepada Pihak Dealer Resmi Honda (ketersediaan unit), Perusahaan Pembiayaan (untuk pembelian kredit), dan Instansi Pemerintah (SAMSAT/Kepolisian).',
        ),
        _SectionData(
          '4. Keamanan Data & Penghapusan Akun',
          'Kami menggunakan sistem enkripsi standar industri untuk melindungi transmisi data Anda dari akses yang tidak sah. Anda juga berhak mengajukan penghapusan akun beserta seluruh data terkait kapan saja dengan menghubungi layanan pelanggan kami.',
        ),
      ];
    } else {
      return [
        _SectionData(
          '1. Ketentuan Umum',
          'Dengan mengakses dan menggunakan aplikasi Hondaku, Anda menyetujui untuk tunduk pada Syarat & Ketentuan ini. Aplikasi ini berfungsi sebagai platform digital pemesanan kendaraan bermotor Honda khusus untuk wilayah operasional OTR Medan dan sekitarnya.',
        ),
        _SectionData(
          '2. Harga & Spesifikasi',
          'Seluruh harga yang tertera adalah Harga On The Road (OTR) Medan dan bersifat tidak mengikat. Harga dan ketersediaan unit dapat berubah sewaktu-waktu tanpa pemberitahuan sebelumnya. Harga final yang berlaku adalah harga pada saat proses penerbitan faktur dilakukan.',
        ),
        _SectionData(
          '3. Proses Pemesanan (Booking)',
          'Pembayaran Booking Fee bersifat sebagai tanda jadi keseriusan pembelian unit kendaraan. Booking Fee yang dibayarkan akan memotong total nominal harga kendaraan (untuk pembayaran Tunai) atau memotong nilai Uang Muka / DP (untuk pembayaran Kredit).',
        ),
        _SectionData(
          '4. Pembatalan & Pengembalian Dana',
          'Pembatalan sepihak oleh pihak konsumen setelah pembayaran Booking Fee akan menyebabkan dana hangus atau dikenakan biaya administrasi. Namun, apabila pengajuan kredit ditolak secara resmi oleh pihak Leasing, Booking Fee akan dikembalikan sepenuhnya 100% (Full Refund).',
        ),
        _SectionData(
          '5. Persetujuan Kredit',
          'Keputusan mutlak mengenai disetujui atau ditolaknya pengajuan kredit sepenuhnya berada di tangan Perusahaan Pembiayaan (Leasing) rekanan, dan bukan merupakan wewenang pihak Hondaku.',
        ),
      ];
    }
  }
}

class _SectionData {
  final String title;
  final String content;

  _SectionData(this.title, this.content);
}

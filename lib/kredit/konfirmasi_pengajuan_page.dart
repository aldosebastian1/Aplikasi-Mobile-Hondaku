import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KonfirmasiPengajuanPage extends StatelessWidget {
  final String referenceId;
  final String namaMotor;
  final String leasing;
  final double angsuranPerBulan;
  final int tenor;
  final double dpNominal;
  final double hargaOTR;

  const KonfirmasiPengajuanPage({
    super.key,
    required this.referenceId,
    required this.namaMotor,
    required this.leasing,
    required this.angsuranPerBulan,
    required this.tenor,
    required this.dpNominal,
    required this.hargaOTR,
  });

  static const _red = Color(0xFFC40000);

  String _formatRupiah(double value) => NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(value);

  @override
  Widget build(BuildContext context) {
    final noRef = referenceId;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 22),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Pengajuan Berhasil',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSuccessCard(),
            const SizedBox(height: 12),
            _buildRingkasanCard(noRef),
            const SizedBox(height: 12),
            _buildStatusCard(),
            const SizedBox(height: 24),
            _buildKembaliButton(context),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Simpan nomor referensi Anda untuk keperluan pelacakan.',
                style: TextStyle(fontSize: 11, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }



  Widget _buildSuccessCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_rounded,
              color: Colors.green.shade600,
              size: 48,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Pengajuan Berhasil Dikirim!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          const Text(
            'Dokumen Anda sedang dalam antrian verifikasi\noleh tim analis kredit kami.',
            style: TextStyle(fontSize: 13, color: Colors.grey, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRingkasanCard(String noRef) {
    final rows = [
      {'label': 'No. Referensi', 'value': noRef, 'highlight': true},
      {'label': 'Motor', 'value': namaMotor, 'highlight': false},
      {
        'label': 'Harga OTR',
        'value': _formatRupiah(hargaOTR),
        'highlight': false,
      },
      {
        'label': 'Uang Muka (DP)',
        'value': _formatRupiah(dpNominal),
        'highlight': false,
      },
      {'label': 'Mitra Leasing', 'value': leasing, 'highlight': false},
      {'label': 'Tenor', 'value': '$tenor Bulan', 'highlight': false},
      {
        'label': 'Angsuran/Bulan',
        'value': _formatRupiah(angsuranPerBulan),
        'highlight': true,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Text(
              'Ringkasan Pengajuan',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(height: 1, thickness: 0.5),
          ...rows.asMap().entries.map((entry) {
            final i = entry.key;
            final row = entry.value;
            final isLast = i == rows.length - 1;
            final isHighlight = row['highlight'] as bool;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 11,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        row['label'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        row['value'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isHighlight
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isHighlight ? _red : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  const Divider(
                    height: 1,
                    thickness: 0.5,
                    indent: 16,
                    endIndent: 16,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.access_time_rounded,
            size: 16,
            color: Colors.amber.shade700,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Status: Sedang Diverifikasi\nEstimasi verifikasi 1x24 jam kerja. Kami akan menghubungi Anda melalui nomor yang terdaftar.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.amber.shade900,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKembaliButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _red,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Kembali ke Beranda',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

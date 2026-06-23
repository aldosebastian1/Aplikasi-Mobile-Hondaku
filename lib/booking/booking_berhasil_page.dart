import 'package:flutter/material.dart';
import '../core/hondaku_app.dart';

class BookingBerhasilPage extends StatelessWidget {
  final String orderId;
  final String tipeUnit;
  final String dealer;
  final String namaMotor;

  const BookingBerhasilPage({
    super.key,
    required this.orderId,
    required this.tipeUnit,
    required this.dealer,
    required this.namaMotor,
  });

  static const _red = Color(0xFFC40000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          namaMotor,
          style: const TextStyle(
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
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Informasi Booking'),
                  content: const Text(
                    'Selamat! Booking Anda telah tercatat di sistem kami.\n\n'
                    'Langkah selanjutnya:\n'
                    '1. Pantau status pesanan secara berkala pada tab Aktivitas.\n'
                    '2. Sales kami akan menghubungi Anda melalui WhatsApp untuk verifikasi data.\n'
                    '3. Unit akan disiapkan dan dikirim setelah verifikasi selesai.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tutup', style: TextStyle(color: _red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(flex: 2),
            _buildSuccessIcon(),
            const SizedBox(height: 28),
            _buildTitleSection(),
            const Spacer(flex: 2),
            _buildOrderCard(),
            const Spacer(flex: 3),
            _buildPantauButton(context),
            const SizedBox(height: 12),
            _buildKembaliButton(context),
            const SizedBox(height: 16),
            _buildBantuanText(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 140,
      height: 140,
      decoration: const BoxDecoration(
        color: Color(0xFFF0F0F0),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Container(
        width: 88,
        height: 88,
        decoration: const BoxDecoration(
          color: Color(0xFF34C759),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 48),
      ),
    );
  }

  Widget _buildTitleSection() {
    return const Column(
      children: [
        Text(
          'Booking Berhasil!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Unit BeAT kamu sedang disiapkan.\nTim kami akan segera menghubungi\nuntuk proses selanjutnya.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: Colors.grey, height: 1.6),
        ),
      ],
    );
  }

  Widget _buildOrderCard() {
    final rows = [
      {
        'label': 'Order ID',
        'value': orderId,
        'valueColor': Colors.black87,
        'bold': true,
      },
      {
        'label': 'Tipe Unit',
        'value': tipeUnit,
        'valueColor': Colors.black87,
        'bold': true,
      },
      {
        'label': 'Dealer',
        'value': dealer,
        'valueColor': Colors.black87,
        'bold': true,
      },
      {
        'label': 'Status Pembayaran',
        'value': 'LUNAS',
        'valueColor': const Color(0xFF34C759),
        'bold': true,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: rows.asMap().entries.map((entry) {
          final i = entry.key;
          final row = entry.value;
          final isLast = i == rows.length - 1;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      row['label'] as String,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        row['value'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: row['valueColor'] as Color,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(height: 1, thickness: 0.5, color: Colors.grey.shade200),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPantauButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const HondakuApp(initialIndex: 2),
            ),
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _red,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Pantau Pesanan',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildKembaliButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const HondakuApp(initialIndex: 0),
            ),
            (route) => false,
          );
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Kembali ke Beranda',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildBantuanText(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Menghubungi Honda Care Medan via WhatsApp...'),
            backgroundColor: _red,
          ),
        );
      },
      child: RichText(
        text: const TextSpan(
          text: 'Butuh bantuan? Hubungi ',
          style: TextStyle(fontSize: 12, color: Colors.grey),
          children: [
            TextSpan(
              text: 'Honda Care Medan',
              style: TextStyle(color: _red, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

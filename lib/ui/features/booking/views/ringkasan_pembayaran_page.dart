import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../domain/models/motorcycle.dart';
import '../../../../domain/models/bank_option.dart';
import '../../../../data/providers.dart';

// PAGE
class RingkasanPembayaranPage extends ConsumerStatefulWidget {
  final Motorcycle motor;
  final bool isFullPayment;

  const RingkasanPembayaranPage({
    super.key,
    required this.motor,
    this.isFullPayment = false,
  });

  @override
  ConsumerState<RingkasanPembayaranPage> createState() =>
      _RingkasanPembayaranPageState();
}

class _RingkasanPembayaranPageState extends ConsumerState<RingkasanPembayaranPage> {
  int _selectedBank = 0; // BCA selected by default

  List<BankOption> get _banks {
    return ref.watch(bankOptionsProvider).value ?? const [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPageHeader(),
                    const SizedBox(height: 16),

                    _buildProductCard(),
                    const SizedBox(height: 12),

                    _buildRingkasanHargaCard(),
                    const SizedBox(height: 20),

                    const Text(
                      'Pilihan Bank Transfer',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    _buildBankList(),
                    const SizedBox(height: 14),

                    _buildSecurityNote(),
                  ],
                ),
              ),
            ),
          ),

          _buildBottomBar(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black, size: 22),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Ringkasan Pesanan',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline, color: Colors.black, size: 22),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Ringkasan Pembayaran'),
                content: const Text(
                  'Periksa kembali rincian pesanan Anda:\n\n'
                  '• Unit Motor: Pastikan tipe dan warna sesuai keinginan.\n'
                  '• Pembayaran: Anda dapat memilih transfer ke Virtual Account bank rekanan resmi kami.\n'
                  '• Booking Fee: Bersifat aman dan dapat dikembalikan (refundable) sesuai syarat & ketentuan jika terjadi pembatalan.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Tutup', style: TextStyle(color: Color(0xFFD32F2F))),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPageHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ringkasan Pesanan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Periksa kembali detail pesanan Anda sebelum\nmelakukan pembayaran.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF757575),
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          Container(
            width: 80,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.motor.imageAsset,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.two_wheeler,
                  color: Color(0xFFD32F2F),
                  size: 36,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.motor.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'OTR Medan: ',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF757575),
                        ),
                      ),
                      TextSpan(
                        text: widget.motor.price,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                const Row(
                  children: [
                    Icon(Icons.verified, color: Color(0xFFD32F2F), size: 14),
                    SizedBox(width: 4),
                    Text(
                      'Dealer Resmi Medan',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFD32F2F),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRingkasanHargaCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isFullPayment ? 'Total Pelunasan Full' : 'Booking Fee',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF757575),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.isFullPayment ? widget.motor.price : 'Rp 500.000',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFD32F2F),
                  ),
                ),
              ],
            ),
          ),
          // Cash icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFD32F2F),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.payments_outlined, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
      ),
      child: Column(
        children: List.generate(_banks.length, (index) {
          final isLast = index == _banks.length - 1;
          return Column(
            children: [
              _buildBankRow(index),
              if (!isLast)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFF0F0F0),
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildBankRow(int index) {
    final bank = _banks[index];
    final bool selected = _selectedBank == index;

    return InkWell(
      onTap: () => setState(() => _selectedBank = index),
      borderRadius: BorderRadius.only(
        topLeft: index == 0 ? const Radius.circular(12) : Radius.zero,
        topRight: index == 0 ? const Radius.circular(12) : Radius.zero,
        bottomLeft: index == _banks.length - 1
            ? const Radius.circular(12)
            : Radius.zero,
        bottomRight: index == _banks.length - 1
            ? const Radius.circular(12)
            : Radius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Bank logo box
            SizedBox(
              width: 52,
              height: 36,
              child: Image.asset(
                bank.logoPath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 12),
            // Bank name
            Expanded(
              child: Text(
                bank.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            // Radio button
            _buildRadio(isSelected: selected),
          ],
        ),
      ),
    );
  }

  Widget _buildRadio({required bool isSelected}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? const Color(0xFFD32F2F) : const Color(0xFFBDBDBD),
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 11,
                height: 11,
                decoration: const BoxDecoration(
                  color: Color(0xFFD32F2F),
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Icon(Icons.security, color: Color(0xFF9E9E9E), size: 18),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Pembayaran Anda aman dan terenkripsi. Booking fee bersifat refundable sesuai dengan syarat dan ketentuan yang berlaku.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF757575),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              context.push(
                '/pembayaran-booking',
                extra: {
                  'motor': widget.motor,
                  'initialBank': _banks[_selectedBank],
                  'isFullPayment': widget.isFullPayment,
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Konfirmasi & Bayar Sekarang',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

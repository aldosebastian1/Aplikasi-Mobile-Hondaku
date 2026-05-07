import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/motorcycle_data.dart';
import 'pembayaran_booking_page.dart';
import '../data/bank_data.dart';

// ─────────────────────────────────────────────────────────────
// PAGE
// ─────────────────────────────────────────────────────────────
class CheckoutSummaryPage extends StatefulWidget {
  final Motorcycle motor;
  const CheckoutSummaryPage({super.key, required this.motor});

  @override
  State<CheckoutSummaryPage> createState() =>
      _CheckoutSummaryPageState();
}

class _CheckoutSummaryPageState extends State<CheckoutSummaryPage> {
  int _selectedBank = 0; // BCA selected by default

  late final List<BankOption> _banks;

  @override
  void initState() {
    super.initState();
    _banks = bankOptions;
  }

  // ───── BUILD ─────────────────────────────────────────────
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
                    // ── Page heading ──
                    _buildPageHeader(),
                    const SizedBox(height: 16),

                    // ── Product card ──
                    _buildProductCard(),
                    const SizedBox(height: 12),

                    // ── Booking fee card ──
                    _buildBookingFeeCard(),
                    const SizedBox(height: 20),

                    // ── Metode Pembayaran label ──
                    const Text(
                      'Pilihan Bank Transfer',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ── Bank list ──
                    _buildBankList(),
                    const SizedBox(height: 14),

                    // ── Security note ──
                    _buildSecurityNote(),
                  ],
                ),
              ),
            ),
          ),

          // ── Bottom CTA ──
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ───── APPBAR ────────────────────────────────────────────
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
          onPressed: () {},
        ),
      ],
    );
  }

  // ───── PAGE HEADER ───────────────────────────────────────
  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
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

  // ───── PRODUCT CARD ──────────────────────────────────────
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
                errorBuilder: (_, __, ___) => const Icon(
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
                Row(
                  children: const [
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

  // ───── BOOKING FEE CARD ──────────────────────────────────
  Widget _buildBookingFeeCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAF0F0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEDDDD), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Booking Fee',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF757575),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Rp 500.000',
                  style: TextStyle(
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
            child: Center(
              child: SizedBox(
                width: 26,
                height: 26,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 24,
                      height: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───── BANK LIST ─────────────────────────────────────────
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
              child: bank.logo,
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

  // ───── SECURITY NOTE ─────────────────────────────────────
  Widget _buildSecurityNote() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 1),
            child: Icon(Icons.security, color: Color(0xFF9E9E9E), size: 18),
          ),
          const SizedBox(width: 10),
          const Expanded(
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

  // ───── BOTTOM BAR ────────────────────────────────────────
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PembayaranBookingPage(
                    motor: widget.motor,
                    initialBank: _banks[_selectedBank],
                  ),
                ),
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
              'Bayar Sekarang',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

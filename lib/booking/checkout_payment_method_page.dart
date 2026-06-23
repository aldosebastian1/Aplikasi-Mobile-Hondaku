import 'package:flutter/material.dart';
import '../data/motorcycle_data.dart';
import 'booking_form_page.dart';
import '../kredit/simulasi_kredit_page.dart';

class CheckoutPaymentMethodPage extends StatefulWidget {
  final Motorcycle motor;
  const CheckoutPaymentMethodPage({super.key, required this.motor});

  @override
  State<CheckoutPaymentMethodPage> createState() =>
      _CheckoutPaymentMethodPageState();
}

class _CheckoutPaymentMethodPageState extends State<CheckoutPaymentMethodPage> {
  // 0 = Tunai, 1 = Kredit, null = none selected
  int? _selectedMethod = 0;

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 16),
                    _buildProductCard(),
                    const SizedBox(height: 16),
                    _buildPaymentOption(
                      index: 0,
                      icon: _buildCashIcon(isSelected: _selectedMethod == 0),
                      title: 'Tunai (Cash)',
                      subtitle:
                          'Pembayaran penuh di muka dengan proses administrasi yang lebih cepat.',
                    ),
                    const SizedBox(height: 12),
                    _buildPaymentOption(
                      index: 1,
                      icon: _buildCreditIcon(isSelected: _selectedMethod == 1),
                      title: 'Kredit (Installment)',
                      subtitle:
                          'Cicilan ringan dengan tenor fleksibel melalui mitra leasing terpercaya kami.',
                    ),
                    const SizedBox(height: 16),
                    _buildBenefitBox(),
                    const SizedBox(height: 24),
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
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black, size: 22),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Metode Pembayaran',
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
                title: const Text('Pilihan Metode Pembayaran'),
                content: const Text(
                  'Anda dapat memilih metode pembayaran yang paling sesuai:\n\n'
                  '1. Tunai (Cash):\n'
                  'Pembayaran booking fee Rp 500.000 atau pelunasan penuh secara langsung. Mempercepat proses administrasi.\n\n'
                  '2. Kredit (Installment):\n'
                  'Pengajuan cicilan motor melalui leasing pilihan Anda (FIF Group, Adira, dll). Pembayaran uang muka (DP) dilakukan setelah pengajuan disetujui.',
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

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Pilih Metode Pembayaran',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Tentukan jalur transaksi yang sesuai dengan kebutuhan\nfinansial Anda.',
          style: TextStyle(fontSize: 13, color: Color(0xFF757575), height: 1.4),
        ),
      ],
    );
  }

  Widget _buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Motorcycle image
                Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.motor.imageAsset,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.two_wheeler,
                        color: Color(0xFFBDBDBD),
                        size: 36,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.motor.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Color(0xFFD32F2F),
                            size: 14,
                          ),
                          SizedBox(width: 2),
                          Text(
                            'OTR Medan',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF757575),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.motor.price,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD32F2F),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Estimasi Pengiriman',
                  style: TextStyle(fontSize: 13, color: Color(0xFF757575)),
                ),
                Text(
                  '1-3 Hari Kerja',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required int index,
    required Widget icon,
    required String title,
    required String subtitle,
  }) {
    final bool isSelected = _selectedMethod == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFD32F2F) : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF757575),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildRadio(isSelected: isSelected),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadio({required bool isSelected}) {
    return Container(
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

  Widget _buildCashIcon({required bool isSelected}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? const Color(0xFFD32F2F) : const Color(0xFFE0E0E0),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer rectangle (card body)
            Container(
              width: 26,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFD32F2F)
                      : const Color(0xFF616161),
                  width: 2,
                ),
              ),
            ),
            // Circle in center (lens/coin)
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFD32F2F)
                      : const Color(0xFF616161),
                  width: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditIcon({required bool isSelected}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? const Color(0xFFD32F2F) : const Color(0xFFE0E0E0),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bank roof (triangle top) - columns
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                4,
                (i) => Container(
                  width: 4,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  color: isSelected
                      ? const Color(0xFFD32F2F)
                      : const Color(0xFF616161),
                ),
              ),
            ),
            const SizedBox(height: 2),
            // Base bar
            Container(
              width: 24,
              height: 3,
              color: isSelected
                  ? const Color(0xFFD32F2F)
                  : const Color(0xFF616161),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitBox() {
    final isCash = _selectedMethod == 0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.info_outline, color: Color(0xFFD32F2F), size: 18),
              SizedBox(width: 6),
              Text(
                'Keuntungan Metode Ini:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (isCash) ...[
            _buildBenefitItem('Bebas biaya bunga bulanan'),
            const SizedBox(height: 6),
            _buildBenefitItem('BPKB diterima lebih cepat setelah pelunasan'),
            const SizedBox(height: 6),
            _buildBenefitItem('Potongan harga khusus untuk pembelian tunai'),
          ] else ...[
            _buildBenefitItem('Cicilan ringan dengan tenor hingga 35 bulan'),
            const SizedBox(height: 6),
            _buildBenefitItem('Sudah termasuk asuransi kehilangan & kerusakan'),
            const SizedBox(height: 6),
            _buildBenefitItem('Proses pengajuan cepat & syarat mudah'),
          ],
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 1),
          child: Icon(
            Icons.check_circle_outline,
            color: Color(0xFF388E3C),
            size: 18,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF424242),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Total Tagihan',
                    style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.motor.price,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedMethod == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SimulasiKreditPage(motor: widget.motor),
                      ),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingFormPage(motor: widget.motor),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                child: const Text(
                  'Konfirmasi Metode',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

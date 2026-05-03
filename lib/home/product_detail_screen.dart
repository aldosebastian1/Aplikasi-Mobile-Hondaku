import 'package:flutter/material.dart';
import '../core/hondaku_app.dart';
import '../booking/checkout_payment_method_page.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedBottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildMainTopBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeroSection(),
                    const SizedBox(height: 16),
                    _buildTitlePriceSection(),
                    const SizedBox(height: 20),
                    _buildKeySpecsSection(),
                    const SizedBox(height: 20),
                    _buildFeaturesSection(),
                    const SizedBox(height: 20),
                    _buildDetailedSpecsSection(),
                    const SizedBox(height: 40),
                    _buildBottomButtonsSection(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildMainTopBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        border: const Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          Text(
            'Hondaku',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w800,
              fontSize: 22,
              color: const Color(0xFFB60020),
              letterSpacing: -1.2,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Row(
              children: [
                Icon(Icons.location_on, size: 13, color: Color(0xFFB60020)),
                SizedBox(width: 4),
                Text(
                  'OTR MEDAN',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: Color(0xFF1A1C1C),
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFE2E2E2),
            backgroundImage: const AssetImage('assets/images/profile.png'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFD50000),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD50000).withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'SPECIAL PROMO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F9),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.24),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: AspectRatio(
                  aspectRatio: 1.6,
                  child: Image.asset(
                    'assets/images/Beat 1.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          _buildColorSelectors(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildColorSelectors() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _colorCircle(const Color(0xFF6A625C), true),
            const SizedBox(width: 10),
            _colorCircle(Colors.black, false),
            const SizedBox(width: 10),
            _colorCircle(const Color(0xFFD7DCE3), false, border: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _colorCircle(Color color, bool selected, {Color? border}) {
    if (selected) {
      return Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFCCCCCC), width: 1.2),
          ),
        ),
      );
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: border != null ? Border.all(color: border, width: 1) : null,
      ),
    );
  }

  Widget _buildTitlePriceSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Control Super Sport',
            style: TextStyle(color: Color(0xFF2F2F2F), fontSize: 14),
          ),
          const SizedBox(height: 4),
          const Text(
            'BEAT',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFF7F8), Color(0xFFFBF4F5)],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'HARGA OTR JAKARTA',
                  style: TextStyle(
                    color: Color(0xFF7D5D5D),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Mulai dari ',
                        style: TextStyle(color: Color(0xFFE11D48)),
                      ),
                      TextSpan(
                        text: 'Rp 19.155.000',
                        style: TextStyle(color: Color(0xFF1A1A1A)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeySpecsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('SPESIFIKASI UTAMA'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _specItem(Icons.settings_suggest_outlined, '190,5cc', 'ENGINE'),
              _specItem(Icons.speed_outlined, '6,6kW', 'POWER'),
              _specItem(Icons.local_gas_station_outlined, '4,2L', 'FUEL'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _specItem(IconData icon, String value, String label) {
    return Container(
      width: 94,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: const Color(0xFFC01F2D)),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('FITUR TEKNOLOGI'),
          const SizedBox(height: 16),
          _featureItem(
            Icons.electric_bolt_outlined,
            'Quick Shifter System',
            'Pengoperasian gigi lebih cepat tanpa menarik tuas kopling, memberikan akselerasi maksimal.',
          ),
          const SizedBox(height: 16),
          _featureItem(
            Icons.swap_calls_outlined,
            'Throttle by Wire',
            'Respon gas lebih presisi dan halus, dilengkapi dengan 3 mode berkendara (Comfort, Sport, Sport+).',
          ),
        ],
      ),
    );
  }

  Widget _featureItem(IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFFC01F2D)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedSpecsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('SPESIFIKASI DETAIL'),
          const SizedBox(height: 16),
          _detailedSpecCategory('Mesin', Icons.settings_suggest_outlined),
          const SizedBox(height: 16),
          _buildSpecTableMesin(),
          const SizedBox(height: 20),
          _detailedSpecCategory(
            'Rangka & Kaki-Kaki',
            Icons.motorcycle_outlined,
          ),
          const SizedBox(height: 16),
          _buildSpecTableRangka(),
          const SizedBox(height: 20),
          _detailedSpecCategory(
            'Dimensi & Kapasitas',
            Icons.linear_scale_outlined,
          ),
          const SizedBox(height: 16),
          _buildSpecTableDimensi(),
        ],
      ),
    );
  }

  Widget _detailedSpecCategory(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF1F1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: const Color(0xFFC01F2D)),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSpecTableMesin() {
    return _specTable([
      _specTableRow('Tipe', '4-Langkah, SOHC, eSP'),
      _specTableRow('Kapasitas', '109,5 cc'),
      _specTableRow('Daya Maksimal', '6,6 kW (9,0 PS) / 7.500 rpm'),
      _specTableRow('Torsi Maksimal', '9,2 Nm (0,94 kgf.m) / 6.000 rpm'),
      _specTableRow('Sistem Suplai', 'PGM-FI'),
    ]);
  }

  Widget _buildSpecTableRangka() {
    return _specTable([
      _specTableRow('Tipe Rangka', 'Tulang punggung - eSAF'),
      _specTableRow('Tipe Ban Depan', '80/90 - 14M/C 40P (Tubeless)'),
      _specTableRow('Tipe Ban Belakang', '90/90 - 14M/C 40P (Tubeless)'),
      _specTableRow('Sistem Pengereman', 'COMBI BRAKE SYSTEM'),
    ]);
  }

  Widget _buildSpecTableDimensi() {
    return _specTable([
      _specTableRow('Panjang x Lebar x Tinggi', '1876 X 669 X 1080 mm'),
      _specTableRow('Jarak Sumbu Roda', '1.255 mm'),
      _specTableRow('Berat Kosong', '88 kg'),
      _specTableRow('Kapasitas Tangki Bensin', '4,2 Liter'),
    ]);
  }

  Widget _specTable(List<Widget> rows) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFECEFF1), width: 0.5),
      ),
      child: Column(
        children: List.generate(
          rows.length,
          (index) => Column(
            children: [
              rows[index],
              if (index < rows.length - 1)
                const Divider(height: 1, color: Color(0xFFECEFF1)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _specTableRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildBottomButtonsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // TANYA SALES Button (Grey)
          Expanded(
            flex: 4,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement contact sales functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Hubungi sales untuk informasi lebih lanjut'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1C1C1E),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                side: const BorderSide(color: Color(0xFFF0C7C7)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: const Text(
                'TANYA SALES',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // BELI SEKARANG Button (Red)
          Expanded(
            flex: 6,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckoutPaymentMethodPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD50000),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 6,
                shadowColor: const Color(0xFFD50000).withValues(alpha: 0.35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: const Text(
                'BELI SEKARANG',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return HondakuBottomNavBar(
      currentIndex: _selectedBottomIndex,
      onTap: (index) => _handleBottomNavTap(context, index),
    );
  }

  Future<void> _handleBottomNavTap(BuildContext context, int index) async {
    if (_selectedBottomIndex == index) {
      return;
    }

    setState(() {
      _selectedBottomIndex = index;
    });

    await Future<void>.delayed(const Duration(milliseconds: 140));

    if (!mounted) {
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HondakuApp(initialIndex: index)),
      (route) => false,
    );
  }
}

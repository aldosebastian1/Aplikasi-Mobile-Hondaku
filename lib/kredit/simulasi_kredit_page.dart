import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/motorcycle_data.dart';
import 'upload_dokumen_kredit_page.dart';

class SimulasiKreditPage extends StatefulWidget {
  final Motorcycle motor;
  const SimulasiKreditPage({super.key, required this.motor});

  @override
  State<SimulasiKreditPage> createState() => _SimulasiKreditPageState();
}

class _SimulasiKreditPageState extends State<SimulasiKreditPage> {
  late double hargaOTR;
  static const double minDpPersen = 0.10;
  static const double maxDpPersen = 0.75;

  // Rate tahunan per leasing (sederhana untuk simulasi)
  static const Map<String, double> leasingRate = {
    'FIF Group': 0.115,
    'Adira Finance': 0.118,
    'MUF': 0.120,
  };

  static const Map<String, String> leasingSubtitle = {
    'FIF Group': 'Proses cepat, Syarat mudah',
    'Adira Finance': 'Bunga kompetitif',
    'MUF': 'Layanan terpadu Mandiri',
  };

  double _dpPersen = 0.10;
  int _selectedTenor = 11;
  String? _selectedLeasing;

  final List<int> _tenorList = [11, 23, 35];

  @override
  void initState() {
    super.initState();
    // Parse price from string e.g. "Rp 19.155.000" to double
    String priceStr = widget.motor.price.replaceAll(RegExp(r'[^0-9]'), '');
    hargaOTR = double.tryParse(priceStr) ?? 0;
  }

  double get _dpNominal => hargaOTR * _dpPersen;
  double get _pokokPinjaman => hargaOTR - _dpNominal;

  double _hitungAngsuran(String leasing) {
    final rate = leasingRate[leasing]!;
    final bungaTotal = _pokokPinjaman * rate * (_selectedTenor / 12);
    return (_pokokPinjaman + bungaTotal) / _selectedTenor;
  }

  String _formatRupiah(double value) => NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pembayaran',
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Panduan Simulasi Kredit'),
                  content: const Text(
                    'Gunakan halaman ini untuk menghitung skema cicilan motor Anda:\n\n'
                    '1. Geser slider Uang Muka (DP) untuk menyesuaikan pembayaran awal (10% - 75% OTR).\n'
                    '2. Pilih Tenor (durasi cicilan) yang diinginkan (11, 23, atau 35 bulan).\n'
                    '3. Bandingkan tarif bunga dan keunggulan masing-masing mitra leasing di bagian bawah.\n\n'
                    'Estimasi angsuran bersifat simulasi awal dan dapat sedikit berubah tergantung kebijakan leasing saat verifikasi.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tutup', style: TextStyle(color: Color(0xFFC40000))),
                    ),
                  ],
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
            _buildHeader(),
            const SizedBox(height: 12),
            _buildMotoImage(),
            const SizedBox(height: 16),
            _buildDpSection(),
            const SizedBox(height: 16),
            _buildTenorSection(),
            const SizedBox(height: 16),
            _buildLeasingSection(),
            const SizedBox(height: 24),
            _buildAjukanButton(),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Estimasi belum termasuk biaya administrasi & asuransi.',
                style: TextStyle(fontSize: 11, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Simulasi Kredit',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              Text(
                'Atur anggaran sesuai kebutuhan Anda',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'Harga OTR Medan',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            Text(
              _formatRupiah(hargaOTR),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC40000),
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildMotoImage() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC40000), width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Image.asset(
            widget.motor.imageAsset,
            height: 140,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const Icon(
              Icons.directions_bike,
              size: 80,
              color: Color(0xFFC40000),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDpSection() {
    return Container(
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
              const Text(
                'Uang Muka (DP)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(
                _formatRupiah(_dpNominal),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC40000),
                ),
              ),
            ],
          ),
          Slider(
            value: _dpPersen,
            min: minDpPersen,
            max: maxDpPersen,
            activeColor: const Color(0xFFC40000),
            inactiveColor: Colors.grey.shade300,
            onChanged: (val) => setState(() => _dpPersen = val),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Min. ${(minDpPersen * 100).toInt()}%',
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              Text(
                'Maks. ${(maxDpPersen * 100).toInt()}%',
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTenorSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pilih Tenor (Bulan)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          Row(
            children: _tenorList.map((tenor) {
              final isSelected = tenor == _selectedTenor;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTenor = tenor),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFC40000)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFC40000)
                              : Colors.grey.shade300,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$tenor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLeasingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mitra Leasing Terpercaya',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        ...leasingRate.keys.map((leasing) {
          final angsuran = _hitungAngsuran(leasing);
          final isSelected = _selectedLeasing == leasing;
          return GestureDetector(
            onTap: () => setState(() => _selectedLeasing = leasing),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFC40000)
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.account_balance,
                      size: 20,
                      color: Color(0xFFC40000),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leasing,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          leasingSubtitle[leasing]!,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Angsuran/bln',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Text(
                        _formatRupiah(angsuran),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFFC40000),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAjukanButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _selectedLeasing == null
            ? null
            : () {
                final leasing = _selectedLeasing!;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadDokumenKreditPage(
                      namaMotor: widget.motor.name,
                      selectedLeasing: leasing,
                      angsuran: _hitungAngsuran(leasing),
                      tenor: _selectedTenor,
                      dpNominal: _dpNominal,
                      hargaOTR: hargaOTR,
                    ),
                  ),
                );
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC40000),
          disabledBackgroundColor: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Ajukan Kredit',
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

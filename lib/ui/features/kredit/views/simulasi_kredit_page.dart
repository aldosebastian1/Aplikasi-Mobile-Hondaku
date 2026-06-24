import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/kredit_view_model.dart';
import '../../../../data/motorcycle_data.dart';
import 'package:hondaku/l10n/app_localizations.dart';

class SimulasiKreditPage extends ConsumerStatefulWidget {
  final Motorcycle motor;
  const SimulasiKreditPage({super.key, required this.motor});

  @override
  ConsumerState<SimulasiKreditPage> createState() => _SimulasiKreditPageState();
}

class _SimulasiKreditPageState extends ConsumerState<SimulasiKreditPage> {
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

  final List<int> _tenorList = [11, 23, 35];

  @override
  void initState() {
    super.initState();
    final double otr = double.tryParse(widget.motor.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(kreditViewModelProvider.notifier).initHarga(otr);
    });
  }

  double get hargaOTR => ref.watch(kreditViewModelProvider).hargaOTR;
  double get _dpPersen => ref.watch(kreditViewModelProvider).dpPersen;
  int get _selectedTenor => ref.watch(kreditViewModelProvider).selectedTenor;
  String? get _selectedLeasing => ref.watch(kreditViewModelProvider).selectedLeasing;
  double get _dpNominal => ref.watch(kreditViewModelProvider).dpNominal;

  double _hitungAngsuran(String leasing) {
    return ref.read(kreditViewModelProvider.notifier).hitungAngsuran(leasing);
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
                  title: Text(AppLocalizations.of(context)!.kreditGuide),
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
                      child: Text(AppLocalizations.of(context)!.close, style: const TextStyle(color: Color(0xFFC40000))),
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
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
            onChanged: (val) => ref.read(kreditViewModelProvider.notifier).updateDpPersen(val),
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
                    onTap: () => ref.read(kreditViewModelProvider.notifier).updateTenor(tenor),
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
            onTap: () => ref.read(kreditViewModelProvider.notifier).updateLeasing(leasing),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
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
                context.push(
                  '/upload-dokumen-kredit',
                  extra: {
                    'namaMotor': widget.motor.name,
                    'selectedLeasing': leasing,
                    'angsuran': _hitungAngsuran(leasing),
                    'tenor': _selectedTenor,
                    'dpNominal': _dpNominal,
                    'hargaOTR': hargaOTR,
                  },
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

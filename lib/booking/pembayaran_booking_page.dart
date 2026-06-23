import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/motorcycle_data.dart';
import '../home/aktivitas_store.dart';
import '../ui/features/home/view_models/aktivitas_view_model.dart';
import 'booking_berhasil_page.dart';
import '../data/bank_data.dart';
import '../ui/core/toast/hondaku_toast.dart';


class PembayaranBookingPage extends ConsumerStatefulWidget {
  final Motorcycle motor;
  final BankOption initialBank;
  final bool isFullPayment;

  const PembayaranBookingPage({
    super.key,
    required this.motor,
    required this.initialBank,
    this.isFullPayment = false,
  });

  @override
  ConsumerState<PembayaranBookingPage> createState() => _PembayaranBookingPageState();
}

class _PembayaranBookingPageState extends ConsumerState<PembayaranBookingPage> {
  late BankOption _currentBank;
  // ── countdown: 24 jam ──
  static const int _totalSeconds = 24 * 3600 - 1; // 23:59:59
  int _remainingSeconds = _totalSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentBank = widget.initialBank;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showChangeBankConfirmation(BuildContext context, BankOption newBank) {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: Column(
            children: const [
              Icon(
                Icons.warning_amber_rounded,
                color: Color(0xFFC40000),
                size: 44,
              ),
              SizedBox(height: 12),
              Text(
                'Ganti Metode Pembayaran?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          content: Text(
            'Apakah Anda yakin ingin mengubah metode pembayaran menjadi ${newBank.name}? Nomor Virtual Account Anda sebelumnya akan hangus dan tidak dapat digunakan lagi.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF666666),
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Batal',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _currentBank = newBank;
                      });
                      HondakuToastHelper.showSuccess(
                        context,
                        'Metode pembayaran berhasil diubah!',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC40000),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Ya, Ubah',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String get _timerLabel {
    final h = _remainingSeconds ~/ 3600;
    final m = (_remainingSeconds % 3600) ~/ 60;
    final s = _remainingSeconds % 60;
    return '${h.toString().padLeft(2, '0')}:'
        '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  // ─────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ── countdown ──
                  _buildCountdown(),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // ── total bayar + VA card ──
                        _buildTotalCard(),
                        const SizedBox(height: 20),

                        // ── pilih bank lain ──
                        const Text(
                          'Pilih Bank Lain',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildBankList(),
                        const SizedBox(height: 16),

                        // ── petunjuk ──
                        _buildInstructions(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ── AppBar ──────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar() => AppBar(
    backgroundColor: Colors.white,
    elevation: 0.5,
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black, size: 22),
      onPressed: () => Navigator.maybePop(context),
    ),
    title: const Text(
      'Instruksi Pembayaran',
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
              title: const Text('Bantuan Pembayaran'),
              content: const Text(
                'Langkah pembayaran via Virtual Account:\n\n'
                '1. Salin Nomor Virtual Account yang tertera.\n'
                '2. Masuk ke aplikasi Mobile Banking atau ATM bank pilihan Anda.\n'
                '3. Pilih menu Transfer > Virtual Account.\n'
                '4. Masukkan nomor Virtual Account dan pastikan nominal tagihan sesuai.\n\n'
                'Pembayaran akan terverifikasi secara otomatis dalam waktu maksimal 10 menit setelah transfer berhasil.',
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

  // ── Countdown ───────────────────────────────────────────
  Widget _buildCountdown() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Column(
        children: [
          const Text(
            'Selesaikan dalam',
            style: TextStyle(fontSize: 13, color: Color(0xFF757575)),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.timer_outlined,
                size: 18,
                color: Color(0xFFD32F2F),
              ),
              const SizedBox(width: 8),
              Text(
                _timerLabel,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFD32F2F),
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Total Bayar + VA number ──────────────────────────────
  Widget _buildTotalCard() {
    final String totalPrice = widget.isFullPayment ? widget.motor.price : 'Rp 500.000';
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
      ),
      child: Column(
        children: [
          // top row: TOTAL BAYAR + cash icon
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TOTAL BAYAR',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9E9E9E),
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        totalPrice,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFD32F2F),
                        ),
                      ),
                    ],
                  ),
                ),
                // Wallet icon
                Container(
                  width: 40,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Color(0xFFD32F2F),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),

          // bottom row: selected bank logo + VA name + number + copy icon
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Row(
              children: [
                // Bank logo box
                SizedBox(
                  width: 52,
                  height: 36,
                  child: Image.asset(
                    _currentBank.logoPath,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Virtual Account ${_currentBank.name.split(' ')[0]}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF757575),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Text(
                            '8801 0812 3456 7890',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                const ClipboardData(text: '88010812345678900'),
                              );
                              HondakuToastHelper.showSuccess(context, 'Nomor VA berhasil disalin');
                            },
                            child: const Icon(
                              Icons.copy_rounded,
                              size: 16,
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
          ),
        ],
      ),
    );
  }

  // ── Bank list (Pilih Bank Lain) ──────────────────────────
  Widget _buildBankList() {
    final List<BankOption> banks = bankOptions;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
      ),
      child: Column(
        children: List.generate(banks.length, (i) {
          final isLast = i == banks.length - 1;
          final bank = banks[i];
          final isSelected = _currentBank.name == bank.name;

          return Column(
            children: [
              InkWell(
                onTap: () {
                  if (_currentBank.name != bank.name) {
                    _showChangeBankConfirmation(context, bank);
                  }
                },
                borderRadius: BorderRadius.only(
                  topLeft: i == 0 ? const Radius.circular(12) : Radius.zero,
                  topRight: i == 0 ? const Radius.circular(12) : Radius.zero,
                  bottomLeft: isLast ? const Radius.circular(12) : Radius.zero,
                  bottomRight: isLast ? const Radius.circular(12) : Radius.zero,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 52,
                        height: 36,
                        child: Image.asset(
                          bank.logoPath,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          bank.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected ? const Color(0xFFD32F2F) : Colors.black,
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(Icons.check_circle,
                            color: Color(0xFFD32F2F), size: 20),
                    ],
                  ),
                ),
              ),
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

  // ── Petunjuk Pembayaran ──────────────────────────────────
  Widget _buildInstructions() {
    const steps = [
      'Salin nomor Virtual Account di atas.',
      'Masuk ke aplikasi m-banking atau ATM bank Anda.',
      'Pilih menu Transfer ke Virtual Account.',
      'Masukkan nominal sesuai "Total Bayar" secara tepat.',
    ];
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.info_outline, color: Color(0xFF757575), size: 16),
              SizedBox(width: 6),
              Text(
                'Petunjuk Pembayaran',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...List.generate(steps.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${i + 1}. ',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFD32F2F),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      steps[i],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF424242),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ── Bottom bar ───────────────────────────────────────────
  Widget _buildBottomBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final now = DateTime.now();
                  final orderId = 'HND-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${now.millisecondsSinceEpoch.toString().substring(7)}';

                  ref.read(aktivitasViewModelProvider.notifier).submitCashTransaction(
                    id: orderId,
                    namaMotor: widget.motor.name,
                    tipeUnit: widget.motor.subtitle,
                    dealer: 'Honda Medan Center',
                    imagePath: widget.motor.imageAsset,
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingBerhasilPage(
                        orderId: orderId,
                        tipeUnit: widget.motor.subtitle,
                        dealer: 'Honda Medan Center',
                        namaMotor: widget.motor.name,
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
                  'Saya Sudah Membayar',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Konfirmasi otomatis dalam 5-10 menit',
              style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../domain/models/aktivitas_item.dart';
import '../../aktivitas/stores/aktivitas_store.dart';
import '../../aktivitas/view_models/aktivitas_view_model.dart';


class StatusPesananPage extends ConsumerStatefulWidget {
  final AktivitasItem item;

  const StatusPesananPage({super.key, required this.item});

  @override
  ConsumerState<StatusPesananPage> createState() => _StatusPesananPageState();
}

class _StatusPesananPageState extends ConsumerState<StatusPesananPage> {
  static const _red = Color(0xFFC40000);
  static const _green = Color(0xFF34C759);

  late AktivitasItem _currentItem;

  AktivitasItem get item => _currentItem;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.item;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<List<AktivitasItem>>(aktivitasViewModelProvider, (previous, next) {
      final index = next.indexWhere((e) => e.id == widget.item.id);
      if (index != -1) {
        final updatedItem = next[index];
        if (updatedItem.status != _currentItem.status) {
          setState(() {
            _currentItem = updatedItem;
          });
        }

        if (updatedItem.status == StatusAktivitas.selesai) {
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              context.pushReplacement('/konfirmasi-pesanan', extra: updatedItem);
            }
          });
        }
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Status Pesanan',
          style: TextStyle(
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Halaman ini memantau pengiriman unit motor Anda secara real-time.'),
                  backgroundColor: _red,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            _buildProductCard(),
            const SizedBox(height: 16),
            _buildTrackingCard(),
            if (_getStatusIndex(item.status) <= 1) ...[
              const SizedBox(height: 16),
              _buildSalesCard(),
            ],
            const SizedBox(height: 24), // Reduced padding
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildProductCard() {
    final bool showDeliveryInfo = _getStatusIndex(item.status) >= 3;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(item.imagePath, fit: BoxFit.contain),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ID: ${item.id}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: _red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.namaMotor,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Black | Dealer: ${item.dealer}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showDeliveryInfo) ...[
            const SizedBox(height: 12),
            const Divider(height: 1, thickness: 0.5),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DEALER PENGIRIM',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Wahana Makmur Sejati',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'ESTIMASI TIBA',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Hari Ini, 16:30',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: _red),
                    ),
                  ],
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildTrackingCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lacak Status',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildTimeline(),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    final statusIndex = _getStatusIndex(item.status);
    
    return Column(
      children: [
        _buildStep(
          index: 0,
          currentIndex: statusIndex,
          title: 'Booking Berhasil',
          description: 'Pembayaran uang tanda jadi telah diverifikasi otomatis oleh sistem.',
          time: '14 Okt 2023, 09:20 WIB',
          icon: Icons.check,
          isFirst: true,
        ),
        _buildStep(
          index: 1,
          currentIndex: statusIndex,
          title: 'Verifikasi Sales',
          description: 'Sales Consultant (Budi - Dealer SM Raja) sedang memproses berkas kamu.',
          time: '20 Okt 2023, 12:20 WIB',
          icon: Icons.person_search_outlined,
          badgeText: 'Sedang Proses',
          forceTitleRed: true,
        ),
        _buildStep(
          index: 2,
          currentIndex: statusIndex,
          title: 'Persiapan Unit (PDI)',
          description: statusIndex == 2 ? 'Pemeriksaan teknis dan kebersihan unit.' : 'Pemeriksaan teknis dan kebersihan unit.',
          time: statusIndex > 2 ? '21 Okt 2023, 11:20 WIB' : null,
          icon: Icons.inventory_2_outlined,
          badgeText: 'Sedang Proses',
          forceTitleRed: true,
        ),
        _buildStep(
          index: 3,
          currentIndex: statusIndex,
          title: 'Pengiriman',
          description: statusIndex >= 3 ? 'Unit sedang dalam perjalanan menuju lokasi Anda.' : 'Unit dalam perjalanan ke alamatmu.',
          time: statusIndex > 3 ? '21 Okt 2023, 15:45 WIB' : null,
          icon: Icons.local_shipping_outlined,
          badgeText: 'Sedang Proses',
          forceTitleRed: true,
          child: statusIndex == 3 ? _buildDriverCard() : null,
        ),
        _buildStep(
          index: 4,
          currentIndex: statusIndex,
          title: 'Selesai',
          description: 'Konfirmasi penerimaan unit di aplikasi.',
          icon: Icons.flag_outlined,
          isLast: true,
        ),
      ],
    );
  }

  int _getStatusIndex(StatusAktivitas status) {
    switch (status) {
      case StatusAktivitas.bookingBerhasil: return 0;
      case StatusAktivitas.verifikasiSales: return 1;
      case StatusAktivitas.persiapanUnit: return 2;
      case StatusAktivitas.pengiriman: return 3;
      case StatusAktivitas.selesai: return 4;
      default: return 0;
    }
  }

  Widget _buildStep({
    required int index,
    required int currentIndex,
    required String title,
    required String description,
    required IconData icon,
    String? time,
    String? badgeText,
    bool isFirst = false,
    bool isLast = false,
    bool forceTitleRed = false,
    Widget? child,
  }) {
    final bool isCompleted = index < currentIndex;
    final bool isActive = index == currentIndex;
    
    Color iconBgColor = Colors.grey.shade200;
    Color iconColor = Colors.grey.shade500;
    Color titleColor = Colors.grey.shade400;
    Color descColor = Colors.grey.shade400;

    if (isCompleted) {
      iconBgColor = const Color(0xFFE5F8ED);
      iconColor = _green;
      titleColor = forceTitleRed ? _red : Colors.black87;
      descColor = Colors.grey.shade600;
    } else if (isActive) {
      iconBgColor = _red;
      iconColor = Colors.white;
      titleColor = _red;
      descColor = Colors.grey.shade600;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                    boxShadow: isActive ? [
                      BoxShadow(color: _red.withValues(alpha: 0.3), blurRadius: 8, spreadRadius: 2)
                    ] : null,
                  ),
                  child: Icon(icon, size: 18, color: iconColor),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isCompleted ? Colors.grey.shade300 : Colors.grey.shade200,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ),
                      ),
                      if (isActive && badgeText != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            badgeText,
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: descColor, height: 1.4),
                  ),
                  if (time != null && isCompleted) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        time,
                        style: const TextStyle(fontSize: 10, color: _red, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                  ?child,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverCard() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: const AssetImage('assets/images/profile.png'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Agus Setiawan',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  'B 1234 ABC • Blind Van',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: _red,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.phone, size: 18, color: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Menghubungi Kurir (Agus Setiawan) di nomor +62 812-3456-7890...'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade50),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: const AssetImage('assets/images/profile.png'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Budi Santoso',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Honda SM Raja Medan',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: IconButton(
                  icon: const Icon(Icons.phone_outlined, size: 20, color: Colors.black87),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Menghubungi Sales (Budi Santoso) di nomor +62 821-9876-5432...'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Membuka chat WhatsApp dengan Sales Consultant Budi Santoso...'),
                    backgroundColor: Color(0xFF25D366),
                  ),
                );
              },
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20),
              label: const Text(
                'Chat via WhatsApp',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366), // WhatsApp Green
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Menghubungi Layanan Bantuan Honda Care Medan di 1-500-989...'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Butuh Bantuan',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Rincian Pesanan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Order ID', style: TextStyle(color: Colors.grey)),
                                  Text(item.id, style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Unit Motor', style: TextStyle(color: Colors.grey)),
                                  Text(item.namaMotor, style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Tipe/Varian', style: TextStyle(color: Colors.grey)),
                                  Text(item.tipeUnit, style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Dealer', style: TextStyle(color: Colors.grey)),
                                  Text(item.dealer, style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Metode Pembayaran', style: TextStyle(color: Colors.grey)),
                                  Text(item.tipe == TipeTransaksi.cash ? 'Cash' : 'Kredit', style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Rincian Pesanan',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

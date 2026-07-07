import 'package:flutter/material.dart';
import '../../../../domain/models/motorcycle.dart';

class BookingPaymentCard extends StatelessWidget {
  final Motorcycle motor;
  final bool isFullPayment;
  final ValueChanged<bool> onPaymentTypeChanged;

  const BookingPaymentCard({
    super.key,
    required this.motor,
    required this.isFullPayment,
    required this.onPaymentTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tipe Pembayaran Cash',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildTypeChip('Booking Unit', !isFullPayment),
            const SizedBox(width: 10),
            _buildTypeChip('Pelunasan Full', isFullPayment),
          ],
        ),
        const SizedBox(height: 16),
        _buildPaymentDetailCard(),
      ],
    );
  }

  Widget _buildTypeChip(String label, bool isSelected) {
    return Expanded(
      child: Material(
        color: isSelected ? const Color(0xFFD32F2F) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isSelected ? const Color(0xFFD32F2F) : const Color(0xFFE0E0E0),
          ),
        ),
        child: InkWell(
          onTap: () => onPaymentTypeChanged(label == 'Pelunasan Full'),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 48,
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : const Color(0xFF707070),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentDetailCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isFullPayment ? 'TOTAL PELUNASAN (FULL)' : 'BIAYA RESERVASI (BOOKING)',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF555555),
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Rp ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFD32F2F),
                        ),
                      ),
                      TextSpan(
                        text: isFullPayment ? motor.price.replaceAll('Rp ', '') : '500.000',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFD32F2F),
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isFullPayment
                      ? 'Pembayaran penuh untuk unit ${motor.name}. Anda tidak perlu membayar lagi saat serah terima unit.'
                      : 'Biaya untuk mengamankan antrian unit. Akan memotong harga OTR saat pelunasan nanti.',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF555555),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ExcludeSemantics(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: const Icon(Icons.payments_outlined, color: Color(0xFFD32F2F), size: 24),
            ),
          ),
        ],
      ),
    );
  }
}

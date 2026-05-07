import 'package:flutter/material.dart';

class BankOption {
  final String name;
  final String logoPath; // Menggunakan path string lebih fleksibel daripada menyimpan Widget langsung

  const BankOption({required this.name, required this.logoPath});
}

// Simulasi database bank agar tidak redundan di setiap halaman
final List<BankOption> bankOptions = [
  BankOption(
    name: 'BCA Virtual Account',
    logoPath: 'assets/payments/bca.svg',
  ),
  BankOption(
    name: 'Mandiri Virtual Account',
    logoPath: 'assets/payments/mandiri.svg',
  ),
  BankOption(
    name: 'BSI Virtual Account',
    logoPath: 'assets/payments/bsi.svg',
  ),
];

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BankOption {
  final String name;
  final Widget logo;

  const BankOption({required this.name, required this.logo});
}

// Simulasi database bank agar tidak redundan di setiap halaman
final List<BankOption> bankOptions = [
  BankOption(
    name: 'BCA Virtual Account',
    logo: SvgPicture.asset('assets/payments/bca.svg', fit: BoxFit.contain),
  ),
  BankOption(
    name: 'Mandiri Virtual Account',
    logo: SvgPicture.asset('assets/payments/mandiri.svg', fit: BoxFit.contain),
  ),
  BankOption(
    name: 'BSI Virtual Account',
    logo: SvgPicture.asset('assets/payments/bsi.svg', fit: BoxFit.contain),
  ),
];

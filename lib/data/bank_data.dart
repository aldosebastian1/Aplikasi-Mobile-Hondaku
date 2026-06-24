import '../domain/models/bank_option.dart';
export '../domain/models/bank_option.dart';



// Simulasi database bank agar tidak redundan di setiap halaman
final List<BankOption> bankOptions = [
  const BankOption(
    name: 'BCA Virtual Account',
    logoPath: 'assets/payments/bca.png',
  ),
  const BankOption(
    name: 'Mandiri Virtual Account',
    logoPath: 'assets/payments/mandiri.png',
  ),
  const BankOption(
    name: 'BSI Virtual Account',
    logoPath: 'assets/payments/bsi.png',
  ),
];

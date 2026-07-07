import '../domain/models/bank_option.dart';
export '../domain/models/bank_option.dart';

final List<BankOption> bankOptions = [
  const BankOption(
    id: 'bca_va',
    name: 'BCA Virtual Account',
    logoPath: 'assets/payments/bca.png',
  ),
  const BankOption(
    id: 'mandiri_va',
    name: 'Mandiri Virtual Account',
    logoPath: 'assets/payments/mandiri.png',
  ),
  const BankOption(
    id: 'bsi_va',
    name: 'BSI Virtual Account',
    logoPath: 'assets/payments/bsi.png',
  ),
];

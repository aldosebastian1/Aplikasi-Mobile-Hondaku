import '../domain/models/leasing_parameter.dart';
export '../domain/models/leasing_parameter.dart';

final List<LeasingParameter> leasingOptions = [
  const LeasingParameter(
    id: 'fif_group',
    name: 'FIF Group',
    subtitle: 'Proses cepat, Syarat mudah',
    rateTahunan: 0.115,
    minDpPersen: 0.10,
    maxDpPersen: 0.75,
    tenorList: [11, 23, 35],
  ),
  const LeasingParameter(
    id: 'adira_finance',
    name: 'Adira Finance',
    subtitle: 'Bunga kompetitif',
    rateTahunan: 0.118,
    minDpPersen: 0.10,
    maxDpPersen: 0.75,
    tenorList: [11, 23, 35],
  ),
  const LeasingParameter(
    id: 'muf',
    name: 'MUF',
    subtitle: 'Layanan terpadu Mandiri',
    rateTahunan: 0.120,
    minDpPersen: 0.10,
    maxDpPersen: 0.75,
    tenorList: [11, 23, 35],
  ),
];

import 'package:flutter_riverpod/flutter_riverpod.dart';

class KreditState {
  final double hargaOTR;
  final double dpPersen;
  final int selectedTenor;
  final String? selectedLeasing;

  const KreditState({
    this.hargaOTR = 0,
    this.dpPersen = 0.10,
    this.selectedTenor = 11,
    this.selectedLeasing,
  });

  KreditState copyWith({
    double? hargaOTR,
    double? dpPersen,
    int? selectedTenor,
    String? selectedLeasing,
  }) {
    return KreditState(
      hargaOTR: hargaOTR ?? this.hargaOTR,
      dpPersen: dpPersen ?? this.dpPersen,
      selectedTenor: selectedTenor ?? this.selectedTenor,
      selectedLeasing: selectedLeasing ?? this.selectedLeasing,
    );
  }

  double get dpNominal => hargaOTR * dpPersen;
  double get pokokPinjaman => hargaOTR - dpNominal;
}

class KreditViewModel extends Notifier<KreditState> {
  static const Map<String, double> leasingRate = {
    'FIF Group': 0.115,
    'Adira Finance': 0.118,
    'MUF': 0.120,
  };

  @override
  KreditState build() {
    return const KreditState();
  }

  void initHarga(double harga) {
    state = state.copyWith(hargaOTR: harga.clamp(0.0, double.infinity));
  }

  void updateDpPersen(double val) {
    state = state.copyWith(dpPersen: val.clamp(0.0, 1.0));
  }

  void updateTenor(int tenor) {
    state = state.copyWith(selectedTenor: tenor);
  }

  void updateLeasing(String? leasing) {
    state = state.copyWith(selectedLeasing: leasing);
  }

  double hitungAngsuran(String leasing) {
    final tenor = state.selectedTenor;
    if (tenor <= 0) return 0.0;
    
    final rate = leasingRate[leasing] ?? 0.115;
    final pokok = state.pokokPinjaman;
    final bungaTotal = pokok * rate * (tenor / 12);
    return (pokok + bungaTotal) / tenor;
  }
}

final kreditViewModelProvider = NotifierProvider<KreditViewModel, KreditState>(() {
  return KreditViewModel();
});

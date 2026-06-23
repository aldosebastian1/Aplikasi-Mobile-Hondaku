import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/providers.dart';
import '../../../../domain/models/aktivitas_item.dart';
import '../../../../domain/repositories/aktivitas_repository.dart';

class AktivitasViewModel extends Notifier<List<AktivitasItem>> {
  StreamSubscription<List<AktivitasItem>>? _subscription;

  @override
  List<AktivitasItem> build() {
    final repository = ref.watch(aktivitasRepositoryProvider);
    
    _subscription?.cancel();
    _subscription = repository.watchAktivitasList().listen(
      (data) {
        state = data;
      },
    );

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return [];
  }

  Future<void> submitCashTransaction({
    required String id,
    required String namaMotor,
    required String tipeUnit,
    required String dealer,
    required String imagePath,
  }) async {
    final item = AktivitasItem(
      id: id,
      namaMotor: namaMotor,
      tipeUnit: tipeUnit,
      dealer: dealer,
      imagePath: imagePath,
      tanggal: DateTime.now(),
      tipe: TipeTransaksi.cash,
      status: StatusAktivitas.bookingBerhasil,
    );
    await ref.read(aktivitasRepositoryProvider).upsertAktivitas(item);
  }

  Future<void> submitKreditTransaction({
    required String id,
    required String namaMotor,
    required String tipeUnit,
    required String dealer,
    required String imagePath,
  }) async {
    final item = AktivitasItem(
      id: id,
      namaMotor: namaMotor,
      tipeUnit: tipeUnit,
      dealer: dealer,
      imagePath: imagePath,
      tanggal: DateTime.now(),
      tipe: TipeTransaksi.kredit,
      status: StatusAktivitas.bookingBerhasil,
    );
    await ref.read(aktivitasRepositoryProvider).upsertAktivitas(item);
  }
}

final aktivitasViewModelProvider = NotifierProvider<AktivitasViewModel, List<AktivitasItem>>(() {
  return AktivitasViewModel();
});

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/providers.dart';
import '../../../../domain/models/aktivitas_item.dart';

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
      onError: (err) {
        // Stream error handling (safe-guarding state)
      },
    );

    // Ambil data inisial secara asinkronus agar data yang sudah ada tetap ditampilkan
    repository.getAktivitasList().then((data) {
      if (state.isEmpty && data.isNotEmpty) {
        state = data;
      }
    }).catchError((_) {
      // Gagal memuat data inisial
    });

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
    try {
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
    } catch (e) {
      // Safe guard logging or error handling in production
    }
  }

  Future<void> submitKreditTransaction({
    required String id,
    required String namaMotor,
    required String tipeUnit,
    required String dealer,
    required String imagePath,
  }) async {
    try {
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
    } catch (e) {
      // Safe guard logging or error handling in production
    }
  }
}

final aktivitasViewModelProvider = NotifierProvider<AktivitasViewModel, List<AktivitasItem>>(() {
  return AktivitasViewModel();
});

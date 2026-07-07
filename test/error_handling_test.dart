import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hondaku/data/providers.dart';
import 'package:hondaku/domain/models/aktivitas_item.dart';
import 'package:hondaku/domain/repositories/aktivitas_repository.dart';
import 'package:hondaku/ui/features/aktivitas/view_models/aktivitas_view_model.dart';
import 'package:hondaku/ui/features/kredit/view_models/kredit_view_model.dart';


class FakeFailureAktivitasRepository implements AktivitasRepository {
  @override
  Future<List<AktivitasItem>> getAktivitasList() async {
    throw Exception('Failed to load aktivitas list');
  }

  @override
  Stream<List<AktivitasItem>> watchAktivitasList() {
    return Stream.error(Exception('Failed to watch stream'));
  }

  @override
  Future<void> upsertAktivitas(AktivitasItem item) async {
    throw Exception('Failed to upsert transaction');
  }

  @override
  void dispose() {}
}

void main() {
  group('KreditViewModel Error Handling & Robustness -', () {
    test('dpNominal and pokokPinjaman bounds clamping', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final model = container.read(kreditViewModelProvider.notifier);

      // Positive test
      model.initHarga(20000000);
      model.updateDpPersen(0.15);
      expect(container.read(kreditViewModelProvider).hargaOTR, 20000000.0);
      expect(container.read(kreditViewModelProvider).dpPersen, 0.15);
      expect(container.read(kreditViewModelProvider).dpNominal, 3000000.0);
      expect(container.read(kreditViewModelProvider).pokokPinjaman, 17000000.0);

      // Clamp negative price
      model.initHarga(-500);
      expect(container.read(kreditViewModelProvider).hargaOTR, 0.0);

      // Clamp low percentage
      model.updateDpPersen(-0.5);
      expect(container.read(kreditViewModelProvider).dpPersen, 0.0);

      // Clamp high percentage
      model.updateDpPersen(1.5);
      expect(container.read(kreditViewModelProvider).dpPersen, 1.0);
    });

    test('Zero tenor division guard in hitungAngsuran', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final model = container.read(kreditViewModelProvider.notifier);
      model.initHarga(20000000);
      model.updateDpPersen(0.10);
      
      // Set tenor to 0
      model.updateTenor(0);
      expect(model.hitungAngsuran(0.115), 0.0);

      // Set tenor to negative
      model.updateTenor(-5);
      expect(model.hitungAngsuran(0.115), 0.0);
    });
  });

  group('AktivitasViewModel Async Error Handling -', () {
    test('Handles repository failures gracefully on stream listening and initialization', () {
      final container = ProviderContainer(
        overrides: [
          aktivitasRepositoryProvider.overrideWith((ref) => FakeFailureAktivitasRepository()),
        ],
      );
      addTearDown(container.dispose);

      // Initial state is empty list
      expect(container.read(aktivitasViewModelProvider), isEmpty);
    });

    test('submitCashTransaction returns false and logs on failure instead of throwing', () async {
      final container = ProviderContainer(
        overrides: [
          aktivitasRepositoryProvider.overrideWith((ref) => FakeFailureAktivitasRepository()),
        ],
      );
      addTearDown(container.dispose);

      final model = container.read(aktivitasViewModelProvider.notifier);
      final result = await model.submitCashTransaction(
        id: '123',
        namaMotor: 'Vario',
        tipeUnit: 'CBS',
        dealer: 'Dealer A',
        imagePath: 'path/to/image',
      );

      // Should return false and not crash
      expect(result, isFalse);
    });

    test('submitKreditTransaction returns false and logs on failure instead of throwing', () async {
      final container = ProviderContainer(
        overrides: [
          aktivitasRepositoryProvider.overrideWith((ref) => FakeFailureAktivitasRepository()),
        ],
      );
      addTearDown(container.dispose);

      final model = container.read(aktivitasViewModelProvider.notifier);
      final result = await model.submitKreditTransaction(
        id: '123',
        namaMotor: 'Vario',
        tipeUnit: 'CBS',
        dealer: 'Dealer A',
        imagePath: 'path/to/image',
      );

      // Should return false and not crash
      expect(result, isFalse);
    });
  });

}

import '../models/aktivitas_item.dart';

abstract class AktivitasRepository {
  Future<List<AktivitasItem>> getAktivitasList();
  Stream<List<AktivitasItem>> watchAktivitasList();
  Future<void> upsertAktivitas(AktivitasItem item);
  void dispose();
}

import 'dart:async';
import '../../domain/models/aktivitas_item.dart';
import '../../domain/repositories/aktivitas_repository.dart';

class AktivitasRepositoryImpl implements AktivitasRepository {
  final List<AktivitasItem> _items = [];
  final StreamController<List<AktivitasItem>> _controller = StreamController<List<AktivitasItem>>.broadcast();

  AktivitasRepositoryImpl() {
    _controller.add([]);
  }

  @override
  Future<List<AktivitasItem>> getAktivitasList() async {
    return List.unmodifiable(_items);
  }

  @override
  Stream<List<AktivitasItem>> watchAktivitasList() {
    return _controller.stream;
  }

  @override
  Future<void> upsertAktivitas(AktivitasItem item) async {
    final index = _items.indexWhere((e) => e.id == item.id);
    if (index >= 0) {
      _items[index] = item;
    } else {
      _items.insert(0, item);
    }
    _controller.add(List.unmodifiable(_items));
    
    if (item.status == StatusAktivitas.bookingBerhasil) {
      _startAutoProgress(item.id);
    }
  }

  void _startAutoProgress(String id) {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      final index = _items.indexWhere((e) => e.id == id);
      if (index >= 0) {
        final item = _items[index];
        StatusAktivitas? nextStatus;
        switch (item.status) {
          case StatusAktivitas.bookingBerhasil:
            nextStatus = StatusAktivitas.verifikasiSales;
            break;
          case StatusAktivitas.verifikasiSales:
            nextStatus = StatusAktivitas.persiapanUnit;
            break;
          case StatusAktivitas.persiapanUnit:
            nextStatus = StatusAktivitas.pengiriman;
            break;
          case StatusAktivitas.pengiriman:
            nextStatus = StatusAktivitas.selesai;
            timer.cancel();
            break;
          default:
            timer.cancel();
            return;
        }
        _items[index] = item.copyWith(status: nextStatus);
        _controller.add(List.unmodifiable(_items));
      } else {
        timer.cancel();
      }
    });
  }
}

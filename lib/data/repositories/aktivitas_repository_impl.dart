import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/aktivitas_item.dart';
import '../../domain/models/garage_item.dart';
import '../../domain/repositories/aktivitas_repository.dart';
import '../../domain/repositories/garage_repository.dart';

class AktivitasRepositoryImpl implements AktivitasRepository {
  final FirebaseFirestore _firestore;
  final String? uid;
  final GarageRepository? garageRepository;
  final StreamController<List<AktivitasItem>> _controller = StreamController<List<AktivitasItem>>.broadcast();
  StreamSubscription? _firestoreSub;
  final Map<String, Timer> _activeTimers = {};

  AktivitasRepositoryImpl({this.uid, this.garageRepository, FirebaseFirestore? firestore}) 
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _initStream();
  }

  Future<void> _initStream() async {
    // Jika login, dengarkan Firestore
    if (uid != null && uid!.isNotEmpty) {
      _listenToFirestore();
    } else {
      _controller.add([]);
    }
  }

  void _startTimersForItems(List<AktivitasItem> items) {
    for (var item in items) {
      if (item.status != StatusAktivitas.selesai && item.status != StatusAktivitas.ditolak) {
        if (!_activeTimers.containsKey(item.id)) {
           _startAutoProgress(item.id, item);
        }
      }
    }
  }

  void _listenToFirestore() {
    _firestoreSub?.cancel();
    _firestoreSub = _firestore
        .collection('users')
        .doc(uid)
        .collection('aktivitas')
        .orderBy('tanggal', descending: true)
        .snapshots()
        .listen((snapshot) {
      final items = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        if (data['tanggal'] is Timestamp) {
          data['tanggal'] = (data['tanggal'] as Timestamp).toDate().toIso8601String();
        }
        return AktivitasItem.fromJson(data);
      }).toList();
      _controller.add(items);
      _startTimersForItems(items);
    });
  }

  @override
  Future<List<AktivitasItem>> getAktivitasList() async {
    if (uid == null || uid!.isEmpty) return [];
    
    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('aktivitas')
        .orderBy('tanggal', descending: true)
        .get();
        
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      if (data['tanggal'] is Timestamp) {
        data['tanggal'] = (data['tanggal'] as Timestamp).toDate().toIso8601String();
      }
      return AktivitasItem.fromJson(data);
    }).toList();
  }

  @override
  Stream<List<AktivitasItem>> watchAktivitasList() {
    return _controller.stream;
  }

  @override
  Future<void> upsertAktivitas(AktivitasItem item) async {
    // Simpan ke Firebase
    if (uid != null && uid!.isNotEmpty) {
      try {
        final jsonItem = item.toJson();
        final json = Map<String, dynamic>.from(jsonItem);
        json['tanggal'] = Timestamp.fromDate(item.tanggal);
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('aktivitas')
            .doc(item.id)
            .set(json, SetOptions(merge: true));
      } catch (e) {
        throw Exception('Gagal menyimpan aktivitas ke server. Silakan coba lagi.');
      }
    } else {
      throw Exception('Anda harus login untuk menyimpan aktivitas.');
    }
  }

  void _startAutoProgress(String id, AktivitasItem item) {
    _activeTimers[id]?.cancel();
    _activeTimers[id] = Timer.periodic(const Duration(seconds: 10), (timer) async {
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
          break;
        default:
          timer.cancel();
          _activeTimers.remove(id);
          return;
      }
      
      final updatedItem = item.copyWith(status: nextStatus);
      await upsertAktivitas(updatedItem);
      
      if (nextStatus == StatusAktivitas.selesai) {
        timer.cancel();
        _activeTimers.remove(id);
        
        if (garageRepository != null) {
          try {
            final garageItem = GarageItem(
              id: item.id,
              name: item.namaMotor,
              type: item.tipeUnit,
              imagePath: item.imagePath,
              category: 'DAILY RIDE',
            );
            await garageRepository!.addVehicle(garageItem);
          } catch (e) {
            // Abaikan
          }
        }
      } else {
        item = updatedItem;
      }
    });
  }

  @override
  void dispose() {
    _firestoreSub?.cancel();
    _controller.close();
    for (var timer in _activeTimers.values) {
      timer.cancel();
    }
    _activeTimers.clear();
  }
}

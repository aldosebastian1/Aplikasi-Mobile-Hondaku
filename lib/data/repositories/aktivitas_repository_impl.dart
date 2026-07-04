import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/aktivitas_item.dart';
import '../../domain/repositories/aktivitas_repository.dart';

class AktivitasRepositoryImpl implements AktivitasRepository {
  final FirebaseFirestore _firestore;
  final String? uid;
  final StreamController<List<AktivitasItem>> _controller = StreamController<List<AktivitasItem>>.broadcast();
  StreamSubscription? _firestoreSub;
  final Map<String, Timer> _activeTimers = {};

  AktivitasRepositoryImpl({this.uid, FirebaseFirestore? firestore}) 
      : _firestore = firestore ?? FirebaseFirestore.instance {
    if (uid != null && uid!.isNotEmpty) {
      _listenToFirestore();
    } else {
      _controller.add([]);
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
        // Fix timestamp if needed, since Firestore timestamp -> DateTime
        if (data['tanggal'] is Timestamp) {
          data['tanggal'] = (data['tanggal'] as Timestamp).toDate().toIso8601String();
        }
        return AktivitasItem.fromJson(data);
      }).toList();
      _controller.add(items);
      
      // Auto-start progress for newly added items that are still active
      for (var item in items) {
        if (item.status != StatusAktivitas.selesai && item.status != StatusAktivitas.ditolak) {
          if (!_activeTimers.containsKey(item.id)) {
             _startAutoProgress(item.id, item);
          }
        }
      }
    });
  }

  @override
  Future<List<AktivitasItem>> getAktivitasList() async {
    if (uid == null || uid!.isEmpty) return [];
    try {
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
    } catch (e) {
      return [];
    }
  }

  @override
  Stream<List<AktivitasItem>> watchAktivitasList() {
    return _controller.stream;
  }

  @override
  Future<void> upsertAktivitas(AktivitasItem item) async {
    if (uid == null || uid!.isEmpty) return;
    final json = item.toJson();
    // Convert string ISO8601 back to Firestore Timestamp for better querying
    json['tanggal'] = Timestamp.fromDate(item.tanggal);
    
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('aktivitas')
        .doc(item.id)
        .set(json, SetOptions(merge: true));
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
      } else {
        // Update local reference to continue correctly
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

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/models/garage_item.dart';
import '../../domain/repositories/garage_repository.dart';
import '../local/database_helper.dart';

class GarageRepositoryImpl implements GarageRepository {
  final FirebaseFirestore _firestore;
  final String? uid;
  final StreamController<List<GarageItem>> _controller = StreamController<List<GarageItem>>.broadcast();
  StreamSubscription? _firestoreSub;

  GarageRepositoryImpl({this.uid, FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _initStream();
  }

  Future<void> _initStream() async {
    // 1. Muat dari lokal (selalu tersedia meski tanpa login)
    final db = await DatabaseHelper.instance.database;
    final localData = await db.query('garage');
    final items = localData.map((e) => GarageItem.fromJson(e)).toList();
    _controller.add(items);

    // 2. Jika login, dengarkan pembaruan dari Firestore
    if (uid != null && uid!.isNotEmpty) {
      _firestoreSub = _firestore
          .collection('users')
          .doc(uid)
          .collection('garage')
          .snapshots()
          .listen((snapshot) {
        final remoteItems = snapshot.docs.map((doc) => GarageItem.fromJson(doc.data())).toList();
        _controller.add(remoteItems);
      });
    }
  }

  @override
  Stream<List<GarageItem>> watchGarageItems() {
    return _controller.stream;
  }

  @override
  Future<void> addVehicle(GarageItem item) async {
    // 1. Simpan ke lokal (berhasil tanpa login)
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'garage', 
      item.toJson(), 
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Update stream lokal
    final localData = await db.query('garage');
    _controller.add(localData.map((e) => GarageItem.fromJson(e)).toList());

    // 2. Simpan ke Firebase (opsional/sync)
    if (uid != null && uid!.isNotEmpty) {
      try {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('garage')
            .doc(item.id)
            .set(item.toJson());
      } catch (e) {
        // Abaikan error jaringan/izin Firebase
      }
    }
  }

  void dispose() {
    _firestoreSub?.cancel();
    _controller.close();
  }
}

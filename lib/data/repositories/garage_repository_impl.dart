import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/garage_item.dart';
import '../../domain/repositories/garage_repository.dart';

class GarageRepositoryImpl implements GarageRepository {
  final FirebaseFirestore _firestore;
  final String? uid;

  GarageRepositoryImpl({this.uid, FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<GarageItem>> watchGarageItems() {
    if (uid == null || uid!.isEmpty) {
      return Stream.value([]);
    }
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('garage')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => GarageItem.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<void> addVehicle(GarageItem item) async {
    // Simpan ke Firebase saja
    if (uid != null && uid!.isNotEmpty) {
      try {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('garage')
            .doc(item.id)
            .set(item.toJson(), SetOptions(merge: true));
      } catch (e) {
        throw Exception('Gagal menyimpan data kendaraan. Silakan periksa koneksi internet Anda.');
      }
    } else {
      throw Exception('Anda harus login untuk menyimpan kendaraan.');
    }
  }

  void dispose() {
    // No longer need to cancel manual subscriptions
  }
}

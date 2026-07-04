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
    if (uid == null || uid!.isEmpty) return Stream.value([]);
    
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('garage')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => GarageItem.fromJson(doc.data()))
            .toList());
  }

  @override
  Future<void> addVehicle(GarageItem item) async {
    if (uid == null || uid!.isEmpty) return;
    
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('garage')
          .doc(item.id)
          .set(item.toJson());
    } catch (e) {
      throw Exception('Gagal menyimpan kendaraan ke garasi');
    }
  }
}

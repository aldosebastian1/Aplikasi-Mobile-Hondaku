import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/motorcycle.dart';
import '../../domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FirebaseFirestore _firestore;
  final String? uid;

  FavoriteRepositoryImpl({this.uid, FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addFavorite(Motorcycle motor) async {
    if (uid == null || uid!.isEmpty) return;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(motor.id)
        .set({
      'id': motor.id,
      'name': motor.name,
      'price': motor.price,
      'imageAsset': motor.imageAsset,
      'addedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  Future<void> removeFavorite(String motorId) async {
    if (uid == null || uid!.isEmpty) return;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(motorId)
        .delete();
  }

  @override
  Future<bool> isFavorite(String motorId) async {
    if (uid == null || uid!.isEmpty) return false;
    final doc = await _firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(motorId)
        .get();
    return doc.exists;
  }

  @override
  Future<List<Map<String, dynamic>>> getFavorites() async {
    if (uid == null || uid!.isEmpty) return [];
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .orderBy('addedAt', descending: true)
          .get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      return [];
    }
  }
}

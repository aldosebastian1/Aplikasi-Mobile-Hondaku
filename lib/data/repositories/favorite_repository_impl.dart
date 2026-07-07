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
    if (uid != null && uid!.isNotEmpty) {
      try {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('favorites')
            .doc(motor.id)
            .set({
          'addedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      } catch (e) {
        throw Exception('Gagal menambahkan ke daftar favorit. Silakan coba lagi nanti.');
      }
    } else {
      throw Exception('Anda harus login untuk menambahkan favorit.');
    }
  }

  @override
  Future<void> removeFavorite(String motorId) async {
    if (uid != null && uid!.isNotEmpty) {
      try {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('favorites')
            .doc(motorId)
            .delete();
      } catch (e) {
        throw Exception('Gagal menghapus dari daftar favorit. Silakan coba lagi.');
      }
    }
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
  Future<List<String>> getFavorites() async {
    if (uid == null || uid!.isEmpty) return [];
    
    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .orderBy('addedAt', descending: true)
        .get();
        
    return snapshot.docs.map((doc) => doc.id).toList();
  }
}

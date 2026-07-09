import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/review.dart';
import '../../domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final FirebaseFirestore _firestore;

  ReviewRepositoryImpl(this._firestore);

  @override
  Future<void> submitReview(Review review) async {
    try {
      await _firestore.collection('reviews').doc(review.id).set(review.toJson());
    } catch (e) {
      throw Exception('Gagal menyimpan ulasan: $e');
    }
  }

  @override
  Future<bool> hasReviewed(String userId, String pesananId) async {
    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where('userId', isEqualTo: userId)
          .where('pesananId', isEqualTo: pesananId)
          .limit(1)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      return false; // Anggap belum jika error
    }
  }

  @override
  Future<Review?> getReview(String userId, String pesananId) async {
    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where('userId', isEqualTo: userId)
          .where('pesananId', isEqualTo: pesananId)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return Review.fromJson(snapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

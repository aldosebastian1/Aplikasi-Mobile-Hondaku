import '../models/review.dart';

abstract class ReviewRepository {
  Future<void> submitReview(Review review);
  Future<bool> hasReviewed(String userId, String pesananId);
  Future<Review?> getReview(String userId, String pesananId);
}

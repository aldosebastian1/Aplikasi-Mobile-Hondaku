import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/review.dart';
import '../../../../data/providers.dart';
import '../../auth/providers/auth_provider.dart';

final reviewViewModelProvider = NotifierProvider<ReviewViewModel, AsyncValue<void>>(() {
  return ReviewViewModel();
});

final hasReviewedProvider = FutureProvider.family<bool, String>((ref, pesananId) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return false;
  
  final repo = ref.read(reviewRepositoryProvider);
  return repo.hasReviewed(user.uid, pesananId);
});

final getReviewProvider = FutureProvider.family<Review?, String>((ref, pesananId) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;
  
  final repo = ref.read(reviewRepositoryProvider);
  return repo.getReview(user.uid, pesananId);
});

class ReviewViewModel extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<bool> submitReview({
    required String pesananId,
    required String motorId,
    required String namaMotor,
    required int rating,
    required String komentar,
  }) async {
    state = const AsyncValue.loading();
    try {
      final user = ref.read(authStateProvider).value;
      if (user == null) {
        throw Exception('User tidak ditemukan');
      }

      final repo = ref.read(reviewRepositoryProvider);
      final id = 'REV-${DateTime.now().millisecondsSinceEpoch}';
      
      final review = Review(
        id: id,
        userId: user.uid,
        pesananId: pesananId,
        motorId: motorId,
        namaMotor: namaMotor,
        rating: rating,
        komentar: komentar,
        createdAt: DateTime.now(),
      );

      await repo.submitReview(review);
      
      // Invalidate provider so button state updates
      ref.invalidate(hasReviewedProvider(pesananId));
      ref.invalidate(getReviewProvider(pesananId));
      
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

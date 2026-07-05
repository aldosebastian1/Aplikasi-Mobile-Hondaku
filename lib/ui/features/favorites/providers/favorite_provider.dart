import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/motorcycle.dart';
import '../../../../domain/repositories/favorite_repository.dart';
import '../../../../data/repositories/favorite_repository_impl.dart';
import '../../auth/providers/auth_provider.dart';

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  final user = ref.watch(authStateProvider).value;
  return FavoriteRepositoryImpl(uid: user?.uid);
});

class FavoriteNotifier extends Notifier<List<String>> {
  late final FavoriteRepository _repository;

  @override
  List<String> build() {
    _repository = ref.watch(favoriteRepositoryProvider);
    _loadFavorites();
    return [];
  }

  Future<void> _loadFavorites() async {
    final favorites = await _repository.getFavorites();
    state = favorites.map((e) => e['id'] as String).toList();
  }

  Future<void> toggleFavorite(Motorcycle motor) async {
    final isCurrentlyFav = state.contains(motor.id);
    
    // Optimistic UI Update: Langsung ubah state agar tombol terasa responsif
    if (isCurrentlyFav) {
      state = state.where((id) => id != motor.id).toList();
    } else {
      state = [...state, motor.id];
    }

    try {
      // Background request ke database
      if (isCurrentlyFav) {
        await _repository.removeFavorite(motor.id);
      } else {
        await _repository.addFavorite(motor);
      }
    } catch (e) {
      // Rollback jika terjadi error pada database (misal: permission denied / koneksi putus)
      if (isCurrentlyFav) {
        state = [...state, motor.id];
      } else {
        state = state.where((id) => id != motor.id).toList();
      }
      debugPrint('Error toggling favorite: $e');
    }
  }

  bool isFavorite(String id) {
    return state.contains(id);
  }
}

final favoriteProvider = NotifierProvider<FavoriteNotifier, List<String>>(() {
  return FavoriteNotifier();
});

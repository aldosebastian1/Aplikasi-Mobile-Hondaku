import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/motorcycle.dart';
import '../../../../domain/repositories/favorite_repository.dart';
import '../../../../data/repositories/favorite_repository_impl.dart';

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepositoryImpl();
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
    if (state.contains(motor.id)) {
      await _repository.removeFavorite(motor.id);
      state = state.where((id) => id != motor.id).toList();
    } else {
      await _repository.addFavorite(motor);
      state = [...state, motor.id];
    }
  }

  bool isFavorite(String id) {
    return state.contains(id);
  }
}

final favoriteProvider = NotifierProvider<FavoriteNotifier, List<String>>(() {
  return FavoriteNotifier();
});

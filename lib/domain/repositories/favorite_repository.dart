import '../models/motorcycle.dart';

abstract class FavoriteRepository {
  Future<void> addFavorite(Motorcycle motor);
  Future<void> removeFavorite(String motorId);
  Future<bool> isFavorite(String motorId);
  Future<List<String>> getFavorites();
}

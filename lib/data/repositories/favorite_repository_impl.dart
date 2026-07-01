import 'package:sqflite/sqflite.dart';
import '../../domain/models/motorcycle.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../local/database_helper.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> addFavorite(Motorcycle motor) async {
    final db = await _dbHelper.database;
    await db.insert(
      'favorites',
      {
        'id': motor.id,
        'name': motor.name,
        'price': motor.price,
        'imageAsset': motor.imageAsset,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(String motorId) async {
    final db = await _dbHelper.database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [motorId],
    );
  }

  Future<bool> isFavorite(String motorId) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'favorites',
      columns: ['id'],
      where: 'id = ?',
      whereArgs: [motorId],
    );
    return maps.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await _dbHelper.database;
    final result = await db.query('favorites');
    return result;
  }
}

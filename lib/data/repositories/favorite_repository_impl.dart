import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/models/motorcycle.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../local/database_helper.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FirebaseFirestore _firestore;
  final String? uid;

  FavoriteRepositoryImpl({this.uid, FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addFavorite(Motorcycle motor) async {
    // 1. Simpan ke database lokal SQLite agar langsung tersimpan meskipun offline/tanpa login
    final db = await DatabaseHelper.instance.database;
    await db.insert('favorites', {
      'id': motor.id,
      'name': motor.name,
      'price': motor.price,
      'imageAsset': motor.imageAsset,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    // 2. Coba sinkronisasi ke Firebase jika user login
    if (uid != null && uid!.isNotEmpty) {
      try {
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
      } catch (e) {
        // Abaikan error Firebase jika aturan keamanan memblokir
      }
    }
  }

  @override
  Future<void> removeFavorite(String motorId) async {
    // 1. Hapus dari database lokal SQLite
    final db = await DatabaseHelper.instance.database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [motorId]);

    // 2. Coba hapus dari Firebase jika user login
    if (uid != null && uid!.isNotEmpty) {
      try {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('favorites')
            .doc(motorId)
            .delete();
      } catch (e) {
        // Abaikan error Firebase
      }
    }
  }

  @override
  Future<bool> isFavorite(String motorId) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [motorId],
    );
    return maps.isNotEmpty;
  }

  @override
  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await DatabaseHelper.instance.database;
    // Mengambil data dari SQLite, memastikan bisa tampil meski tanpa login
    return await db.query('favorites');
  }
}

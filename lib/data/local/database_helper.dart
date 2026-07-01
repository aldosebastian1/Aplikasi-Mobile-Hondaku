import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('hondaku.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // Determine the exact directory where the DB should be stored
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Creating the 'favorites' table
    await db.execute('''
CREATE TABLE favorites (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  price TEXT NOT NULL,
  imageAsset TEXT NOT NULL
)
''');
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}

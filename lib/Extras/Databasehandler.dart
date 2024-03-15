import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Modal/LatLngModel.dart';

class DatabaseHelper {
  late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE latlngs(
        id INTEGER PRIMARY KEY,
       latitude REAL,
         longitude REAL,
       
        
      )
    ''');
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'latlng_database.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> insertLatLng(LatLngModel latLng) async {
    final Database db = await database;
    await db.insert(
      'latlngs',
      latLng.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

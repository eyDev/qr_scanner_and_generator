import 'package:eydev_qr_scanner_and_generator/src/models/ScanModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConnection {
  static Database? _database;
  static final DBConnection db = DBConnection._();

  DBConnection._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future _initDB() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'ScansDB.db');
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans('
          ' id INTEGER PRIMARY KEY,'
          ' data TEXT NOT NULL'
          ')');
    });
  }

  Future<int> newScan(ScanModel scan) async {
    final Database db = await database;
    final int res = await db.insert('Scans', scan.toJson());
    return res;
  }

  Future<List<ScanModel>> getScans() async {
    final Database db = await database;
    final List<Map<String, dynamic>> res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
    return list;
  }

  Future<int> deleteScan(int id) async {
    final Database db = await database;
    final int res = await db.delete('Scans', where: 'id=?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteALlScans() async {
    final Database db = await database;
    final int res = await db.rawDelete("DELETE FROM Scans");
    return res;
  }

  Future<List<ScanModel>> searchScans(query) async {
    final Database db = await database;
    final List<Map<String, dynamic>> res = await db.query(
      'Scans',
      where: 'data LIKE ?',
      whereArgs: ["%$query%"],
    );

    List<ScanModel> list = res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
    return list;
  }
}

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/scan_model.dart';
export '../models/scan_model.dart';

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    //* Path from where the database will be stored
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = '${documentsDirectory.path}/ScansDB.db';

    print(path);

    // * Create the database
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          type TEXT,
          value TEXT
        );
      ''');
    });
  }

  newScanRaw(ScanModel newScan) async {
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans (id, type, value)
      VALUES (${newScan.id}, '${newScan.type}', '${newScan.value}')
    ''');

    return res;
  }

  newScan(ScanModel newScan) async {
    final db = await database;

    final res = await db.insert('Scans', newScan.toMap());

    //* ID of the last inserted row
    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty
        ? ScanModel.fromMap(res.first)
        : throw 'ID: $id not found';
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final res = await db.rawQuery(''' 
      SELECT * FROM Scans WHERE type = '$type'
    
      ''');

    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromMap(scan)).toList()
        : [];
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromMap(scan)).toList()
        : [];
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.update('Scans', newScan.toMap(),
        where: 'id = ?', whereArgs: [newScan.id]);

    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');

    return res;
  }
}

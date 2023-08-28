import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'pemilih.dart';

class DatabaseLocal {
  final String _databaseName = 'kpu_database.db';
  final int _databaseVersion = 1;

  final String table = 'pemilih';
  final String id = 'id';
  final String nik = 'nik';
  final String nama = 'nama';
  final String noHp = 'noHp';
  final String jk = 'jk';
  final String tglData = 'tglData';
  final String koordinat = 'koordinat';
  final String photoName = 'photoName';

  Database? _database;
  Future<Database> database() async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<dynamic> alterTable() async {
    await _database!.execute("ALTER TABLE $table ADD "
        "COLUMN photoName TEXT;");
    print("Tambah Data Berhasil");
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $nik TEXT, $nama TEXT, $noHp TEXT, $jk TEXT, $tglData TEXT, $koordinat TEXT, $photoName TEXT)');
  }

  Future<List<PemilihModel>> fetchData() async {
    // final data = await _database!.query(table);
    final data = await _database!.rawQuery('select * from $table');
    List<PemilihModel> result =
        data.map((e) => PemilihModel.fromJson(e)).toList();
    print(result);

    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(table, row);
    print("Sukses Add Data");
    return query;
  }

  Future deleteAll() async {
    // await _database!.delete(table);

    await _database!.rawDelete("DELETE FROM $table");
  }
}

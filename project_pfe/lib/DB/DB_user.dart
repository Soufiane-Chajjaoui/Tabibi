// pour stocke les donnees dans sqflite
// ignore_for_file: camel_case_types, prefer_const_declarations, unnecessary_brace_in_string_interps

import 'dart:async';

import 'package:path/path.dart';
import 'package:project_pfe/DB/models/user.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:sqflite/sqflite.dart';

class Auth_DATABASE {
  static final Auth_DATABASE instance = Auth_DATABASE._init();
  static Database? _database;

  Auth_DATABASE._init();
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB('Auth.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onceateDB);
  }

  Future<void> _onceateDB(Database db, int version) async {
    final idtype = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final name = 'VARCHAR(30) ';
    final cni = 'VARCHAR(10) ';
    final tele = 'VARCHAR(10) ';
    // final image = 'BLOB ';

    await db.execute('''
        CREATE TABLE $tablePatient (
        ${PatientFields.id} $idtype ,
        ${PatientFields.complete_name}  $name,
        ${PatientFields.cni}  $cni,
        ${PatientFields.tele}  $tele
         )''');
  }

  Future<Patient> insertPatient(Patient P) async {
    final db = await instance.database;
    final id = await db?.insert(tablePatient, P.toJson());
    return P.copy(id: id);
  }

  Future<Patient> readPatient(int id) async {
    final db = await instance.database;
    final maps = await db!.query(
      tablePatient,
      columns: PatientFields.values,
      where: '${PatientFields}.id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      return Patient.fromjson(maps.first);
    } else {
      throw Exception('id $id not found');
    }
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }
}

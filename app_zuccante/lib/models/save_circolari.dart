import 'dart:async';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SaveCircolare {
  final String id;
  final String title;
  final String content;
  final String link;
  final String pubblicazione;
  final String scadenza;

  const SaveCircolare({
    required this.id,
    required this.title,
    required this.content,
    required this.link,
    required this.pubblicazione,
    required this.scadenza,
  });
}

class CircolariDb {
  CircolariDb._privatecostructor();
  static final CircolariDb instance = CircolariDb._privatecostructor();
  static Database? _circolari;
  Future<Database> get database async {
    if (_circolari != null) return _circolari!;

    _circolari = await _initDB('circolari.db');
    return _circolari!;
  }

  CircolariDb.init();

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE circolare(
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  title TEXT NOT NULL, 
  content TEXT NOT NULL,
  link TEXT NOT NULL,
  pubblicazione TEXT NOT NULL,
  scadenza TEXT NOT NULL,
  )
''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert("circolare", row);
  }

  Future<List<Map<String, dynamic>>> queryAll(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.query("circolare");
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row["id"];
    return await db.update("circolare", row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete("circolare", where: 'id = ?', whereArgs: [id]);
  }
}

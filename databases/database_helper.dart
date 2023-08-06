import 'package:path_provider/path_provider.dart';  
import 'dart:async'; 
import 'dart:typed_data';  
import 'package:flutter/services.dart';  
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:commalarm_app/models/traffic_data_model.dart';

class DataBaseHelper {
  
  static const int _version = 1;
  static const String _dbName = "commalarm_proj_data.db";
  static const String table_name = "commalarm_data";
  static const String column_id = "_id";
  static const String column_origin = "origin";
  static const String column_destination = "destination";
  static const String column_duration_in_traffic = "durationInTraffic";

  static const String CREATE_TABLE = "CREATE TABLE $table_name ("
      "$column_id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$column_origin TEXT,"
      "$column_destination TEXT,"
      "$column_duration_in_traffic TEXT"
      ")";


  

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(CREATE_TABLE),
        version: _version);
  }

  static Future<void> insertData(DBDataModel dbDataModel) async {
    final db = await _getDB();
    await db.insert(
      table_name,
      dbDataModel.toJSON(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateData(DBDataModel dbDataModel) async {
    final db = await _getDB();
    return await db.update(
      table_name,
      dbDataModel.toJSON(),
      where: "id = ?",
      whereArgs: [dbDataModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteData(int id) async {
    final db = await _getDB();
    await db.delete(
      table_name,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<DBDataModel>> getAllData() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(table_name);
    return List.generate(maps.length, (i) {
      return DBDataModel.fromJSON(maps[i]);
    }
    );
  }

  static Future<void> deleteAllData() async {
    final db = await _getDB();
    await db.delete(table_name);
  }

  static Future<void> insertDataList(List<DBDataModel> dbDataModelList) async {
    final db = await _getDB();
    Batch batch = db.batch();
    dbDataModelList.forEach((dbDataModel) {
      batch.insert(table_name, dbDataModel.toJSON());
    });
    await batch.commit(noResult: true);
    
  }

  static Future<void> updateDataList(List<DBDataModel> dbDataModelList) async {
    final db = await _getDB();
    Batch batch = db.batch();
    dbDataModelList.forEach((dbDataModel) {
      batch.update(table_name, dbDataModel.toJSON(), where: "id = ?", whereArgs: [dbDataModel.id]);
    });
    await batch.commit(noResult: true);
  }

  static Future<void> deleteDataList(List<int> idList) async {
    final db = await _getDB();
    Batch batch = db.batch();
    idList.forEach((id) {
      batch.delete(table_name, where: "id = ?", whereArgs: [id]);
    });
    await batch.commit(noResult: true);
  }

  static Future<void> deleteAllDataList() async {
    final db = await _getDB();
    Batch batch = db.batch();
    batch.delete(table_name);
    await batch.commit(noResult: true);
  }

  

  static Future<void> insertDataMap(Map<int, DBDataModel> dbDataModelMap) async {
    final db = await _getDB();
    Batch batch = db.batch();
    dbDataModelMap.forEach((key, value) {
      batch.insert(table_name, value.toJSON());
    });
    await batch.commit(noResult: true);
  }


  static Future<void> updateDataMap(Map<int, DBDataModel> dbDataModelMap) async {
    final db = await _getDB();
    Batch batch = db.batch();
    dbDataModelMap.forEach((key, value) {
      batch.update(table_name, value.toJSON(), where: "id = ?", whereArgs: [value.id]);
    });
    await batch.commit(noResult: true);
  }

  static Future<void> deleteDataMap(Map<int, DBDataModel> dbDataModelMap) async {
    final db = await _getDB();
    Batch batch = db.batch();
    dbDataModelMap.forEach((key, value) {
      batch.delete(table_name, where: "id = ?", whereArgs: [value.id]);
    });
    await batch.commit(noResult: true);
  }

  static Future<void> deleteAllDataMap() async {
    final db = await _getDB();
    Batch batch = db.batch();
    batch.delete(table_name);
    await batch.commit(noResult: true);
  }

}

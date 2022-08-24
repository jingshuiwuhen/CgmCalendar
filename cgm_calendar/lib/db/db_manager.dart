import 'dart:io';

import 'package:cgm_calendar/db/schedule_db_model.dart';
import 'package:cgm_calendar/db/sql_str.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBManager {
  Database? database;

  static final DBManager db = DBManager._();
  DBManager._();

  Future _initDB() async {
    String directory;
    if (Platform.isAndroid) {
      directory = await getDatabasesPath();
    } else if (Platform.isIOS) {
      Directory dir = await getLibraryDirectory();
      directory = dir.path;
    } else {
      throw Exception("Do not support other platform");
    }

    String path = "$directory/schedule.db";
    debugPrint(path);
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int v) async {
      await db.execute(SQLStr.createTableSchedule);
    });
  }

  Future _checkDB() async {
    if (database == null) {
      await _initDB();
    }
  }

  Future<ScheduleDBModel> insert(ScheduleDBModel model) async {
    await _checkDB();
    model.id = await database?.insert(tableName, model.toMap());
    return model;
  }

  Future delete(int id) async {
    await _checkDB();
    await database?.delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }

  Future deleteTimeOutSchedules(int time) async {
    await _checkDB();
    await database?.delete(tableName,
        where:
            "($columnRepeatType = ? and $columnEndTime <= ?) or ($columnRepeatType <> ? and $columnRepeatUntil <= ?)",
        whereArgs: [0, time, 0, time]);
  }

  Future update(ScheduleDBModel model) async {
    await _checkDB();
    await database?.update(tableName, model.toMap(),
        where: "$columnId = ?", whereArgs: [model.id]);
  }

  Future<List<ScheduleDBModel>> getAll() async {
    List<ScheduleDBModel> datas = List.empty(growable: true);
    await _checkDB();
    List<Map<String, Object?>>? maps =
        await database?.query(tableName, columns: [
      columnId,
      columnTitle,
      columnStartTime,
      columnEndTime,
      columnExceptionTimes,
      columnRepeatUntil,
      columnRepeatType,
      columnScheduleType,
      columnRemarks,
    ]);

    if (maps != null && maps.isNotEmpty) {
      for (Map<String, Object?> map in maps) {
        datas.add(ScheduleDBModel.fromMap(map));
      }
    }
    return datas;
  }
}

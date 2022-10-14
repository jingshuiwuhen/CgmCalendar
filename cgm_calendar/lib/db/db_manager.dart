import 'package:cgm_calendar/db/schedule_db_model.dart';
import 'package:cgm_calendar/db/sql_str.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  Database? database;

  static final DBManager db = DBManager._();
  DBManager._();

  Future _initDB() async {
    String directory = "${await getDatabasesPath()}/schedule.db";
    debugPrint(directory);
    database = await openDatabase(directory, version: 1,
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
    model.id = await database!.insert(tableName, model.toMap());
    return model;
  }

  Future delete(int id) async {
    await _checkDB();
    await database?.delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }

  Future update(ScheduleDBModel model) async {
    await _checkDB();
    await database?.update(tableName, model.toMap(),
        where: "$columnId = ?", whereArgs: [model.id]);
  }

  Future<ScheduleDBModel> getOneSchedule(int id) async {
    await _checkDB();
    List<Map<String, Object?>> maps = await database!.query(
      tableName,
      columns: [
        columnId,
        columnTitle,
        columnStartTime,
        columnEndTime,
        columnExceptionTimes,
        columnRepeatUntil,
        columnRepeatType,
        columnScheduleType,
        columnRemarks,
      ],
      where: "$columnId = ?",
      whereArgs: [id],
    );

    return ScheduleDBModel.fromMap(maps.first);
  }
}

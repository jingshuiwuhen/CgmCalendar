import 'package:cgm_calendar/db/schedule_db_model.dart';

class SQLStr {
  static const String createTableSchedule =
      """CREATE TABLE IF NOT EXISTS $tableName
      ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $columnTitle TEXT NOT NULL, 
      $columnStartTime INTEGER NOT NULL, 
      $columnEndTime INTEGER NOT NULL, 
      $columnExceptionTimes TEXT,
      $columnRepeatUntil INTEGER,
      $columnRepeatType INTEGER NOT NULL, 
      $columnScheduleType INTEGER NOT NULL, 
      $columnRemarks TEXT)""";
}

import 'package:cgm_calendar/models/schedule_model.dart';

const String tableName = "Schedule";
const String columnId = "id";
const String columnTitle = "title";
const String columnStartTime = "start_time";
const String columnEndTime = "end_time";
const String columnExceptionTimes = "exception_times";
const String columnRepeatUntil = "repeat_until";
const String columnRepeatType = "repeat_type";
const String columnScheduleType = "schedule_type";
const String columnRemarks = "remarks";

class ScheduleDBModel {
  int? id;
  String title = "";
  int startTime = 0;
  int endTime = 0;
  int repeatType = 0;
  String exceptionTimes = "";
  int repeatUntil = 0;
  int scheduleType = 0;
  String remarks = "";

  ScheduleDBModel();

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnTitle: title,
      columnStartTime: startTime,
      columnEndTime: endTime,
      columnExceptionTimes: exceptionTimes,
      columnRepeatUntil: repeatUntil,
      columnRepeatType: repeatType,
      columnScheduleType: scheduleType,
      columnRemarks: remarks,
    };

    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }

  ScheduleDBModel.fromMap(Map<String, Object?> map) {
    id = map[columnId]! as int;
    title = map[columnTitle]! as String;
    startTime = map[columnStartTime]! as int;
    endTime = map[columnEndTime]! as int;
    exceptionTimes = map[columnExceptionTimes]! as String;
    repeatUntil = map[columnRepeatUntil]! as int;
    repeatType = map[columnRepeatType]! as int;
    scheduleType = map[columnScheduleType]! as int;
    remarks = map[columnRemarks]! as String;
  }

  ScheduleModel copyToScheduleModel() {
    ScheduleModel scheduleModel = ScheduleModel();
    scheduleModel.id = id ?? 0;
    scheduleModel.title = title;
    scheduleModel.startTime = startTime;
    scheduleModel.endTime = endTime;
    scheduleModel.repeatType = repeatType;
    scheduleModel.scheduleType = scheduleType;
    scheduleModel.remarks = remarks;
    scheduleModel.repeatUntil = repeatUntil;
    return scheduleModel;
  }

  void copyFromScheduleModel(ScheduleModel model) {
    title = model.title;
    startTime = model.startTime;
    endTime = model.endTime;
    repeatType = model.repeatType;
    scheduleType = model.scheduleType;
    remarks = model.remarks;
    repeatUntil = model.repeatUntil;
  }
}

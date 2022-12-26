import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:cgm_calendar/view_models/set_schedule_page_view_model.dart';

const String columnId = "id";
const String columnTitle = "title";
const String columnStartTime = "start_time";
const String columnEndTime = "end_time";
const String columnExceptionTimes = "exception_times";
const String columnRepeatUntil = "repeat_until";
const String columnRepeatType = "repeat_type";
const String columnScheduleType = "schedule_type";
const String columnRemarks = "remarks";
const String columnAlarmTime = "alarm_time";

class ScheduleDBModel {
  int id = 0;
  String title = "";
  int startTime = 0;
  int endTime = 0;
  int repeatType = 0;
  String exceptionTimes = "";
  int repeatUntil = 0;
  int scheduleType = 0;
  String remarks = "";
  int alarmTime = 0;

  ScheduleDBModel();

  Map<String, Object> toMap() {
    var map = <String, Object>{
      columnId: id,
      columnTitle: title,
      columnStartTime: startTime,
      columnEndTime: endTime,
      columnExceptionTimes: exceptionTimes,
      columnRepeatUntil: repeatUntil,
      columnRepeatType: repeatType,
      columnScheduleType: scheduleType,
      columnRemarks: remarks,
      columnAlarmTime: alarmTime,
    };

    return map;
  }

  ScheduleDBModel.fromMap(Map<String, dynamic> map) {
    id = map[columnId]! as int;
    title = map[columnTitle]! as String;
    startTime = map[columnStartTime]! as int;
    endTime = map[columnEndTime]! as int;
    exceptionTimes = map[columnExceptionTimes]! as String;
    repeatUntil = map[columnRepeatUntil]! as int;
    repeatType = map[columnRepeatType]! as int;
    scheduleType = map[columnScheduleType]! as int;
    remarks = map[columnRemarks]! as String;
    alarmTime = map[columnAlarmTime]! as int;
  }

  ScheduleModel copyToScheduleModel() {
    ScheduleModel scheduleModel = ScheduleModel(DateTime.now());
    scheduleModel.id = id;
    scheduleModel.title = title;
    scheduleModel.startTime = startTime;
    scheduleModel.endTime = endTime;
    scheduleModel.repeatType = RepeatType.values[repeatType];
    scheduleModel.scheduleType = ScheduleType.values[scheduleType];
    scheduleModel.remarks = remarks;
    scheduleModel.repeatUntil = repeatUntil;
    scheduleModel.alarmType = _getAlertType();
    return scheduleModel;
  }

  void copyFromScheduleModel(ScheduleModel model) {
    id = model.id;
    title = model.title;
    startTime = model.startTime;
    endTime = model.endTime;
    repeatType = model.repeatType.index;
    scheduleType = model.scheduleType.index;
    remarks = model.remarks;
    repeatUntil = model.repeatUntil;
    alarmTime = model.changeAlertTypeToTime();
  }

  AlertType _getAlertType() {
    if (alarmTime == 0) {
      return AlertType.none;
    }

    final startTimeStr = startTime.toString();
    final startFormattedStr =
        '${startTimeStr.substring(0, 8)} ${startTimeStr.substring(8, 10)}:${startTimeStr.substring(10)}:00';
    DateTime startDateTime = DateTime.parse(startFormattedStr);

    final alarmTimeStr = alarmTime.toString();
    final alarmFormattedStr =
        '${alarmTimeStr.substring(0, 8)} ${alarmTimeStr.substring(8, 10)}:${alarmTimeStr.substring(10)}:00';
    DateTime alarmDateTime = DateTime.parse(alarmFormattedStr);

    final duration = startDateTime.difference(alarmDateTime).abs();
    if (duration.inMinutes == 5) {
      return AlertType.fiveMinutesBefore;
    } else if (duration.inMinutes == 10) {
      return AlertType.tenMinutesBefore;
    } else if (duration.inMinutes == 15) {
      return AlertType.fifteenMinutesBefore;
    } else if (duration.inMinutes == 30) {
      return AlertType.thirtyMinutesBefore;
    } else if (duration.inHours == 1) {
      return AlertType.oneHourBefore;
    } else if (duration.inHours == 2) {
      return AlertType.oneHourBefore;
    } else if (duration.inDays == 1) {
      return AlertType.oneDayBefore;
    } else {
      return AlertType.none;
    }
  }
}

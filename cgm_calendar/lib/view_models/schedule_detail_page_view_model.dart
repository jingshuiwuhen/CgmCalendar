import 'package:cgm_calendar/add_schedule_helper.dart';
import 'package:cgm_calendar/db/db_manager.dart';
import 'package:cgm_calendar/db/schedule_db_model.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:intl/intl.dart';

enum DeleteType {
  thisOnly,
  futureContainsThis,
}

class ScheduleDetailPageViewModel {
  late ScheduleModel _model;
  String _title = "";
  String _timeStr1 = "";
  String _timeStr2 = "";
  int _repeatType = 0;
  int _scheduleType = 0;
  int _repeatUntil = 0;
  String _remarks = "";

  ScheduleDetailPageViewModel(ScheduleModel model) {
    _model = model;
    _setParams();
  }

  String get title => _title;
  String get timeStr1 => _timeStr1;
  String get timeStr2 => _timeStr2;
  int get repeatType => _repeatType;
  int get scheduleType => _scheduleType;
  int get repeatUntil => _repeatUntil;
  String get remarks => _remarks;

  void _setParams() {
    _title = _model.title;
    _makeTimeStr();
    _repeatType = _model.repeatType;
    _scheduleType = _model.scheduleType;
    _remarks = _model.remarks;
    _repeatUntil = _model.repeatUntil;
  }

  void _makeTimeStr() {
    int startDate = _model.startTime ~/ 10000;
    int endDate = _model.endTime ~/ 10000;
    if (startDate == endDate) {
      DateTime time = DateTime.parse(startDate.toString());
      _timeStr1 = DateFormat.yMMMMEEEEd(Global.localeStr()).format(time);
      String startTimeStr = _model.startTime.toString().substring(8);
      String endTimeStr = _model.endTime.toString().substring(8);
      _timeStr2 =
          "${startTimeStr.substring(0, 2)}:${startTimeStr.substring(2)} - ${endTimeStr.substring(0, 2)}:${endTimeStr.substring(2)}";
    } else {
      String startTimeStr = _model.startTime.toString().substring(8);
      DateTime start = DateTime.parse(
          "${startDate.toString()} ${startTimeStr.substring(0, 2)}:${startTimeStr.substring(2)}:00");
      _timeStr1 =
          "开始 : ${DateFormat.yMMMMEEEEd(Global.localeStr()).add_Hm().format(start)}";

      String endTimeStr = _model.endTime.toString().substring(8);
      DateTime end = DateTime.parse(
          "${endDate.toString()} ${endTimeStr.substring(0, 2)}:${endTimeStr.substring(2)}:00");
      _timeStr2 =
          "结束 : ${DateFormat.yMMMMEEEEd(Global.localeStr()).add_Hm().format(end)}";
    }
  }

  Future deleteNoRepeatSchedule() async {
    await DBManager.db.delete(_model.id);
    _deleteLocalSchedule(_model.id);
  }

  Future deleteRepeatSchedule(DeleteType deleteType) async {
    ScheduleDBModel dbModel = await DBManager.db.getOneSchedule(_model.id);
    if (deleteType == DeleteType.thisOnly) {
      dbModel.exceptionTimes = "${dbModel.exceptionTimes}${_model.startTime},";
    } else {
      dbModel.repeatUntil = _model.startTime;
    }

    if (dbModel.repeatUntil > 0 && dbModel.repeatUntil <= dbModel.startTime) {
      await DBManager.db.delete(_model.id);
    } else {
      await DBManager.db.update(dbModel);
    }

    _deleteLocalSchedule(_model.id);
    AddScheduleHelper.addToCalendar(dbModel);
  }

  void _deleteLocalSchedule(int id) {
    List<DayModel>? days = Global.idScheduleMap[_model.id];
    if (days == null) {
      return;
    }
    for (var day in days) {
      day.scheduleList.removeWhere((element) => element.id == _model.id);
    }
  }
}

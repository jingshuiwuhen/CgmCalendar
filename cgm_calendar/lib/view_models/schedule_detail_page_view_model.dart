import 'package:cgm_calendar/add_schedule_helper.dart';
import 'package:cgm_calendar/app_shared_pref.dart';
import 'package:cgm_calendar/models/schedule_db_model.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:cgm_calendar/network/remote_api.dart';
import 'package:cgm_calendar/view_models/set_schedule_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_context/one_context.dart';

enum DeleteType {
  thisOnly,
  futureContainsThis,
}

class ScheduleDetailPageViewModel {
  late ScheduleModel _model;
  String _title = "";
  String _timeStr1 = "";
  String _timeStr2 = "";
  RepeatType _repeatType = RepeatType.none;
  ScheduleType _scheduleType = ScheduleType.personal;
  int _repeatUntil = 0;
  String _remarks = "";
  AlertType _alertType = AlertType.none;

  ScheduleDetailPageViewModel(ScheduleModel model) {
    _model = model;
    _setParams();
  }

  String get title => _title;
  String get timeStr1 => _timeStr1;
  String get timeStr2 => _timeStr2;
  RepeatType get repeatType => _repeatType;
  ScheduleType get scheduleType => _scheduleType;
  int get repeatUntil => _repeatUntil;
  String get remarks => _remarks;
  AlertType get alertType => _alertType;

  void _setParams() {
    _title = _model.title;
    _makeTimeStr();
    _repeatType = _model.repeatType;
    _scheduleType = _model.scheduleType;
    _remarks = _model.remarks;
    _repeatUntil = _model.repeatUntil;
    _alertType = _model.alarmType;
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

  Future deleteNoRepeatSchedule(
      BuildContext context, Function() success) async {
    final remoteApi = RemoteApi(context);
    OneContext().context = context;
    await OneContext().showProgressIndicator();
    try {
      await remoteApi.deleteSchedules(
        [_model.id],
        await AppSharedPref.loadUid(),
      );
      _deleteLocalSchedule(_model.id);
      success();
    } catch (e) {
      debugPrint("deleteNoRepeatSchedule error ${e.toString()}");
    } finally {
      OneContext().hideProgressIndicator();
    }
  }

  Future deleteRepeatSchedule(
      DeleteType deleteType, BuildContext context, Function() success) async {
    final remoteApi = RemoteApi(context);
    OneContext().context = context;
    await OneContext().showProgressIndicator();
    try {
      Map<String, dynamic> schedule = await remoteApi.getOneSchedule(
        _model.id,
        await AppSharedPref.loadUid(),
      );
      ScheduleDBModel dbModel = ScheduleDBModel.fromMap(schedule);
      if (deleteType == DeleteType.thisOnly) {
        dbModel.exceptionTimes =
            "${dbModel.exceptionTimes}${_model.startTime},";
      } else {
        dbModel.repeatUntil = _model.startTime;
      }

      if (dbModel.repeatUntil > 0 && dbModel.repeatUntil <= dbModel.startTime) {
        await remoteApi.deleteSchedules(
          [_model.id],
          await AppSharedPref.loadUid(),
        );
      } else {
        await remoteApi.updateSchedule(
          dbModel,
          await AppSharedPref.loadUid(),
        );
      }

      _deleteLocalSchedule(_model.id);
      AddScheduleHelper.addToCalendar(dbModel);
      success();
    } catch (e) {
      debugPrint("deleteRepeatSchedule error ${e.toString()}");
    } finally {
      OneContext().hideProgressIndicator();
    }
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

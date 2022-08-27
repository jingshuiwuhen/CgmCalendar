import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class ScheduleDetailPageViewModel with ChangeNotifier {
  late ScheduleModel _model;
  String _title = "";
  String _timeStr1 = "";
  String _timeStr2 = "";
  int _repeatType = 0;
  int _scheduleType = 0;
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
  String get remarks => _remarks;

  void _setParams() {
    _title = _model.title;
    _makeTimeStr();
    _repeatType = _model.repeatType;
    _scheduleType = _model.scheduleType;
    _remarks = _model.remarks;
  }

  void _makeTimeStr() {
    int startDate = _model.startTime ~/ 10000;
    int endDate = _model.endTime ~/ 10000;
    if (startDate == endDate) {
      DateTime time = DateTime.parse(startDate.toString());
      _timeStr1 = DateFormat.yMMMMEEEEd().format(time);
      String startTimeStr = _model.startTime.toString().substring(8);
      String endTimeStr = _model.endTime.toString().substring(8);
      _timeStr2 =
          "${startTimeStr.substring(0, 2)}:${startTimeStr.substring(2)} - ${endTimeStr.substring(0, 2)}:${endTimeStr.substring(2)}";
    } else {
      String startTimeStr = _model.startTime.toString().substring(8);
      DateTime start = DateTime.parse(
          "${startDate.toString()} ${startTimeStr.substring(8, 10)}:${startTimeStr.substring(10)}:00");
      _timeStr1 = "开始 : ${DateFormat.yMMMMEEEEd().add_Hm().format(start)}";

      String endTimeStr = _model.endTime.toString().substring(8);
      DateTime end = DateTime.parse(
          "${endDate.toString()} ${endTimeStr.substring(8, 10)}:${endTimeStr.substring(10)}:00");
      _timeStr2 = "结束 : ${DateFormat.yMMMMEEEEd().add_Hm().format(end)}";
    }
  }
}

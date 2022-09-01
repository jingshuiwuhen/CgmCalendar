import 'package:cgm_calendar/add_schedule_helper.dart';
import 'package:cgm_calendar/db/db_manager.dart';
import 'package:cgm_calendar/db/schedule_db_model.dart';
import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

enum RepeatType {
  none,
  everyDay,
  everyWeek,
  everyMonth,
}

enum SchedualType {
  personal,
  work,
}

class SetSchedulePageViewModel with ChangeNotifier {
  late TextEditingController _titleEditingController;
  late FocusNode _titleFocus;
  late String _startDate;
  late String _startTime;
  late String _endDate;
  late String _endTime;
  late RepeatType _repeatType;
  late SchedualType _scheduleType;
  late bool _isNotRightTime;
  late TextEditingController _remarksEditingController;
  late FocusNode _remarksFocus;
  ScheduleModel? _oldSchedule;
  ScheduleModel? _newSchedule;

  SetSchedulePageViewModel(ScheduleModel? schedule) {
    _oldSchedule = schedule;
    _newSchedule = _oldSchedule?.copy();

    _titleEditingController = TextEditingController(
        text: _newSchedule == null ? "" : _newSchedule!.title);
    _titleEditingController.addListener(() {
      notifyListeners();
    });
    _titleFocus = FocusNode();

    if (_newSchedule == null) {
      DateTime now = DateTime.now();
      _startDate = formatDate(now, [yyyy, '/', mm, '/', dd]);
      DateTime oneHourFromNow = now.add(const Duration(hours: 1));
      _startTime = "${formatDate(oneHourFromNow, [HH])}:00";

      DateTime twoHoursFromNow = oneHourFromNow.add(const Duration(hours: 1));
      _endDate = formatDate(twoHoursFromNow, [yyyy, '/', mm, '/', dd]);
      _endTime = "${formatDate(twoHoursFromNow, [HH])}:00";
    } else {
      String start = _newSchedule!.startTime.toString();
      _startDate =
          "${start.substring(0, 4)}/${start.substring(4, 6)}/${start.substring(6, 8)}";
      _startTime = "${start.substring(8, 10)}:${start.substring(10)}";

      String end = _newSchedule!.endTime.toString();
      _endDate =
          "${end.substring(0, 4)}/${end.substring(4, 6)}/${end.substring(6, 8)}";
      _endTime = "${end.substring(8, 10)}:${end.substring(10)}";
    }

    _repeatType =
        RepeatType.values[_newSchedule == null ? 0 : _newSchedule!.repeatType];
    _scheduleType = SchedualType
        .values[_newSchedule == null ? 0 : _newSchedule!.scheduleType];
    _isNotRightTime = false;

    _remarksEditingController = TextEditingController(
        text: _newSchedule == null ? "" : _newSchedule!.remarks);
    _remarksFocus = FocusNode();
  }

  TextEditingController get titleEditingController => _titleEditingController;
  FocusNode get titleFocus => _titleFocus;
  String get startDate => _startDate;
  String get startTime => _startTime;
  String get endDate => _endDate;
  String get endTime => _endTime;
  RepeatType get repeatType => _repeatType;
  SchedualType get scheduleType => _scheduleType;
  bool get isNotRightTime => _isNotRightTime;
  TextEditingController? get remarksEditingController =>
      _remarksEditingController;
  FocusNode get remarksFocus => _remarksFocus;

  void updateStartDate(DateTime newStartDate) {
    _startDate = formatDate(newStartDate, [yyyy, '/', mm, '/', dd]);
    _isNotRightTime = _checkTime();
    notifyListeners();
  }

  void updateEndDate(DateTime newEndDate) {
    _endDate = formatDate(newEndDate, [yyyy, '/', mm, '/', dd]);
    _isNotRightTime = _checkTime();
    notifyListeners();
  }

  void updateStartTime(DateTime newStartTime) {
    _startTime = formatDate(newStartTime, [HH, ':', nn]);
    _isNotRightTime = _checkTime();
    notifyListeners();
  }

  void updateEndTime(DateTime newEndTime) {
    _endTime = formatDate(newEndTime, [HH, ':', nn]);
    _isNotRightTime = _checkTime();
    notifyListeners();
  }

  void updateRepeatType(RepeatType repeatType) {
    _repeatType = repeatType;
    notifyListeners();
  }

  void updateScheduleType(SchedualType scheduleType) {
    _scheduleType = scheduleType;
    notifyListeners();
  }

  bool _checkTime() {
    DateTime wholeStartDate = DateTime.parse(
        "${_startDate.replaceAll(RegExp(r'/'), "-")} $_startTime:00");
    DateTime wholeEndDate = DateTime.parse(
        "${_endDate.replaceAll(RegExp(r'/'), "-")} $_endTime:00");
    return wholeStartDate.isAfter(wholeEndDate);
  }

  void cancelFocus() {
    _titleFocus.unfocus();
    _remarksFocus.unfocus();
  }

  Future addSchedule() async {
    ScheduleDBModel model = await _addToDB();
    AddScheduleHelper.addToCalendar(model);
  }

  Future<ScheduleDBModel> _addToDB() async {
    ScheduleDBModel model = ScheduleDBModel();
    model.title = _titleEditingController.text;

    String startTimeStr = _startDate.replaceAll(RegExp(r'/'), "") +
        _startTime.replaceAll(RegExp(r':'), "");
    model.startTime = int.parse(startTimeStr);

    String endTimeStr = _endDate.replaceAll(RegExp(r'/'), "") +
        _endTime.replaceAll(RegExp(r':'), "");
    model.endTime = int.parse(endTimeStr);

    model.repeatType = _repeatType.index;
    model.scheduleType = _scheduleType.index;
    model.remarks = _remarksEditingController.text;
    return await DBManager.db.insert(model);
  }
}

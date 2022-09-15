import 'package:cgm_calendar/add_schedule_helper.dart';
import 'package:cgm_calendar/db/db_manager.dart';
import 'package:cgm_calendar/db/schedule_db_model.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/day_model.dart';
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

enum EditType {
  thisOnly,
  futureContainsThis,
}

class SetSchedulePageViewModel with ChangeNotifier {
  late TextEditingController _titleEditingController;
  late FocusNode _titleFocus;
  late String _startDate;
  late String _startTime;
  late String _endDate;
  late String _endTime;
  late RepeatType _repeatType;
  int _repeatUntil = 0;
  late SchedualType _scheduleType;
  late bool _isNotRightTime;
  late TextEditingController _remarksEditingController;
  late FocusNode _remarksFocus;
  ScheduleModel? _oldSchedule;
  late ScheduleModel _newSchedule;

  SetSchedulePageViewModel(ScheduleModel? schedule) {
    _oldSchedule = schedule;
    if (_oldSchedule != null) {
      _newSchedule = _oldSchedule!.copy();
    } else {
      _newSchedule = ScheduleModel();
    }

    _titleEditingController = TextEditingController(text: _newSchedule.title);
    _titleEditingController.addListener(() {
      _newSchedule.title = _titleEditingController.text;
      notifyListeners();
    });
    _titleFocus = FocusNode();

    String start = _newSchedule.startTime.toString();
    _startDate =
        "${start.substring(0, 4)}/${start.substring(4, 6)}/${start.substring(6, 8)}";
    _startTime = "${start.substring(8, 10)}:${start.substring(10)}";

    String end = _newSchedule.endTime.toString();
    _endDate =
        "${end.substring(0, 4)}/${end.substring(4, 6)}/${end.substring(6, 8)}";
    _endTime = "${end.substring(8, 10)}:${end.substring(10)}";

    _repeatType = RepeatType.values[_newSchedule.repeatType];
    _repeatUntil = _newSchedule.repeatUntil;
    _scheduleType = SchedualType.values[_newSchedule.scheduleType];
    _isNotRightTime = false;

    _remarksEditingController =
        TextEditingController(text: _newSchedule.remarks);
    _remarksEditingController.addListener(() {
      _newSchedule.remarks = _remarksEditingController.text;
    });
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
  int get repeatUntil => _repeatUntil;
  bool get isNotRightTime => _isNotRightTime;
  TextEditingController? get remarksEditingController =>
      _remarksEditingController;
  FocusNode get remarksFocus => _remarksFocus;

  void updateStartDate(DateTime newStartDate) {
    _startDate = formatDate(newStartDate, [yyyy, '/', mm, '/', dd]);
    _isNotRightTime = _checkTime();
    notifyListeners();
    _setStartTimeToNewSchedule();
  }

  void updateEndDate(DateTime newEndDate) {
    _endDate = formatDate(newEndDate, [yyyy, '/', mm, '/', dd]);
    _isNotRightTime = _checkTime();
    notifyListeners();
    _setEndTimeToNewSchedule();
  }

  void updateStartTime(DateTime newStartTime) {
    _startTime = formatDate(newStartTime, [HH, ':', nn]);
    _isNotRightTime = _checkTime();
    notifyListeners();
    _setStartTimeToNewSchedule();
  }

  void updateEndTime(DateTime newEndTime) {
    _endTime = formatDate(newEndTime, [HH, ':', nn]);
    _isNotRightTime = _checkTime();
    notifyListeners();
    _setEndTimeToNewSchedule();
  }

  void updateRepeatType(RepeatType repeatType) {
    _repeatType = repeatType;
    notifyListeners();
    _newSchedule.repeatType = repeatType.index;
  }

  void updateRepeatUntil(int repeatUntil) {
    _repeatUntil = repeatUntil;
    notifyListeners();
    _newSchedule.repeatUntil = repeatUntil;
  }

  void updateScheduleType(SchedualType scheduleType) {
    _scheduleType = scheduleType;
    notifyListeners();
    _newSchedule.scheduleType = scheduleType.index;
  }

  DateTime getInitialDateTimeOfRepeatUntil() {
    int repeatUntilDate = _oldSchedule!.repeatUntil ~/ 10000;
    return DateTime.parse(repeatUntilDate.toString());
  }

  bool _checkTime() {
    DateTime wholeStartDate = DateTime.parse(
        "${_startDate.replaceAll(RegExp(r'/'), "-")} $_startTime:00");
    DateTime wholeEndDate = DateTime.parse(
        "${_endDate.replaceAll(RegExp(r'/'), "-")} $_endTime:00");
    return wholeStartDate.isAfter(wholeEndDate);
  }

  bool canAddSchedule() {
    return !_isNotRightTime && _titleEditingController.text.isNotEmpty;
  }

  bool isChanged() {
    return _newSchedule.isDifferent(_oldSchedule);
  }

  bool isRepeatChanged() {
    return _newSchedule.repeatType != _oldSchedule!.repeatType;
  }

  bool isRepeatUntilChanged() {
    return _newSchedule.repeatUntil != _oldSchedule!.repeatUntil;
  }

  void _setStartTimeToNewSchedule() {
    String startTimeStr = _startDate.replaceAll(RegExp(r'/'), "") +
        _startTime.replaceAll(RegExp(r':'), "");
    _newSchedule.startTime = int.parse(startTimeStr);
  }

  void _setEndTimeToNewSchedule() {
    String endTimeStr = _endDate.replaceAll(RegExp(r'/'), "") +
        _endTime.replaceAll(RegExp(r':'), "");
    _newSchedule.endTime = int.parse(endTimeStr);
  }

  void cancelFocus() {
    _titleFocus.unfocus();
    _remarksFocus.unfocus();
  }

  Future addNewSchedule() async {
    ScheduleDBModel model = ScheduleDBModel();
    model.copyFromScheduleModel(_newSchedule);
    await DBManager.db.insert(model);
    AddScheduleHelper.addToCalendar(model);
  }

  Future editNoRepeatSchedule() async {
    ScheduleDBModel model = await DBManager.db.getOneSchedule(_oldSchedule!.id);
    model.copyFromScheduleModel(_newSchedule);
    await DBManager.db.update(model);
    _deleteSchedules(model.id!);
    AddScheduleHelper.addToCalendar(model);
  }

  Future editRepeatSchedule(EditType type) async {
    ScheduleDBModel model = await DBManager.db.getOneSchedule(_oldSchedule!.id);

    ScheduleDBModel newModel = ScheduleDBModel();
    newModel.copyFromScheduleModel(_newSchedule);
    newModel.exceptionTimes = model.exceptionTimes;
    newModel = await DBManager.db.insert(newModel);
    AddScheduleHelper.addToCalendar(newModel);
    await _deleteUnuseScheduleDBData(newModel.id!);

    if (type == EditType.thisOnly) {
      model.exceptionTimes =
          "${model.exceptionTimes}${_oldSchedule!.startTime},";
    } else {
      model.repeatUntil = _oldSchedule!.startTime;
    }
    await DBManager.db.update(model);
    _deleteSchedules(model.id!);
    AddScheduleHelper.addToCalendar(model);
    await _deleteUnuseScheduleDBData(model.id!);
  }

  void _deleteSchedules(int id) {
    List<DayModel>? days = Global.idScheduleMap[id];
    if (days == null || days.isEmpty) {
      return;
    }

    for (DayModel day in days) {
      day.scheduleList.removeWhere((element) => element.id == id);
    }
  }

  Future _deleteUnuseScheduleDBData(int id) async {
    List<DayModel>? list = Global.idScheduleMap[id];
    if (list == null || list.isEmpty) {
      await DBManager.db.delete(id);
    }
  }
}

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

class AddSchedulePageViewModel with ChangeNotifier {
  late TextEditingController _titleEditingController;
  late String _startDate;
  late String _startTime;
  late String _endDate;
  late String _endTime;
  late RepeatType _repeatType;
  late SchedualType _scheduleType;
  late bool _isNotRightTime;
  late TextEditingController _remarksEditingController;

  AddSchedulePageViewModel() {
    _titleEditingController = TextEditingController(text: "");
    _startDate = formatDate(DateTime.now(), [yyyy, '/', mm, '/', dd]);
    _startTime =
        "${formatDate(DateTime.now().add(const Duration(hours: 1)), [HH])}:00";
    _endDate = formatDate(
        DateTime.now().add(const Duration(hours: 2)), [yyyy, '/', mm, '/', dd]);
    _endTime =
        "${formatDate(DateTime.now().add(const Duration(hours: 2)), [HH])}:00";
    _repeatType = RepeatType.none;
    _scheduleType = SchedualType.personal;
    _isNotRightTime = false;
    _remarksEditingController = TextEditingController(text: "");
  }

  TextEditingController get titleEditingController => _titleEditingController;
  String get startDate => _startDate;
  String get startTime => _startTime;
  String get endDate => _endDate;
  String get endTime => _endTime;
  RepeatType get repeatType => _repeatType;
  SchedualType get scheduleType => _scheduleType;
  bool get isNotRightTime => _isNotRightTime;
  TextEditingController? get remarksEditingController =>
      _remarksEditingController;

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
}

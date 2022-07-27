import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class AddSchedulePageViewModel with ChangeNotifier {
  String _startDate = "";
  String _startTime = "";
  String _endDate = "";
  String _endTime = "";
  String _repeatStr = "";
  int _type = 0;

  AddSchedulePageViewModel() {
    _startDate = formatDate(DateTime.now(), [yyyy, '/', mm, '/', dd]);
    _startTime =
        "${formatDate(DateTime.now().add(const Duration(hours: 1)), [HH])}:00";
    _endDate = formatDate(
        DateTime.now().add(const Duration(hours: 2)), [yyyy, '/', mm, '/', dd]);
    _endTime =
        "${formatDate(DateTime.now().add(const Duration(hours: 2)), [HH])}:00";
    _repeatStr = "永不";
    _type = 1;
  }

  String get startDate => _startDate;
  String get startTime => _startTime;
  String get endDate => _endDate;
  String get endTime => _endTime;
  String get repeatStr => _repeatStr;
  int get type => _type;
}

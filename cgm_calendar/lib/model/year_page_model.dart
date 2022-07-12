import 'package:cgm_calendar/model/date_model.dart';
import 'package:flutter/material.dart';

class YearPageModel with ChangeNotifier {
  static const int _length = 20;

  final List<DateModel> _oldYears = [];
  final List<DateModel> _newYears = [];

  YearPageModel() {
    _initData();
  }

  List<DateModel> get oldYears => _oldYears;
  List<DateModel> get newYears => _newYears;

  void _initData() {
    int yearOfNow = DateTime.now().year;
    addOldYears(yearOfNow - 1);
    addNewYears(yearOfNow);
  }

  void addOldYears(int lastYear) {
    for (var i = 0; i < _length; i++) {
      var dateModel = DateModel(lastYear - i);
      oldYears.add(dateModel);
    }
  }

  void addNewYears(int beginYear) {
    for (var i = 0; i < _length; i++) {
      var dateModel = DateModel(beginYear + i);
      newYears.add(dateModel);
    }
  }
}

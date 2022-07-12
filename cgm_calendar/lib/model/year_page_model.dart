import 'package:cgm_calendar/model/date_model.dart';
import 'package:flutter/material.dart';

class YearPageModel with ChangeNotifier {
  static const int _length = 10;

  final List<DateModel> _oldYears = [];
  final List<DateModel> _newYears = [];

  YearPageModel() {
    initData();
  }

  List<DateModel> get oldYears => _oldYears;
  List<DateModel> get newYears => _newYears;

  void initData() {
    oldYears.clear();
    newYears.clear();
    _addOldYears();
    _addNewYears();
    notifyListeners();
  }

  void addData() {
    _addOldYears();
    _addNewYears();
    notifyListeners();
  }

  void _addOldYears() {
    int lastYear = DateTime.now().year - 1;
    if (oldYears.isNotEmpty) {
      lastYear = oldYears.last.year - 1;
    }
    for (var i = 0; i < _length; i++) {
      var dateModel = DateModel(lastYear - i);
      oldYears.add(dateModel);
    }
  }

  void _addNewYears() {
    int beginYear = DateTime.now().year;
    if (newYears.isNotEmpty) {
      beginYear = newYears.last.year + 1;
    }
    for (var i = 0; i < _length; i++) {
      var dateModel = DateModel(beginYear + i);
      newYears.add(dateModel);
    }
  }
}

import 'package:cgm_calendar/model/year_model.dart';
import 'package:flutter/material.dart';

class YearPageModel with ChangeNotifier {
  static const int _length = 10;

  final List<YearModel> _oldYears = [];
  final List<YearModel> _newYears = [];

  YearPageModel() {
    initData();
  }

  List<YearModel> get oldYears => _oldYears;
  List<YearModel> get newYears => _newYears;

  void initData() {
    oldYears.clear();
    newYears.clear();
    addOldYears(false);
    addNewYears(true);
  }

  void addOldYears(bool refresh) {
    int lastYear = DateTime.now().year - 1;
    if (oldYears.isNotEmpty) {
      lastYear = oldYears.last.year - 1;
    }
    for (var i = 0; i < _length; i++) {
      var dateModel = YearModel(lastYear - i);
      oldYears.add(dateModel);
    }

    if (refresh) {
      notifyListeners();
    }
  }

  void addNewYears(bool refresh) {
    int beginYear = DateTime.now().year;
    if (newYears.isNotEmpty) {
      beginYear = newYears.last.year + 1;
    }
    for (var i = 0; i < _length; i++) {
      var dateModel = YearModel(beginYear + i);
      newYears.add(dateModel);
    }

    if (refresh) {
      notifyListeners();
    }
  }
}

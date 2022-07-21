import 'package:cgm_calendar/model/year_model.dart';

class YearPageModel {
  static const int _length = 100;

  final List<YearModel> _oldYears = [];
  final List<YearModel> _newYears = [];

  YearPageModel() {
    _initData();
  }

  List<YearModel> get oldYears => _oldYears;
  List<YearModel> get newYears => _newYears;

  void _initData() {
    _addOldYears();
    _addNewYears();
  }

  void _addOldYears() {
    int lastYear = DateTime.now().year - 1;
    if (oldYears.isNotEmpty) {
      lastYear = oldYears.last.year - 1;
    }
    for (var i = 0; i < _length; i++) {
      var dateModel = YearModel(lastYear - i);
      oldYears.add(dateModel);
    }
  }

  void _addNewYears() {
    int beginYear = DateTime.now().year;
    if (newYears.isNotEmpty) {
      beginYear = newYears.last.year + 1;
    }
    for (var i = 0; i < _length; i++) {
      var dateModel = YearModel(beginYear + i);
      newYears.add(dateModel);
    }
  }
}

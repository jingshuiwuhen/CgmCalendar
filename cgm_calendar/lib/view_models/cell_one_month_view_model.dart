import 'package:cgm_calendar/models/day_model.dart';
import 'package:flutter/foundation.dart';

class CellOneMonthViewModel with ChangeNotifier {
  int _selectingIndex = 0;
  List<DayModel> _daysOfMonth = [];

  CellOneMonthViewModel(List<DayModel> daysOfMonth) {
    _daysOfMonth = daysOfMonth;
  }

  List<DayModel> get daysOfMonth => _daysOfMonth;
  int get selectingIndex => _selectingIndex;

  void oneDayClick(int index) {
    _selectingIndex = index;
    notifyListeners();
  }
}

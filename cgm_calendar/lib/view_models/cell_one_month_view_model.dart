import 'package:cgm_calendar/models/day_model.dart';
import 'package:flutter/foundation.dart';

class CellOneMonthViewModel with ChangeNotifier {
  int _selectingIndex = 0;
  List<DayModel> _daysOfMonth = [];

  CellOneMonthViewModel(List<DayModel> daysOfMonth) {
    _daysOfMonth = daysOfMonth;
    _daysOfMonth[_selectingIndex].isSelecting = true;
  }

  List<DayModel> get daysOfMonth => _daysOfMonth;

  void oneDayClick(int index) {
    _daysOfMonth[_selectingIndex].isSelecting = false;
    _daysOfMonth[index].isSelecting = true;
    _selectingIndex = index;
    notifyListeners();
  }
}

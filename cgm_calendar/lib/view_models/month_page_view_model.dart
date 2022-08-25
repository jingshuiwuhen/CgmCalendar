import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/month_model.dart';
import 'package:flutter/material.dart';

class MonthPageViewModel with ChangeNotifier {
  String _title = "";
  PageController? _controller;
  late DayModel _day;

  MonthPageViewModel(int index) {
    _title = Global.allMonths[index].getYearAndMonthStr();
    _controller = PageController(initialPage: index, keepPage: false);
    _day = Global.allMonths[index].daysOfMonth[0];
  }

  String get title => _title;
  PageController? get controller => _controller;
  DayModel get day => _day;

  void onPageChanged(int index) {
    MonthModel newMonth = Global.allMonths[index];
    _title = newMonth.getYearAndMonthStr();
    _day = newMonth.daysOfMonth.first;
    notifyListeners();
  }

  void refreshScheduleList(DayModel day) {
    _day = day;
    notifyListeners();
  }

  void refreshPage() {
    notifyListeners();
  }
}

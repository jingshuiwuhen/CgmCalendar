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

  void updateTitle(int index) {
    MonthModel newMonth = Global.allMonths[index];
    _title = newMonth.getYearAndMonthStr();
    notifyListeners();
  }

  String weekDayName(int weekday) {
    switch (weekday) {
      case 0:
        return "日";
      case 1:
        return "一";
      case 2:
        return "二";
      case 3:
        return "三";
      case 4:
        return "四";
      case 5:
        return "五";
      default:
        return "六";
    }
  }

  void refreshScheduleList(DayModel day) {
    _day = day;
    notifyListeners();
  }
}

import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/month_model.dart';
import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:flutter/material.dart';

class MonthPageViewModel with ChangeNotifier {
  String _title = "";
  PageController? _controller;
  List<ScheduleModel>? _scheduleList;

  MonthPageViewModel(int index) {
    _title = Global.allMonths[index].getYearAndMonthStr();
    _controller = PageController(initialPage: index, keepPage: false);
  }

  String get title => _title;
  PageController? get controller => _controller;
  List<ScheduleModel>? get scheduleList => _scheduleList;

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

  void refreshScheduleList(List<ScheduleModel> list) {
    _scheduleList = list;
    notifyListeners();
  }
}

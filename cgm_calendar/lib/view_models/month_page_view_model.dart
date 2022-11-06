import 'package:cgm_calendar/app_shared_pref.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/month_model.dart';
import 'package:flutter/material.dart';

class MonthPageViewModel with ChangeNotifier {
  String _title = "";
  late PageController _controller;
  late DayModel _day;
  late int _selectIndex;
  bool _isLogined = false;

  MonthPageViewModel(int index) {
    _title = Global.allMonths[index].getYearAndMonthStr();
    _controller = PageController(initialPage: index, keepPage: false);
    _setSelectIndex(index);
    _day = Global.allMonths[index].daysOfMonth[_selectIndex];
    setLoginFlag();
  }

  String get title => _title;
  PageController get controller => _controller;
  DayModel get day => _day;
  int get selectIndex => _selectIndex;
  bool get isLogined => _isLogined;

  Future<void> setLoginFlag() async {
    _isLogined = await AppSharedPref.loadAccessToken() != "";
    notifyListeners();
  }

  void onPageChanged(int index) {
    MonthModel newMonth = Global.allMonths[index];
    _title = newMonth.getYearAndMonthStr();
    _setSelectIndex(index);
    _day = newMonth.daysOfMonth[_selectIndex];
    notifyListeners();
  }

  void refreshScheduleList(DayModel day) {
    _selectIndex = day.dayOfMonth - 1;
    _day = day;
    notifyListeners();
  }

  void refreshPage() {
    notifyListeners();
  }

  void _setSelectIndex(int index) {
    _selectIndex = 0;
    MonthModel monthModel = Global.allMonths[index];
    if (!monthModel.isThisMonth()) {
      return;
    }

    _selectIndex =
        monthModel.daysOfMonth.indexWhere((element) => element.isToday());
  }
}

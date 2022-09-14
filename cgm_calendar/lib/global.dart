import 'dart:io';

import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/month_model.dart';
import 'package:cgm_calendar/models/year_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Global {
  static PackageInfo? info;
  static const int _oldYearsCount = 5;
  static const int _newYearsCount = 10;
  static final List<YearModel> oldYears = [];
  static final List<YearModel> newYears = [];
  static final List<MonthModel> allMonths = [];
  static final Map<int, List<DayModel>> idScheduleMap = {};

  static init() {
    int lastYear = DateTime.now().year - 1;
    if (oldYears.isNotEmpty) {
      lastYear = oldYears.last.year - 1;
    }
    for (var i = 0; i < _oldYearsCount; i++) {
      var dateModel = YearModel(lastYear - i);
      oldYears.add(dateModel);
    }

    int beginYear = DateTime.now().year;
    if (newYears.isNotEmpty) {
      beginYear = newYears.last.year + 1;
    }
    for (var i = 0; i < _newYearsCount; i++) {
      var dateModel = YearModel(beginYear + i);
      newYears.add(dateModel);
    }

    for (var i = oldYears.length - 1; i > -1; i--) {
      YearModel year = oldYears[i];
      allMonths.addAll(year.monthsOfYear);
    }

    for (var i = 0; i < newYears.length; i++) {
      YearModel year = newYears[i];
      allMonths.addAll(year.monthsOfYear);
    }
  }

  static String localeStr() {
    String locale = Platform.localeName;
    if (locale.substring(0, 2).compareTo("zh") == 0) {
      return "zh_CN";
    } else if (locale.substring(0, 2).compareTo("ja") == 0) {
      return "ja_JP";
    } else if (locale.substring(0, 2).compareTo("vi") == 0) {
      return "vi_VN";
    } else {
      return "en_US";
    }
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

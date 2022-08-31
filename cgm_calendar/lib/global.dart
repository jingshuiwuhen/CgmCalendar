import 'dart:io';

import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/month_model.dart';
import 'package:cgm_calendar/models/year_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Global {
  static PackageInfo? info;
  static const int _length = 5;
  static final List<YearModel> oldYears = [];
  static final List<YearModel> newYears = [];
  static final List<MonthModel> allMonths = [];
  static final Map<int, List<DayModel>> idScheduleMap = {};

  static init() {
    int lastYear = DateTime.now().year - 1;
    if (oldYears.isNotEmpty) {
      lastYear = oldYears.last.year - 1;
    }
    for (var i = 0; i < _length; i++) {
      var dateModel = YearModel(lastYear - i);
      oldYears.add(dateModel);
    }

    int beginYear = DateTime.now().year;
    if (newYears.isNotEmpty) {
      beginYear = newYears.last.year + 1;
    }
    for (var i = 0; i < _length; i++) {
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
}

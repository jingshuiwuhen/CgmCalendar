import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/month_model.dart';
import 'package:intl/intl.dart';

class YearModel {
  int year;
  List<MonthModel> monthsOfYear = [];

  YearModel(this.year) {
    _makeMonthsOfYear();
  }

  void _makeMonthsOfYear() {
    for (var i = 1; i <= 12; i++) {
      MonthModel monthModel = MonthModel(year, i);
      monthsOfYear.add(monthModel);
    }
  }

  bool isThisYear() {
    return year == DateTime.now().year;
  }

  String getYearStr() {
    String dateStr = "${year}0101";
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat.y(Global.localeStr()).format(dateTime);
  }
}

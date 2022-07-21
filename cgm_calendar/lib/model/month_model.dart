import 'package:cgm_calendar/model/day_model.dart';

class MonthModel {
  int year;
  int month;
  List<DayModel> daysOfMonth = [];

  MonthModel(this.year, this.month) {
    _makeDaysOfMonth();
  }

  void _makeDaysOfMonth() {
    var dayCount = DateTime(year, month + 1, 0).day;
    var firstDayWeek = DateTime(year, month, 1).weekday;
    for (var i = 1; i <= dayCount; i++) {
      DayModel dayModel = DayModel();
      dayModel.year = year;
      dayModel.month = month;
      dayModel.dayOfMonth = i;
      dayModel.dayOfWeek = (firstDayWeek + i - 1) % 7;
      daysOfMonth.add(dayModel);
    }
  }

  bool isThisMonth() {
    return year == DateTime.now().year && month == DateTime.now().month;
  }

  String getYearAndMonth() {
    return "$year年$month月";
  }
}

import 'package:cgm_calendar/model/day_model.dart';

class DateModel {
  int year = 0;
  List<DayModel> daysOfMonth = [];

  DateModel(this.year) {
    _makeDaysOfMonth();
  }

  void _makeDaysOfMonth() {
    for (var i = 1; i <= 12; i++) {
      DayModel dayModel = DayModel();
      dayModel.year == year;
      dayModel.month = i;
      var dayCount = DateTime(year, i + 1, 0).day;
      var firstDayWeek = DateTime(year, i, 0).weekday;
      for (var j = 1; j <= dayCount; j++) {
        dayModel.dayOfMonth = j;
        dayModel.dayOfWeek = (firstDayWeek + j - 1) % 7;
      }
      daysOfMonth.add(dayModel);
    }
  }
}

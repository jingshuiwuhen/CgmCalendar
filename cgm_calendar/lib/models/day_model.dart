import 'package:cgm_calendar/models/schedule_model.dart';

class DayModel {
  //年份
  int year = 0;

  //月份
  int month = 0;

  //日期
  int dayOfMonth = 0;

  //星期
  int dayOfWeek = 0;

  List<ScheduleModel> scheduleList = List.empty(growable: true);

  void addScheduleAndSort(ScheduleModel model) {
    scheduleList.add(model);
    scheduleList.sort((left, right) {
      if (left.startTime.compareTo(right.startTime) != 0) {
        return left.startTime.compareTo(right.startTime);
      }
      return left.endTime.compareTo(right.endTime);
    });
  }

  //是否是今天
  bool isToday() {
    var now = DateTime.now();
    return (now.year == year) &&
        (now.month == month) &&
        (now.day == dayOfMonth);
  }
}

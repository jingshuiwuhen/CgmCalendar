import 'package:date_format/date_format.dart';

class ScheduleModel {
  int id = 0;
  String title = "";
  int startTime = 0;
  int endTime = 0;
  int repeatType = 0;
  int scheduleType = 0;
  int repeatUntil = 0;
  String remarks = "";

  ScheduleModel(DateTime time) {
    DateTime oneHourFromNow = time.add(const Duration(hours: 1));
    String startDateStr = formatDate(oneHourFromNow, [yyyy, '/', mm, '/', dd]);
    String startTimeStr = "${formatDate(oneHourFromNow, [HH])}:00";
    startTime = int.parse(
        "${startDateStr.replaceAll(RegExp(r'/'), "")}${startTimeStr.replaceAll(RegExp(r':'), "")}");

    DateTime twoHoursFromNow = oneHourFromNow.add(const Duration(hours: 1));
    String endDateStr = formatDate(twoHoursFromNow, [yyyy, '/', mm, '/', dd]);
    String endTimeStr = "${formatDate(twoHoursFromNow, [HH])}:00";
    endTime = int.parse(
        "${endDateStr.replaceAll(RegExp(r'/'), "")}${endTimeStr.replaceAll(RegExp(r':'), "")}");
  }

  ScheduleModel copy() {
    ScheduleModel copy = ScheduleModel(DateTime.now());
    copy.id = id;
    copy.title = title;
    copy.startTime = startTime;
    copy.endTime = endTime;
    copy.repeatType = repeatType;
    copy.scheduleType = scheduleType;
    copy.remarks = remarks;
    copy.repeatUntil = repeatUntil;
    return copy;
  }

  bool isDifferent(ScheduleModel? model) {
    if (model == null) {
      return true;
    }

    return id != model.id ||
        title.compareTo(model.title) != 0 ||
        startTime != model.startTime ||
        endTime != model.endTime ||
        repeatType != model.repeatType ||
        scheduleType != model.scheduleType ||
        repeatUntil != model.repeatUntil ||
        remarks.compareTo(model.remarks) != 0;
  }
}

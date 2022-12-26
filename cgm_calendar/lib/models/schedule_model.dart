import 'package:cgm_calendar/view_models/set_schedule_page_view_model.dart';
import 'package:date_format/date_format.dart';

class ScheduleModel {
  int id = 0;
  String title = "";
  int startTime = 0;
  int endTime = 0;
  RepeatType repeatType = RepeatType.none;
  ScheduleType scheduleType = ScheduleType.personal;
  int repeatUntil = 0;
  String remarks = "";
  AlertType alarmType = AlertType.none;

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
    copy.alarmType = alarmType;
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
        remarks.compareTo(model.remarks) != 0 ||
        alarmType != model.alarmType;
  }

  int changeAlertTypeToTime() {
    final startTimeStr = startTime.toString();
    final formattedStr =
        '${startTimeStr.substring(0, 8)} ${startTimeStr.substring(8, 10)}:${startTimeStr.substring(10)}:00';
    DateTime dateTime = DateTime.parse(formattedStr);

    switch (alarmType) {
      case AlertType.fiveMinutesBefore:
        dateTime.subtract(const Duration(minutes: 5));
        break;
      case AlertType.tenMinutesBefore:
        dateTime.subtract(const Duration(minutes: 10));
        break;
      case AlertType.fifteenMinutesBefore:
        dateTime.subtract(const Duration(minutes: 15));
        break;
      case AlertType.thirtyMinutesBefore:
        dateTime.subtract(const Duration(minutes: 30));
        break;
      case AlertType.oneHourBefore:
        dateTime.subtract(const Duration(hours: 1));
        break;
      case AlertType.twoHoursBefore:
        dateTime.subtract(const Duration(hours: 2));
        break;
      case AlertType.oneDayBefore:
        dateTime.subtract(const Duration(days: 1));
        break;
      default:
        return 0;
    }

    String alarmDateStr = formatDate(dateTime, [yyyy, '/', mm, '/', dd]);
    String alarmTimeStr = "${formatDate(dateTime, [HH])}:00";
    return int.parse(
        "${alarmDateStr.replaceAll(RegExp(r'/'), "")}${alarmTimeStr.replaceAll(RegExp(r':'), "")}");
  }
}

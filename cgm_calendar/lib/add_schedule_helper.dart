import 'package:cgm_calendar/db/schedule_db_model.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/month_model.dart';
import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:cgm_calendar/models/year_model.dart';
import 'package:cgm_calendar/view_models/add_schedule_page_view_model.dart';
import 'package:sprintf/sprintf.dart';

class AddScheduleHelper {
  static void addToCalendar(ScheduleDBModel model) {
    if (model.repeatType == RepeatType.none.index) {
      addScheduleToTargetDaysOnce(model.copyToScheduleModel());
    } else if (model.repeatType == RepeatType.everyDay.index) {
      addScheduleToTargetDaysEveryDayOrEveryWeek(model, true);
    } else if (model.repeatType == RepeatType.everyWeek.index) {
      addScheduleToTargetDaysEveryDayOrEveryWeek(model, false);
    } else if (model.repeatType == RepeatType.everyMonth.index) {}
  }

  static void addScheduleToTargetDaysOnce(ScheduleModel model) {
    String startTime = model.startTime.toString();
    int startYear = int.parse(startTime.substring(0, 4));
    int startMonth = int.parse(startTime.substring(4, 6));
    int startDay = int.parse(startTime.substring(6, 8));
    int thisYear = Global.newYears.first.year;
    int startDate = 0;
    String endTime = model.endTime.toString();
    int endDate = int.parse(endTime.substring(0, 8));
    do {
      YearModel targetYear;
      if (thisYear <= startYear) {
        if ((startYear - thisYear + 1) > Global.newYears.length) {
          break;
        }
        targetYear = Global.newYears[startYear - thisYear];
      } else {
        if (Global.oldYears.length >= (thisYear - startYear)) {
          targetYear = Global.oldYears[thisYear - startYear - 1];
        } else {
          targetYear = Global.oldYears.last;
          startYear = targetYear.year;
          startMonth = 1;
          startDay = 1;
        }
      }
      MonthModel targetMonth = targetYear.monthsOfYear[startMonth - 1];
      DayModel targetDay = targetMonth.daysOfMonth[startDay - 1];
      targetDay.addScheduleAndSort(model);

      if (targetMonth.daysOfMonth.indexOf(targetDay) ==
          (targetMonth.daysOfMonth.length - 1)) {
        startDay = 1;

        if (startMonth == 12) {
          startMonth = 1;
          startYear++;
        } else {
          startMonth++;
        }
      } else {
        startDay++;
      }
      startDate = int.parse(
          "$startYear${sprintf("%02i", startMonth)}${sprintf("%02i", startDay)}");
    } while (startDate <= endDate);
  }

  static void addScheduleToTargetDaysEveryDayOrEveryWeek(
      ScheduleDBModel model, bool isEveryDay) {
    String startTime = "${model.startTime.toString()}:00";
    DateTime startDateTime = DateTime.parse(startTime);
    String endTime = "${model.endTime.toString()}:00";
    DateTime endDateTime = DateTime.parse(endTime);
    ScheduleModel scheduleModel = model.copyToScheduleModel();
    while (true) {
      startDateTime.add(Duration(days: isEveryDay ? 1 : 7));
      endDateTime.add(Duration(days: isEveryDay ? 1 : 7));
      if (endDateTime.compareTo(DateTime.parse(
                  "${Global.oldYears.last.year}-01-01 00:00:00")) ==
              -1 ||
          model.exceptionTimes.contains(
              "${startDateTime.year}${sprintf("%02i", startDateTime.month)}${sprintf("%02i", startDateTime.day)}${sprintf("%02i", startDateTime.hour)}${sprintf("%02i", startDateTime.minute)}")) {
        continue;
      }

      if (startDateTime.compareTo(DateTime.parse(
                  "${Global.newYears.last.year + 1}-01-01 00:00:00")) ==
              -1 ||
          model.repeatUntil ==
              int.parse(
                  "${startDateTime.year}${sprintf("%02i", startDateTime.month)}${sprintf("%02i", startDateTime.day)}${sprintf("%02i", startDateTime.hour)}${sprintf("%02i", startDateTime.minute)}")) {
        break;
      }

      scheduleModel.startTime = int.parse(
          "${startDateTime.year}${sprintf("%02i", startDateTime.month)}${sprintf("%02i", startDateTime.day)}${sprintf("%02i", startDateTime.hour)}${sprintf("%02i", startDateTime.minute)}");
      scheduleModel.endTime = int.parse(
          "${endDateTime.year}${sprintf("%02i", endDateTime.month)}${sprintf("%02i", endDateTime.day)}${sprintf("%02i", endDateTime.hour)}${sprintf("%02i", endDateTime.minute)}");
      addScheduleToTargetDaysOnce(scheduleModel);
    }
  }
}

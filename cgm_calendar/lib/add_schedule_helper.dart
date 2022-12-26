import 'package:cgm_calendar/models/schedule_db_model.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/month_model.dart';
import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:cgm_calendar/models/year_model.dart';
import 'package:cgm_calendar/view_models/set_schedule_page_view_model.dart';
import 'package:sprintf/sprintf.dart';

class AddScheduleHelper {
  static void addToCalendar(ScheduleDBModel model) {
    if (model.repeatType == RepeatType.none.index) {
      addScheduleToTargetDaysOnce(model.copyToScheduleModel());
    } else if (model.repeatType == RepeatType.everyDay.index) {
      addScheduleToTargetDaysEveryDayOrEveryWeek(model, true);
    } else if (model.repeatType == RepeatType.everyWeek.index) {
      addScheduleToTargetDaysEveryDayOrEveryWeek(model, false);
    } else if (model.repeatType == RepeatType.everyMonth.index) {
      addScheduleToTargetDaysEveryMonth(model);
    }
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
      if (Global.idScheduleMap[model.id] == null) {
        Global.idScheduleMap[model.id] = List.empty(growable: true);
      }
      Global.idScheduleMap[model.id]!.add(targetDay);

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
      startDate = int.parse("$startYear${sprintf("%02i", [
            startMonth
          ])}${sprintf("%02i", [startDay])}");
    } while (startDate <= endDate);
  }

  static void addScheduleToTargetDaysEveryDayOrEveryWeek(
      ScheduleDBModel model, bool isEveryDay) {
    String startTimeStr = model.startTime.toString();
    DateTime startDateTime = DateTime.parse(
        "${startTimeStr.substring(0, 8)} ${startTimeStr.substring(8, 10)}:${startTimeStr.substring(10)}:00");
    String endTimeStr = model.endTime.toString();
    DateTime endDateTime = DateTime.parse(
        "${endTimeStr.substring(0, 8)} ${endTimeStr.substring(8, 10)}:${endTimeStr.substring(10)}:00");
    for (var i = 0;; i++) {
      if (i != 0) {
        startDateTime = startDateTime.add(Duration(days: isEveryDay ? 1 : 7));
        endDateTime = endDateTime.add(Duration(days: isEveryDay ? 1 : 7));
      }

      if (endDateTime.compareTo(DateTime.parse(
                  "${Global.oldYears.last.year}0101 00:00:00")) ==
              -1 ||
          model.exceptionTimes.contains(
              "${startDateTime.year}${sprintf("%02i", [
                startDateTime.month
              ])}${sprintf("%02i", [startDateTime.day])}${sprintf("%02i", [
                startDateTime.hour
              ])}${sprintf("%02i", [startDateTime.minute])}")) {
        continue;
      }

      if (startDateTime.compareTo(DateTime.parse(
                  "${Global.newYears.last.year}1231 23:59:59")) ==
              1 ||
          (model.repeatUntil > 0 &&
              model.repeatUntil <=
                  int.parse("${startDateTime.year}${sprintf("%02i", [
                        startDateTime.month
                      ])}${sprintf("%02i", [
                        startDateTime.day
                      ])}${sprintf("%02i", [
                        startDateTime.hour
                      ])}${sprintf("%02i", [startDateTime.minute])}"))) {
        break;
      }

      ScheduleModel scheduleModel = model.copyToScheduleModel();
      scheduleModel.startTime = int.parse(
          "${startDateTime.year}${sprintf("%02i", [
            startDateTime.month
          ])}${sprintf("%02i", [startDateTime.day])}${sprintf("%02i", [
            startDateTime.hour
          ])}${sprintf("%02i", [startDateTime.minute])}");
      scheduleModel.endTime = int.parse("${endDateTime.year}${sprintf("%02i", [
            endDateTime.month
          ])}${sprintf("%02i", [endDateTime.day])}${sprintf("%02i", [
            endDateTime.hour
          ])}${sprintf("%02i", [endDateTime.minute])}");
      addScheduleToTargetDaysOnce(scheduleModel);
    }
  }

  static void addScheduleToTargetDaysEveryMonth(ScheduleDBModel model) {
    String startTime = model.startTime.toString();
    int startYear = int.parse(startTime.substring(0, 4));
    int startMonth = int.parse(startTime.substring(4, 6));
    int startDay = int.parse(startTime.substring(6, 8));

    String startTimeStr =
        "${startTime.substring(0, 8)} ${startTime.substring(8, 10)}:${startTime.substring(10)}:00";
    DateTime startDateTime = DateTime.parse(startTimeStr);

    String endTime = model.endTime.toString();
    String endTimeStr =
        "${endTime.substring(0, 8)} ${endTime.substring(8, 10)}:${endTime.substring(10)}:00";
    DateTime endDateTime = DateTime.parse(endTimeStr);
    int daysBetweenStartToEnd = endDateTime.difference(startDateTime).inDays;

    DateTime tempLastDayOfMonthDateTime = DateTime.parse(startTimeStr);
    do {
      tempLastDayOfMonthDateTime =
          tempLastDayOfMonthDateTime.add(const Duration(days: 1));
    } while (tempLastDayOfMonthDateTime.month == startMonth);
    tempLastDayOfMonthDateTime =
        tempLastDayOfMonthDateTime.subtract(const Duration(days: 1));
    int daysBetweenStartToLastDayOfMonth =
        tempLastDayOfMonthDateTime.difference(startDateTime).inDays;

    int thisYear = Global.newYears.first.year;
    for (var i = 0;; i++) {
      if (i != 0) {
        if (startMonth == 12) {
          startYear++;
          startMonth = 1;
        } else {
          startMonth++;
        }

        MonthModel targetMonth;
        if (thisYear <= startYear) {
          if (startYear - thisYear >= Global.newYears.length) {
            break;
          }
          targetMonth = Global
              .newYears[startYear - thisYear].monthsOfYear[startMonth - 1];
        } else {
          if (thisYear - startYear > Global.oldYears.length) {
            continue;
          }
          targetMonth = Global
              .oldYears[thisYear - startYear - 1].monthsOfYear[startMonth - 1];
        }

        if (targetMonth.daysOfMonth.length >= startDay) {
          startTimeStr =
              "$startYear${sprintf("%02i", [startMonth])}${sprintf("%02i", [
                startDay
              ])} ${startTime.substring(8, 10)}:${startTime.substring(10)}:00";
          startDateTime = DateTime.parse(startTimeStr);
        } else {
          DayModel lastDay = targetMonth.daysOfMonth.last;
          DateTime lastDayOfMonthDateTime =
              DateTime(lastDay.year, lastDay.month, lastDay.dayOfMonth);
          startDateTime = lastDayOfMonthDateTime
              .subtract(Duration(days: daysBetweenStartToLastDayOfMonth));
        }
        endDateTime = startDateTime.add(Duration(days: daysBetweenStartToEnd));
      }

      if (endDateTime.compareTo(DateTime.parse(
                  "${Global.oldYears.last.year}0101 00:00:00")) ==
              -1 ||
          model.exceptionTimes.contains(
              "${startDateTime.year}${sprintf("%02i", [
                startDateTime.month
              ])}${sprintf("%02i", [startDateTime.day])}${sprintf("%02i", [
                startDateTime.hour
              ])}${sprintf("%02i", [startDateTime.minute])}")) {
        continue;
      }

      if (startDateTime.compareTo(DateTime.parse(
                  "${Global.newYears.last.year + 1}1231 23:59:59")) ==
              1 ||
          (model.repeatUntil > 0 &&
              model.repeatUntil <=
                  int.parse("${startDateTime.year}${sprintf("%02i", [
                        startDateTime.month
                      ])}${sprintf("%02i", [
                        startDateTime.day
                      ])}${sprintf("%02i", [
                        startDateTime.hour
                      ])}${sprintf("%02i", [startDateTime.minute])}"))) {
        break;
      }

      ScheduleModel scheduleModel = model.copyToScheduleModel();
      scheduleModel.startTime = int.parse(
          "${startDateTime.year}${sprintf("%02i", [
            startDateTime.month
          ])}${sprintf("%02i", [startDateTime.day])}${sprintf("%02i", [
            startDateTime.hour
          ])}${sprintf("%02i", [startDateTime.minute])}");
      scheduleModel.endTime = int.parse("${endDateTime.year}${sprintf("%02i", [
            endDateTime.month
          ])}${sprintf("%02i", [endDateTime.day])}${sprintf("%02i", [
            endDateTime.hour
          ])}${sprintf("%02i", [endDateTime.minute])}");
      addScheduleToTargetDaysOnce(scheduleModel);
    }
  }
}

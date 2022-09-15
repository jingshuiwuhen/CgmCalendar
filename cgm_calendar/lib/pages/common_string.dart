import 'package:cgm_calendar/generated/l10n.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/view_models/set_schedule_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonString {
  static String getRepeatStr(BuildContext context, RepeatType repeatType) {
    String text = "";
    switch (repeatType) {
      case RepeatType.none:
        text = S.of(context).repeat_type_none;
        break;
      case RepeatType.everyDay:
        text = S.of(context).repeat_type_every_day;
        break;
      case RepeatType.everyWeek:
        text = S.of(context).repeat_type_every_week;
        break;
      case RepeatType.everyMonth:
        text = S.of(context).repeat_type_every_month;
        break;
    }
    return text;
  }

  static String getRepeatUntilStr(BuildContext context, int repeatUntil) {
    if (repeatUntil == 0) {
      return S.of(context).repeat_until_none;
    }

    int repeatUntilDate = repeatUntil ~/ 10000;
    DateTime time = DateTime.parse(repeatUntilDate.toString());
    return DateFormat.yMMMMd(Global.localeStr()).format(time);
  }

  static String getScheduleStr(
      BuildContext context, SchedualType schedualType) {
    String text = "";
    switch (schedualType) {
      case SchedualType.personal:
        text = S.of(context).schedule_type_personal;
        break;
      case SchedualType.work:
        text = S.of(context).schedule_type_work;
        break;
    }
    return text;
  }
}

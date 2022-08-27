import 'package:cgm_calendar/view_models/add_schedule_page_view_model.dart';

class CommonString {
  static String getRepeatStr(RepeatType repeatType) {
    String text = "";
    switch (repeatType) {
      case RepeatType.none:
        text = "永不";
        break;
      case RepeatType.everyDay:
        text = "每天";
        break;
      case RepeatType.everyWeek:
        text = "每周";
        break;
      case RepeatType.everyMonth:
        text = "每月";
        break;
    }
    return text;
  }

  static String getScheduleStr(SchedualType schedualType) {
    String text = "";
    switch (schedualType) {
      case SchedualType.personal:
        text = "个人";
        break;
      case SchedualType.work:
        text = "工作";
        break;
    }
    return text;
  }
}

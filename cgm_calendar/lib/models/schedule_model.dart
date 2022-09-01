class ScheduleModel {
  int id = 0;
  String title = "";
  int startTime = 0;
  int endTime = 0;
  int repeatType = 0;
  int scheduleType = 0;
  String remarks = "";

  ScheduleModel copy() {
    ScheduleModel copy = ScheduleModel();
    copy.id = id;
    copy.title = title;
    copy.startTime = startTime;
    copy.endTime = endTime;
    copy.repeatType = repeatType;
    copy.scheduleType = scheduleType;
    copy.remarks = remarks;
    return copy;
  }

  bool isDifferent(ScheduleModel model) {
    return id != model.id ||
        title.compareTo(model.title) != 0 ||
        startTime != model.startTime ||
        endTime != model.endTime ||
        repeatType != model.repeatType ||
        scheduleType != model.scheduleType ||
        remarks.compareTo(model.remarks) != 0;
  }
}

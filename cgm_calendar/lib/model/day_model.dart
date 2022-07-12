class DayModel {
  //年份
  int year = 0;

  //月份
  int month = 0;

  //日期
  int dayOfMonth = 0;

  //星期
  int dayOfWeek = 0;

  //是否是今天
  bool isToday() {
    var now = DateTime.now();
    return (now.year == year) &&
        (now.month == month) &&
        (now.day == dayOfMonth);
  }
}

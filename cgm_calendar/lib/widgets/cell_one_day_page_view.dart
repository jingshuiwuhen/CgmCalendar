import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/view_models/set_schedule_page_view_model.dart';
import 'package:cgm_calendar/widgets/right_bottom_corner_triangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CellOneDayPageView extends StatelessWidget {
  final DayModel dayModel;
  int selectIndex = 0;
  final bool isLastDay;

  CellOneDayPageView({
    Key? key,
    required this.dayModel,
    this.selectIndex = 0,
    required this.isLastDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: setBorder(),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                  2.w,
                  2.h,
                  2.w,
                  0,
                ),
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                  color: dayModel.isToday() ? Colors.red : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "${dayModel.dayOfMonth}",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: dayModel.isToday()
                        ? Colors.white
                        : dayModel.isHighLight()
                            ? Colors.black
                            : Colors.grey[350],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 2.w,
                        right: 2.w,
                      ),
                      color: dayModel.scheduleList.isEmpty
                          ? null
                          : dayModel.scheduleList[0].scheduleType ==
                                  ScheduleType.personal
                              ? Colors.lightBlue[100]
                              : Colors.purpleAccent[100],
                      padding: EdgeInsets.fromLTRB(
                        1.w,
                        1.h,
                        1.w,
                        1.h,
                      ),
                      child: Text(
                        dayModel.scheduleList.isEmpty
                            ? ""
                            : dayModel.scheduleList[0].title,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 9.sp,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 2.w,
                        right: 2.w,
                      ),
                      color: dayModel.scheduleList.length < 2
                          ? null
                          : dayModel.scheduleList[1].scheduleType ==
                                  ScheduleType.personal
                              ? Colors.lightBlue[100]
                              : Colors.purpleAccent[100],
                      padding: EdgeInsets.fromLTRB(
                        1.w,
                        1.h,
                        1.w,
                        1.h,
                      ),
                      child: Text(
                        dayModel.scheduleList.length < 2
                            ? ""
                            : dayModel.scheduleList[1].title,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 9.sp,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 2.w,
                        right: 2.w,
                      ),
                      color: dayModel.scheduleList.length < 3
                          ? null
                          : dayModel.scheduleList[2].scheduleType ==
                                  ScheduleType.personal
                              ? Colors.lightBlue[100]
                              : Colors.purpleAccent[100],
                      padding: EdgeInsets.fromLTRB(
                        1.w,
                        1.h,
                        1.w,
                        1.h,
                      ),
                      child: Text(
                        dayModel.scheduleList.length < 3
                            ? ""
                            : dayModel.scheduleList[2].title,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 9.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Visibility(
            visible: dayModel.scheduleList.length > 3,
            child: CustomPaint(
              painter: RightBottomCornerTriangle(),
              child: Container(
                alignment: Alignment.bottomRight,
                width: double.infinity,
                height: double.infinity,
                child: Text(
                  setMoreStr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration setBorder() {
    if (selectIndex == dayModel.dayOfMonth - 1) {
      return BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 2,
        ),
      );
    }

    return BoxDecoration(
      border: Border(
        bottom: const BorderSide(
          color: Color(0xffd6d6d6),
        ),
        left: const BorderSide(
          color: Color(0xffd6d6d6),
        ),
        right: isLastDay
            ? const BorderSide(
                color: Color(0xffd6d6d6),
              )
            : BorderSide.none,
      ),
    );
  }

  String setMoreStr() {
    int count = dayModel.scheduleList.length;
    if (count <= 3) {
      return "";
    }

    if (count > 3 && count < 13) {
      return "+${count - 3}";
    }

    return "9+";
  }
}

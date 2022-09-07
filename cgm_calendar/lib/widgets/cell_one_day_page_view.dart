import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/view_models/set_schedule_page_view_model.dart';
import 'package:cgm_calendar/widgets/right_bottom_corner_triangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CellOneDayPageView extends StatelessWidget {
  final DayModel dayModel;
  int selectIndex = 0;

  CellOneDayPageView({
    Key? key,
    required this.dayModel,
    this.selectIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: selectIndex == dayModel.dayOfMonth - 1
              ? Colors.red
              : Colors.transparent,
          width: selectIndex == dayModel.dayOfMonth - 1 ? 2 : 1,
        ),
      ),
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
                padding: EdgeInsets.all(3.h),
                decoration: BoxDecoration(
                  color: dayModel.isToday() ? Colors.red : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "${dayModel.dayOfMonth}",
                  style: TextStyle(
                    fontSize: 10.sp,
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
                                  SchedualType.personal.index
                              ? Colors.lightBlue
                              : Colors.purpleAccent,
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
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
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
                                  SchedualType.personal.index
                              ? Colors.lightBlue
                              : Colors.purpleAccent,
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
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
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
                                  SchedualType.personal.index
                              ? Colors.lightBlue
                              : Colors.purpleAccent,
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
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CustomPaint(
            painter: RightBottomCornerTriangle(),
            child: Container(
              alignment: Alignment.bottomRight,
              width: double.infinity,
              height: double.infinity,
              child: Text(
                "+5",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

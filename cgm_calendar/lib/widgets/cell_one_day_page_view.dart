import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/view_models/set_schedule_page_view_model.dart';
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
          color:
              selectIndex == dayModel.dayOfMonth - 1 ? Colors.red : Colors.grey,
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
                  1.h,
                ),
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                  color: dayModel.isToday() ? Colors.red : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "${dayModel.dayOfMonth}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: dayModel.isToday()
                        ? Colors.white
                        : dayModel.isHighLight()
                            ? Colors.black
                            : Colors.grey[350],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  2.w,
                  1.h,
                  2.w,
                  1.h,
                ),
                color: dayModel.scheduleList[0].scheduleType ==
                        SchedualType.personal.index
                    ? Colors.lightBlue
                    : Colors.purpleAccent,
                padding: EdgeInsets.fromLTRB(
                  2.w,
                  2.h,
                  2.w,
                  2.h,
                ),
                child: Text(
                  dayModel.scheduleList[0].title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  2.w,
                  1.h,
                  2.w,
                  1.h,
                ),
                color: dayModel.scheduleList[1].scheduleType ==
                        SchedualType.personal.index
                    ? Colors.lightBlue
                    : Colors.purpleAccent,
                padding: EdgeInsets.fromLTRB(
                  2.w,
                  2.h,
                  2.w,
                  2.h,
                ),
                child: Text(
                  dayModel.scheduleList[1].title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  2.w,
                  1.h,
                  2.w,
                  2.h,
                ),
                color: dayModel.scheduleList[2].scheduleType ==
                        SchedualType.personal.index
                    ? Colors.lightBlue
                    : Colors.purpleAccent,
                padding: EdgeInsets.fromLTRB(
                  2.w,
                  2.h,
                  2.w,
                  2.h,
                ),
                child: Text(
                  dayModel.scheduleList[2].title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border(),
            ),
          )
        ],
      ),
    );
  }
}

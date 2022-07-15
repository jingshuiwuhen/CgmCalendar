import 'package:cgm_calendar/model/day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CellOneDay extends StatelessWidget {
  final DayModel dayModel;
  const CellOneDay({Key? key, required this.dayModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(414, 896));
    return Container(
      alignment: Alignment.center,
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: dayModel.isToday() ? Colors.red : Colors.transparent,
      ),
      child: Text(
        dayModel.dayOfMonth.toString(),
        style: TextStyle(
          color: dayModel.isToday() ? Colors.white : Colors.black,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

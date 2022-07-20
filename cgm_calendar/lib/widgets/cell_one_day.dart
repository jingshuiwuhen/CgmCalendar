import 'package:cgm_calendar/model/day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CellOneDay extends StatelessWidget {
  final DayModel dayModel;
  const CellOneDay({Key? key, required this.dayModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
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

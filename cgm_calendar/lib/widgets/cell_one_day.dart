import 'package:cgm_calendar/models/day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CellOneDay extends StatelessWidget {
  final DayModel dayModel;
  final double? fontSize;
  final EdgeInsetsGeometry? itemMargin;
  const CellOneDay({
    Key? key,
    required this.dayModel,
    this.fontSize,
    this.itemMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: itemMargin ?? const EdgeInsets.all(0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: dayModel.isToday() ? Colors.red : Colors.transparent,
      ),
      child: Text(
        dayModel.dayOfMonth.toString(),
        style: TextStyle(
          color: dayModel.isToday() ? Colors.white : Colors.black,
          fontSize: fontSize ?? 10.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

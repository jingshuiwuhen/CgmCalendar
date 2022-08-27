import 'package:cgm_calendar/models/day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CellOneDay extends StatelessWidget {
  final DayModel dayModel;
  final double? fontSize;
  final EdgeInsetsGeometry? itemMargin;
  int selectingIndex;
  bool clickable;

  CellOneDay({
    Key? key,
    required this.dayModel,
    required this.selectingIndex,
    required this.clickable,
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
        color: clickable && (selectingIndex == dayModel.dayOfMonth - 1)
            ? Colors.grey
            : dayModel.isToday()
                ? Colors.red
                : Colors.transparent,
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

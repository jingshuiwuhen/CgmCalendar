import 'package:cgm_calendar/model/month_model.dart';
import 'package:cgm_calendar/widgets/cell_one_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CellOneMonth extends StatelessWidget {
  final MonthModel monthModel;
  final bool showTitle;
  final double crossAxisSpacing;
  final double? fontSize;
  final EdgeInsetsGeometry? itemMargin;

  const CellOneMonth({
    Key? key,
    required this.monthModel,
    this.showTitle = true,
    this.crossAxisSpacing = 0.0,
    this.fontSize,
    this.itemMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: showTitle,
          child: Text(
            "${monthModel.month}月",
            style: TextStyle(
              color: monthModel.isThisMonth() ? Colors.red : Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: GridView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: monthModel.daysOfMonth.length +
                  (monthModel.daysOfMonth[0].dayOfWeek % 7),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: crossAxisSpacing,
              ),
              itemBuilder: (context, index) {
                if (index < (monthModel.daysOfMonth[0].dayOfWeek % 7)) {
                  return Container(
                    color: Colors.transparent,
                  );
                } else {
                  return CellOneDay(
                      itemMargin: itemMargin,
                      fontSize: fontSize,
                      dayModel: monthModel.daysOfMonth[
                          index - (monthModel.daysOfMonth[0].dayOfWeek % 7)]);
                }
              }),
        ),
      ],
    );
  }
}

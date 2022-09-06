import 'package:cgm_calendar/models/month_model.dart';
import 'package:cgm_calendar/widgets/cell_one_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CellOneMonth extends StatelessWidget {
  final MonthModel monthModel;

  const CellOneMonth({
    Key? key,
    required this.monthModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int gridViewItemCount = monthModel.daysOfMonth.length +
        (monthModel.daysOfMonth[0].dayOfWeek % 7);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          monthModel.getMonthStr(),
          style: TextStyle(
            color: monthModel.isThisMonth()
                ? Colors.red
                : monthModel.isHighLight()
                    ? Colors.black
                    : Colors.grey[350],
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: GridView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: gridViewItemCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemBuilder: (context, index) {
              if (index < (monthModel.daysOfMonth[0].dayOfWeek % 7)) {
                return const Spacer();
              } else {
                return CellOneDay(
                  dayModel: monthModel.daysOfMonth[
                      index - (monthModel.daysOfMonth[0].dayOfWeek % 7)],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

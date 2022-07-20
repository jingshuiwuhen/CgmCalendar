import 'package:cgm_calendar/model/month_model.dart';
import 'package:cgm_calendar/widgets/cell_one_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CellOneMonth extends StatelessWidget {
  final MonthModel monthModel;

  const CellOneMonth({Key? key, required this.monthModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${monthModel.month}月",
          style: TextStyle(
            color: monthModel.isThisMonth() ? Colors.red : Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
          child: GridView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: 42,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemBuilder: (context, index) {
                if (index < (monthModel.daysOfMonth[0].dayOfWeek % 7) ||
                    index > monthModel.daysOfMonth.length - 1) {
                  return Container(
                    color: Colors.transparent,
                  );
                } else {
                  return CellOneDay(
                      dayModel: monthModel.daysOfMonth[
                          index - (monthModel.daysOfMonth[0].dayOfWeek % 7)]);
                }
              }),
        ),
      ],
    );
  }
}

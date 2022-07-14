import 'package:cgm_calendar/model/month_model.dart';
import 'package:cgm_calendar/widgets/cell_one_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CellOneMonth extends StatelessWidget {
  final MonthModel monthModel;

  const CellOneMonth({Key? key, required this.monthModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(1.w, 1.h, 1.w, 1.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${monthModel.month}月",
            style: TextStyle(
              color: monthModel.isThisMonth() ? Colors.red : Colors.black,
              fontSize: 20.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5.h,
            ),
            child: GridView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: monthModel.daysOfMonth.length +
                    (monthModel.daysOfMonth[0].dayOfWeek % 7),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 2.w,
                  crossAxisSpacing: 2.h,
                ),
                itemBuilder: (context, index) {
                  if (index < (monthModel.daysOfMonth[0].dayOfWeek % 7)) {
                    return Container(
                      color: Colors.white,
                    );
                  } else {
                    return Container(
                      color: Colors.green,
                    );
                  }
                  // if (index < (monthModel.daysOfMonth[0].dayOfWeek % 7)) {
                  //   return const Text("");
                  // } else {
                  //   return CellOneDay(
                  //       dayModel: monthModel.daysOfMonth[
                  //           index - (monthModel.daysOfMonth[0].dayOfWeek % 7)]);
                  // }
                }),
          ),
        ],
      ),
    );
  }
}

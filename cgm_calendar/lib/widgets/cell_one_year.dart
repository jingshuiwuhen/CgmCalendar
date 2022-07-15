import 'package:cgm_calendar/widgets/cell_one_month.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/year_model.dart';

class CellOneYear extends StatelessWidget {
  final YearModel yearModel;

  const CellOneYear({Key? key, required this.yearModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(414, 896));
    return Padding(
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${yearModel.year}年",
            style: TextStyle(
              color: yearModel.isThisYear() ? Colors.red : Colors.black,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 3.h,
              bottom: 6.h,
            ),
            child: const Divider(
              color: Colors.black,
              thickness: 2,
            ),
          ),
          GridView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: yearModel.monthsOfYear.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.w,
                crossAxisSpacing: 8.h,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                return CellOneMonth(
                  monthModel: yearModel.monthsOfYear[index],
                );
              }),
        ],
      ),
    );
  }
}

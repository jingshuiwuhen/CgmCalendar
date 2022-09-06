import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/year_model.dart';
import 'package:cgm_calendar/pages/month_page.dart';
import 'package:cgm_calendar/widgets/cell_one_month.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CellOneYear extends StatelessWidget {
  final YearModel yearModel;
  void Function()? oneYearClick;

  CellOneYear({
    Key? key,
    required this.yearModel,
    this.oneYearClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            yearModel.getYearStr(),
            style: TextStyle(
              color: yearModel.isThisYear()
                  ? Colors.red
                  : yearModel.isHighLight()
                      ? Colors.black
                      : Colors.grey[350],
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
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          GridView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: yearModel.monthsOfYear.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.h,
              mainAxisExtent: 0.35.sw,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  if (!yearModel.isHighLight()) {
                    return;
                  }

                  var monthModelIndex = 0;
                  if (yearModel.year < Global.newYears.first.year) {
                    monthModelIndex =
                        (Global.oldYears.last.year - yearModel.year) * 12 +
                            index;
                  } else {
                    monthModelIndex += Global.oldYears.length * 12;
                    monthModelIndex +=
                        (yearModel.year - Global.newYears.first.year) * 12 +
                            index;
                  }
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      settings: const RouteSettings(name: "MonthPage"),
                      builder: (context) =>
                          MonthPage(monthModelIndex: monthModelIndex),
                    ),
                  );
                  if (oneYearClick != null) {
                    oneYearClick!();
                  }
                },
                child: CellOneMonth(
                  monthModel: yearModel.monthsOfYear[index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

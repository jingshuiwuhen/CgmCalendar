import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/month_model.dart';
import 'package:cgm_calendar/view_models/cell_one_month_view_model.dart';
import 'package:cgm_calendar/widgets/cell_one_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CellOneMonth extends StatelessWidget {
  final MonthModel monthModel;
  final bool showTitle;
  final double crossAxisSpacing;
  final double? fontSize;
  final EdgeInsetsGeometry? itemMargin;
  final Function(DayModel)? oneDayClick;

  const CellOneMonth({
    Key? key,
    required this.monthModel,
    this.showTitle = true,
    this.crossAxisSpacing = 0.0,
    this.fontSize,
    this.itemMargin,
    this.oneDayClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CellOneMonthViewModel(monthModel.daysOfMonth),
        builder: (context, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: showTitle,
                child: Text(
                  monthModel.getMonthStr(),
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
                        return GestureDetector(
                          onTap: () {
                            int selectIndex = index -
                                (monthModel.daysOfMonth[0].dayOfWeek % 7);
                            context
                                .read<CellOneMonthViewModel>()
                                .oneDayClick(selectIndex);

                            if (oneDayClick != null) {
                              oneDayClick!(context
                                  .watch<CellOneMonthViewModel>()
                                  .daysOfMonth[selectIndex]);
                            }
                          },
                          child: CellOneDay(
                              itemMargin: itemMargin,
                              fontSize: fontSize,
                              dayModel: context
                                      .watch<CellOneMonthViewModel>()
                                      .daysOfMonth[
                                  index -
                                      (monthModel.daysOfMonth[0].dayOfWeek %
                                          7)]),
                        );
                      }
                    }),
              ),
            ],
          );
        });
  }
}

import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/month_model.dart';
import 'package:cgm_calendar/view_models/cell_one_month_view_model.dart';
import 'package:cgm_calendar/widgets/cell_one_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CellOneMonth extends StatelessWidget {
  final MonthModel monthModel;
  final bool showTitle;
  final double? fontSize;
  final EdgeInsetsGeometry? itemMargin;
  final bool clickable;
  final Function(DayModel)? oneDayClick;
  late CellOneMonthViewModel wViewModel;
  late CellOneMonthViewModel rViewModel;

  CellOneMonth({
    Key? key,
    required this.monthModel,
    required this.clickable,
    this.showTitle = true,
    this.fontSize,
    this.itemMargin,
    this.oneDayClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int gridViewItemCount = monthModel.daysOfMonth.length +
        (monthModel.daysOfMonth[0].dayOfWeek % 7);
    return ChangeNotifierProvider(
      create: (_) => CellOneMonthViewModel(monthModel.daysOfMonth),
      builder: (context, child) {
        wViewModel = context.watch<CellOneMonthViewModel>();
        rViewModel = context.read<CellOneMonthViewModel>();
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
            Container(
              decoration: BoxDecoration(
                color: clickable ? Colors.grey[100] : Colors.transparent,
                border: clickable
                    ? const Border(
                        bottom: BorderSide(
                          color: Color(0xffd6d6d6),
                        ),
                      )
                    : null,
              ),
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
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: clickable
                            ? const Border(
                                bottom: BorderSide(
                                  color: Color(0xffd6d6d6),
                                ),
                              )
                            : null,
                      ),
                    );
                  } else {
                    if (clickable) {
                      return GestureDetector(
                        onTap: () {
                          int selectIndex =
                              index - (monthModel.daysOfMonth[0].dayOfWeek % 7);
                          rViewModel.oneDayClick(selectIndex);

                          if (oneDayClick != null) {
                            oneDayClick!(rViewModel.daysOfMonth[selectIndex]);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: (gridViewItemCount % 7) >
                                    (gridViewItemCount - index - 1)
                                ? null
                                : const Border(
                                    bottom: BorderSide(
                                      color: Color(0xffd6d6d6),
                                    ),
                                  ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: CellOneDay(
                                    itemMargin: itemMargin,
                                    fontSize: fontSize,
                                    clickable: true,
                                    selectingIndex: wViewModel.selectingIndex,
                                    dayModel: wViewModel.daysOfMonth[index -
                                        (monthModel.daysOfMonth[0].dayOfWeek %
                                            7)]),
                              ),
                              Container(
                                height: 6.w,
                                width: 6.w,
                                margin: EdgeInsets.only(bottom: 3.h),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: wViewModel
                                          .daysOfMonth[index -
                                              (monthModel.daysOfMonth[0]
                                                      .dayOfWeek %
                                                  7)]
                                          .scheduleList
                                          .isNotEmpty
                                      ? Colors.grey[400]
                                      : Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return CellOneDay(
                        itemMargin: itemMargin,
                        fontSize: fontSize,
                        clickable: false,
                        selectingIndex: 0,
                        dayModel: wViewModel.daysOfMonth[
                            index - (monthModel.daysOfMonth[0].dayOfWeek % 7)],
                      );
                    }
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

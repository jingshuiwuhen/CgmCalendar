import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/month_model.dart';
import 'package:cgm_calendar/widgets/cell_one_day_page_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CellPageView extends StatelessWidget {
  final MonthModel monthModel;
  final Function(DayModel) oneDayClicked;
  int selectIndex;

  CellPageView({
    Key? key,
    required this.monthModel,
    required this.oneDayClicked,
    this.selectIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int gridViewItemCount = monthModel.daysOfMonth.length +
        (monthModel.daysOfMonth[0].dayOfWeek % 7);
    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: gridViewItemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.67,
      ),
      itemBuilder: (context, index) {
        if (index < (monthModel.daysOfMonth[0].dayOfWeek % 7)) {
          return Container();
        } else {
          return CellOneDayPageView(
            dayModel: monthModel
                .daysOfMonth[index - (monthModel.daysOfMonth[0].dayOfWeek % 7)],
          );
        }
      },
    );
  }
}

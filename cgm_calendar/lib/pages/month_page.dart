import 'package:cgm_calendar/generated/l10n.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:cgm_calendar/pages/schedule_detail_page.dart';
import 'package:cgm_calendar/pages/set_schedule_page.dart';
import 'package:cgm_calendar/view_models/month_page_view_model.dart';
import 'package:cgm_calendar/view_models/set_schedule_page_view_model.dart';
import 'package:cgm_calendar/widgets/cell_page_view.dart';
import 'package:cgm_calendar/widgets/left_drawer.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

// ignore: must_be_immutable
class MonthPage extends StatelessWidget {
  final int monthModelIndex;
  late MonthPageViewModel rViewModel;
  late MonthPageViewModel wViewModel;

  MonthPage({Key? key, required this.monthModelIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MonthPageViewModel(monthModelIndex),
      builder: (context, child) {
        rViewModel = context.read<MonthPageViewModel>();
        wViewModel = context.watch<MonthPageViewModel>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.red,
              ),
            ),
            title: Text(
              wViewModel.title,
              style: TextStyle(fontSize: 20.sp),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  await Navigator.of(context).push(_addSchedulePageRoute());
                  rViewModel.refreshPage();
                },
                icon: const Icon(
                  Icons.add,
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20.h),
              child: GridView.builder(
                itemCount: 7,
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisExtent: 20.h,
                ),
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      _weekDayName(context, index),
                      style: TextStyle(color: Colors.black, fontSize: 10.sp),
                    ),
                  );
                },
              ),
            ),
          ),
          drawer: LeftDrawer(
            clean: () => rViewModel.refreshPage(),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1,
                )
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      rViewModel.controller.animateToPage(
                        monthModelIndex,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOutSine,
                      );
                    },
                    icon: const Icon(
                      Icons.calendar_today,
                      color: Colors.red,
                    ),
                  ),
                  const Spacer(),
                  Builder(
                    builder: ((context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.red,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                color: Colors.grey[200],
                child: ExpandablePageView.builder(
                  controller: rViewModel.controller,
                  itemCount: Global.allMonths.length,
                  onPageChanged: (index) {
                    rViewModel.onPageChanged(index);
                  },
                  itemBuilder: (context, index) => CellPageView(
                    monthModel: Global.allMonths[index],
                    oneDayClicked: (day) => rViewModel.refreshScheduleList(day),
                    selectIndex: wViewModel.selectIndex,
                  ),
                ),
              ),
              Expanded(
                child: wViewModel.day.scheduleList.isEmpty
                    ? Center(
                        child: Text(
                          S.of(context).schedule_not_exist,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        primary: false,
                        itemCount: wViewModel.day.scheduleList.length,
                        itemBuilder: (context, index) {
                          ScheduleModel schedule =
                              wViewModel.day.scheduleList[index];
                          return InkWell(
                            onTap: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ScheduleDetailPage(
                                    model: schedule,
                                  ),
                                ),
                              );
                              rViewModel.refreshPage();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 5.h,
                                left: 10.w,
                                right: 10.w,
                                bottom: 5.h,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _startTimeStr(
                                          context,
                                          schedule,
                                          rViewModel.day,
                                        ),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Text(
                                        _endTimeStr(
                                          schedule,
                                          rViewModel.day,
                                        ),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 40.h,
                                    width: 6.w,
                                    margin: EdgeInsets.only(
                                      left: 6.w,
                                      right: 6.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: schedule.scheduleType ==
                                              SchedualType.personal.index
                                          ? Colors.lightBlue[100]
                                          : Colors.purpleAccent[100],
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                        20.r,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          schedule.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                        Text(
                                          schedule.remarks,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Route _addSchedulePageRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SetSchedulePage(
        selectedDayModel: rViewModel.day,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  String _weekDayName(BuildContext context, int weekday) {
    switch (weekday) {
      case 0:
        return S.of(context).sunday;
      case 1:
        return S.of(context).monday;
      case 2:
        return S.of(context).tuesday;
      case 3:
        return S.of(context).wedsday;
      case 4:
        return S.of(context).thursday;
      case 5:
        return S.of(context).friday;
      default:
        return S.of(context).saturday;
    }
  }

  String _startTimeStr(
      BuildContext context, ScheduleModel schedule, DayModel day) {
    int startDate = schedule.startTime ~/ 10000;
    String startDateStr = schedule.startTime.toString();
    int endDate = schedule.endTime ~/ 10000;
    int dateOfDay = int.parse("${day.year}${sprintf("%02i", [
          day.month
        ])}${sprintf("%02i", [day.dayOfMonth])}");

    if (startDate == dateOfDay) {
      return "${startDateStr.substring(8, 10)}:${startDateStr.substring(10)}";
    }

    if (endDate == dateOfDay) {
      return S.of(context).end;
    }

    return S.of(context).all_day;
  }

  String _endTimeStr(ScheduleModel schedule, DayModel day) {
    int endDate = schedule.endTime ~/ 10000;
    String endDateStr = schedule.endTime.toString();
    int dateOfDay = int.parse("${day.year}${sprintf("%02i", [
          day.month
        ])}${sprintf("%02i", [day.dayOfMonth])}");

    if (endDate == dateOfDay) {
      return "${endDateStr.substring(8, 10)}:${endDateStr.substring(10)}";
    }

    return "";
  }
}

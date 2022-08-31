import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:cgm_calendar/pages/add_schedule_page.dart';
import 'package:cgm_calendar/pages/schedule_detail_page.dart';
import 'package:cgm_calendar/view_models/add_schedule_page_view_model.dart';
import 'package:cgm_calendar/view_models/month_page_view_model.dart';
import 'package:cgm_calendar/widgets/cell_one_month.dart';
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
                      _weekDayName(index),
                      style: TextStyle(color: Colors.black, fontSize: 10.sp),
                    ),
                  );
                },
              ),
            ),
          ),
          drawer: const LeftDrawer(),
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
                      rViewModel.controller.jumpToPage(monthModelIndex);
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
              ExpandablePageView.builder(
                controller: rViewModel.controller,
                itemCount: Global.allMonths.length,
                onPageChanged: (index) {
                  rViewModel.onPageChanged(index);
                },
                itemBuilder: (context, index) => CellOneMonth(
                  clickable: true,
                  monthModel: Global.allMonths[index],
                  showTitle: false,
                  fontSize: 15.sp,
                  itemMargin: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                  oneDayClick: (day) => rViewModel.refreshScheduleList(day),
                ),
              ),
              Expanded(
                child: wViewModel.day.scheduleList.isEmpty
                    ? Center(
                        child: Text(
                          "没有日程",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: wViewModel.day.scheduleList.length,
                        itemBuilder: (context, index) {
                          ScheduleModel schedule =
                              wViewModel.day.scheduleList[index];
                          return InkWell(
                            onTap: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  settings:
                                      const RouteSettings(name: "MonthPage"),
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
                                  Container(
                                    height: 50.h,
                                    width: 6.w,
                                    decoration: BoxDecoration(
                                      color: schedule.scheduleType ==
                                              SchedualType.personal.index
                                          ? Colors.lightBlue
                                          : Colors.purpleAccent,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                              20.r),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 6.w,
                                        right: 6.w,
                                      ),
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
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _startTimeStr(
                                          schedule,
                                          rViewModel.day,
                                        ),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      Text(
                                        _endTimeStr(
                                          schedule,
                                          rViewModel.day,
                                        ),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
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
      pageBuilder: (context, animation, secondaryAnimation) =>
          AddSchedulePage(),
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

  String _weekDayName(int weekday) {
    switch (weekday) {
      case 0:
        return "日";
      case 1:
        return "一";
      case 2:
        return "二";
      case 3:
        return "三";
      case 4:
        return "四";
      case 5:
        return "五";
      default:
        return "六";
    }
  }

  String _startTimeStr(ScheduleModel schedule, DayModel day) {
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
      return "结束";
    }

    return "全天";
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

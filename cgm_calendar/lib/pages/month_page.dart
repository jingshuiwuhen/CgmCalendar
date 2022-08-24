import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:cgm_calendar/view_models/add_schedule_page_view_model.dart';
import 'package:cgm_calendar/view_models/month_page_view_model.dart';
import 'package:cgm_calendar/widgets/cell_one_month.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MonthPage extends StatelessWidget {
  final int monthModelIndex;

  const MonthPage({Key? key, required this.monthModelIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MonthPageViewModel(monthModelIndex),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            elevation: 1,
            title: Text(
              context.watch<MonthPageViewModel>().title,
              style: TextStyle(fontSize: 20.sp),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
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
                      context.read<MonthPageViewModel>().weekDayName(index),
                      style: TextStyle(color: Colors.black, fontSize: 10.sp),
                    ),
                  );
                },
              ),
            ),
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.calendar_today,
                      color: Colors.red,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.info_outline,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              ExpandablePageView.builder(
                controller: context.read<MonthPageViewModel>().controller,
                itemCount: Global.allMonths.length,
                onPageChanged: (index) {
                  context.read<MonthPageViewModel>().updateTitle(index);
                },
                itemBuilder: (context, index) => CellOneMonth(
                  monthModel: Global.allMonths[index],
                  showTitle: false,
                  crossAxisSpacing: 10.h,
                  fontSize: 15.sp,
                  itemMargin: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                  oneDayClick: (day) => context
                      .read<MonthPageViewModel>()
                      .refreshScheduleList(day),
                ),
              ),
              Expanded(
                child: context
                        .watch<MonthPageViewModel>()
                        .day!
                        .scheduleList
                        .isEmpty
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
                        itemCount: context
                            .watch<MonthPageViewModel>()
                            .day!
                            .scheduleList
                            .length,
                        itemBuilder: (context, index) {
                          ScheduleModel model = context
                              .watch<MonthPageViewModel>()
                              .day!
                              .scheduleList[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              top: 3.h,
                              bottom: 3.h,
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 3.w,
                                    decoration: BoxDecoration(
                                      color: model.scheduleType ==
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
                                        left: 3.w,
                                        right: 3.w,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            model.remarks,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.sp,
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
                                        model.title,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        model.remarks,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.sp,
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
}

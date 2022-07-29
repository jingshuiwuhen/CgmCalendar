import 'package:cgm_calendar/view_models/add_schedule_page_view_model.dart';
import 'package:cgm_calendar/widgets/cell_date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddSchedulePage extends StatelessWidget {
  const AddSchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddSchedulePageViewModel(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[200],
            foregroundColor: Colors.red,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.only(
                left: 10.w,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    "取消",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ),
              ),
            ),
            title: Text(
              "新建日程",
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: 10.w,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (!context
                        .read<AddSchedulePageViewModel>()
                        .isNotRightTime) {
                      Navigator.pop(context);
                    }
                  },
                  child: Center(
                    child: Text(
                      "添加",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: context
                                .watch<AddSchedulePageViewModel>()
                                .isNotRightTime
                            ? Colors.grey
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              20.w,
              20.h,
              20.w,
              20.h,
            ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: TextField(
                    controller: context
                        .read<AddSchedulePageViewModel>()
                        .titleEditingController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "标题",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CellDateTimePicker(
                        title: "开始",
                        date:
                            context.watch<AddSchedulePageViewModel>().startDate,
                        time:
                            context.watch<AddSchedulePageViewModel>().startTime,
                        onDateChanged: (date) => context
                            .read<AddSchedulePageViewModel>()
                            .updateStartDate(date),
                        onTimeChanged: (time) => context
                            .read<AddSchedulePageViewModel>()
                            .updateStartTime(time),
                      ),
                      Divider(
                        height: 2.h,
                      ),
                      CellDateTimePicker(
                        title: "结束",
                        isNotRightTime: context
                            .watch<AddSchedulePageViewModel>()
                            .isNotRightTime,
                        date: context.watch<AddSchedulePageViewModel>().endDate,
                        time: context.watch<AddSchedulePageViewModel>().endTime,
                        onDateChanged: (date) => context
                            .read<AddSchedulePageViewModel>()
                            .updateEndDate(date),
                        onTimeChanged: (time) => context
                            .read<AddSchedulePageViewModel>()
                            .updateEndTime(time),
                      ),
                      Divider(
                        height: 2.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showSelector<RepeatType>(context);
                        },
                        child: Row(
                          children: [
                            Text(
                              "重复",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      10.w,
                                      11.h,
                                      5.w,
                                      11.h,
                                    ),
                                    child: Text(
                                      _getRepeatStr(context
                                          .watch<AddSchedulePageViewModel>()
                                          .repeatType),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12.sp,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 2.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showSelector<SchedualType>(context);
                        },
                        child: Row(
                          children: [
                            Text(
                              "类型",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: context
                                                .watch<
                                                    AddSchedulePageViewModel>()
                                                .scheduleType ==
                                            SchedualType.personal
                                        ? Colors.lightBlue
                                        : Colors.purpleAccent,
                                    radius: 3.r,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      10.w,
                                      11.h,
                                      5.w,
                                      11.h,
                                    ),
                                    child: Text(
                                      _getScheduleStr(context
                                          .watch<AddSchedulePageViewModel>()
                                          .scheduleType),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: TextField(
                    controller: context
                        .read<AddSchedulePageViewModel>()
                        .remarksEditingController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                      ),
                      hintText: "备注",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.sp,
                      ),
                    ),
                    maxLines: null,
                    minLines: 7,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSelector<T>(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: ((context) => CupertinoActionSheet(
            actions: _actionList<T>(context),
          )),
    );
  }

  List<CupertinoActionSheetAction> _actionList<T>(BuildContext context) {
    List<CupertinoActionSheetAction> list = List.empty(growable: true);
    if (T is RepeatType) {
      for (int i = 0; i < RepeatType.values.length; i++) {
        RepeatType type = RepeatType.values.elementAt(i);
        list.add(CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            context.read<AddSchedulePageViewModel>().updateRepeatType(type);
            Navigator.pop(context);
          },
          child: Text(_getRepeatStr(type)),
        ));
      }
    } else {
      for (int i = 0; i < SchedualType.values.length; i++) {
        SchedualType type = SchedualType.values.elementAt(i);
        list.add(CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            context.read<AddSchedulePageViewModel>().updateScheduleType(type);
            Navigator.pop(context);
          },
          child: Text(_getScheduleStr(type)),
        ));
      }
    }
    return list;
  }

  String _getRepeatStr(RepeatType repeatType) {
    String text = "";
    switch (repeatType) {
      case RepeatType.none:
        text = "永不";
        break;
      case RepeatType.everyDay:
        text = "每天";
        break;
      case RepeatType.everyWeek:
        text = "每周";
        break;
      case RepeatType.everyMonth:
        text = "每月";
        break;
    }
    return text;
  }

  String _getScheduleStr(SchedualType schedualType) {
    String text = "";
    switch (schedualType) {
      case SchedualType.personal:
        text = "个人";
        break;
      case SchedualType.work:
        text = "工作";
        break;
    }
    return text;
  }
}

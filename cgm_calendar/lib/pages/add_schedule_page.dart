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
                    if (_canAddSchedule(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Center(
                    child: Text(
                      "添加",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: _canAddSchedule(context) ? null : Colors.grey,
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
                    focusNode:
                        context.read<AddSchedulePageViewModel>().titleFocus,
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
                        onClick: () => context
                            .read<AddSchedulePageViewModel>()
                            .cancelFocus(),
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
                        onClick: () => context
                            .read<AddSchedulePageViewModel>()
                            .cancelFocus(),
                      ),
                      Divider(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "重复",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<AddSchedulePageViewModel>()
                                    .cancelFocus();
                                _showSelector<RepeatType>(
                                  context,
                                  RepeatType.values,
                                );
                              },
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
                          ),
                        ],
                      ),
                      Divider(
                        height: 2.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<AddSchedulePageViewModel>()
                              .cancelFocus();
                          _showSelector<SchedualType>(
                            context,
                            SchedualType.values,
                          );
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
                    focusNode:
                        context.read<AddSchedulePageViewModel>().remarksFocus,
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

  void _showSelector<T>(BuildContext pContext, List<T> typeValues) {
    showCupertinoModalPopup<void>(
      context: pContext,
      builder: ((context) => CupertinoActionSheet(
            actions: _actionList<T>(pContext, typeValues),
          )),
    );
  }

  List<CupertinoActionSheetAction> _actionList<T>(
      BuildContext context, List<T> typeValues) {
    List<CupertinoActionSheetAction> list = List.empty(growable: true);
    for (int i = 0; i < typeValues.length; i++) {
      T type = typeValues.elementAt(i);
      list.add(CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          if (type is RepeatType) {
            context.read<AddSchedulePageViewModel>().updateRepeatType(type);
          } else {
            context
                .read<AddSchedulePageViewModel>()
                .updateScheduleType((type as SchedualType));
          }
          Navigator.pop(context);
        },
        child: Text(
          type is RepeatType
              ? _getRepeatStr(type)
              : _getScheduleStr((type as SchedualType)),
        ),
      ));
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

  bool _canAddSchedule(BuildContext context) {
    return !context.read<AddSchedulePageViewModel>().isNotRightTime &&
        context
            .read<AddSchedulePageViewModel>()
            .titleEditingController
            .text
            .isNotEmpty;
  }
}

import 'package:cgm_calendar/pages/common_string.dart';
import 'package:cgm_calendar/view_models/add_schedule_page_view_model.dart';
import 'package:cgm_calendar/widgets/cell_date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddSchedulePage extends StatelessWidget {
  late AddSchedulePageViewModel wViewModel;
  late AddSchedulePageViewModel rViewModel;

  AddSchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddSchedulePageViewModel(),
      builder: (context, child) {
        wViewModel = context.watch<AddSchedulePageViewModel>();
        rViewModel = context.read<AddSchedulePageViewModel>();
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
                  onTap: () async {
                    if (_canAddSchedule(context)) {
                      final navigator = Navigator.of(context);
                      await rViewModel.addSchedule();
                      navigator.pop();
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
                    focusNode: rViewModel.titleFocus,
                    controller: rViewModel.titleEditingController,
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
                        date: wViewModel.startDate,
                        time: wViewModel.startTime,
                        onDateChanged: (date) =>
                            rViewModel.updateStartDate(date),
                        onTimeChanged: (time) =>
                            rViewModel.updateStartTime(time),
                        onClick: () => rViewModel.cancelFocus(),
                      ),
                      Divider(
                        height: 2.h,
                      ),
                      CellDateTimePicker(
                        title: "结束",
                        isNotRightTime: wViewModel.isNotRightTime,
                        date: wViewModel.endDate,
                        time: wViewModel.endTime,
                        onDateChanged: (date) => rViewModel.updateEndDate(date),
                        onTimeChanged: (time) => rViewModel.updateEndTime(time),
                        onClick: () => rViewModel.cancelFocus(),
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
                                rViewModel.cancelFocus();
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
                                      CommonString.getRepeatStr(
                                          wViewModel.repeatType),
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
                          rViewModel.cancelFocus();
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
                                    backgroundColor: wViewModel.scheduleType ==
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
                                      CommonString.getScheduleStr(
                                          wViewModel.scheduleType),
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
                    focusNode: rViewModel.remarksFocus,
                    controller: rViewModel.remarksEditingController,
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
            rViewModel.updateRepeatType(type);
          } else {
            rViewModel.updateScheduleType((type as SchedualType));
          }
          Navigator.pop(context);
        },
        child: Text(
          type is RepeatType
              ? CommonString.getRepeatStr(type)
              : CommonString.getScheduleStr((type as SchedualType)),
        ),
      ));
    }
    return list;
  }

  bool _canAddSchedule(BuildContext context) {
    return !rViewModel.isNotRightTime &&
        rViewModel.titleEditingController.text.isNotEmpty;
  }
}

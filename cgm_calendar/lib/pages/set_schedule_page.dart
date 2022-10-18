import 'package:cgm_calendar/generated/l10n.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:cgm_calendar/pages/common_string.dart';
import 'package:cgm_calendar/view_models/set_schedule_page_view_model.dart';
import 'package:cgm_calendar/widgets/cell_date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

// ignore: must_be_immutable
class SetSchedulePage extends StatelessWidget {
  ScheduleModel? scheduleModel;
  DayModel? selectedDayModel;
  late SetSchedulePageViewModel wViewModel;
  late SetSchedulePageViewModel rViewModel;

  SetSchedulePage({
    Key? key,
    this.scheduleModel,
    this.selectedDayModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SetSchedulePageViewModel(
        scheduleModel,
        selectedDayModel,
      ),
      builder: (context, child) {
        wViewModel = context.watch<SetSchedulePageViewModel>();
        rViewModel = context.read<SetSchedulePageViewModel>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[200],
            foregroundColor: Colors.red,
            elevation: 0,
            leadingWidth: 0.25.sw,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10.w),
                child: Text(
                  S.of(context).cancel,
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
            ),
            title: Text(
              scheduleModel == null
                  ? S.of(context).new_schedule
                  : S.of(context).edit_schedule,
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
                    if (!rViewModel.canAddSchedule()) {
                      return;
                    }

                    if (scheduleModel == null) {
                      rViewModel.addNewSchedule(
                          context, () => Navigator.of(context).pop());
                      return;
                    }

                    if (!rViewModel.isChanged()) {
                      Navigator.of(context).pop();
                      return;
                    }

                    if (scheduleModel!.repeatType == RepeatType.none.index) {
                      rViewModel.editNoRepeatSchedule(
                          context,
                          () => Navigator.of(context)
                              .popUntil(ModalRoute.withName("MonthPage")));
                      return;
                    }

                    _showEditSelector(context);
                  },
                  child: Center(
                    child: Text(
                      scheduleModel == null
                          ? S.of(context).add
                          : S.of(context).done,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: rViewModel.canAddSchedule() ? null : Colors.grey,
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
                      hintText: S.of(context).title,
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
                        title: S.of(context).start,
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
                        title: S.of(context).end,
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
                            S.of(context).repeat,
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
                                          context, wViewModel.repeatType),
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
                      Visibility(
                        visible: scheduleModel != null &&
                            scheduleModel!.repeatType != RepeatType.none.index,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Divider(
                              height: 2.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  S.of(context).repeat_until,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      rViewModel.cancelFocus();
                                      _showRepeatUntilSelector(context);
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
                                            CommonString.getRepeatUntilStr(
                                              context,
                                              wViewModel.repeatUntil,
                                            ),
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
                          ],
                        ),
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
                              S.of(context).type,
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
                                        ? Colors.lightBlue[100]
                                        : Colors.purpleAccent[100],
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
                                          context, wViewModel.scheduleType),
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
                      hintText: S.of(context).notes,
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
      builder: (context) => CupertinoActionSheet(
        actions: _actionList<T>(pContext, typeValues),
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text(
            S.of(context).cancel,
          ),
        ),
      ),
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
              ? CommonString.getRepeatStr(context, type)
              : CommonString.getScheduleStr(context, (type as SchedualType)),
        ),
      ));
    }
    return list;
  }

  void _showEditSelector<T>(BuildContext pContext) {
    List<CupertinoActionSheetAction> actions = List.empty(growable: true);
    if (!rViewModel.isRepeatChanged() || !rViewModel.isRepeatUntilChanged()) {
      actions.add(
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            rViewModel.editRepeatSchedule(
                EditType.thisOnly,
                pContext,
                () => Navigator.of(pContext)
                    .popUntil(ModalRoute.withName("MonthPage")));
          },
          child: Text(S.of(pContext).for_this_schedule_only),
        ),
      );
    }

    actions.add(
      CupertinoActionSheetAction(
        isDestructiveAction: true,
        onPressed: () {
          rViewModel.editRepeatSchedule(
              EditType.futureContainsThis,
              pContext,
              () => Navigator.of(pContext)
                  .popUntil(ModalRoute.withName("MonthPage")));
        },
        child: Text(S.of(pContext).for_future_schedule),
      ),
    );

    showCupertinoModalPopup<void>(
      context: pContext,
      builder: (context) => CupertinoActionSheet(
        actions: actions,
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
        ),
      ),
    );
  }

  void _showRepeatUntilSelector(BuildContext pContext) {
    showCupertinoModalPopup<void>(
      context: pContext,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(pContext);
              rViewModel.updateRepeatUntil(0);
            },
            child: Text(S.of(pContext).repeat_until_none),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(pContext);
              showModalBottomSheet(
                context: context,
                builder: (context) => CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: rViewModel.getInitialDateTimeOfRepeatUntil(),
                  minimumDate: rViewModel.getInitialDateTimeOfRepeatUntil(),
                  maximumYear: Global.newYears.last.year,
                  onDateTimeChanged: (value) {
                    String date = "${value.year}${sprintf("%02i", [
                          value.month
                        ])}${sprintf("%02i", [value.day])}";
                    rViewModel.updateRepeatUntil(int.parse(date) * 10000);
                  },
                ),
              );
            },
            child: Text(S.of(pContext).edit),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text(
            S.of(context).cancel,
          ),
        ),
      ),
    );
  }
}

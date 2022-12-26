import 'package:cgm_calendar/generated/l10n.dart';
import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:cgm_calendar/pages/common_string.dart';
import 'package:cgm_calendar/pages/set_schedule_page.dart';
import 'package:cgm_calendar/view_models/set_schedule_page_view_model.dart';
import 'package:cgm_calendar/view_models/schedule_detail_page_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ScheduleDetailPage extends StatelessWidget {
  final ScheduleModel model;
  late ScheduleDetailPageViewModel viewModel;

  ScheduleDetailPage({
    Key? key,
    required this.model,
  }) : super(key: key) {
    viewModel = ScheduleDetailPageViewModel(model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 1,
        title: Text(
          S.of(context).schedule_detail,
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SetSchedulePage(
                      scheduleModel: model,
                    ),
                  ),
                );
              },
              child: Center(
                child: Text(
                  S.of(context).edit,
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 10.h),
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
            GestureDetector(
              onTap: () async {
                if (model.repeatType == RepeatType.none) {
                  _showDeleteConfirmSelector(context);
                  return;
                }

                _showDeleteSelector(context);
              },
              child: Text(
                S.of(context).delete_schedule,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        )),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20.w,
          20.h,
          20.w,
          20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viewModel.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.timeStr1,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    viewModel.timeStr2,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20.h,
                bottom: 10.h,
              ),
              padding: EdgeInsets.only(
                top: 10.h,
                bottom: 10.h,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[200]!,
                  ),
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    S.of(context).repeat,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    CommonString.getRepeatStr(
                      context,
                      viewModel.repeatType,
                    ),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: viewModel.repeatType != RepeatType.none,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 10.h,
                ),
                padding: EdgeInsets.only(
                  bottom: 10.h,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[200]!,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      S.of(context).repeat_until,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      CommonString.getRepeatUntilStr(
                        context,
                        viewModel.repeatUntil,
                      ),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 10.h,
              ),
              padding: EdgeInsets.only(
                bottom: 10.h,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    S.of(context).type,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            viewModel.scheduleType == ScheduleType.personal
                                ? Colors.lightBlue[100]
                                : Colors.purpleAccent[100],
                        radius: 3.r,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.w,
                        ),
                        child: Text(
                          CommonString.getScheduleStr(
                            context,
                            viewModel.scheduleType,
                          ),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 10.h,
              ),
              padding: EdgeInsets.only(
                bottom: 10.h,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    S.of(context).alert,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    CommonString.getAlertStr(
                      context,
                      viewModel.alertType,
                    ),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: viewModel.remarks.isNotEmpty,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 10.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).notes,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      viewModel.remarks,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteSelector<T>(BuildContext pContext) {
    showCupertinoModalPopup<void>(
      context: pContext,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              viewModel.deleteRepeatSchedule(
                  DeleteType.thisOnly,
                  context,
                  () => Navigator.of(context)
                      .popUntil(ModalRoute.withName("MonthPage")));
            },
            child: Text(S.of(context).for_this_schedule_only),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              viewModel.deleteRepeatSchedule(
                  DeleteType.futureContainsThis,
                  context,
                  () => Navigator.of(context)
                      .popUntil(ModalRoute.withName("MonthPage")));
            },
            child: Text(S.of(context).for_future_schedule),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
        ),
      ),
    );
  }

  void _showDeleteConfirmSelector<T>(BuildContext pContext) {
    showCupertinoModalPopup<void>(
      context: pContext,
      builder: (context) => CupertinoActionSheet(
        title: Text(
          S.of(context).wish_to_delete,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () async {
              await viewModel.deleteNoRepeatSchedule(
                  context,
                  () => Navigator.of(context)
                      .popUntil(ModalRoute.withName("MonthPage")));
            },
            child: Text(S.of(context).delete_schedule),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
        ),
      ),
    );
  }
}

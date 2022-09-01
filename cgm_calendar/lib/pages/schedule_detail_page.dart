import 'package:cgm_calendar/models/schedule_model.dart';
import 'package:cgm_calendar/pages/common_string.dart';
import 'package:cgm_calendar/view_models/set_schedule_page_view_model.dart';
import 'package:cgm_calendar/view_models/schedule_detail_page_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ScheduleDetailPage extends StatelessWidget {
  final ScheduleModel model;
  late ScheduleDetailPageViewModel wViewModel;
  late ScheduleDetailPageViewModel rViewModel;

  ScheduleDetailPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScheduleDetailPageViewModel(model),
      builder: (context, child) {
        wViewModel = context.watch<ScheduleDetailPageViewModel>();
        rViewModel = context.read<ScheduleDetailPageViewModel>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            elevation: 1,
            title: Text(
              "日程详细",
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
                  onTap: () {},
                  child: Center(
                    child: Text(
                      "编辑",
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
                    if (model.repeatType == RepeatType.none.index) {
                      final navigator = Navigator.of(context);
                      await rViewModel.deleteNoRepeatSchedule();
                      navigator.popUntil(ModalRoute.withName("MonthPage"));
                      return;
                    }

                    _showSelector(context);
                  },
                  child: Text(
                    "删除日程",
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
                  wViewModel.title,
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
                        wViewModel.timeStr1,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        wViewModel.timeStr2,
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
                        "重复",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        CommonString.getRepeatStr(
                            RepeatType.values[wViewModel.repeatType]),
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
                        "类型",
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
                            backgroundColor: wViewModel.scheduleType ==
                                    SchedualType.personal.index
                                ? Colors.lightBlue
                                : Colors.purpleAccent,
                            radius: 3.r,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10.w,
                            ),
                            child: Text(
                              CommonString.getScheduleStr(
                                  SchedualType.values[wViewModel.scheduleType]),
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
                Visibility(
                  visible: wViewModel.remarks.isNotEmpty,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "备注",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          wViewModel.remarks,
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
      },
    );
  }

  void _showSelector<T>(BuildContext pContext) {
    showCupertinoModalPopup<void>(
      context: pContext,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () async {
              final navigator = Navigator.of(context);
              await rViewModel.deleteRepeatSchedule(DeleteType.thisOnly);
              navigator.popUntil(ModalRoute.withName("MonthPage"));
            },
            child: const Text("仅针对此日程"),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () async {
              final navigator = Navigator.of(context);
              await rViewModel
                  .deleteRepeatSchedule(DeleteType.futureContainsThis);
              navigator.popUntil(ModalRoute.withName("MonthPage"));
            },
            child: const Text("针对将来日程"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text("取消"),
        ),
      ),
    );
  }
}

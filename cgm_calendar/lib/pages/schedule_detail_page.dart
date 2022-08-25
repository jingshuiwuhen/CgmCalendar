import 'package:cgm_calendar/view_models/schedule_detail_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScheduleDetailPage extends StatelessWidget {
  const ScheduleDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScheduleDetailPageViewModel(),
      builder: (context, child) {
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
                  onTap: () {},
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
          body: Container(
            color: Colors.green,
            height: double.infinity,
            width: double.infinity,
          ),
        );
      },
    );
  }
}

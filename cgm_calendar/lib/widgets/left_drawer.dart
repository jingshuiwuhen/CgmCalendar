import 'package:cgm_calendar/db/db_manager.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeftDrawer extends StatelessWidget {
  final Function()? clean;
  const LeftDrawer({
    Key? key,
    this.clean,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 20.w,
                bottom: 20.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "设定",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "版本: ${Global.info?.version}(${Global.info?.buildNumber})",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      leading: Icon(
                        Icons.cleaning_services_outlined,
                        size: 24.sp,
                      ),
                      title: Text(
                        "清空数据",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                        ),
                      ),
                      onTap: () async {
                        await DBManager.db.deleteAll();
                        Global.idScheduleMap.forEach((id, days) {
                          for (DayModel day in days) {
                            day.scheduleList.clear();
                          }
                        });
                        if (clean != null) {
                          clean!();
                        }
                      },
                    ),
                    // ListTile(
                    //   contentPadding: EdgeInsets.symmetric(
                    //     horizontal: 20.w,
                    //   ),
                    //   leading: Icon(
                    //     Icons.info_outline_rounded,
                    //     size: 24.sp,
                    //   ),
                    //   title: Text(
                    //     "关于我们",
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 20.sp,
                    //     ),
                    //   ),
                    // ),
                  ],
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

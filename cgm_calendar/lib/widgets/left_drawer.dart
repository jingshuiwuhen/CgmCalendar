import 'package:cgm_calendar/db/db_manager.dart';
import 'package:cgm_calendar/generated/l10n.dart';
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
      backgroundColor: Colors.white,
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
                    S.of(context).Setting,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${S.of(context).version}: ${Global.info?.version}(${Global.info?.buildNumber})",
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
                        S.of(context).clear_all_data,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                        ),
                      ),
                      onTap: () async {
                        final navigator = Navigator.of(context);
                        await DBManager.db.deleteAll();
                        Global.idScheduleMap.forEach((id, days) {
                          for (DayModel day in days) {
                            day.scheduleList.clear();
                          }
                        });
                        if (clean != null) {
                          clean!();
                        }
                        navigator.pop();
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
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(
                bottom: 0.05.sh,
                left: 10.w,
                right: 10.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/adv.png',
                    fit: BoxFit.contain,
                    width: 250.w,
                    height: 250.w,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(
                      right: 5.w,
                      bottom: 5.h,
                    ),
                    child: Text(
                      S.of(context).adv,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

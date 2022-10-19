import 'dart:io';

import 'package:cgm_calendar/app_shared_pref.dart';
import 'package:cgm_calendar/generated/l10n.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/day_model.dart';
import 'package:cgm_calendar/network/remote_api.dart';
import 'package:cgm_calendar/pages/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_context/one_context.dart';

class LeftDrawer extends StatelessWidget {
  final Function() clean;
  const LeftDrawer({
    Key? key,
    required this.clean,
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
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                            title: Text(
                              S.of(context).do_clear,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            actions: [
                              CupertinoActionSheetAction(
                                isDestructiveAction: true,
                                onPressed: () async {
                                  final navigator = Navigator.of(context);
                                  navigator.pop();
                                  final remoteApi = RemoteApi(context);
                                  OneContext().context = context;
                                  await OneContext().showProgressIndicator();
                                  try {
                                    await remoteApi.deleteAllSchedules(
                                        await AppSharedPref.loadUid());
                                    Global.idScheduleMap.forEach((id, days) {
                                      for (DayModel day in days) {
                                        day.scheduleList.clear();
                                      }
                                    });
                                    navigator.pop();
                                    clean();
                                  } catch (e) {
                                    debugPrint(
                                        "deleteAllSchedules error ${e.toString()}");
                                  } finally {
                                    OneContext().hideProgressIndicator();
                                  }
                                },
                                child: Text(
                                  S.of(context).clear_all_data,
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                S.of(context).cancel,
                                style: TextStyle(fontSize: 20.sp),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      leading: Icon(
                        Icons.logout_outlined,
                        size: 24.sp,
                        color: Colors.redAccent,
                      ),
                      title: Text(
                        S.of(context).logout,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.sp,
                        ),
                      ),
                      onTap: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                            title: Text(
                              S.of(context).do_logout,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            actions: [
                              CupertinoActionSheetAction(
                                isDestructiveAction: true,
                                onPressed: () async {
                                  final navigator = Navigator.of(context);
                                  await AppSharedPref.saveAccessToken("");
                                  navigator.pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => WelcomePage(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: Text(
                                  S.of(context).logout,
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                S.of(context).cancel,
                                style: TextStyle(fontSize: 20.sp),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      leading: Icon(
                        Icons.delete_outline_outlined,
                        size: 24.sp,
                        color: Colors.redAccent,
                      ),
                      title: Text(
                        S.of(context).delete_account,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.sp,
                        ),
                      ),
                      onTap: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                            title: Text(
                              S.of(context).do_delete_account,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            actions: [
                              CupertinoActionSheetAction(
                                isDestructiveAction: true,
                                onPressed: () async {
                                  final navigator = Navigator.of(context);
                                  navigator.pop();
                                  final remoteApi = RemoteApi(context);
                                  OneContext().context = context;
                                  await OneContext().showProgressIndicator();
                                  try {
                                    await remoteApi.deleteAccount(
                                        await AppSharedPref.loadUid());
                                    await AppSharedPref.saveAccessToken("");
                                    navigator.pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => WelcomePage(),
                                      ),
                                      (route) => false,
                                    );
                                  } catch (e) {
                                    debugPrint(
                                        "delete account error ${e.toString()}");
                                  } finally {
                                    OneContext().hideProgressIndicator();
                                  }
                                },
                                child: Text(
                                  S.of(context).delete_account,
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                S.of(context).cancel,
                                style: TextStyle(fontSize: 20.sp),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
                    'assets/adv_main.png',
                    fit: BoxFit.contain,
                    width: 250.w,
                    height: 170.h,
                  ),
                  Image.asset(
                    Platform.isIOS
                        ? 'assets/adv_app_store.png'
                        : 'assets/adv_google_play.png',
                    fit: BoxFit.contain,
                    width: 80.w,
                    height: 25.h,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(
                      right: 5.w,
                      bottom: 5.h,
                      top: 10.h,
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

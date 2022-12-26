import 'package:cgm_calendar/add_schedule_helper.dart';
import 'package:cgm_calendar/app_shared_pref.dart';
import 'package:cgm_calendar/models/schedule_db_model.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/year_model.dart';
import 'package:cgm_calendar/network/remote_api.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

enum SignState {
  idle,
  loading,
}

class WelcomePageViewModel with ChangeNotifier {
  SignState _signState = SignState.loading;

  SignState get signState => _signState;

  Future init(BuildContext context, Function() success) async {
    final remoteApi = RemoteApi(context);
    String token = await AppSharedPref.loadAccessToken();
    if (token == "") {
      _signState = SignState.idle;
      notifyListeners();
      return;
    }

    await Future.delayed(const Duration(seconds: 2));
    OneContext().context = context;
    await OneContext().showProgressIndicator();
    try {
      Map<String, dynamic> data = await remoteApi.refreshToken();
      AppSharedPref.saveAccessToken(data["token"]);
    } catch (e) {
      OneContext().hideProgressIndicator();
      AppSharedPref.saveAccessToken("");
      _signState = SignState.idle;
      notifyListeners();
      return;
    }

    try {
      int uid = await AppSharedPref.loadUid();
      YearModel oldestYear = Global.oldYears.last;
      int startTime = int.parse("${oldestYear.year}01010000");
      List schedules = await remoteApi.getSchedules(uid, startTime);

      for (Map<String, dynamic> schedule in schedules) {
        AddScheduleHelper.addToCalendar(ScheduleDBModel.fromMap(schedule));
      }
      Global.setApnsToken(remoteApi);
      success();
    } catch (e) {
      debugPrint('getSchedules error : ${e.toString()}');
      _signState = SignState.idle;
      notifyListeners();
    } finally {
      OneContext().hideProgressIndicator();
    }
  }
}

import 'package:cgm_calendar/app_shared_pref.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/year_model.dart';
import 'package:flutter/foundation.dart';

class YearPageViewModel with ChangeNotifier {
  final _oldYears = Global.oldYears;
  final _newYears = Global.newYears;
  bool _isLogined = false;

  YearPageViewModel() {
    setLoginFlag();
  }

  List<YearModel> get oldYears => _oldYears;
  List<YearModel> get newYears => _newYears;
  bool get isLogined => _isLogined;

  Future<void> setLoginFlag() async {
    _isLogined = await AppSharedPref.loadAccessToken() != "";
    notifyListeners();
  }

  void refresh() => notifyListeners();
}

import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/year_model.dart';
import 'package:flutter/foundation.dart';

class YearPageViewModel with ChangeNotifier {
  final _oldYears = Global.oldYears;
  final _newYears = Global.newYears;

  List<YearModel> get oldYears => _oldYears;
  List<YearModel> get newYears => _newYears;

  void refresh() => notifyListeners();
}

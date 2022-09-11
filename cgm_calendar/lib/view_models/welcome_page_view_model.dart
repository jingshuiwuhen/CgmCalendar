import 'package:cgm_calendar/app_shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

enum SignState {
  idle,
  loading,
  gotoSignIn,
  gotoHome,
}

class WelcomePageViewModel with ChangeNotifier {
  SignState _signState = SignState.loading;

  SignState get signState => _signState;

  Future init(BuildContext context) async {
    String token = await AppSharedPref.loadAccessToken();
    if (token == "") {
      _signState = SignState.idle;
      notifyListeners();
      return;
    }
    OneContext().context = context;
    await OneContext().showProgressIndicator();
  }
}

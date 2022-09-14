import 'package:cgm_calendar/app_shared_pref.dart';
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

    OneContext().context = context;
    await OneContext().showProgressIndicator();
    remoteApi.updateTokenToHeader(token);
    try {
      Map<String, dynamic> data = await remoteApi.refreshToken();
      AppSharedPref.saveAccessToken(data["token"]);
      remoteApi.updateTokenToHeader(data["token"]);
      success();
    } catch (e) {
      AppSharedPref.saveAccessToken("");
      remoteApi.updateTokenToHeader("");
      _signState = SignState.idle;
      notifyListeners();
    } finally {
      OneContext().hideProgressIndicator();
    }
  }
}

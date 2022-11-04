import 'package:cgm_calendar/add_schedule_helper.dart';
import 'package:cgm_calendar/app_shared_pref.dart';
import 'package:cgm_calendar/db/schedule_db_model.dart';
import 'package:cgm_calendar/generated/l10n.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/year_model.dart';
import 'package:cgm_calendar/network/remote_api.dart';
import 'package:flutter/widgets.dart';
import 'package:one_context/one_context.dart';

class InputPageViewModel with ChangeNotifier {
  final BuildContext context;
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _authCodeEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  bool _isAgreed = false;

  InputPageViewModel(this.context);

  TextEditingController get emailEditingController => _emailEditingController;
  TextEditingController get authCodeEditingController =>
      _authCodeEditingController;
  TextEditingController get passwordEditingController =>
      _passwordEditingController;
  bool get isAgreed => _isAgreed;

  Future<bool> requestEmailAuthCode() async {
    String? emailInputError = _checkEmail();

    if (emailInputError != null) {
      Global.showToast(emailInputError);
      return Future.value(false);
    }

    try {
      await RemoteApi(context).requestEmailAuthCode(
        _emailEditingController.text,
      );
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  String? _checkEmail() {
    if (_emailEditingController.text.isEmpty) {
      return S.of(context).input_email;
    }

    if (!_isEmail(_emailEditingController.text)) {
      return S.of(context).not_email;
    }

    return null;
  }

  bool _isEmail(String email) {
    String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
    return RegExp(regexEmail).hasMatch(email);
  }

  bool checkParam(bool isLogin) {
    String? emailInputError = _checkEmail();

    if (emailInputError != null) {
      Global.showToast(emailInputError);
      return false;
    }

    String? passwordInputError = _checkPassword();

    if (passwordInputError != null) {
      Global.showToast(passwordInputError);
      return false;
    }

    if (!isLogin && _authCodeEditingController.text.isEmpty) {
      Global.showToast(S.of(context).input_verification_code);
      return false;
    }

    if (!isLogin && !_isAgreed) {
      Global.showToast(S.of(context).please_check_privacy);
      return false;
    }

    return true;
  }

  String? _checkPassword() {
    if (_passwordEditingController.text.isEmpty) {
      return S.of(context).input_password;
    }

    if (!_isPassword(_passwordEditingController.text)) {
      return S.of(context).not_password;
    }

    return null;
  }

  bool _isPassword(String password) {
    String regexPassword = "^[0-9a-zA-Z]{6,}\$";
    return RegExp(regexPassword).hasMatch(password);
  }

  Future<bool> register() async {
    final remoteApi = RemoteApi(context);
    OneContext().context = context;
    await OneContext().showProgressIndicator();

    try {
      await remoteApi.authEmailCode(
        _emailEditingController.text,
        _authCodeEditingController.text,
      );

      await remoteApi.registry(
        _emailEditingController.text,
        _passwordEditingController.text,
      );

      Map<String, dynamic> login = await remoteApi.login(
        _emailEditingController.text,
        _passwordEditingController.text,
      );
      AppSharedPref.saveAccessToken(login["token"]);
      AppSharedPref.saveUid(login["uid"]);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    } finally {
      OneContext().hideProgressIndicator();
    }
  }

  Future<bool> login() async {
    final remoteApi = RemoteApi(context);
    OneContext().context = context;
    await OneContext().showProgressIndicator();
    try {
      Map<String, dynamic> login = await remoteApi.login(
        _emailEditingController.text,
        _passwordEditingController.text,
      );
      AppSharedPref.saveAccessToken(login["token"]);
      AppSharedPref.saveUid(login["uid"]);

      YearModel oldestYear = Global.oldYears.last;
      int startTime = int.parse("${oldestYear.year}01010000");
      List schedules = await remoteApi.getSchedules(login["uid"], startTime);

      for (Map<String, dynamic> schedule in schedules) {
        AddScheduleHelper.addToCalendar(ScheduleDBModel.fromMap(schedule));
      }

      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    } finally {
      OneContext().hideProgressIndicator();
    }
  }

  void refreshCheckBox(bool isChecked) {
    _isAgreed = isChecked;
    notifyListeners();
  }
}

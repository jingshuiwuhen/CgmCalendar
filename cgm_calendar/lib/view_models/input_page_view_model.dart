import 'package:cgm_calendar/generated/l10n.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/network/remote_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class InputPageViewModel with ChangeNotifier {
  final BuildContext context;
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _authCodeEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  InputPageViewModel(this.context);

  TextEditingController get emailEditingController => _emailEditingController;
  TextEditingController get authCodeEditingController =>
      _authCodeEditingController;
  TextEditingController get passwordEditingController =>
      _passwordEditingController;

  Future<bool> requestEmailAuthCode() async {
    String? emailInputError = _checkEmail();

    if (emailInputError != null) {
      Global.showToast(emailInputError);
      return Future.value(false);
    }

    try {
      await RemoteApi().requestEmailAuthCode(
        context,
        _emailEditingController.text,
      );
      return Future.value(true);
    } catch (e) {
      DioError err = e as DioError;
      if (err.type == DioErrorType.other && err.response != null) {
        if (err.response!.data == "010004") {
          Global.showToast(S.of(context).email_exist);
        }
      }
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
}

import 'dart:convert';

import 'package:cgm_calendar/generated/l10n.dart';
import 'package:cgm_calendar/global.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioInstance with DioMixin implements Dio {
  late BuildContext _context;
  DioInstance._([BaseOptions? options]) {
    options = BaseOptions(
      baseUrl: "http://8.210.114.49",
      // baseUrl: "http://192.168.100.159:3000",
      contentType: 'application/json',
      connectTimeout: 10000,
      sendTimeout: 10000,
      receiveTimeout: 10000,
    );

    this.options = options;
    interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          var data = json.decode(response.toString());
          if (data['error'] != null) {
            String errorCode = data['error']['error_code'];
            _showToastMsgError(errorCode);
            return handler
                .reject(DioError(requestOptions: response.requestOptions));
          }
          return handler.resolve(
            Response(
              requestOptions: response.requestOptions,
              data: data['result'],
            ),
          );
        },
        onError: (error, handler) {
          String message;
          if (error.error is String) {
            message = error.error;
          } else {
            var osError = error.error.osError;
            message = '${osError.message} [${osError.errorCode}]';
          }

          error.type = DioErrorType.response;
          Global.showToast(message);
          handler.next(error);
        },
      ),
    );

    httpClientAdapter = DefaultHttpClientAdapter();
  }

  void updateToken(String token) {
    options.headers['x-access-token'] = token;
  }

  set context(BuildContext context) {
    _context = context;
  }

  void _showToastMsgError(String errorCode) {
    switch (errorCode) {
      case "000000":
      case "010000":
      case "020000":
      case "040000":
        Global.showToast(S.of(_context).system_error);
        break;
      case "000001":
        Global.showToast(S.of(_context).not_email);
        break;
      case "000002":
      case "010001":
      case "010003":
        Global.showToast(S.of(_context).auth_code_wrong);
        break;
      case "000003":
        Global.showToast(S.of(_context).not_password);
        break;
      case "010002":
        Global.showToast(S.of(_context).auth_code_expired);
        break;
      case "010004":
        Global.showToast(S.of(_context).email_exist);
        break;
      case "020001":
        Global.showToast(S.of(_context).email_not_exist);
        break;
      case "020002":
        Global.showToast(S.of(_context).password_wrong);
        break;
      case "030000":
        Global.showToast(S.of(_context).token_verify_failed);
        break;
      default:
        Global.showToast('errorCode : $errorCode');
        break;
    }
  }

  static Dio getInstance() => DioInstance._();
}

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
      baseUrl: "http://3.18.239.29",
      // baseUrl: "http://192.168.0.6:3000",
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
            if (_notToastMsgError(errorCode) || _tokenMsgError(errorCode)) {
              return handler.reject(
                DioError(
                  requestOptions: response.requestOptions,
                  response: Response(
                    requestOptions: response.requestOptions,
                    data: data['error']['error_code'],
                  ),
                ),
              );
            }
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
      case "010000":
      case "020000":
      case "040000":
      case "040001":
      case "050000":
      case "060000":
      case "070000":
      case "080000":
      case "080001":
        Global.showToast(S.of(_context).db_error);
        break;
      default:
        Global.showToast('errorCode : $errorCode');
        break;
    }
  }

  bool _notToastMsgError(String errorCode) {
    return errorCode == "010001" ||
        errorCode == "010002" ||
        errorCode == "010003" ||
        errorCode == "010004" ||
        errorCode == "010005" ||
        errorCode == "020001" ||
        errorCode == "020002";
  }

  bool _tokenMsgError(String errorCode) {
    if (errorCode == "030000") {
      Global.showToast(S.of(_context).token_verify_failed);
      return true;
    }
    return false;
  }

  static Dio getInstance() => DioInstance._();
}

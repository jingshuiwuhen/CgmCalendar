import 'dart:convert';

import 'package:cgm_calendar/network/dio_instance.dart';
import 'package:flutter/widgets.dart';

class RemoteApi {
  late final DioInstance _dio;

  RemoteApi(BuildContext context) {
    _dio = DioInstance.getInstance() as DioInstance;
    _dio.context = context;
  }

  Future refreshToken() async {
    // var _response = await _dio.get("/app/limit/user/refreshToken");
    // var _data = json.decode(_response.toString());
    // return Login.fromJson(_data);
  }

  Future requestEmailAuthCode(String email) async {
    Map<String, dynamic> dataMap = {};
    dataMap['email'] = email;
    await _dio.post(
      "/app/open/email_auth/request_email_auth_code",
      data: dataMap,
    );
  }

  Future authEmailCode(String email, String authCode) async {
    Map<String, dynamic> dataMap = {};
    dataMap['email'] = email;
    dataMap['email_auth_code'] = authCode;
    await _dio.post("/app/open/email_auth/auth_email_code", data: dataMap);
  }

  Future registry(
    String email,
    String password,
  ) async {
    Map<String, dynamic> dataMap = {};
    dataMap['email'] = email;
    dataMap['password'] = password;
    await _dio.post("/app/open/user/registry", data: dataMap);
  }

  Future login(String email, String password) async {
    Map<String, dynamic> dataMap = {};
    dataMap['email'] = email;
    dataMap['password'] = password;
    var result = await _dio.post("/app/open/user/login", data: dataMap);
    return json.decode(result.toString());
  }

  void updateTokenToHeader(String token) {
    _dio.updateToken(token);
  }
}

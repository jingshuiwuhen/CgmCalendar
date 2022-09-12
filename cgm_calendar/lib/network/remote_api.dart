import 'package:cgm_calendar/network/dio_instance.dart';
import 'package:flutter/widgets.dart';

class RemoteApi {
  late final DioInstance _dio;

  RemoteApi() {
    _dio = DioInstance.getInstance() as DioInstance;
  }

  Future refreshToken() async {
    // var _response = await _dio.get("/app/limit/user/refreshToken");
    // var _data = json.decode(_response.toString());
    // return Login.fromJson(_data);
  }

  Future<void> requestEmailAuthCode(BuildContext context, String email) async {
    _dio.context = context;
    Map<String, dynamic> dataMap = {};
    dataMap['email'] = email;
    await _dio.post(
      "/app/open/email_auth/request_email_auth_code",
      data: dataMap,
    );
  }

  Future<void> authEmailCode(
      BuildContext context, String email, String authCode) async {
    _dio.context = context;
    Map<String, dynamic> dataMap = {};
    dataMap['email'] = email;
    dataMap['email_auth_code'] = authCode;
    await _dio.post("/app/open/email_auth/auth_email_code", data: dataMap);
  }

  Future<void> registry(
    BuildContext context,
    String email,
    String password,
  ) async {
    _dio.context = context;
    Map<String, dynamic> dataMap = {};
    dataMap['email'] = email;
    dataMap['password'] = password;
    await _dio.post("/app/open/user/registry", data: dataMap);
  }

  Future login(BuildContext context, String email, String password) async {
    _dio.context = context;
    // Map<String, dynamic> _dataMap = Map();
    // _dataMap['id'] = await DeviceInfoUtil.getUniqueId();
    // _dataMap['email'] = email;
    // _dataMap['password'] = password;
    // var _result = await _dio.post("/app/open/user/login", data: _dataMap);
    // var _data = json.decode(_result.toString());
    // return Login.fromJson(_data);
  }
}

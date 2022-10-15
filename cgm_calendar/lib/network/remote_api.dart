import 'dart:convert';

import 'package:cgm_calendar/db/schedule_db_model.dart';
import 'package:cgm_calendar/network/dio_instance.dart';
import 'package:flutter/widgets.dart';

class RemoteApi {
  late final DioInstance _dio;

  RemoteApi(BuildContext context) {
    _dio = DioInstance.getInstance() as DioInstance;
    _dio.context = context;
  }

  Future refreshToken() async {
    var response = await _dio.get("/app/limit/user/refreshToken");
    return json.decode(response.toString());
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

  Future<List<Map<String, dynamic>>> getSchedules(
      int uid, int startTime) async {
    Map<String, dynamic> dataMap = {};
    dataMap['uid'] = uid;
    dataMap['start_time'] = startTime;
    var result =
        await _dio.post("/app/limit/schedule/get_all_schedule", data: dataMap);
    Map<String, dynamic> jsonObj = json.decode(result.toString());
    return jsonObj['schedules'];
  }

  Future deleteAllSchedules(int uid) async {
    Map<String, dynamic> dataMap = {};
    dataMap['uid'] = uid;
    await _dio.post("/app/limit/schedule/delete_all_schedule", data: dataMap);
  }

  Future deleteAccount(int uid) async {
    Map<String, dynamic> dataMap = {};
    dataMap['uid'] = uid;
    await _dio.post("/app/limit/user/delete_account", data: dataMap);
  }

  Future<int> addNewSchedule(ScheduleDBModel model, int uid) async {
    Map<String, dynamic> dataMap = model.toMap();
    dataMap['uid'] = uid;
    var result = await _dio.post("/app/limit/schedule/add_new_schedule",
        data: model.toMap());
    Map<String, dynamic> jsonObj = json.decode(result.toString());
    return jsonObj['id'];
  }

  Future<Map<String, dynamic>> getOneSchedule(int id, int uid) async {
    Map<String, dynamic> dataMap = {};
    dataMap['id'] = id;
    dataMap['uid'] = uid;
    var result =
        await _dio.post("/app/limit/schedule/get_one_schedule", data: dataMap);
    Map<String, dynamic> jsonObj = json.decode(result.toString());
    return jsonObj['schedule'];
  }

  Future updateSchedule(ScheduleDBModel model, int uid) async {
    Map<String, dynamic> dataMap = model.toMap();
    dataMap['uid'] = uid;
    await _dio.post("/app/limit/schedule/update_one_schedule", data: dataMap);
  }

  void updateTokenToHeader(String token) {
    _dio.updateToken(token);
  }
}

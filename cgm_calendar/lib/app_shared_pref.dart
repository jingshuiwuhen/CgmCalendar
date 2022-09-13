import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static const String keyAccessToken = 'app_settings_access_token';
  static const String keyUid = 'app_settings_uid';

  static final _prefs = SharedPreferences.getInstance();

  static Future<String> loadAccessToken() async {
    final prefs = await _prefs;
    return prefs.getString(keyAccessToken) ?? "";
  }

  static Future<void> saveAccessToken(String? accessToken) async {
    final prefs = await _prefs;
    prefs.setString(keyAccessToken, accessToken ?? "");
  }

  static Future<int> loadUid() async {
    final prefs = await _prefs;
    return prefs.getInt(keyUid) ?? 0;
  }

  static Future<void> saveUid(int uid) async {
    final prefs = await _prefs;
    prefs.setInt(keyUid, uid);
  }
}

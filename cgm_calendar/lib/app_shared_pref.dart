import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static const String keyAccessToken = 'app_settings_access_token';

  static final _prefs = SharedPreferences.getInstance();

  static Future<String> loadAccessToken() async {
    final prefs = await _prefs;
    return prefs.getString(keyAccessToken) ?? "";
  }

  static Future<void> saveAccessToken(String? accessToken) async {
    final prefs = await _prefs;
    prefs.setString(keyAccessToken, accessToken ?? "");
  }
}

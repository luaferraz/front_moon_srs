import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageKeys {
  static const String access_token = "ACCESS_TOKEN";
  static const String expiration = "EXPIRATION";
  static const String user = "USER";
}

class LocalStorageSource {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<String> getString(String key) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString(key) ?? "";
  }

  static Future<void> setString(String key, dynamic value) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString(key, value);
  }

  static Future<void> remove(String key) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.remove(key);
  }
}

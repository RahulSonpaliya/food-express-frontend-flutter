import 'package:shared_preferences/shared_preferences.dart';

import 'preference_keys.dart';

class AppSharedPrefs {
  static final AppSharedPrefs _repo = AppSharedPrefs();

  static AppSharedPrefs get() => _repo;

  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> addValue(PreferenceKeys preferenceKeys, String text) async {
    SharedPreferences prefs = await getSharedPrefs();
    await prefs.setString(preferenceKeys.getKey(), text);
  }

  Future<void> addBoolean(PreferenceKeys preferenceKeys, bool value) async {
    SharedPreferences prefs = await getSharedPrefs();
    await prefs.setBool(preferenceKeys.getKey(), value);
  }

  Future<void> addInt(PreferenceKeys preferenceKeys, int value) async {
    SharedPreferences prefs = await getSharedPrefs();
    await prefs.setInt(preferenceKeys.getKey(), value);
  }

  Future<String?> getValue(PreferenceKeys preferenceKeys) async {
    SharedPreferences prefs = await getSharedPrefs();
    return prefs.getString(preferenceKeys.getKey());
  }

  Future<int> getInt(PreferenceKeys preferenceKeys) async {
    SharedPreferences prefs = await getSharedPrefs();
    return prefs.getInt(preferenceKeys.getKey()) ?? 0;
  }

  Future<bool?> getBoolean(PreferenceKeys preferenceKeys) async {
    SharedPreferences prefs = await getSharedPrefs();
    return prefs.getBool(preferenceKeys.getKey());
  }

  Future<bool> clearSharedPreference() async {
    SharedPreferences prefs = await getSharedPrefs();
    String? email = await getValue(PreferenceKeys.USER_EMAIL);
    String? password = await getValue(PreferenceKeys.USER_PASSWORD);
    bool? firstTime = await getBoolean(PreferenceKeys.FIRST_TIME);
    await prefs.clear();
    await addValue(PreferenceKeys.USER_EMAIL, email ?? "");
    await addValue(PreferenceKeys.USER_PASSWORD, password ?? "");
    await addBoolean(PreferenceKeys.FIRST_TIME, firstTime ?? false);
    return true;
  }

  static Future<String?> getAccessToken() async {
    return await AppSharedPrefs.get().getValue(PreferenceKeys.ACCESS_TOKEN);
  }
}

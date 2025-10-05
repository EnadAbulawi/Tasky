import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  // ! Singleton pattern

  // * Singleton instance
  static final PreferencesManager _instance = PreferencesManager._internal();

  // * Factory constructor to return the same instance
  factory PreferencesManager() {
    return _instance;
  }

  // * privet constructor
  PreferencesManager._internal();

  // ! Shared Preferences instance
  late final SharedPreferences _preference;

  // * Initialization method to be called once
  init() async {
    _preference = await SharedPreferences.getInstance();
  }

  // * Methods to interact with SharedPreferences
  String? getString(String key) {
    return _preference.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    return await _preference.setString(key, value);
  }

  remove(String key) async {
    await _preference.remove(key);
  }

  bool? getBool(String key) {
    return _preference.getBool(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preference.setBool(key, value);
  }
}

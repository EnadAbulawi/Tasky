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
  late final SharedPreferences _preferance;

  // * Initialization method to be called once
  init() async {
    _preferance = await SharedPreferences.getInstance();
  }

  // * Methods to interact with SharedPreferences
  String? getString(String key) {
    return _preferance.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    return await _preferance.setString(key, value);
  }

  remove(String key) async {
    await _preferance.remove(key);
  }

  bool? getBool(String key) {
    return _preferance.getBool(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferance.setBool(key, value);
  }
}

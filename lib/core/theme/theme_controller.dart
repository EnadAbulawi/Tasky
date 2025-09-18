import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';

class ThemeController {
  // * value notifier
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  init() {
    bool result = PreferencesManager().getBool('dark_mode') ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PreferencesManager().setBool('dark_mode', false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PreferencesManager().setBool('dark_mode', true);
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}

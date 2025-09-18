import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/navigation/main_view.dart';
import 'package:tasky/features/welcome/welcom_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  ThemeController().init();

  // await pref.clear();
  String? username = PreferencesManager().getString('username');
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});
  final String? username;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode themeMode, Widget? child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tasky',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: username == null ? WelcomeView() : MainView(),
      ),
    );
  }
}

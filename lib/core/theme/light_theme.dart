import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Color(0xff15b86c),
    primaryContainer: Color(0xffffffff),
    secondary: Color(0xff3a4640),
  ),
  scaffoldBackgroundColor: const Color(0xfff6f7f9),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xfff6f7f9),
    iconTheme: IconThemeData(color: Color(0xff161f1b)),
    titleTextStyle: const TextStyle(color: Color(0xff161f1b), fontSize: 20),
    centerTitle: true,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return Color(0xff15b86c);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xff9e9e9e);
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xff15b86c)),
      foregroundColor: WidgetStateProperty.all(Color(0xfffffcfc)),
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.black),
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff15b86c),
    foregroundColor: Color(0xfffffcfc),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),

  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: Color(0xff161f1b),
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),

    displayMedium: TextStyle(
      color: Color(0xff161f1b),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: Color(0xff161f1b),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),

    titleSmall: TextStyle(
      color: Color(0xff3a4640),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xff161f1b),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: Color(0xff161f1b),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
    labelLarge: TextStyle(color: Colors.black, fontSize: 24),

    // ! for done task
    titleLarge: TextStyle(
      color: Color(0xff6a6a6a),
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff49454f),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xffffffff),
    hintStyle: TextStyle(color: Color(0xff9e9e9e)),
    focusColor: Color(0xffd1dad6),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffd1dad6), width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffd1dad6), width: 0.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffd1dad6), width: 0.5),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xffd1dad6), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),

  iconTheme: IconThemeData(color: Color(0xff161f1b)),

  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xff161f1b),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xffd1dad6), thickness: 1),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Color(0xff15b86c),
    selectionHandleColor: Color(0xff15b86c),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xfff6f7f9),
    selectedItemColor: Color(0xff15b86c),
    unselectedItemColor: Color(0xff14a662),
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xff6e6e6e), width: 1),
      borderRadius: BorderRadius.circular(16),
    ),
    color: Color(0xfff6f7f9),
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(color: Colors.black, fontSize: 20),
    ),
  ),
);

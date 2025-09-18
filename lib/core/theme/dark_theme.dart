import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Color(0xff15b86c),
    primaryContainer: Color(0xff282828),
    secondary: Color(0xffc6c6c6),
  ),
  scaffoldBackgroundColor: const Color(0xff181818),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xff181818),
    iconTheme: IconThemeData(color: Color(0xfffcfcfc)),
    titleTextStyle: const TextStyle(color: Color(0xfffcfcfc), fontSize: 20),
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
      foregroundColor: WidgetStateProperty.all(Color(0xfffffcfc)),
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
      color: Color(0xfffffcfc),
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0xffffffff),
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: Color(0xfffffcfc),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),

    titleSmall: TextStyle(
      color: Color(0xffc6c6c6),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xfffffcfc),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: Color(0xfffcfcfc),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      color: Color(0xffffffff),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(color: Colors.white, fontSize: 24),

    // ! for done task
    titleLarge: TextStyle(
      color: Color(0xffa0a0a0),
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xffa0a0a0),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xff282828),
    hintStyle: TextStyle(color: Color(0xff6d6d6d)),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xff6e6e6e), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Color(0xfffffcfc)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xfffffcfc),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),

  dividerTheme: DividerThemeData(color: Color(0xff6e6e6e), thickness: 1),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Color(0xff15b86c),
    selectionHandleColor: Color(0xff15b86c),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xff181818),
    selectedItemColor: Color(0xff15b86c),
    unselectedItemColor: Color(0xffc6c6c6),
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xff6e6e6e), width: 1),
      borderRadius: BorderRadius.circular(16),
    ),
    color: Color(0xff181818),
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(color: Colors.white, fontSize: 20),
    ),
  ),
);

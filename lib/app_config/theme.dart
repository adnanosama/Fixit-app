import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: const Color(0xFFA5B4CF), // Shaded background
    useMaterial3: true,
    brightness: Brightness.light,
    cardColor: Colors.white24, // Distinct card color
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.transparent),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF0F2F5), foregroundColor: Colors.black),
    dividerColor: Colors.blueGrey,
  );

  static ThemeData get darkTheme => ThemeData(
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: const Color(0xFF0A0A12), // Deep midnight
    useMaterial3: true,
    cardColor: const Color(0xFF161625), // Layered dark slate
    brightness: Brightness.dark,
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.transparent),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF0A0A12), foregroundColor: Colors.white),
    dividerColor: const Color(0xFF2D2D44),
    primaryColor: const Color(0xFF00F2FF), // Neon Cyan accent
  );
}

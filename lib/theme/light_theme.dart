import 'package:flutter/material.dart';

/// Configuration for Light Mode Theme.
final ThemeData lightThemeData = ThemeData(
  primarySwatch: Colors.indigo,
  scaffoldBackgroundColor: const Color(0xFFA5B4CF), // Shaded background
  useMaterial3: true,
  brightness: Brightness.light,
  cardColor: Colors.white24, // Distinct card color
  drawerTheme: const DrawerThemeData(backgroundColor: Colors.transparent),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF0F2F5),
    foregroundColor: Colors.black,
  ),
  dividerColor: Colors.blueGrey,
);

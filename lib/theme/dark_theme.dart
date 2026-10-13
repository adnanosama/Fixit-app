import 'package:flutter/material.dart';

/// Configuration for Dark Mode Theme.
final ThemeData darkThemeData = ThemeData(
  primarySwatch: Colors.indigo,
  scaffoldBackgroundColor: const Color(0xFF0A0A12), // Deep midnight
  useMaterial3: true,
  cardColor: const Color(0xFF161625), // Layered dark slate
  brightness: Brightness.dark,
  drawerTheme: const DrawerThemeData(backgroundColor: Colors.transparent),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0A0A12),
    foregroundColor: Colors.white,
  ),
  dividerColor: const Color(0xFF2D2D44),
  primaryColor: const Color(0xFF00F2FF), // Neon Cyan accent
);

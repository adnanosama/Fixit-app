import 'package:flutter/material.dart';

/// Global ValueNotifier managing the active theme mode.
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);

/// Controller helper class providing theme state queries and toggling.
abstract class ThemeController {
  static ThemeMode get currentMode => themeNotifier.value;

  static bool get isDarkMode => themeNotifier.value == ThemeMode.dark;

  static void toggleTheme() {
    themeNotifier.value = isDarkMode ? ThemeMode.light : ThemeMode.dark;
  }

  static void setThemeMode(ThemeMode mode) {
    themeNotifier.value = mode;
  }
}

import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

export 'dark_theme.dart';
export 'light_theme.dart';
export 'theme_controller.dart';

/// Central theme provider exposing light and dark theme configurations.
abstract class AppTheme {
  static ThemeData get lightTheme => lightThemeData;
  static ThemeData get darkTheme => darkThemeData;
}

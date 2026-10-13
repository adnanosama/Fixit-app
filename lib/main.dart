import 'package:flutter/material.dart';
import 'app_config/theme.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const RepairShopApp());
}

class RepairShopApp extends StatelessWidget {
  const RepairShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, mode, __) {
        return MaterialApp(
          title: 'FixIt Pro',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const HomePage(),
        );
      },
    );
  }
}

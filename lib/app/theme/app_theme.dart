import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF1F2F4),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2478C6),
        brightness: Brightness.light,
      ),
      fontFamily: 'Verdana',
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontSize: 28, height: 1.2),
        titleLarge: TextStyle(fontSize: 24, height: 1.2),
        titleMedium: TextStyle(fontSize: 18, height: 1.3),
        titleSmall: TextStyle(fontSize: 14, height: 1.3),
        bodyLarge: TextStyle(fontSize: 16, height: 1.5),
        bodyMedium: TextStyle(fontSize: 14, height: 1.5),
        bodySmall: TextStyle(fontSize: 12, height: 1.4),
      ),
    );
  }
}

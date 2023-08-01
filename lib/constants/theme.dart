import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xFFF3F3F3),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.black),
        bodyLarge: TextStyle(color: Colors.black),
        bodySmall: TextStyle(color: Colors.black),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Color(0xFF0067FF),
        secondary: Colors.white,
        tertiary: Color(0xFF1C1C1C),
        outline: Color(0xFF0067FF),
      )
  );

}
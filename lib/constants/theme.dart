import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xFFF3F3F3),
      // scaffoldBackgroundColor:Color(0xFF1C1C1C),
      // textTheme: const TextTheme(
      //   bodyMedium: TextStyle(color: Colors.black),
      //   bodyLarge: TextStyle(color: Colors.black),
      //   bodySmall: TextStyle(color: Colors.black),
      // ),
      textTheme: GoogleFonts.interTextTheme(),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        // primary: Color(0xFF0067FF),
        // primary: Color(0xFF0067FF),
        // tertiary: Color(0xFF0067FF),
        secondary: Colors.white,
        primary: Color(0xFF1C1C1C),
        outline: Color(0xFF0067FF),
      )
  );

}
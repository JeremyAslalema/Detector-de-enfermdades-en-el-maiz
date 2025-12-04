import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF8BC34A),
      primary: const Color(0xFF689F38),
      secondary: const Color(0xFFFFD54F),
      surface: const Color(0xFFF9FBE7),
    ),
    scaffoldBackgroundColor: const Color(0xFFF9FBE7),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF689F38),
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 4,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF689F38),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF689F38),
        side: const BorderSide(color: Color(0xFF689F38), width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    // Eliminamos cardTheme completamente - causa problemas
    // cardTheme: CardTheme(...),
    useMaterial3: true,
  );
}
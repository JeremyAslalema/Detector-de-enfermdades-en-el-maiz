import 'package:flutter/material.dart';

class AppThemes {
  // Colores principales del maíz
  static const Color cornGreen = Color(0xFF689F38);
  static const Color cornGreenDark = Color(0xFF558B2F);
  static const Color cornYellow = Color(0xFFFFD54F);
  static const Color cornYellowLight = Color(0xFFFFE082);
  static const Color cornCream = Color(0xFFFFF9C4);
  static const Color backgroundLight = Color(0xFFF9FBE7);
  static const Color backgroundGreen = Color(0xFFE8F5E9);
  
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: cornGreen,
      primary: cornGreen,
      secondary: cornYellow,
      tertiary: cornYellowLight,
      surface: backgroundLight,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: backgroundLight,
    
    appBarTheme: const AppBarTheme(
      backgroundColor: cornGreen,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: cornGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        elevation: 4,
        shadowColor: cornGreen.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: cornGreen,
        side: const BorderSide(color: cornGreen, width: 2.5),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    ),
    
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: cornYellow,
      foregroundColor: cornGreen,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    
    chipTheme: ChipThemeData(
      backgroundColor: cornCream,
      labelStyle: const TextStyle(
        color: cornGreenDark,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    
    dividerTheme: DividerThemeData(
      color: cornGreen.withValues(alpha: 0.2),
      thickness: 1.5,
      space: 32,
    ),
    
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: cornGreen,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: cornGreen,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: cornGreen,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: cornGreenDark,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: cornGreenDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black87,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black87,
        height: 1.5,
      ),
    ),
    
    useMaterial3: true,
  );
  
  // Gradientes personalizados
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [cornGreen, Color(0xFF8BC34A)],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [cornYellow, cornYellowLight],
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundLight, backgroundGreen],
  );
  
  static LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white,
      cornCream.withValues(alpha: 0.3),
    ],
  );
}
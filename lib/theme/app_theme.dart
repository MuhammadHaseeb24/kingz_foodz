import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color maroon = Color(0xFF800000);
  static const Color maroonDark = Color(0xFF5D0000);
  static const Color gold = Color(0xFFFFD700);
  static const Color goldLight = Color(0xFFFFF3C4);
  
  // Neutral Colors
  static const Color charcoal = Color(0xFF2D2D2D);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color backgroundColor = Color(0xFFF8F8F8);
  static const Color cream = Color(0xFFFFFDD0);
  
  // Status Colors
  static const Color success = Color(0xFF388E3C);
  static const Color danger = Color(0xFFD32F2F);
}

class AppTheme {
  // Main colors
  static const Color primaryColor = AppColors.maroon;
  static const Color secondaryColor = AppColors.gold;
  static const Color backgroundColor = AppColors.backgroundColor;
  static const Color darkBackgroundColor = Color(0xFF121212);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: backgroundColor,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.charcoal,
    ),

    cardTheme: CardThemeData(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 2,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      brightness: Brightness.dark,
    ),

    scaffoldBackgroundColor: darkBackgroundColor,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),

    cardTheme: CardThemeData(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 2,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),
  );
}

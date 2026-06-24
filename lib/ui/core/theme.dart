import 'package:flutter/material.dart';

class HondakuTheme {
  // Brand Colors
  static const Color red = Color(0xFFD50000); // Premium Honda Red
  static const Color redLight = Color(0xFFFFF2F2);
  static const Color dark = Color(0xFF1E1E24); // HIG Dark Grey/Black
  
  // Light Theme Colors
  static const Color lightBg = Color(0xFFFAFAFA);
  static const Color lightSurface = Colors.white;
  static const Color lightBorder = Color(0xFFEBEBEB);
  static const Color lightTextPrimary = Color(0xFF1F1F1F);
  static const Color lightTextSecondary = Color(0xFF757575);

  // Dark Theme Colors
  static const Color darkBg = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkBorder = Color(0xFF2E2E2E);
  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFF9E9E9E);

  // Card Decorations (Premium standard dropshadows & borders)
  static BoxDecoration premiumCardDecoration({
    required bool isDark,
    double borderRadius = 16.0,
  }) {
    return BoxDecoration(
      color: isDark ? darkSurface : lightSurface,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: isDark ? darkBorder : lightBorder,
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.03),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  // Text Styles
  static TextStyle headlineStyle({required bool isDark, double fontSize = 24.0}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: isDark ? darkTextPrimary : lightTextPrimary,
      letterSpacing: -0.5,
    );
  }

  static TextStyle bodyStyle({required bool isDark, double fontSize = 14.0}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      color: isDark ? darkTextSecondary : lightTextSecondary,
      height: 1.4,
    );
  }

  // Light ThemeData
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: red,
      scaffoldBackgroundColor: lightBg,
      colorScheme: const ColorScheme.light(
        primary: red,
        secondary: dark,
        surface: lightSurface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurface,
        elevation: 0.5,
        iconTheme: IconThemeData(color: lightTextPrimary),
        titleTextStyle: TextStyle(
          color: lightTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: red,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Dark ThemeData
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: red,
      scaffoldBackgroundColor: darkBg,
      colorScheme: const ColorScheme.dark(
        primary: red,
        secondary: Colors.white,
        surface: darkSurface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        elevation: 0.5,
        iconTheme: IconThemeData(color: darkTextPrimary),
        titleTextStyle: TextStyle(
          color: darkTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: red,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileThemeColors {
  final bool isDark;
  ProfileThemeColors(this.isDark);

  Color get red => isDark ? const Color(0xFFFF3E3E) : const Color(0xFFC40000);
  Color get background => isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5);
  Color get surface => isDark ? const Color(0xFF1E1E1E) : Colors.white;
  Color get textPrimary => isDark ? const Color(0xFFF5F5F5) : const Color(0xFF1F1F1F);
  Color get textSecondary => isDark ? const Color(0xFF9E9E9E) : const Color(0xFF757575);
  Color get border => isDark ? const Color(0xFF2E2E2E) : const Color(0xFFE9E9E9);
  Color get cardBorder => isDark ? const Color(0xFF2E2E2E) : const Color(0xFFEBEBEB);
  Color get tileBg => isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF3F3F3);
}
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AppColors {
  // Common
  static const Color primary = Color(0xFF0E1B33); // Deep navy blue
  static const Color accent = Color(0xFF0E1B33); // Consistent accent
  static const Color secondary = Color(0xFF1C2C4C);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Color(0xFFB0B0B0);
  static const Color lightGrey = Color(0xFFF5F5F5);

  // Light Mode
  static const Color lightPrimary = Color(0xFF6A1B9A);
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF8F9FC);
  static const Color lightText = Color(0xFF0E1B33);
  static const Color lightSecondary = Color(0xFF9C27B0);
  static const Color lightAccent = Color(0xFFB388FF);

  // Dark Mode
  static const Color darkPrimary = Color(0xFFB388FF);
  static const Color darkBackground = Color(0xFF0E1B33);
  static const Color darkSurface = Color(0xFF162544);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkSecondary = Color(0xFFCE93D8);
  static const Color darkAccent = Color(0xFF7E57C2);

  // Common / neutral tones
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);

  // Shadows, borders, etc.
  static Color divider(bool isDark) => isDark ? Colors.white12 : Colors.black12;

  static Color shadow(bool isDark) =>
      isDark ? Colors.black.withOpacity(0.4) : Colors.black.withOpacity(0.1);
}

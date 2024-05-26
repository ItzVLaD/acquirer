import "package:flutter/material.dart";

/// Custom class to keep all colors constants
class TColors {
  TColors._();

  //App basic colors
  static const Color primary = Color.fromARGB(255, 99, 133, 255);
  static const Color secondary = Color.fromARGB(255, 255, 201, 60);
  static const Color accent = Color.fromARGB(255, 134, 229, 255);

  // Text colors
  static const Color textPrimary = Color.fromARGB(255, 51, 51, 51);
  static const Color textSecondary = Color.fromARGB(255, 108, 117, 125);
  static const Color textWhite = Color.fromARGB(255, 255, 255, 255);

  // Background colors
  static const Color backgroundLight = Color.fromARGB(255, 245, 245, 245);
  static const Color backgroundDark = Color.fromARGB(255, 40, 40, 39);
  static const Color backgroundPrimary = Color(0xFFF3F5FF);

  // Background Container colors
  static const Color containerLight = Color.fromARGB(255, 245, 245, 245);
  static Color containerDark = TColors.white.withOpacity(0.1);

  // Button colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color.fromARGB(255, 211, 47, 47);
  static const Color success = Color.fromARGB(255, 56, 142, 60);
  static const Color warning = Color.fromARGB(255, 245, 124, 0);
  static const Color info = Color.fromARGB(255, 25, 118, 210);

  // Neutral Shades
  static const Color black = Color.fromARGB(255, 35, 35, 35);
  static const Color darkerGrey = Color.fromARGB(255, 79, 79, 79);
  static const Color darkGrey = Color.fromARGB(255, 147, 147, 147);
  static const Color grey = Color.fromARGB(255, 224, 224, 224);
  static const Color softGrey = Color.fromARGB(255, 244, 244, 244);
  static const Color lightGrey = Color.fromARGB(255, 249, 249, 249);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
}

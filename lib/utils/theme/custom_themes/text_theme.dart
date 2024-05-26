import "package:acquirer/utils/constants/colors.dart";
import "package:flutter/material.dart";

/// custom class with text themes
class TTextTheme {
  TTextTheme._();

  static TextTheme lightTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32, fontWeight: FontWeight.w700, color: TColors.backgroundDark),
    headlineMedium: const TextStyle().copyWith(fontSize: 24, fontWeight: FontWeight.w700, color: TColors.backgroundDark),
    headlineSmall: const TextStyle().copyWith(fontSize: 20, fontWeight: FontWeight.w700, color: TColors.backgroundDark),
    //
    titleLarge: const TextStyle().copyWith(fontSize: 18, fontWeight: FontWeight.w400, color: TColors.backgroundDark),
    titleMedium: const TextStyle().copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: TColors.backgroundDark),
    titleSmall: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: TColors.backgroundDark),
    //
    bodyLarge: const TextStyle().copyWith(fontSize: 17, fontWeight: FontWeight.w700, color: TColors.backgroundDark),
    bodyMedium: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: TColors.backgroundDark),
    bodySmall: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: TColors.backgroundDark.withOpacity(0.6)),
    //
    labelLarge: const TextStyle().copyWith(fontSize: 18, fontWeight: FontWeight.w500, color: TColors.backgroundDark),
    labelMedium: const TextStyle().copyWith(fontSize: 12, fontWeight: FontWeight.w300, color: TColors.backgroundDark.withOpacity(0.5)),
    labelSmall: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: TColors.secondary),
  );
}

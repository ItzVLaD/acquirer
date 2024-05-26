import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

/// Light Outlined Button Themes
class TOutlinedButtonTheme {
  TOutlinedButtonTheme._(); //To avoid creating instances

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: TColors.backgroundDark,
      side: const BorderSide(color: TColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: TColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight, horizontal: TSizes.md),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
    ),
  );
}

import 'package:acquirer/utils/theme/custom_themes/appbar_theme.dart';
import 'package:acquirer/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:acquirer/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:acquirer/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:acquirer/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:acquirer/utils/theme/custom_themes/text_field_theme.dart';
import 'package:acquirer/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

/// Custom class with main app theme
class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.lightTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );
}

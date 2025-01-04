import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: theme_blue_color_1,
      foregroundColor: colorWhite,
      minimumSize: Size.fromHeight(50),
      textStyle: TSB.semiBoldSmall(textColor: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );

  static final _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: bg_edit_text_color),
  );

  static final appTheme = ThemeData(
    primaryColor: theme_blue_color_1,
    scaffoldBackgroundColor: theme_bg_color_1,
    brightness: Brightness.light,
    fontFamily: FONT_FAMILY,
    elevatedButtonTheme: _elevatedButtonTheme,
    colorScheme: ColorScheme.fromSeed(seedColor: theme_bg_color_1)
        .copyWith(onSurface: theme_bg_color_1),
    appBarTheme: AppBarTheme(
      backgroundColor: theme_bg_color_1,
      foregroundColor: Colors.black,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        textStyle: TSB.regularSmall(underLineText: true),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: bg_edit_text_color,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      hintStyle: TSB.regularSmall(textColor: grey_hint_text_color),
      border: _inputBorder,
      enabledBorder: _inputBorder,
      disabledBorder: _inputBorder,
      errorBorder: _inputBorder.copyWith(
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedBorder: _inputBorder,
      focusedErrorBorder: _inputBorder,
    ),
  );
}

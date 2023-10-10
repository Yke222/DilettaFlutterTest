import 'package:flutter/material.dart';
import 'package:shample_app/src/config/themes/colors_map.dart';

class CustomTheme {
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: const Color(0xFFFFFFff),
      hintColor: const Color(0xFF556E68),
      fontFamily: 'Roboto',
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorsMap.inputBackground,
        ),
      ),
    );
  }
}

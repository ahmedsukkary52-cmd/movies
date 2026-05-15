import 'package:flutter/material.dart';
import 'package:moives/config/theme/color_app.dart';

class ThemeApp {
  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: ColorApp.black,
    appBarTheme: AppBarTheme(backgroundColor: ColorApp.black),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: ColorApp.primary),
  );
}

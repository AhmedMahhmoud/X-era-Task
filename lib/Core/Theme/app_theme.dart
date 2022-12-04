import 'package:flutter/material.dart';
import 'package:xera_task/Core/Colors/app_colors.dart';

class AppThemeManager {
  static ThemeData getApplicationTheme() {
    return ThemeData(
      primaryColor: CustomColors.primaryColor,
      scaffoldBackgroundColor: CustomColors.primaryColor,
    );
  }
}

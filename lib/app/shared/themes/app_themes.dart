import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;
}

class AppThemes {
  static final darkTheme = ThemeData(
    backgroundColor: AppColors.bgDark,
    appBarTheme: AppBarTheme(color: AppColors.bgDark),
    bottomAppBarColor: AppColors.bgDark,
    scaffoldBackgroundColor: AppColors.bgDark,
  );

  static final lightTheme = ThemeData(
    backgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(color: AppColors.white),
    bottomAppBarColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.white,
  );
}

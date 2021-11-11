import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;
}

class AppThemes {
  static final darkTheme = ThemeData(
    //cor de fundo do app
    backgroundColor: AppColors.bgDark,
    appBarTheme: AppBarTheme(color: AppColors.bgDark),
    bottomAppBarColor: AppColors.bgDark,
    scaffoldBackgroundColor: AppColors.bgDark,
    primaryColor: AppColors.primary,
    //cor botao
    buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primary, disabledColor: AppColors.bgDark),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.primary,
        ), //button color
        foregroundColor: MaterialStateProperty.all<Color>(
            AppColors.bgDark), //text (and icon)
      ),
    ),
  );

  static final lightTheme = ThemeData(
    backgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(color: AppColors.white),
    bottomAppBarColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.primary,
        ), //button color
        foregroundColor: MaterialStateProperty.all<Color>(
            AppColors.bgDark), //text (and icon)
      ),
    ),
  );
}

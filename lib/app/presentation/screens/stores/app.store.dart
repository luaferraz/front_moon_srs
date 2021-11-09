import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/authentication/data/sources/locar_storage.source.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';
import 'package:front_moon_srs/app/shared/themes/app_themes.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app.store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  // @observable
  // ThemeMode themeMode = ThemeMode.light;

  @observable
  ThemeData themeData = AppThemes.lightTheme;

  @computed
  bool get isDark => themeData == AppThemes.darkTheme;

  @action
  void changeTheme() {
    print(isDark);
    if (isDark) {
      themeData = AppThemes.darkTheme;
    } else {
      themeData = AppThemes.lightTheme;
    }
    saveThemePreferences();
  }

  void saveThemePreferences() {
    SharedPreferences.getInstance().then((instance) {
      instance.setBool('isDark', isDark);
    });
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('isDark') &&
        prefs.containsKey('isDark') != prefs.getBool('isDark')) {
      themeData = AppThemes.darkTheme;
    } else {
      themeData = AppThemes.lightTheme;
    }
  }
}

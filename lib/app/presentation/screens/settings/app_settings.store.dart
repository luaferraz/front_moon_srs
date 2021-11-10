import 'package:flutter/material.dart';
import 'package:front_moon_srs/app.dart';
import 'package:front_moon_srs/app/authentication/data/sources/locar_storage.source.dart';
import 'package:mobx/mobx.dart';
part 'app_settings.store.g.dart';

class AppSettingsStore = _AppSettingsStore with _$AppSettingsStore;

abstract class _AppSettingsStore with Store {
  @observable
  bool isDark = false;

  @observable
  ThemeMode themeMode = ThemeMode.dark;

  void setCurrentTheme() async {
    if (isDark == true) {
      AppWidget.themeNotifier.value = ThemeMode.dark;
      await LocalStorageSource.setString('themeNotifier', 'dark');
      print(await LocalStorageSource.getString('themeNotifier'));
    } else {
      AppWidget.themeNotifier.value = ThemeMode.light;
      await LocalStorageSource.setString('themeNotifier', 'light');
      print(await LocalStorageSource.getString('themeNotifier'));
    }
  }

  Future<void> loadTheme() async {
    final storedTheme = await LocalStorageSource.getString('themeNotifier');
    if (storedTheme == 'dark') {
      themeMode = ThemeMode.dark;
      print(themeMode);
    } else {
      themeMode = ThemeMode.light;
      print(themeMode);
    }
  }
}

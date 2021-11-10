import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/shared/themes/app_themes.dart';
import 'package:front_moon_srs/core/routes/routes.dart';
import 'package:front_moon_srs/core/routes/router.dart' as app;

import 'app/presentation/screens/settings/app_settings.store.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

String theme = '';

ThemeMode themeBrightness = ThemeMode.dark;

class _AppWidgetState extends State<AppWidget> {
  final AppSettingsStore _appSettingsStore = AppSettingsStore();

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  asyncInit() async {
    await _appSettingsStore.loadTheme();
    setState(() {
      themeBrightness = _appSettingsStore.themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppWidget.themeNotifier.value = themeBrightness;
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppWidget.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Moon SRS',
          themeMode: currentMode,
          darkTheme: AppThemes.darkTheme,
          theme: AppThemes.lightTheme,
          onGenerateRoute: app.Router.generateRoute,
          initialRoute: Routes.login,
        );
      },
    );
  }
}

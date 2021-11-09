import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:front_moon_srs/app/presentation/screens/stores/app.store.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';
import 'package:front_moon_srs/app/shared/themes/app_themes.dart';
import 'package:front_moon_srs/core/app_config.dart';
import 'package:front_moon_srs/core/routes/routes.dart';
import 'package:front_moon_srs/core/service_locator.dart';
import 'package:front_moon_srs/core/routes/router.dart' as app;

void main() {
  AppConfig.setEnvironment(Environment.DEV);

  setupLocator();
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppStore _appStore = AppStore();
    print("${_appStore.isDark} main dev");
    return Observer(builder: (_) {
      return MaterialApp(
        title: 'Moon SRS',
        // themeMode: _appStore.themeMode,
        themeMode: ThemeMode.system,
        darkTheme: AppThemes.darkTheme,
        theme: AppThemes.lightTheme,
        // theme: _appStore.themeData,
        onGenerateRoute: app.Router.generateRoute,
        initialRoute: Routes.login,
      );
    });
  }
}

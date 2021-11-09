import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/shared/themes/app_themes.dart';
import 'package:front_moon_srs/core/app_config.dart';
import 'package:front_moon_srs/core/routes/router.dart' as app;
import 'package:front_moon_srs/core/routes/routes.dart';
import 'package:front_moon_srs/core/service_locator.dart';
import 'app/shared/themes/app_colors.dart';

void main() {
  AppConfig.setEnvironment(Environment.LOCAL);

  setupLocator();

  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      darkTheme: AppThemes.darkTheme,
      theme: AppThemes.lightTheme,
      // navigatorKey: serviceLocator<NavigatorHelper>().navigatorKey,
      onGenerateRoute: app.Router.generateRoute,
      initialRoute: Routes.login,
    );
  }
}

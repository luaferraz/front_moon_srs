import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/authentication/presentation/screens/auth/login_screen.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue, backgroundColor: AppColors.white),
      // navigatorKey: serviceLocator<NavigatorHelper>().navigatorKey,
      onGenerateRoute: app.Router.generateRoute,
      initialRoute: Routes.login,
    );
  }
}

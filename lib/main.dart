import 'package:flutter/material.dart';
import 'package:front_moon_srs/core/app_config.dart';
import 'package:front_moon_srs/core/helpers/navigator.helper.dart';
import 'package:front_moon_srs/core/service_locator.dart';
import 'package:front_moon_srs/routes.dart' as route;
import 'package:front_moon_srs/screens/auth/login_screen.dart';
import 'package:front_moon_srs/shared/themes/app_colors.dart';

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
      theme: ThemeData(
          primarySwatch: Colors.blue, backgroundColor: AppColors.white),
      navigatorKey: serviceLocator<NavigatorHelper>().navigatorKey,
      home: LoginScreen(),
      onGenerateRoute: route.controller,
      initialRoute: route.login,
    );
  }
}

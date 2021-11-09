import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/presentation/screens/auth/login_screen.dart';
import 'package:front_moon_srs/app/presentation/screens/auth/sign_up_screen.dart';
import 'package:front_moon_srs/app/presentation/screens/collection/edit_collection_screen.dart';
import 'package:front_moon_srs/app/presentation/screens/home/home_screen.dart';
import 'package:front_moon_srs/app/presentation/screens/settings/app_settings.dart';
import 'package:front_moon_srs/app/presentation/screens/srs/spaced_repetition_screen.dart';
import 'package:front_moon_srs/core/routes/routes.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomeScreen(),
        );
      case Routes.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginScreen(),
        );
      case Routes.signUp:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SignUpScreen(),
        );
      case Routes.editCollection:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const EditCollectionScreen(),
        );
      case Routes.spacedRepetition:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SpacedRepetitionScreen(),
        );
      case Routes.appSettings:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AppSettingsScreen(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

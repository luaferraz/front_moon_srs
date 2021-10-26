import 'package:flutter/material.dart';
import 'package:front_moon_srs/screens/auth/login_screen.dart';
import 'package:front_moon_srs/screens/auth/sign_up_screen.dart';
import 'package:front_moon_srs/screens/collection/edit_collection_screen.dart';
import 'package:front_moon_srs/screens/home/home_screen.dart';
import 'package:front_moon_srs/screens/settings/app_settings.dart';
import 'package:front_moon_srs/screens/srs/spaced_repetition_screen.dart';

const String login = LoginScreen.route;
const String signUp = SignUpScreen.route;
const String home = HomeScreen.route;
const String editCollection = EditCollectionScreen.route;
const String spacedRepetition = SpacedRepetitionScreen.route;
const String appSettings = AppSettingsScreen.route;

// control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case login:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case signUp:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case appSettings:
      return MaterialPageRoute(builder: (context) => const AppSettingsScreen());
    case home:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case editCollection:
      return MaterialPageRoute(
          builder: (context) => const EditCollectionScreen());
    case spacedRepetition:
      return MaterialPageRoute(
          builder: (context) => const SpacedRepetitionScreen());
    default:
      throw ('This route name does not exist');
  }
}

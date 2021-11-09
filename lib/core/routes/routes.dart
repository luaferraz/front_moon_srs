import 'package:front_moon_srs/app/presentation/screens/auth/login_screen.dart';
import 'package:front_moon_srs/app/presentation/screens/auth/sign_up_screen.dart';
import 'package:front_moon_srs/app/presentation/screens/collection/edit_collection_screen.dart';
import 'package:front_moon_srs/app/presentation/screens/home/home_screen.dart';
import 'package:front_moon_srs/app/presentation/screens/settings/app_settings.dart';
import 'package:front_moon_srs/app/presentation/screens/srs/spaced_repetition_screen.dart';

class Routes {
  static const String home = HomeScreen.route;
  static const String login = LoginScreen.route;
  static const String signUp = SignUpScreen.route;
  static const String editCollection = EditCollectionScreen.route;
  static const String spacedRepetition = SpacedRepetitionScreen.route;
  static const String appSettings = AppSettingsScreen.route;
}

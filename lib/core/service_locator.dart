import 'package:front_moon_srs/app/authentication/data/services/auth.service.dart';
import 'package:front_moon_srs/app/authentication/data/services/card.service.dart';
import 'package:front_moon_srs/app/authentication/data/services/collection.service.dart';
import 'package:front_moon_srs/core/helpers/navigator.helper.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupLocator() {
  serviceLocator.registerSingleton<AuthService>(AuthService());
  serviceLocator.registerSingleton<CollectionService>(CollectionService());
  serviceLocator.registerSingleton<CardService>(CardService());

  serviceLocator.registerSingleton<NavigatorHelper>(NavigatorHelper());
}

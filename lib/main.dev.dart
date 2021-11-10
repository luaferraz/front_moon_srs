import 'package:flutter/material.dart';
import 'package:front_moon_srs/app.dart';
import 'package:front_moon_srs/core/app_config.dart';
import 'package:front_moon_srs/core/service_locator.dart';

void main() {
  AppConfig.setEnvironment(Environment.DEV);

  setupLocator();

  runApp(const AppWidget());
}

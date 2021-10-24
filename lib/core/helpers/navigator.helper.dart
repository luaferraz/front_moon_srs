import 'package:flutter/material.dart';

class NavigatorHelper {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateToArguments(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }
  // Future<dynamic> pushAndRemoveUntil(String routeName) {
  //   return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false);
  // }
}

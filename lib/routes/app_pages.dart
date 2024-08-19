
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/screens/home/home_view.dart';

import '../screens/auth/login.dart';
import '../screens/intro.dart';
import '../screens/splash.dart';
import 'app_routes.dart';
class AppPages {
  static const initialRoute = Routes.splashRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.splashRoute: (context) => const SplashScreen(),
    Routes.introRoute: (context) => const IntroScreen(),
    Routes.loginRoute: (context) => const HomeView(),
  };

  static route(String route,
      {
        dynamic arguments,
        int? id,
        bool? preventDuplicates,
        bool? isReplace,
        Map<String, String>? parameters,
        Function(dynamic)? callback
      }) {
    if (isReplace ?? false) {
      Get.offAllNamed(
          route,
          arguments: arguments,
          id: id, parameters: parameters)?.then((value) {
        if (callback != null) {
          callback(value);
        }
      },);
      // Get.reset(clearRouteBindings: true);

    }
    else {
      Get.toNamed(
          route,
          arguments: arguments,
          id: id, preventDuplicates: preventDuplicates ?? false, parameters: parameters)?.then((value) {
        if (callback != null) {
          callback(value);
        }
      },);
    }
  }
}
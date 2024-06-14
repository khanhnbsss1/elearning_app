
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/auth/login.dart';
import 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.loginRoute: (context) => const LoginPage(),

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
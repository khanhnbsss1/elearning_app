import 'package:flutter/material.dart';
import 'package:lms_app/base/instance_mananger_elearning/instance_mananger.dart';

class NavigationService {
  static BuildContext? globalContext;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void registerContext(BuildContext context, {bool update = false}) {
    if (globalContext == null || update) {
      globalContext = context;
      InstanceManager().navigatorKey = NavigationService.navigatorKey ;
    }
  }
}

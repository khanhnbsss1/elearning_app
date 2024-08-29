import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/screens/auth/login.dart';

class NavigatorKey {
  static NavigatorKey? _instance;
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorKey._internal();

  static NavigatorKey get instance {
    _instance ??= NavigatorKey._internal();
    return _instance!;
  }

  Key get navigatorKey => _navigatorKey;

  void push() => _navigatorKey.currentState?.push(
    MaterialPageRoute(builder: (_) => const LoginScreen(popUpScreen: false,)),
  );
}
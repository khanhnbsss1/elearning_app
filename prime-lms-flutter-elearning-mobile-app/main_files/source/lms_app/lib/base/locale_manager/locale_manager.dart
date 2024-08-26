import 'package:flutter/cupertino.dart';

class LocaleManager {
  static LocaleManager? _instance;
  static Key _refreshKey = UniqueKey();

  static LocaleManager get instance {
    _instance ??= LocaleManager._internal();
    return _instance!;
  }

  LocaleManager._internal();

  static Key get refreshKey => _refreshKey  ;

  static void handleLocaleChanged() {
    _refreshKey = UniqueKey();
  }
}
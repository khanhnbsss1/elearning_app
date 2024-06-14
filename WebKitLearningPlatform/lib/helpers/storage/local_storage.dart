import 'package:shared_preferences/shared_preferences.dart';
import 'package:webkit/helpers/localizations/language.dart';
import 'package:webkit/helpers/services/auth_services.dart';
import 'package:webkit/helpers/theme/theme_customizer.dart';

import '../../base/store/cache_storage.dart';

class AuthorHelper {
  static const String _loggedInUserKey = "user";
  static const String _themeCustomizerKey = "theme_customizer";
  
  static Future<void> init() async {
    await initData();
  }

  static Future<void> initData() async {
    AuthService.isLoggedIn = SharedPreferencesStorage().getBoolean(_loggedInUserKey) ?? false;
    ThemeCustomizer.fromJSON(SharedPreferencesStorage().getString(_themeCustomizerKey));
  }

  static Future<void> setLoggedInUser(bool loggedIn) async {
    return SharedPreferencesStorage().saveBoolean(_loggedInUserKey, loggedIn);
  }

  static Future<void> setCustomizer(ThemeCustomizer themeCustomizer) {
    return SharedPreferencesStorage().saveString(_themeCustomizerKey, themeCustomizer.toJSON());
  }

  static Future<void> removeLoggedInUser() async {
    return SharedPreferencesStorage().removeByKey(_loggedInUserKey);
  }
}

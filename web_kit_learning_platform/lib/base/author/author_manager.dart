import 'dart:convert';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/theme/theme_customizer.dart';
import 'package:webkit/services/apis/auth/login/models/login_response.dart';

class AuthorManager {
  static final AuthorManager _singletonAuthorManager = AuthorManager._internal();
  static AuthorManager get getInstance => _singletonAuthorManager;

  factory AuthorManager() {
    return _singletonAuthorManager;
  }

  AuthorManager._internal();

  static const String _loggedInUserKey = "isLoggedIn";
  static const String _themeCustomizerKey = "theme_customizer";
  bool isLoggedIn= false;
  Future<void> init() async {
    await initData();
  }
  Future<void> initData() async {
    isLoggedIn = SharedPreferencesStorage().getBoolean(_loggedInUserKey) ?? false;
    ThemeCustomizer.fromJSON(SharedPreferencesStorage().getString(_themeCustomizerKey));
  }
  bool getLoggedInUser() {
    isLoggedIn = SharedPreferencesStorage().getBoolean(_loggedInUserKey,);
    return isLoggedIn;
  }
  Future<void> setLoggedInUser(bool loggedIn) async {
    return await SharedPreferencesStorage().saveBoolean(_loggedInUserKey, loggedIn);
  }

  Future<void> setCustomizer(ThemeCustomizer themeCustomizer) {
    return SharedPreferencesStorage().saveString(_themeCustomizerKey, themeCustomizer.toJSON());
  }

  Future<void> removeLoggedInUser() async {
    return SharedPreferencesStorage().removeByKey(_loggedInUserKey);
  }
  Future<void> deleteDataWhenLogout() async {
    await setLoggedInUser(false);
    await SharedPreferencesStorage().removeAllDynamicData();
    await SharedPreferencesStorage().removeAllDynamicKeys();

  }


  // Define a function that inserts dogs into the database
  Future<void> saveAuthInfo(AuthInfo loginResponse) async {
    await setLoggedInUser(true);
    SharedPreferencesStorage().saveString(Storage.currentAuthInfoKey, jsonEncode(loginResponse.toJson()));
  }


  Future<AuthInfo?> getAuthInfo() async {
    String authStr = SharedPreferencesStorage().getString(Storage.currentAuthInfoKey);
    AuthInfo? userInfo;
    if(authStr.isNotEmpty)
    {
      userInfo = AuthInfo.fromJson(jsonDecode(authStr));
    }
    return userInfo;
  }
  Future<void> removeAuthInfo() async {
    SharedPreferencesStorage().removeByKey(Storage.currentAuthInfoKey);
  }

  Future<void> handleLogout() async {
    await removeAuthInfo();
    AuthorManager().deleteDataWhenLogout();
    UserManager().handleLogoutData();
    setLoggedInUser(false);
  }
}

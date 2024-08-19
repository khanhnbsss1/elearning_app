import 'dart:convert';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/base/base.export.dart';

import '../../services_elearning/apis/auth/login/models/login_response.dart';
import '../../services_elearning/apis/auth/refreshToken/refresh_token_api.dart';

class AuthorManager {
  static final AuthorManager _singletonAuthorManager = AuthorManager._internal();
  static AuthorManager get getInstance => _singletonAuthorManager;
  factory AuthorManager() {
    return _singletonAuthorManager;
  }

  AuthorManager._internal();

  static const String _loggedInUserKey = "isLoggedIn";
  static const String _themeCustomizerKey = "theme_customizer";
  bool allowCallRefreshToken = true;
  bool isLoggedIn= false;
  Future<void> init() async {
    await initData();
  }
  Future<void> initData() async {
    isLoggedIn = SharedPreferencesStorage().getBoolean(_loggedInUserKey) ?? false;
    // ThemeCustomizer.fromJSON(SharedPreferencesStorage().getString(_themeCustomizerKey));
  }
  bool getLoggedInUser() {
    isLoggedIn = SharedPreferencesStorage().getBoolean(_loggedInUserKey,);
    return isLoggedIn;
  }
  Future<void> setLoggedInUser(bool loggedIn) async {
    return await SharedPreferencesStorage().saveBoolean(_loggedInUserKey, loggedIn);
  }

  // Future<void> setCustomizer(ThemeCustomizer themeCustomizer) {
  //   return SharedPreferencesStorage().saveString(_themeCustomizerKey, themeCustomizer.toJSON());
  // }

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


  AuthInfo? getAuthInfo() {
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

  Future<void> refreshToken() async {
    if(allowCallRefreshToken==false) {
      return;
    }
    allowCallRefreshToken = false;
    AuthInfo? authInfo = getAuthInfo();
    RefreshTokenApi refreshTokenApi = RefreshTokenApi(authInfo: authInfo);
    await refreshTokenApi.call();
    allowCallRefreshToken = true;
  }
  bool isValidToken(){
    /// ham nay kiem tra xem token co con han khong
    AuthInfo? authInfo = getAuthInfo();
    if(authInfo==null) {
      return false;
    }
    DateTime now =DateTime.now();
    int nowInTimestamp = now.toUtc().millisecondsSinceEpoch~/1000;
    bool isInvalidToken = nowInTimestamp> authInfo.expireAt!;
    return isInvalidToken;
  }
  Future<void> handleLogout() async {
    await removeAuthInfo();
    AuthorManager().deleteDataWhenLogout();
    UserManager().handleLogoutData();
    setLoggedInUser(false);
  }
  
}

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/sqliteManager/sqliteManager.dart';
import 'package:lms_app/models/user/UserProfile.dart';

class InstanceManager{
  static final InstanceManager _singletonBlocManager = InstanceManager._internal();
  static InstanceManager get getInstance => _singletonBlocManager;
  factory InstanceManager() {
    return _singletonBlocManager;
  }
  InstanceManager._internal();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BuildContext ?rootContext;

  bool firstLogin = true;
  Widget? userListTreeView;
  dynamic paymentManagerAllConfig;
  UserProfile? currentUserProfile;
  int walletBalanceOfCurrentUser=0;
  bool? enableDarkMode;
  void clearAllInstanceData()
  {
    userListTreeView = null;
    paymentManagerAllConfig = null;
    currentUserProfile = null;
    walletBalanceOfCurrentUser = 0;
  }
  void onChangeCurrentUser(){
  }
  void handlerLogoutData(){
    SqliteManager.getInstance.deleteCurrentUserInfo();
    SqliteManager.getInstance.deleteDataWhenLogout();
    SqliteManager.getInstance.deleteCurrentLoginUserInfo();
    SqliteManager.getInstance.deleteAllUserProfileInfo();
    clearAllInstanceData();
  }
  void handlerChangeCurrentUser(){
    onChangeCurrentUser();
  }
}

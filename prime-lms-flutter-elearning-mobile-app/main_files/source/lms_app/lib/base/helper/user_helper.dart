import 'dart:convert';
import 'package:lms_app/enviroments/permisstion.dart';
import 'package:lms_app/models/user/UserProfile.dart';

import '../../base/base.export.dart';
import '../firebase_manager/fire_base_manager.dart';
import '../instance_mananger/instance_mananger.dart';
import '../sqliteManager/sqliteManager.dart';
class UserHelper{
  static final UserHelper _singletonUserHelper = UserHelper._internal();
  static UserHelper get getInstance => _singletonUserHelper;
  factory UserHelper() {
    return _singletonUserHelper;
  }
  UserHelper._internal();

  bool _isChildenOnRootUser = true;

  Future<void> saveCurrentUserInfo(UserInfo userInfo) async {
   await SharedPreferencesStorage().saveString(Storage.currentUserInfoKey, json.encode(userInfo.toJson()));
  }
  Future<void> handleLogoutData() async {
    UserInfo? userInfos = await SqliteManager.getInstance.getCurrentSelectUserInfo();
    if(userInfos!=null){
      FirebaseManager.getInstance.removeSubscribeTopic(userInfos.userId!);
    }
    InstanceManager.getInstance.clearAllInstanceData();
    SqliteManager.getInstance.deleteDataWhenLogout();

  }


  Future<UserProfile?> getCurrentUserProfile() async {
    UserProfile? currentUserProfile;
    UserInfo? currentUserInfo = await SqliteManager.getInstance.getCurrentLoginUserInfo();
    if(currentUserInfo!=null)
    {
      List<UserProfile> listCurrentUserProfileInfo = await SqliteManager.getInstance.getUserProfileInfoByUserName(currentUserInfo.username!);
      if(listCurrentUserProfileInfo.isNotEmpty)
      {
        currentUserProfile = listCurrentUserProfileInfo.first;
      }
    }
    return currentUserProfile;
  }

  Future<UserProfile?> getCurrentRootUserProfile() async {
    UserInfo? rootUserInfo = await SqliteManager.getInstance.getCurrentLoginUserInfo();
    UserProfile? rootUserProfileInfo;
    if(rootUserInfo!=null)
    {
      List<UserProfile>? rootUserProfileInfos = await SqliteManager.getInstance.getUserProfileInfoByUserId(rootUserInfo.userId!);
      if(rootUserProfileInfos.isNotEmpty)
      {
        rootUserProfileInfo = rootUserProfileInfos.elementAt(0);
      }
    }
    return rootUserProfileInfo;
  }


  Future<void> setChildenOnRootUser() async {

    UserProfile? userProfile = await getCurrentUserProfile();

    if(userProfile!= null && userProfile.isParent())
    {
      _isChildenOnRootUser = true;
    }
    else
    {
      _isChildenOnRootUser = false;
    }
  }
}
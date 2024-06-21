import 'dart:convert';


import '../base.export.dart';

class UserHelper{
  static final UserHelper _singletonUserHelper = UserHelper._internal();
  static UserHelper get getInstance => _singletonUserHelper;
  factory UserHelper() {
    return _singletonUserHelper;
  }
  UserHelper._internal();
  
  Future<void> saveCurrentUserInfo(UserInfo userInfo) async {
   await SharedPreferencesStorage().saveString(Storage.currentUserInfoKey, json.encode(userInfo.toJson()));
  }
  Future<void> handleLogoutData() async {
    UserInfo? userInfos = await AuthorManager.getInstance.getCurrentSelectUserInfo();
    if(userInfos!=null){
      FirebaseManager.getInstance.removeSubscribeTopic(userInfos.userId!);
    }
    InstanceManager.getInstance.clearAllInstanceData();
    AuthorManager.getInstance.deleteDataWhenLogout();

  }


  Future<UserProfile?> getCurrentUserProfile() async {
    UserProfile? currentUserProfile;
    UserInfo? currentUserInfo = await AuthorManager.getInstance.getCurrentLoginUserInfo();
    if(currentUserInfo!=null)
    {
      List<UserProfile> listCurrentUserProfileInfo = await AuthorManager.getInstance.getUserProfileInfoByUserName(currentUserInfo.username!);
      if(listCurrentUserProfileInfo.isNotEmpty)
      {
        currentUserProfile = listCurrentUserProfileInfo.first;
      }
    }
    return currentUserProfile;
  }

  Future<UserProfile?> getCurrentRootUserProfile() async {
    UserInfo? rootUserInfo = await AuthorManager.getInstance.getCurrentLoginUserInfo();
    UserProfile? rootUserProfileInfo;
    if(rootUserInfo!=null)
    {
      List<UserProfile>? rootUserProfileInfos = await AuthorManager.getInstance.getUserProfileInfoByUserId(rootUserInfo.userId!);
      if(rootUserProfileInfos.isNotEmpty)
      {
        rootUserProfileInfo = rootUserProfileInfos.elementAt(0);
      }
    }
    return rootUserProfileInfo;
  }

}
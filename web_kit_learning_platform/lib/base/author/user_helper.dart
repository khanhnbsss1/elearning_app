import 'dart:convert';


import 'package:webkit/base/store/store.exports.dart';

import '../base.export.dart';

class UserManager{
  static final UserManager _singletonUserManager = UserManager._internal();
  static UserManager get getInstance => _singletonUserManager;
  factory UserManager() {
    return _singletonUserManager;
  }
  UserManager._internal();

  Future<void> handleLogoutData() async {
    UserProfile? userInfos = await getUserProfile();
    if(userInfos!=null){
      FirebaseManager().removeSubscribeTopic(userInfos.id.toString());
    }
    InstanceManager().clearAllInstanceData();

  }
  
  Future<void> saveUserProfileInfo(UserProfile userInfo) async {
   await SharedPreferencesStorage().saveString(Storage.currentUserInfoKey, json.encode(userInfo.toJson()));
  }

  Future<UserProfile?> getUserProfile() async {
    String rootUserStr = SharedPreferencesStorage().getString(Storage.currentUserInfoKey);
    UserProfile? userInfo;
    if(rootUserStr.isNotEmpty)
    {
      userInfo = UserProfile.fromJson(jsonDecode(rootUserStr));
    }
    return userInfo;
  }

  Future<void> deleteUserProfile() async {
    SharedPreferencesStorage().removeByKey(Storage.currentUserInfoKey);
  }
  // Config account nearest
  Future<void> saveAccountLoginNearest(String account) async{
    // save account login nearest
    SharedPre.saveDataString(SharedPre.accountNearest, account.toLowerCase().trim());
  }

  Future<String> getAccountLoginNearest() async{
    // get account login nearest
    String account = await SharedPre.readDataString(SharedPre.accountNearest);
    return account;
  }
  // Define a function that inserts dogs into the database
  Future<void> insertRecentUserInfo(UserProfile useInfo) async {
    // Get a reference to the database.
    String reUserListStr =  SharedPreferencesStorage().getString(Storage.recentUserInfoKey);
    RecentUserList recentUserList = RecentUserList();
    if(reUserListStr.isNotEmpty)
    {
      recentUserList = RecentUserList.fromJson(jsonDecode(reUserListStr));
    }
    recentUserList.recentUserContentList!.clear();
    if(recentUserList.recentUserContentList!.where((element) => element.id == useInfo.id).isEmpty)
    {
      recentUserList.recentUserContentList!.add(useInfo);
      String reUserListStr = jsonEncode(recentUserList.toJson());
      SharedPreferencesStorage().saveString(Storage.recentUserInfoKey, reUserListStr);
    }
  }

  Future<List<UserProfile>> getRecentAllUserInfo() async {
    String reUserListStr =  SharedPreferencesStorage().getString(Storage.recentUserInfoKey);
    if(reUserListStr.isEmpty)
    {
      return [];
    }
    RecentUserList recentUserList = RecentUserList.fromJson(jsonDecode(reUserListStr));
    return recentUserList.recentUserContentList??[];
  }

  Future<void> deleteRecentAllUserInfo() async {
    await SharedPreferencesStorage().removeByKey(Storage.recentUserInfoKey);
  }

}
import 'dart:convert';
import 'package:lms_app/base/author/author_manager.dart';
import '../../models/user/UserProfile.dart';
import '../base.export.dart';
import '../instance_mananger_elearning/instance_mananger.dart';
import '../store/shared_preferences.dart';

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
      //FirebaseManager().removeSubscribeTopic(userInfos.id.toString());
    }
    InstanceManager().clearAllInstanceData();

  }
  
  Future<void> saveUserProfileInfo(UserProfile userInfo) async {
   await SharedPreferencesStorage().saveString(Storage.currentUserInfoKey, json.encode(userInfo.toJson()));
  }

  Future<UserProfile?> getUserProfile() async {
    if(AuthorManager().getAuthInfo()==null) {
      return null;
    }
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
    SharedPreferencesStorage().saveString(SharedPre.accountNearest, account.toLowerCase().trim());
  }

  String getAccountLoginNearest() {
    // get account login nearest
    String account = SharedPreferencesStorage().getString(SharedPre.accountNearest);
    return account;
  }
  // Define a function that inserts dogs into the database
  Future<void> insertRecentUserInfo(UserInfo useInfo) async {
    // Get a reference to the database.
    String reUserListStr =  SharedPreferencesStorage().getString(Storage.recentUserInfoKey);
    RecentUserList recentUserList = RecentUserList();
    if(reUserListStr.isNotEmpty)
    {
      recentUserList = RecentUserList.fromJson(jsonDecode(reUserListStr));
    }
    recentUserList.recentUserContentList!.clear();
    if(recentUserList.recentUserContentList!.where((element) => element.userId == useInfo.userId).isEmpty)
    {
      recentUserList.recentUserContentList!.add(useInfo);
      String reUserListStr = jsonEncode(recentUserList.toJson());
      SharedPreferencesStorage().saveString(Storage.recentUserInfoKey, reUserListStr);
    }
  }

  // Future<List<UserProfile>> getRecentAllUserInfo() async {
  //   String reUserListStr =  SharedPreferencesStorage().getString(Storage.recentUserInfoKey);
  //   if(reUserListStr.isEmpty)
  //   {
  //     return [];
  //   }
  //   RecentUserList recentUserList = RecentUserList.fromJson(jsonDecode(reUserListStr));
  //   return recentUserList.recentUserContentList??[];
  // }

  Future<void> deleteRecentAllUserInfo() async {
    await SharedPreferencesStorage().removeByKey(Storage.recentUserInfoKey);
  }

}
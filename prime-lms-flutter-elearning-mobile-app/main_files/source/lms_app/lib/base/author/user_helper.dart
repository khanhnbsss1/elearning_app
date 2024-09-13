import 'dart:convert';
import 'package:lms_app/base/author/author_manager.dart';
import '../../models/user/UserProfile.dart';
import '../../services/apis/course/course_detail/models/course_detail_model.dart';
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
    UserProfile? userInfo = await getUserProfile();
    if(userInfo!=null){
      //FirebaseManager().removeSubscribeTopic(userInfo.id.toString());
    }
    InstanceManager().clearAllInstanceData();
  }
  
  Future<void> saveUserProfileInfo(UserProfile userInfo) async {
   await SharedPreferencesStorage().saveString(Storage.currentUserInfoKey, json.encode(userInfo.toJson()));
  }

  UserProfile? getUserProfile() {
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
  Future<void> saveAccountLoginNearest(String account, String password) async{
    // save account login nearest
    SharedPreferencesStorage().saveString(SharedPre.accountNearest, account);
    SharedPreferencesStorage().saveString(SharedPre.passwordNearest, password);
  }

  Future<void> saveRememberPassword(bool rememberPassword) async{
    // save account login nearest
    SharedPreferencesStorage().saveBoolean(SharedPre.rememberPassword, rememberPassword);
  }

  String getAccountLoginNearest() {
    // get account login nearest
    String account = SharedPreferencesStorage().getString(SharedPre.accountNearest);
    return account;
  }

  String getPasswordLoginNearest() {
    // get account login nearest
    String password = SharedPreferencesStorage().getString(SharedPre.passwordNearest);
    return password;
  }
  
  bool getRememberPassword() {
    return SharedPreferencesStorage().getBoolean(SharedPre.rememberPassword);
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

  Future<void> deleteAccountNearest() async {
    await SharedPreferencesStorage().removeByKey(SharedPre.accountNearest);
    await SharedPreferencesStorage().removeByKey(SharedPre.passwordNearest);
    await SharedPreferencesStorage().removeByKey(SharedPre.rememberPassword);
  }

  bool checkRegisteredCourse(CourseInfo courseInfo, List<CourseInfo> myCourse) {
    return myCourse.any((e) => e.id == courseInfo.id);
  }

}
import 'dart:convert';

import 'package:lms_app/models/user/UserProfile.dart';

import '../base.export.dart';

class SqliteManager {
  static final SqliteManager _singleton = SqliteManager._internal();
  static SqliteManager get getInstance => _singleton;

  factory SqliteManager() {
    return _singleton;
  }

  SqliteManager._internal();

  Future<void> deleteDataWhenLogout() async {
    await SharedPreferencesStorage().removeAllDynamicData();
    await SharedPreferencesStorage().removeAllDynamicKeys();

  }
  //#region define db for store key values
  /* ----------- begin define db for store key values-------------*/
  // Define a function that inserts dogs into the database
  Future<void> setValueForKey(String key, String value) async {
    // Get a reference to the database.
    await SharedPreferencesStorage().saveString(key, value);
  }

  Future<String> getValueForKey(String key) async {
    return SharedPreferencesStorage().getString(key);
  }

  String BoolToString(bool value) {
    return value ? "true" : "false";
  }

  Future<void> setIntergerForKey(String key, int value) async {
    // Get a reference to the database.
    await SharedPreferencesStorage().saveInteger(key, value);
  }

  Future<void> setBoolForKey(String key, bool value) async {
    // Get a reference to the database.
    await SharedPreferencesStorage().saveBoolean(key, value);

  }

  Future<void> setDoubleForKey(String key, double value) async {
    // Get a reference to the database.
    await SharedPreferencesStorage().saveDouble(key, value);

  }

  Future<void> setStringForKey(String key, String value) async {
    await SharedPreferencesStorage().saveString(key, value);

  }

  bool parseBool(String value) {
    return value.toLowerCase() == 'true';
  }

  Future<bool> getBoolForKey(String key) async {
    return SharedPreferencesStorage().getBoolean(key);
  }

  Future<int> getIntergerForKey(String key) async {
    return SharedPreferencesStorage().getInt(key);

  }

  Future<double> getDoubleForKey(String key) async {
    return SharedPreferencesStorage().getDouble(key);
  }

  Future<String> getStringForKey(String key) async {
    return SharedPreferencesStorage().getString(key);

  }

  /* ----------- end define db for store key values-------------*/
// #endregion
  
  // Define a function that inserts dogs into the database
  Future<void> insertCurrentLoginUserInfo(UserInfo useInfo) async {

    SharedPreferencesStorage().saveString(Storage.rootUserInfoKey, jsonEncode(useInfo.toJson()));
  }
  Future<void> deleteCurrentLoginUserInfo() async {
    SharedPreferencesStorage().removeByKey(Storage.rootUserInfoKey);
  }
  Future<UserInfo?> getCurrentLoginUserInfo() async {
    String rootUserStr = SharedPreferencesStorage().getString(Storage.rootUserInfoKey);
    UserInfo? userInfo;
    if(rootUserStr.isNotEmpty)
    {
      userInfo = UserInfo.fromJsonForDB(jsonDecode(rootUserStr));
    }
    return userInfo;
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

  Future<List<UserInfo>> getRecentAllUserInfo() async {
    String reUserListStr =  SharedPreferencesStorage().getString(Storage.recentUserInfoKey);
    if(reUserListStr.isEmpty)
    {
      return [];
    }
    RecentUserList recentUserList = RecentUserList.fromJson(jsonDecode(reUserListStr));
    return recentUserList.recentUserContentList??[];
  }

  Future<void> insertCurrentSelectUserInfo(UserInfo useInfo) async {
    // Get a reference to the database.
    RecentUserList recentUserList = RecentUserList();
    recentUserList.recentUserContentList!.add(useInfo);
    String reUserListStr = jsonEncode(recentUserList.toJson());
    SharedPreferencesStorage().saveString(Storage.currentUserInfoKey, reUserListStr);
  }

  Future<UserInfo?> getCurrentSelectUserInfo() async {
    String reUserListStr =  SharedPreferencesStorage().getString(Storage.currentUserInfoKey);
    if(reUserListStr.isEmpty)
    {
      return null;
    }
    RecentUserList recentUserList = RecentUserList.fromJson(jsonDecode(reUserListStr));
    return (recentUserList.recentUserContentList!=null && recentUserList.recentUserContentList!.isNotEmpty)?recentUserList.recentUserContentList!.first:null;

  }

  Future<void> deleteCurrentUserInfo() async {
    SharedPreferencesStorage().removeByKey(Storage.currentUserInfoKey);
  }
  Future<void> deleteRecentAllUserInfo() async {
    await SharedPreferencesStorage().removeByKey(Storage.recentUserInfoKey);
  }

  Future<void> insertUserProfileInfoList(List<UserProfile> userProfileInfos) async {
    String reUserListStr =  SharedPreferencesStorage().getString(Storage.currentUserProfileInfoKey);
    RecentUserProfileList recentUserList = RecentUserProfileList(recentList: []);
    if(reUserListStr.isNotEmpty)
    {
      recentUserList = RecentUserProfileList.fromJson(jsonDecode(reUserListStr));
    }
    for(UserProfile userProfile in userProfileInfos)
      {
        if(recentUserList.recentList!.where((element) => element.id == userProfile.id).isEmpty)
        {
          recentUserList.recentList!.add(userProfile);

        }
      }
    String reUserListStrFinal = jsonEncode(recentUserList.toJson());
    SharedPreferencesStorage().saveString(Storage.currentUserProfileInfoKey, reUserListStrFinal);
  }
  Future<void> insertUserProfileInfo(UserProfile useProfileInfo) async {
    // Get a reference to the database.
    // Get a reference to the database.
    String reUserListStr =  SharedPreferencesStorage().getString(Storage.currentUserProfileInfoKey);
    RecentUserProfileList recentUserList = RecentUserProfileList(recentList: []);
    if(reUserListStr.isNotEmpty)
    {
      recentUserList = RecentUserProfileList.fromJson(jsonDecode(reUserListStr));
    }
    recentUserList.recentList!.clear(); /// tạm thời chỉ lưu thông tin user đăng nhập gần nhất
    if(recentUserList.recentList!.where((element) => element.id == useProfileInfo.id).isEmpty)
    {
      recentUserList.recentList!.add(useProfileInfo);
      String reUserListStr = jsonEncode(recentUserList.toJson());
      SharedPreferencesStorage().saveString(Storage.currentUserProfileInfoKey, reUserListStr);
    }
  }

  Future<List<UserProfile>> getUserProfileInfoByUserId(String userId) async {
    String reUserListStr =  SharedPreferencesStorage().getString(Storage.currentUserProfileInfoKey);
    if(reUserListStr.isEmpty)
    {
      return [];
    }
    RecentUserProfileList recentUserList = RecentUserProfileList.fromJson(jsonDecode(reUserListStr));
    List<UserProfile>? recentList = [...(recentUserList.recentList??[]).where((element) => element.id == int.parse(userId))];
    return recentList;
  }

  Future<List<UserProfile>> getUserProfileInfoByParentUserId(String userId) async {
    String reUserListStr =  SharedPreferencesStorage().getString(Storage.currentUserProfileInfoKey);
    if(reUserListStr.isEmpty)
    {
      return [];
    }
    RecentUserProfileList recentUserList = RecentUserProfileList.fromJson(jsonDecode(reUserListStr));
    List<UserProfile>? recentList = [...(recentUserList.recentList??[]).where((element) => element.parentId == userId)];
    return recentList;
  }

  Future<List<UserProfile>> getUserProfileInfoByUserName(String userName) async {
    String reUserListStr =  SharedPreferencesStorage().getString(Storage.currentUserProfileInfoKey);
    if(reUserListStr.isEmpty)
    {
      return [];
    }
    RecentUserProfileList recentUserList = RecentUserProfileList.fromJson(jsonDecode(reUserListStr));
    List<UserProfile>? recentList = [...(recentUserList.recentList??[]).where((element) => element.username == userName)];
    return recentList;
  }
  Future<void> deleteAllUserProfileInfo() async {
    SharedPreferencesStorage().removeByKey(Storage.currentUserProfileInfoKey);
  }
}

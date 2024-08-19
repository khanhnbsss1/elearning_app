import 'shared_preferences.dart';

class DataAccess {

  // Config account nearest
  static Future<void> saveAccountLoginNearest(String account) async{
    // save account login nearest
    SharedPre.saveDataString(SharedPre.accountNearest, account.toLowerCase().trim());
  }

  static Future<String> getAccountLoginNearest() async{
    // get account login nearest
    String account = await SharedPre.readDataString(SharedPre.accountNearest);
    return account;
  }

  // Config language
  static Future<void> saveLanguageCurrent(bool isVi) async{
    // save language current
    SharedPre.saveDataBool(SharedPre.isVi, isVi);
  }
  static Future<bool> getLanguageCurrent() async{
    // get language current
    bool isVi = await SharedPre.readDataBool(SharedPre.isVi) ;
    return isVi;
  }

  // Config darkmode
  static Future<void> setDarkTheme(bool value) async{
    // save darkmode
    SharedPre.saveDataBool(SharedPre.themeStatus, value);
  }
    // get theme
  Future<bool> getTheme() async {
    return SharedPre.readDataBool(SharedPre.themeStatus);
  }

  static void clearListKey(List<String> listKey) async {
    for (String key in listKey) {
      SharedPre.deleteByKey(key);
    }
  }
  // Config show popup biometric
  static Future<void> saveBiometricPopupStatus(String account, bool isShow) async{
    // save language current
    SharedPre.saveDataBool(account, isShow);
  }
  static Future<bool> getBiometricPopupStatus(String account) async{
    // get language current
    bool isShowPopup = await SharedPre.readDataBool(account) ;
    return isShowPopup;
  }

}
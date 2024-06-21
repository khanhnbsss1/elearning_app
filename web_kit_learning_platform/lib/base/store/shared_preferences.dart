import 'package:shared_preferences/shared_preferences.dart';

class SharedPre {
  static String isVi = "isVi";
  static String accountNearest = "accountNearest";
  static const themeStatus = "themeStatus";

  static const List<String> keyDeleteWhenLogout = [
  ];

  /*
  SharedPreferences with String
   */
  static saveDataString(String key, String value) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // set value
    prefs.setString(key, value);
  }

  static Future<String> readDataString(String key) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the key. If it doesn't exist, return "".
    if (prefs.containsKey(key)) {
      final value = prefs.getString(key) ?? "";
      return value;
    }
    return "";
  }

  /*
  SharedPreferences with bool
  */
  static saveDataBool(String key, bool value) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // set value
    prefs.setBool(key, value);
  }

  static Future<bool> readDataBool(String key) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the key. If it doesn't exist, return "".
    if (prefs.containsKey(key)) {
      final value = prefs.getBool(key) ?? true;
      return value;
    }
    return true;
  }

  /*
  SharedPreferences with Int
  */
  static saveDataInt(String key, int value) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // set value
    prefs.setInt(key, value);
  }

  static Future<int> readDataInt(String key) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the key. If it doesn't exist, return 0.
    if (prefs.containsKey(key)) {
      final value = prefs.getInt(key) ?? -1;
      return value;
    }
    return -1;
  }

  /*
  SharedPreferences with Double
  */
  static saveDataDouble(String key, double value) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // set value
    prefs.setDouble(key, value);
  }

  static Future<double> readDataDouble(String key) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the key. If it doesn't exist, return 0.
    if (prefs.containsKey(key)) {
      final value = prefs.getDouble(key) ?? 0;
      return value;
    }
    return 0;
  }

  /*
    SharedPreferences clear data by key
    */
  static deleteByKey(String key) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // delete value
    prefs.remove(key);
  }
}

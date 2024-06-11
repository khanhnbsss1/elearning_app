import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  // Create storage
  static const storage =  FlutterSecureStorage();


  /// Hàm lưu
  static saveValue(String key, String value) async {
    // Write value
    await storage.write(key: key, value: value);
  }
  static Future<bool> exitKeyValue(String key) async {
    return await storage.containsKey(key: key);
  }

  /// Hàm đọc
  static Future<String> readValue(String key) async {
    // Read value
    try {
      final value = await storage.read(key: key);
      return value ?? "";
    } catch (e){
      return "";
    }
  }

  /// Hàm xóa từng key
  static deleteValue(String key) async {
    // Delete value
    await storage.delete(key: key);
  }

  // Hàm xóa tất cả
  static deleteValueAll() async {
    // Delete all
    await storage.deleteAll();
  }

}
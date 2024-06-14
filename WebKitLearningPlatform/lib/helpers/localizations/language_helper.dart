import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webkit/base/utils/key_manager.dart';

class LanguageHelper{
  static final LanguageHelper _singletonLanguageHelper = LanguageHelper._internal();
  static LanguageHelper get getInstance => _singletonLanguageHelper;
  factory LanguageHelper() {
    return _singletonLanguageHelper;
  }
  LanguageHelper._internal();
  Future<void>setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KeyManager.GetInstance().COUNTRY_CODE_KEY, locale.countryCode!);
    await prefs.setString(KeyManager.GetInstance().LANGUAGE_CODE_KEY, locale.languageCode);
  }
  Future<Locale> getCurrentLocale()async{
    final prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString(KeyManager.GetInstance().LANGUAGE_CODE_KEY)??"vi";
    String countryCode = prefs.getString(KeyManager.GetInstance().COUNTRY_CODE_KEY)??"VN";
    Locale locale = Locale(languageCode,countryCode);
    return locale;
  }
}
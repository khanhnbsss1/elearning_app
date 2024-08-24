import 'package:flutter/material.dart';

class LanguageConfig {
  //Initial Language
  static const Locale startLocale = Locale('en', 'US');

  //Language if any error happens
  static const Locale fallbackLocale = Locale('en', 'US');

  // Languages
  static const Map<String, List<String>> languages = {
    //language_name : [language_code, country_code(Capital format)]
    "English": ['en', 'US'],
    "Chinese": ['zh', 'CN'],
    "Vietnamese": ['vi', 'VN'],
  };

  // Don't edit this
  static List<Locale> supportedLocales = languages.values.map((e) => Locale(e.first, e.last)).toList();
}

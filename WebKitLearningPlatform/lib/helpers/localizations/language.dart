import 'package:flutter/material.dart';
import 'package:webkit/helpers/storage/local_storage.dart';
import 'package:webkit/helpers/theme/theme_customizer.dart';

import 'language_helper.dart';
enum LANGUAGE_INDEX{
  VIETNAMESE,
  ENGLISH,
  SPANISH,
  CHINESE,
  GERMAN
}
const Map<LANGUAGE_INDEX, String>LANGUAGE_VIEW = {
  LANGUAGE_INDEX.VIETNAMESE: "Tiếng Việt",
  LANGUAGE_INDEX.ENGLISH: "English",
  LANGUAGE_INDEX.SPANISH: "Spanish",
  LANGUAGE_INDEX.CHINESE: "Chinese",
  LANGUAGE_INDEX.GERMAN: "German",
};
const Map<LANGUAGE_INDEX, Locale> LANGUAGE_MAPS = {
  LANGUAGE_INDEX.VIETNAMESE: Locale('vi','VN'),
  LANGUAGE_INDEX.ENGLISH: Locale('en','US'),
  LANGUAGE_INDEX.SPANISH: Locale('es','US'),
  LANGUAGE_INDEX.CHINESE: Locale('zh','CN'),
  LANGUAGE_INDEX.GERMAN: Locale('de','US'),
  };
const Map<String, LANGUAGE_INDEX > LANGUAGE_INDEX_MAPS = {
  'vi':LANGUAGE_INDEX.VIETNAMESE,
  'en': LANGUAGE_INDEX.ENGLISH,
  'es': LANGUAGE_INDEX.SPANISH,
  'zh': LANGUAGE_INDEX.CHINESE,
  'de': LANGUAGE_INDEX.GERMAN,
};


class Language {
  /// the country code (IT,AF..)
  String? languageCode;
  LANGUAGE_INDEX languageIndex;
  /// the locale (en, es, da)
  String? country;

  /// the full name of language (English, Danish..)
  String? language;

  /// the full name of language (English, Danish..)
  String? scripCode;
  /// map of keys used based on industry type (service worker, route etc)
  Map<String, String>? dictionary;
  bool supportRTL;
  Language(
      {
        this.languageCode,
        this.country,
        this.language,
        this.dictionary,
        this.scripCode,
        required this.languageIndex,
        this.supportRTL = false
      });
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/store/cache_storage.dart';
import '../../base/utils/key_manager.dart';

class LanguageHelper{
  static final LanguageHelper _singletonLanguageHelper = LanguageHelper._internal();
  static LanguageHelper get getInstance => _singletonLanguageHelper;
  factory LanguageHelper() {
    return _singletonLanguageHelper;
  }
  LanguageHelper._internal();


  final List<LanguageInfo> supportedLanguages = [
    LanguageInfo(languageCode: 'en', country: 'US', language: 'English', languageIndex: LANGUAGE_INDEX.ENGLISH, ),
    LanguageInfo(languageCode: 'vi', country: 'VN', language: 'VietNam', languageIndex: LANGUAGE_INDEX.VIETNAMESE),
    LanguageInfo(languageCode: 'zh', country: 'CN', language: 'Chinese', languageIndex: LANGUAGE_INDEX.CHINESE),
  ];
  Locale? _locale;
  void setLocale(Locale inputLocale)  {
    _locale = inputLocale;
     SharedPreferencesStorage().saveString(KeyManager.GetInstance().COUNTRY_CODE_KEY, inputLocale.countryCode!);
     SharedPreferencesStorage().saveString(KeyManager.GetInstance().LANGUAGE_CODE_KEY, inputLocale.languageCode);
  }
  
  Locale getCurrentLocale(){
    if(_locale!=null)
      {
        return _locale!;
      }
    else
      {
        String languageCode = SharedPreferencesStorage().getString(KeyManager.GetInstance().LANGUAGE_CODE_KEY).isNotEmpty?SharedPreferencesStorage().getString(KeyManager.GetInstance().LANGUAGE_CODE_KEY):"vi";
        String countryCode = SharedPreferencesStorage().getString(KeyManager.GetInstance().COUNTRY_CODE_KEY).isNotEmpty?SharedPreferencesStorage().getString(KeyManager.GetInstance().COUNTRY_CODE_KEY):"VN";
        _locale = Locale(languageCode,countryCode);
        return _locale!;
      }
  }
  void changeLanguage(LanguageInfo language, BuildContext context) {
    Locale locale = LANGUAGE_MAPS[language.languageIndex]!;
    // AppNotifier().changeLanguage(language, notify: false);
    // BlocProvider.of<MainBloc>(NavigationService.globalContext!).add(MainChangeLanguageEvent(locale: locale));
  }
}

enum LANGUAGE_INDEX{
  VIETNAMESE,
  ENGLISH,
  CHINESE,
}
const Map<LANGUAGE_INDEX, String>LANGUAGE_VIEW = {
  LANGUAGE_INDEX.VIETNAMESE: "Tiếng Việt",
  LANGUAGE_INDEX.ENGLISH: "English",
  LANGUAGE_INDEX.CHINESE: "Chinese",
};
const Map<LANGUAGE_INDEX, Locale> LANGUAGE_MAPS = {
  LANGUAGE_INDEX.VIETNAMESE: Locale('vi','VN'),
  LANGUAGE_INDEX.ENGLISH: Locale('en','US'),
  LANGUAGE_INDEX.CHINESE: Locale('zh','CN'),
};
const Map<String, LANGUAGE_INDEX > LANGUAGE_INDEX_MAPS = {
  'vi':LANGUAGE_INDEX.VIETNAMESE,
  'en': LANGUAGE_INDEX.ENGLISH,
  'zh': LANGUAGE_INDEX.CHINESE,
};


class LanguageInfo {
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
  LanguageInfo(
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
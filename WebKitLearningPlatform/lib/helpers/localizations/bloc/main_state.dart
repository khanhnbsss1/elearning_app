part of 'main_bloc.dart';

enum MainStatus {
  initial,
  onchangeLanguage,
  onEnableDarkMode,
  unKnown
}
class MainState extends Equatable {
  MainStatus mainStatus =  MainStatus.initial;
   Locale? locale = const Locale("vi","VN");
  final List<Language> supportedLanguages = [
    Language(languageCode: 'en', country: 'US', language: 'English', languageIndex: LANGUAGE_INDEX.ENGLISH, ),
    Language(languageCode: 'vi', country: 'VN', language: 'VietNam', languageIndex: LANGUAGE_INDEX.VIETNAMESE),
    Language(languageCode: 'es', country: 'US', language: 'Spanish', languageIndex: LANGUAGE_INDEX.SPANISH),
    Language(languageCode: 'zh', country: 'CN', language: 'Chinese', languageIndex: LANGUAGE_INDEX.CHINESE),
  ];

  MainState(
      {
        this.locale,
        required this.mainStatus
      });

  MainState copyWith({
    Locale? locale,
    MainStatus? mainStatus
  }) {
    return MainState(
      locale:locale ?? this.locale,
      mainStatus: mainStatus??this.mainStatus
    );
  }

  @override
  List<Object?> get props {
    return [locale, mainStatus];
  }
}


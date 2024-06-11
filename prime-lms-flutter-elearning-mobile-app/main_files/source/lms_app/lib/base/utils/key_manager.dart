class KeyManager {
  static KeyManager ?_instance = KeyManager();

  static KeyManager GetInstance() {
    _instance ??= KeyManager();
    return _instance!;
  }
  final String COUNTRY_CODE_KEY ="local";
  final String LANGUAGE_CODE_KEY = "language";
  String saveFileFolder = "navitrack";
  String isEnableDarkMode = "isEnableDarkMode";

  /// share preference keys
  String categoryItemKey = "categoryItemKey";
}
class FirebasePackHandler {
  static FirebasePackHandler ?_instance = FirebasePackHandler();

  static FirebasePackHandler getInstance() {
    _instance ??= FirebasePackHandler();
    return _instance!;
  }
}
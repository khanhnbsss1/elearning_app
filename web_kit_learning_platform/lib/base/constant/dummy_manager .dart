class DummyManager{
  static final DummyManager _singletonDummyManager = DummyManager._internal();
  static DummyManager get getInstance => _singletonDummyManager;
  factory DummyManager() {
    return _singletonDummyManager;
  }
  DummyManager._internal();
  final int connectorId = 15829;
}
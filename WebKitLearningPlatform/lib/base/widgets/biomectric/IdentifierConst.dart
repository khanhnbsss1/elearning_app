class IdentifierConst{
  static BiometricTypeDevice biometricType = BiometricTypeDevice.none;
  static String username = "";
  static String password = "";

}
// Loại sinh trắc được hỗ trợ trong device
enum BiometricTypeDevice {
  fingerprint, face, none
}
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
class AuthService {
  // =============== implementing-face-recognition-authentication ============
  static Future<InfoBiometric> inforSupportAuthentication () async {
    try {
      //Khởi tạo Local Authentication plugin
      final LocalAuthentication localAuthentication = LocalAuthentication();
      // 1. Kiểm tra xem thiết bị có hỗ trợ xác thực sinh trắc học hay không
      bool isBiometricSupported = await localAuthentication.isDeviceSupported();
      // 2. Xác thực xem sinh trắc học có thể truy cập từ ứng dụng không?
      bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
      // ==> Đủ 2 điều kiện trên thì cho phép hiện button biometric
      bool canAuthen = isBiometricSupported && canCheckBiometrics;
      // 4. Kiểm tra loại biomitric được hỗ trợ trong thiết bị: FaceID hoặc Fingerprint
      if (canAuthen){
        // 4.1 Thiết bị có hỗ trợ faceId hoặc vân tay
        List<BiometricType> biometricTypes = await localAuthentication.getAvailableBiometrics();
        return InfoBiometric(canAuthen: canAuthen, biometricTypes: biometricTypes);
      } else {
        // 4.2 Thiết bị không hỗ trợ faceId hoặc vân tay
        return InfoBiometric(canAuthen: canAuthen, biometricTypes: []);
      }
    } catch (e){
      return InfoBiometric(canAuthen: false, biometricTypes: []);
    }
  }

  static Future<bool> authenticateUser(BuildContext context) async {
    // initialize Local Authentication plugin.
    final LocalAuthentication localAuthentication = LocalAuthentication();
    // status of authentication.
    bool isAuthenticated = false;
    //if device_elearning supports biometrics and user has enabled biometrics, then authenticate.
    try {
      isAuthenticated = await localAuthentication.authenticate(
          localizedReason:  Platform.isIOS ?
          S.of(context).header_popup_fingerprint:
          S.of(context).header_popup_biometric ,
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: true,
          ),
          authMessages: [
            IOSAuthMessages(
              goToSettingsDescription: S.of(context).title_popup_biometric,
              cancelButton:  S.of(context).str_cancel,
              goToSettingsButton: S.of(context).str_accept,
            ),
            AndroidAuthMessages(
              signInTitle: Platform.isIOS ?
              S.of(context).title_popup_fingerprint :
              S.of(context).title_popup_biometric,
              cancelButton:  S.of(context).str_cancel,
              goToSettingsButton: S.of(context).str_accept,
            )
          ]
      );
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        // Add handling of no hardware here.
      } else if (e.code == auth_error.notEnrolled) {
        // ...
      } else {
        // ...
      }
    }
    return isAuthenticated;
  }
}

class InfoBiometric {
  InfoBiometric({
    this.canAuthen,
    this.biometricTypes,
  });

  bool? canAuthen;
  List<BiometricType>? biometricTypes;

  InfoBiometric copyWith({
    bool? canAuthen,
    List<BiometricType>? biometricTypes
  }) {
    return InfoBiometric(
      canAuthen: canAuthen ?? this.canAuthen,
      biometricTypes: biometricTypes ?? this.biometricTypes,
    );
  }
}

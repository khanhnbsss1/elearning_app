import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceUtil {
  static String get _getDeviceType {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    return data.size.shortestSide < 550 ? 'phone' : 'tablet';
  }

  static bool get isTablet {
    return _getDeviceType == 'tablet';
  }
  static Future<bool> isPhysicalDevice() async {
    bool isPhysicalDevice = false;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    switch (defaultTargetPlatform){

      case TargetPlatform.android:
        // TODO: Handle this case.
      {
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        if(androidDeviceInfo.isPhysicalDevice)
          {
            isPhysicalDevice = true;
          }
      }
      break;
        // TODO: Handle this case.
      case TargetPlatform.iOS:
        // TODO: Handle this case.
      {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        if(iosDeviceInfo.isPhysicalDevice)
          {
            isPhysicalDevice = true;
          }
      }
        break;
      default:break;
    }
    return isPhysicalDevice;
  }
}

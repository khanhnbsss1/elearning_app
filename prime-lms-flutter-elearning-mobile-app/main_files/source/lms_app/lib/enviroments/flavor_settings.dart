
import 'package:lms_app/enviroments/permisstion.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io' show Platform;

import '../base/utils/file_utils.dart';

/// Contains the hard-coded settings per flavor.
class FlavorSettings {
  static final FlavorSettings _singletonFlavorSettings = FlavorSettings._internal();
  static FlavorSettings get getInstance => _singletonFlavorSettings;
  factory FlavorSettings() {
    return _singletonFlavorSettings;
  }
  late FlavorType flavorType;
  FlavorSettings._internal();

  FlavorType getFlavorType(){
    return flavorType;
  }
  Future<FlavorType> getFlavorSettingsInfo() async {
    flavorType = FlavorType.elearningLms;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      switch (packageInfo.packageName) {
        case "com.FFTCompany.elearninglms":
          flavorType = FlavorType.elearningLms;
          break;
        default:
          flavorType = FlavorType.elearningLms;
      }
    }
    else if (Platform.isIOS)
      {
        FileUtils.PrintLog("packageNameIOS:${packageInfo.packageName}");
        switch (packageInfo.packageName) {
          case "FFTCompany.elearninglms":
            flavorType = FlavorType.elearningLms;
            break;
          default:
            flavorType = FlavorType.elearningLms;
        }
      }
    return flavorType;
  }

  Future<void> setProductTypeByFlavor() async {
    flavorType = await getFlavorSettingsInfo();
      /// cai dat product type theo flavor
      switch(flavorType){
        case FlavorType.elearningLms:
          PermissionManager().setProductType(ProductType.elearningLmsVersion);
          break;
      }
    }
}

enum FlavorType {
  elearningLms,
}

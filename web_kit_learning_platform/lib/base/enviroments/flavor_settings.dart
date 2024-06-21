import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:webkit/base/permission/permisstion.dart';
import 'package:webkit/base/utils/file_utils.dart';

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
    flavorType = FlavorType.webUser;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (kIsWeb){
      switch (packageInfo.packageName) {
        case "YAXChineseLearningAdmin":
          flavorType = FlavorType.webAdmin;
          break;
        case "YAXChineseLearningUser":
          flavorType = FlavorType.webUser;
          break;
        default:
          flavorType = FlavorType.webUser;
      }
    }
   else if (Platform.isAndroid) {
      switch (packageInfo.packageName) {
        case "com.FFTCompany.YAXChineseLearning":
          flavorType = FlavorType.mobileUser;
          break;
        default:
          flavorType = FlavorType.mobileUser;
      }
    }
    else if (Platform.isIOS)
      {
        FileUtils.PrintLog("packageNameIOS:${packageInfo.packageName}");
        switch (packageInfo.packageName) {
          case "FFTCompany.YAXChineseLearning":
            flavorType = FlavorType.mobileUser;
            break;
          default:
            flavorType = FlavorType.mobileUser;
        }
      }
    return flavorType;
  }

  Future<void> setProductTypeByFlavor() async {
    flavorType = await getFlavorSettingsInfo();
      /// cai dat product type theo flavor
      switch(flavorType){
        case FlavorType.webAdmin:
          PermissionManager().setProductType(ProductType.webAdminVersion);
          break;
        case FlavorType.webUser:
          PermissionManager().setProductType(ProductType.webUserVersion);
          break;
        case FlavorType.mobileUser:
        // TODO: Handle this case.
          PermissionManager().setProductType(ProductType.mobileUserVersion);
          break;
      }
    }
}

enum FlavorType {
  webAdmin,
  webUser,
  mobileUser
}


import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static final PermissionManager _singletonPermissionManager = PermissionManager._internal();
  static PermissionManager get getInstance => _singletonPermissionManager;
  factory PermissionManager() {
    return _singletonPermissionManager;
  }
  PermissionManager._internal();

  ProductType _productType = ProductType.financialUserVersion;

  /// 安卓权限
  static List<Permission> androidPermissions = <Permission>[
    // 在这里添加需要的权限
    Permission.storage
  ];
  static Future<Map<Permission, PermissionStatus>> requestAll() async {
    if (Platform.isIOS) {
      return await iosPermissions.request();
    }
    return await androidPermissions.request();
  }

  static Future<Map<Permission, PermissionStatus>> request(
      Permission permission) async {
    final List<Permission> permissions = <Permission>[permission];
    return await permissions.request();
  }

  static bool isDenied(Map<Permission, PermissionStatus> result) {
    var isDenied = false;
    result.forEach((key, value) {
      if (value == PermissionStatus.denied) {
        isDenied = true;
        return;
      }
    });
    return isDenied;
  }

  /// 检查权限
  static Future<bool> checkGranted(Permission permission) async {
    PermissionStatus storageStatus = await permission.status;
    if (storageStatus == PermissionStatus.granted) {
      //已授权
      return true;
    } else {
      //拒绝授权
      return false;
    }
  }
  /// ios权限
  static List<Permission> iosPermissions = <Permission>[
    // 在这里添加需要的权限
    Permission.storage
  ];

  void setProductType(ProductType productType){
    _productType = productType;
  }
  ProductType getProductType(){
    return _productType;
  }


}

/// Loai product duoc phat trien
enum ProductType {
  elearningLmsVersion,/// product voi full cac tinh nang va them tinh nang admin
  financialUserVersion,/// product voi full cac tinh nang
}

const Map<ProductType, String> mapProductTypeFlavorName = {
  ProductType.elearningLmsVersion:"elearninglms",

};

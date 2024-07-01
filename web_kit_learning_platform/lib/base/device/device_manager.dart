import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
class DeviceManager {
  static final DeviceManager _singletonDeviceManager = DeviceManager._internal();
  static DeviceManager get getInstance => _singletonDeviceManager;
  factory DeviceManager() {
    return _singletonDeviceManager;
  }
  DeviceManager._internal();

  Future<DeviceInfoModel?> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    DeviceInfoModel? deviceInfoModel;
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      deviceInfoModel = DeviceInfoModel(serialNumber: "", type: "web");
      print(webBrowserInfo);
    } else {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print("androidInfo ${androidInfo.toString()}");
        deviceInfoModel = DeviceInfoModel(type: "phone", serialNumber: androidInfo.serialNumber);

      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print("iosInfo ${iosInfo.toString()}");
        deviceInfoModel = DeviceInfoModel(type: "phone", serialNumber: iosInfo.identifierForVendor);


      } else if (Platform.isLinux) {
        LinuxDeviceInfo linuxDeviceInfo = await deviceInfo.linuxInfo;
        print("linuxDeviceInfo ${linuxDeviceInfo.toString()}");
        deviceInfoModel = DeviceInfoModel(type: "desktop", serialNumber: linuxDeviceInfo.machineId);


      } else if (Platform.isMacOS) {
        MacOsDeviceInfo macOsDeviceInfo = await deviceInfo.macOsInfo;
        print("macOsDeviceInfo ${macOsDeviceInfo.toString()}");
        deviceInfoModel = DeviceInfoModel(type: "desktop", serialNumber: macOsDeviceInfo.systemGUID);


      } else if (Platform.isWindows) {
        WindowsDeviceInfo windowsDeviceInfo = await deviceInfo.windowsInfo;
        print("windowsDeviceInfo ${windowsDeviceInfo.toString()}");
        deviceInfoModel = DeviceInfoModel(type: "desktop", serialNumber: windowsDeviceInfo.deviceId);

      }
    
  }
    return deviceInfoModel;
  }
}
class DeviceInfoModel {
  String? serialNumber;
  String? type;

  DeviceInfoModel({this.serialNumber, this.type});

  DeviceInfoModel.fromJson(Map<String, dynamic> json) {
    serialNumber = json['SerialNumber'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SerialNumber'] = serialNumber;
    data['Type'] = type;
    return data;
  }
}


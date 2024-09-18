import 'package:flutter/material.dart';
import '../base.export.dart';
enum DeviceStatus{
  deviceNotActive,// Chưa hoạt động
  deviceAvailable,// Hoat dong
  deviceExpired,// het han
  deviceOffline,// Mat ke noi
}

Map<DeviceStatus, String> paymentDeviceStatusToStr={
  DeviceStatus.deviceAvailable:"device_online",
  DeviceStatus.deviceOffline:"device_offline",
  DeviceStatus.deviceExpired:"device_expired",
  DeviceStatus.deviceNotActive:"device_not_setup",
};

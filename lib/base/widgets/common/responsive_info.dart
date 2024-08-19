import 'dart:math';
import 'package:flutter/cupertino.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveInfo {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static bool _isTablet = false;
  static bool _isPhone = false;

  static bool isTablet() {
    return _isTablet;
  }

  static bool isPhone() {
    return _isPhone;
  }

  void init(BuildContext context) async {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _isTablet = checkTabletType(context);
    _isPhone = !_isTablet;
  }

  static bool checkTabletType(BuildContext context)  {
    bool isTab = false;
    double height = ScreenUtil().screenHeight;
    double width = ScreenUtil().screenWidth;
    double realHeightInInch = (height)/160;
    double realWidthInInch = (width)/160;
    ScreenUtil().pixelRatio;
    double crossLineinInch = sqrt((realHeightInInch*realHeightInInch) + (realWidthInInch*realWidthInInch));
    if(crossLineinInch>=7) {
      ///tablet
      isTab = true;
    } else {
      isTab = false;
    }
    return isTab;
  }
  static DeviceScreenType getDeviceType(BuildContext context)  {
    /// ham nay tinh toan kieu thiet bi dua tren size cua duong cheo
    DeviceScreenType deviceType = DeviceScreenType.mobile;
    double height = ScreenUtil().screenHeight;
    double width = ScreenUtil().screenWidth;
    double realHeightInInch = (height)/160;
    double realWidthInInch = (width)/160;
    ScreenUtil().pixelRatio;
    double crossLineinInch = sqrt((realHeightInInch*realHeightInInch) + (realWidthInInch*realWidthInInch));
    if(crossLineinInch>=7 && crossLineinInch<13.5) {
      ///tablet
      deviceType = DeviceScreenType.tablet;
    } else if(crossLineinInch>=13.5) {
      deviceType = DeviceScreenType.desktop;
    }
    else {
      deviceType = DeviceScreenType.mobile;
    }
    return deviceType;
  }
}
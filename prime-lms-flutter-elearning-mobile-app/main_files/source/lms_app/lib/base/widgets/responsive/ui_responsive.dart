import 'package:flutter/material.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:responsive_builder/responsive_builder.dart';

mixin ResponsivePage on Widget {
  Widget buildDesktop(BuildContext context);
  Widget buildTablet(BuildContext context);
  Widget buildMobile(BuildContext context);
  Widget buildUi(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeInfor) {
      DeviceScreenType deviceScreenType = ResponsiveInfo.getDeviceType(context);
      if (deviceScreenType == DeviceScreenType.desktop) {
        return buildDesktop(context);
      } else if (deviceScreenType == DeviceScreenType.tablet) {
        return buildTablet(context);
      } else if (deviceScreenType == DeviceScreenType.mobile) {
        return buildMobile(context);
      }
      return const Center(child: Text("UI un supported"));
    });
  }
}

import 'package:webkit/base/base.export.dart';
import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

  const NotificationBadge({super.key, required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Text(
            '$totalNotifications',
            style:baseStyle.copyWithCustom(color: ColorConst.whiteColor, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

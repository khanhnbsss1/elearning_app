import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../base/constant.dart';

class PhoneCallButton extends StatefulWidget {
  const PhoneCallButton({super.key});

  @override
  State<PhoneCallButton> createState() => _PhoneCallButtonState();
}

class _PhoneCallButtonState extends State<PhoneCallButton> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> animationRotation;
  late Animation<double> animationScale;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    animationRotation = Tween<double>(begin: 0.05, end: -0.05).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 1.0, curve: Curves.easeInOutCubic)));

    animationScale = Tween<double>(begin: 0, end: 0.3).animate(controller);
    controller.forward().whenComplete(() {
      controller.reverse();
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
          onPressed: () => launchUrlString("tel://${IdentifierConst.hotline}"),
          icon: const Icon(
            Icons.phone,
            color: Colors.white,
            size: 30,
          ),
    );
  }
}

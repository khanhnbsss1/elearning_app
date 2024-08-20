import 'package:flutter/material.dart';
import 'package:lms_app/configs/app_assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 55,
      child: ClipOval(
        child: Image.asset(
          logo,
          height: 45,
          width: 45,
          fit: BoxFit.cover,
        ),
      )
    );
  }
}

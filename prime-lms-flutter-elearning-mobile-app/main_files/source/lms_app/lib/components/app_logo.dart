import 'package:flutter/material.dart';
import 'package:lms_app/configs/app_assets.dart';

class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ClipOval(
        child: Image.asset(
          logo,
          fit: BoxFit.cover,
        ),
      )
    );
  }
}

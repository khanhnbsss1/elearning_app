
import 'package:flutter/material.dart';
import 'package:lms_app/base/base.export.dart';
class ButtonBiometric extends StatelessWidget {
  final Widget icon;
  final GestureTapCallback press;
  double?biometricSize;
   ButtonBiometric(
      {super.key,
        required this.icon, required this.press, this.biometricSize
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: biometricSize??(ResponsiveInfo.isTablet() ? Dimens.size70 : Dimens.size50),
        height: biometricSize??(ResponsiveInfo.isTablet() ? Dimens.size70 : Dimens.size50),
        decoration:  BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: ColorConst.shadowColor,
                blurRadius: 33,
                offset: const Offset(0, 7))
          ],
        ),
        child: icon,
        //onPressed: press,
      ),
    );
  }
}
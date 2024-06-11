import 'package:flutter/material.dart';

import '../../base.export.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final double height;
  double? width;
  final GestureTapCallback press;
  final Color? bgColor,textColor;
  final Color colorBorder;
  double? radius;
    RoundedButton({
    super.key,
    required this.fontSize,
    required this.press,
    required this.text,
      this.bgColor,
    required this.height,
     this.radius,
      this.width,
    this.textColor,
    this.colorBorder =  const Color(0x00141ed2),
  }){
     radius??=12;
   }

  @override
  Widget build(BuildContext context) {
      width??=MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        color: bgColor?? ColorConst.buttonbgColor,
        border: Border.all(
          width: 1,
          color: colorBorder
        ),

      ),
      child: InkWell(
        onTap: press,
        child: Center(
          child: Text(
            text,
            style:baseStyle.copyWithCustom(
                color: textColor??ColorConst.textColor,
                fontSize: fontSize,
                fontWeight:FontWeight.w600,
                fontFamily: TextStyleConstant.fontFamily),
          ),
        ),
      ),
    );
  }
}

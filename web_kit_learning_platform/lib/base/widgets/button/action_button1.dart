
import 'package:flutter/material.dart';

import '../../base.export.dart';

class ActionButton1 extends StatelessWidget {
  Color? enableBgColor;
  Color? borderColor;
  double? borderWidth;
  TextStyle? textStype;
  String? text;
  double? radius;
  Function()? onTap;
  double? width;
  double? height;
  bool? enable;
  bool? enableLinearColor;
  EdgeInsetsGeometry? contentPadding;
  ActionButton1(
      {super.key,
      this.enableBgColor,
      this.text,
      this.textStype,
      this.radius,
      this.onTap,
      this.width,
      this.height, 
      this.borderColor,
        this.borderWidth,
        this.enableLinearColor,
        this.contentPadding,
      this.enable}) {
    enableBgColor ??= ColorConst.buttonbgColor;
    textStype ??= TextStyleConstant.textStyleBlack14w600.copyWith(color: ColorConst.textColorOnMainButton.withOpacity(0.8));
    radius ??= Dimens.size22;
    height ??= Dimens.size40;
    enable ??= true;
    enableLinearColor??=false;
  }
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return InkWell(
      onTap: () {
        if (onTap != null && enable!) {
          onTap!();
        }
      },
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        borderRadius:BorderRadius.all(Radius.circular(radius??Dimens.size5)),
        child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(radius??Dimens.size5)),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(radius??Dimens.size5)),
                shape: BoxShape.rectangle,
                gradient:(enableLinearColor??false)?
                LinearGradient(
                    begin: Alignment.centerLeft,
                  stops: const [
                    0,
                    0.6,
                    1
                  ],
                  colors: [
                  ColorConst.colorLinear1,
                  ColorConst.colorLinear2,
                  ColorConst.colorLinear3
                  ]):null,
                color: enable! ? enableBgColor : enableBgColor!.withOpacity(0.3),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: contentPadding??EdgeInsets.symmetric(vertical: Dimens.size4, horizontal: Dimens.size10),
                    child: Center(
                      child: Text(
                        text!,
                        style: enable! ?textStype:textStype!.copyWith(color: textStype!.color!.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}

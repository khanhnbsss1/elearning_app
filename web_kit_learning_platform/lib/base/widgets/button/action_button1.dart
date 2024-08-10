
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';

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
  Widget? preIcon;
  
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
        this.preIcon,
      this.enable}) {
    enableBgColor ??= ColorConst.buttonbgColor;
    textStype ??= TextStyleConstant.textStyleBlack16w600.copyWith(color: ColorConst.whiteColor);
    radius ??= Dimens.size22;
    height ??= Dimens.size45;
    enable ??= true;
    enableLinearColor??=false;
    
  }
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    Color? color = enable! ?enableBgColor : enableBgColor!.withOpacity(0.3);
    return InkWell(
      onTap: () {
        if (onTap != null && enable!) {
          onTap!();
        }
      },
      child: OnHoverWidget(
        builder: (bool isHovered) { 
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius??Dimens.size5)),
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
                color: isHovered? color?.withOpacity(0.8): color ,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: contentPadding??EdgeInsets.symmetric(vertical: Dimens.size4, horizontal: Dimens.size16),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(preIcon!=null)
                            Row(
                              children: [
                                preIcon!,
                                Gap(Dimens.size16)
                              ],
                            ),
                          
                          Text(
                            text!,
                            style: enable! ?textStype:textStype!.copyWith(color: textStype!.color!.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

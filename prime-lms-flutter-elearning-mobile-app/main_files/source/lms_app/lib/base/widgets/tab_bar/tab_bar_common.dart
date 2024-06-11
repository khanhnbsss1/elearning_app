import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base.export.dart';

class TabBarCommon extends StatelessWidget{
  TabBarCommon(
      {
        super.key,
        this.title,
        this.titleTextStyle,
        this.child,
        this.enableBackButton,
        this.height,
        this.padding,
        this.notNullChildMainAxisAlignment,
        this.nullChildCrossAxisAlignment,
        this.enableLinearColor
      }){
    enableBackButton??=false;
    titleTextStyle??TextStyleConstant.textStyleBlack16w600;
    height??=Dimens.size60;
    padding??= EdgeInsets.symmetric(vertical: Dimens.size0, horizontal: Dimens.size0);
    notNullChildMainAxisAlignment??= MainAxisAlignment.center;
    nullChildCrossAxisAlignment??= CrossAxisAlignment.center;
    enableLinearColor??false;
  }
  String? title;
  TextStyle? titleTextStyle;
  Widget? child;
  bool? enableBackButton;
  double? height;
  EdgeInsetsGeometry? padding;
  MainAxisAlignment? notNullChildMainAxisAlignment;
  CrossAxisAlignment? nullChildCrossAxisAlignment;
  bool? enableLinearColor;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: ColorConst.mainColorWithOpacity50,
          gradient:(enableLinearColor??false)?
          LinearGradient(begin: Alignment.centerLeft,
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
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular((Dimens.size30)))),
      padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
      child: SafeArea(
        child: SizedBox(
          height: height,
          child: Padding(
            padding: padding!,
            child: Stack(
              children: [
                Visibility(
                    visible:child!=null,
                    child: Column(
                      mainAxisAlignment: notNullChildMainAxisAlignment!,
                      children: [
                        child??const SizedBox(),
                      ],
                    )
                ),
                Visibility(
                  visible:child==null,
                  child: Row(
                    crossAxisAlignment: nullChildCrossAxisAlignment!,
                    children: [
                      Visibility(
                        visible: enableBackButton==true,
                        child: BackButtonCustom(
                            buildContext: context),
                      ),
                      Gap(Dimens.size10),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              title??"",
                              style: titleTextStyle,
                            ),
                            
                          ],
                        ),
                      ),
                    ],
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
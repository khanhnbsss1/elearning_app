import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lms_app/base/widgets/common/stateless_widget_common.dart';

import '../../base.export.dart';
import '../widgets.export.dart';

class CustomDialog1 extends StatelessWidgetCommon{
  /// This [CustomDialog1] show app dialog common
  CustomDialog1(
      {
        super.key,
        required this.child,
        this.height,
        this.width,
        this.radius,
        this.insetPadding,
        this.enableCloseButton,
        this.enableBackButton,
        this.title,
        this.canBackdrop = true,
        this.enableHeader= true,
        this.alignment,
        this.mainAxisSizeParent,
        this.titleIcon,
        this.bodyBackGroundColor,
        this.backButtonCallback,
        this.titleAlignment,
        this.titleStyle,
        this.enableHeaderDivider,
        this.headerColor
      }){
    title??="";
    bodyBackGroundColor??=ColorConst.bgDialogColor;
    enableCloseButton??=true;
    enableBackButton??=false;
    radius??=Dimens.size22;
    enableHeader??=true;
    alignment??=Alignment.center;
    mainAxisSizeParent ??=MainAxisSize.max;
    enableHeaderDivider??=false;
  }

  ///constant width dynamic
  static const double dynamicSize = -1;

  /// content dialog;
  final Widget child;
  final Widget? titleIcon;
  TextStyle? titleStyle;
  bool? enableCloseButton;
  bool? enableBackButton;
  String? title;
  bool ? enableHeader;
  Color? bodyBackGroundColor;
  Color? headerColor;

  AlignmentGeometry? alignment;
  MainAxisAlignment? titleAlignment;
  /// radius dialog;
  double? radius;
  final EdgeInsets? insetPadding;
  /// The [height] height of dialog
  final double? height;

  Function()?backButtonCallback;
  ///The [width] width of dialog
  ///
  /// If [width] is null width default is device_elearning screen width DeviceUtils.isTablet() ? size.width * 0.4 : size.width * 0.95
  final double? width;
  MainAxisSize? mainAxisSizeParent;
  final bool canBackdrop;
  bool? enableHeaderDivider;

  ///The [show] function show custom dialog
  void show(BuildContext context) {
    showDialog(
        barrierDismissible: canBackdrop,
        context: context,
        builder: (context) => this);
  }

  @override
  Widget rootWidget(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    bool isTablet = ResponsiveInfo.isTablet();
    double? widthSize = width ?? (ResponsiveInfo.isTablet() ? size.width * 0.7 : size.width * 0.95);

    return InkWell(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        /// boc de thuc hien ontap outside
        height:MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius!,),
        ),
        constraints: BoxConstraints(
          maxHeight:  MediaQuery.sizeOf(context).height,
          maxWidth: MediaQuery.sizeOf(context).width,
        ),
        child: Dialog(
          insetPadding: insetPadding ??  EdgeInsets.symmetric(horizontal: Dimens.size10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
          alignment: alignment!,
          child: Container(
                width: widthSize,
                height: height,
                decoration: BoxDecoration(
                  color: headerColor??ColorConst.mainColor,
                  borderRadius: BorderRadius.circular(radius!,),
                ),
                constraints: const BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: SafeArea(
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: bodyBackGroundColor,
                      borderRadius: BorderRadius.circular(radius!,),
                    ),
                    padding: EdgeInsets.only(bottom: radius??0),
                    child: Column(
                      mainAxisSize: mainAxisSizeParent!,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: enableHeader!,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: isTablet?Dimens.size60:Dimens.size50,
                                decoration: BoxDecoration(
                                  color: headerColor??ColorConst.mainColor,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(radius!)),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: Dimens.size16, vertical: Dimens.size8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Visibility(
                                        visible: enableBackButton??false,
                                        child: InkWell(
                                            onTap: (){
                                              if(enableBackButton!)
                                                {
                                                  if(backButtonCallback!=null)
                                                    {
                                                      backButtonCallback!();
                                                    }
                                                  else
                                                    {
                                                      Navigator.of(context).pop();
                                                    }
                                                }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                                              child: Icon(
                                                Icons.arrow_back_ios_rounded,
                                                size: Dimens.size20,
                                                color: enableBackButton!?ColorConst.blackColor:Colors.transparent,
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: titleAlignment??MainAxisAlignment.start,
                                          children: [
                                            titleIcon??const SizedBox.shrink(),
                                            Gap(Dimens.size5),
                                            Text(
                                                title!,
                                                style: titleStyle??TextStyleConstant.textStyleBlack20w700.copyWith(color: ColorConst.blackColor)),
                                          ],
                                        ),
                                      ),
                                      enableCloseButton!?
                                      InkWell(
                                          onTap: (){
                                            Navigator.of(context).pop();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Icon(
                                              Icons.close,
                                              size: Dimens.size20,
                                              color: ColorConst.blackColor,
                                            ),
                                          )):
                                      SizedBox(width: Dimens.size20,),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: enableHeaderDivider??false,
                                child: Divider(
                                  color: ColorConst.greyColor1,
                                  height: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: mainAxisSizeParent==MainAxisSize.min,
                          child: Container(
                            decoration: BoxDecoration(
                                color: bodyBackGroundColor,
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius!)),
                                //border: const Border(bottom: BorderSide(color: Colors.white), right: BorderSide(color: Colors.white), left: BorderSide(color: Colors.white))
                            ),
                            child: Column(
                              children: [
                                child,
                              ],
                            )),
                        ),
                        Visibility(
                          visible: mainAxisSizeParent==MainAxisSize.max,
                          child: Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: bodyBackGroundColor,
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius!)),
                                    //border: const Border(bottom: BorderSide(color: Colors.white), right: BorderSide(color: Colors.white), left: BorderSide(color: Colors.white))
                                ),
                                child: Column(
                                  children: [
                                    child,
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),
        ),
      ),
    );
  }
}

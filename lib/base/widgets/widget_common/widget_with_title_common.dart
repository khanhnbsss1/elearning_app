
import 'package:lms_app/base/base.export.dart';
import 'package:flutter/material.dart';
class WidgetWithTitleCommon extends StatefulWidget {

  String? title;
  final Function()? onTap;
  final Function(String value)? onTapOutSide;
  bool ?enable;
  double? height;
  Color? bgColor;
  bool? isRequirement;
  double? radius =Dimens.size4;
  Widget? child;
  MainAxisAlignment? titleMainAxisAlignment;
  AlignmentGeometry? alignmentGeometry;
  EdgeInsetsGeometry? childPadding;
  WidgetWithTitleCommon({
    super.key,
    this.onTap,
    this.onTapOutSide,
    this.enable,
    this.height,
    this.bgColor,
    this.radius,
    this.title,
    this.isRequirement,
    this.child,
    this.titleMainAxisAlignment,
    this.alignmentGeometry,
    this.childPadding
  }){
    height = height??Dimens.size40;
    bgColor ??=ColorConst.whiteColor;
    radius??=Dimens.size4;
    enable??=true;
    title??="";
    isRequirement??=false;
    titleMainAxisAlignment??= MainAxisAlignment.start;
    alignmentGeometry??= Alignment.centerLeft;
  }

  @override
  State<WidgetWithTitleCommon> createState() => _WidgetWithTitleCommonState();
}

class _WidgetWithTitleCommonState extends State<WidgetWithTitleCommon> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

        if(widget.enable! && widget.onTap!=null)
          {
            widget.onTap!();
          }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title!.isNotEmpty?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:0.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: widget.titleMainAxisAlignment!,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: widget.alignmentGeometry!,
                  child: Tooltip(
                    message:  widget.title!,
                    child: Text(
                        widget.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleConstant.normalTextOnBackGroundColorStyle14w400),
                  ),
                ),
                Gap(Dimens.size2),
                Visibility(
                    visible: widget.isRequirement??false,
                    child:  Icon(
                      Icons.star,
                      size: Dimens.size10,
                      color: Colors.red,)
                )
              ],
            ),
          ):
          const SizedBox.shrink(),
          Align(
              alignment: widget.alignmentGeometry!,
              child: Padding(
                padding: widget.childPadding??EdgeInsets.symmetric(horizontal: Dimens.size4, vertical: Dimens.size8),
                child: widget.child??const SizedBox.shrink(),
              )),
        ],
      ),
    );
  }
}
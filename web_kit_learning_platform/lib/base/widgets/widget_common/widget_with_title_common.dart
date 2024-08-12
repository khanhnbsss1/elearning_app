
import 'package:webkit/base/base.export.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../helpers/widgets/my_spacing.dart';

class WidgetWithColumnTitleCommon extends StatefulWidget {

  String? title;
  final Function()? onTap;
  final Function(String value)? onTapOutSide;
  final Function(bool value)? onCheckChanged;
  bool ?enable;
  double? height;
  Color? bgColor;
  bool? isRequirement;
  double? radius =Dimens.size4;
  Widget? child;
  MainAxisAlignment? titleMainAxisAlignment;
  AlignmentGeometry? alignmentGeometry;
  EdgeInsetsGeometry? childPadding;
  TextStyle? titleStyle;
  Widget ?titleWidget;
  bool? enableAttachFile;
  WidgetWithColumnTitleCommon({
    super.key,
    this.onTap,
    this.onTapOutSide,
    this.onCheckChanged,
    this.enable,
    this.height,
    this.bgColor,
    this.radius,
    this.title,
    this.isRequirement,
    this.child,
    this.titleMainAxisAlignment,
    this.alignmentGeometry,
    this.childPadding,
    this.titleStyle,
    this.titleWidget,
    this.enableAttachFile,
  }){
    height = height??Dimens.size40;
    bgColor ??=ColorConst.whiteColor;
    radius??=Dimens.size4;
    enable??=true;
    title??="";
    isRequirement??=false;
    titleMainAxisAlignment??= MainAxisAlignment.start;
    alignmentGeometry??= Alignment.centerLeft;
    enableAttachFile??=false;
  }

  @override
  State<WidgetWithColumnTitleCommon> createState() => _WidgetWithColumnTitleCommonState();
}

class _WidgetWithColumnTitleCommonState extends State<WidgetWithColumnTitleCommon> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: widget.titleWidget!=null,
            child: SizedBox(
              child: widget.titleWidget,
            )
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Visibility(
            visible: widget.titleWidget==null,
            child: widget.title!.isNotEmpty?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:0.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: widget.titleMainAxisAlignment!,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: widget.alignmentGeometry!,
                    child: Tooltip(
                      message:  widget.title!,
                      child: Text(
                          widget.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: widget.titleStyle??TextStyleConstant.textStyleBlack13w500.copyWith(fontWeight:  FontWeight.w600)),
                    ),
                  ),
                  Gap(Dimens.size2),
                  Visibility(
                      visible: widget.isRequirement??false,
                      child:  Icon(
                        Icons.star,
                        size: Dimens.size10,
                        color: Colors.red,)
                  ),
                  Spacer(),
                  Visibility(
                      visible: widget.enableAttachFile == true,
                      child: SizedBox(
                        child: Row(
                          children: [
                            Text(
                              L10nX.getStr.upload_file,
                              style: widget.titleStyle??TextStyleConstant.textStyleBlack13w500.copyWith(fontWeight:  FontWeight.w600),),
                            MySpacing.width(8),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  check = !check;
                                  if(widget.onCheckChanged != null) {
                                    widget.onCheckChanged!(check);
                                  }
                                });
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration:
                                BoxDecoration(
                                    border:
                                    Border.all(
                                      color: Colors.red,
                                    )),
                                child: Align(
                                  alignment:
                                  Alignment.center,
                                  child: check
                                      ? Icon(
                                    Icons.check,
                                    color: Colors
                                        .red,
                                  )
                                      : SizedBox(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ):
            const SizedBox.shrink(),
          ),
        ),
        Align(
            alignment: widget.alignmentGeometry!,
            child: Padding(
              padding: widget.childPadding??EdgeInsets.symmetric(horizontal: Dimens.size4, vertical: Dimens.size8),
              child: widget.child??const SizedBox.shrink(),
            )),
      ],
    );
  }
}

class WidgetWithRowTitleCommon extends StatefulWidget {

  String? title;
  final Function()? onTap;
  final Function(String value)? onTapOutSide;
  bool ?enable;
  double? height;
  Color? bgColor;
  bool? isRequirement;
  double? radius =Dimens.size4;
  Widget? child;
  Widget ?titleWidget;
  MainAxisAlignment? titleMainAxisAlignment;
  AlignmentGeometry? alignmentGeometry;
  EdgeInsetsGeometry? childPadding;
  TextStyle? titleStyle;
  CrossAxisAlignment? crossAxisAlignment;
  WidgetWithRowTitleCommon({
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
    this.childPadding,
    this.titleStyle,
    this.crossAxisAlignment,
    this.titleWidget
  }){
    height = height??Dimens.size40;
    bgColor ??=ColorConst.whiteColor;
    radius??=Dimens.size4;
    enable??=true;
    title??="";
    isRequirement??=false;
    titleMainAxisAlignment??= MainAxisAlignment.start;
    alignmentGeometry??= Alignment.centerLeft;
    crossAxisAlignment??= CrossAxisAlignment.center;
  }

  @override
  State<WidgetWithRowTitleCommon> createState() => _WidgetWithRowTitleCommonState();
}

class _WidgetWithRowTitleCommonState extends State<WidgetWithRowTitleCommon> {

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: widget.titleWidget!=null,
            child: SizedBox(
              child: widget.titleWidget,
            )
        ),
        Visibility(
          visible: widget.titleWidget==null,
            child: widget.title!.isNotEmpty?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:0.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: widget.titleMainAxisAlignment!,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: widget.crossAxisAlignment!,
                children: [
                  Align(
                    alignment: widget.alignmentGeometry!,
                    child: Tooltip(
                      message:  widget.title!,
                      child: Text(
                          widget.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: widget.titleStyle??TextStyleConstant.textStyleBlack13w500.copyWith(fontWeight:  FontWeight.w600)),
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
        ),
        Align(
            alignment: widget.alignmentGeometry!,
            child: Padding(
              padding: widget.childPadding??EdgeInsets.symmetric(horizontal: Dimens.size4, vertical: Dimens.size8),
              child: widget.child??const SizedBox.shrink(),
            )),
      ],
    );
  }
}
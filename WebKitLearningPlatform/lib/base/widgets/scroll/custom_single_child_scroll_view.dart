import 'package:flutter/cupertino.dart';

class CustomSingleChildScrollView extends SingleChildScrollView{
  bool? thumbVisibility;
  Radius? radius;
  double? thickness;
  Color? thumbColor;
  double?minThumbLength;
  double? minOverscrollLength;
  bool? trackVisibility;
  Radius? trackRadius;
  Color? trackColor;
  Color? trackBorderColor;
  @override
  ScrollController? controller;

  CustomSingleChildScrollView({
    super.key,
    this.controller,
    this.thumbVisibility,
    super.child,
    super.scrollDirection,
    super.primary,
    this.thickness,
    this.trackRadius,
    this.trackColor,
    this.trackBorderColor,
    this.trackVisibility,
    this.minOverscrollLength,
    this.thumbColor,
    this.radius,
    this.minThumbLength,
  }){

    thumbVisibility??=true;
    thickness??= 10.0;
    radius ??=Radius.circular(5.0);
    controller??=ScrollController();
  }
  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
        controller: controller,
        thumbVisibility: thumbVisibility,
        thickness: thickness,
        thumbColor: thumbColor,
        minOverscrollLength: minOverscrollLength,
        trackVisibility: trackVisibility,
        trackBorderColor: trackBorderColor,
        trackColor: trackColor,
        trackRadius: trackRadius,
        radius: radius,

        child: super.build(context));
  }
}
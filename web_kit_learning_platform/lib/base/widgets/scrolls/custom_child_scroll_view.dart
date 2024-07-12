import 'package:flutter/cupertino.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

class CustomChildScrollView extends StatelessWidget{
  CustomChildScrollView({
    this.child,
    this.animationCurve,
    this.durationMS,
    this.physics, 
    this.scrollSpeed,
    this.scrollDirection,
    this.controller
  });
  Widget? child;
  ScrollPhysics? physics;
  int? durationMS = 1000;
  double? scrollSpeed = 1000;
  Curve? animationCurve;
  Axis? scrollDirection;
  ScrollController? controller;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DynMouseScroll(
      animationCurve: animationCurve??Curves.linear,
      durationMS: durationMS??100,
      scrollSpeed: scrollSpeed??100,
      controller: controller,
      mobilePhysics: physics??BouncingScrollPhysics(),
      builder: (buildContext , scrollController , scrollPhysics ) {
        return SingleChildScrollView(
          controller: scrollController,
          scrollDirection: scrollDirection??Axis.vertical,
          physics: scrollPhysics,
          child: child,
        );
      },
    );
  }
}

class CustomListView extends StatelessWidget{
  CustomListView({
    this.children,
    this.animationCurve,
    this.durationMS,
    this.physics,
    this.scrollSpeed
  });
  List<Widget>? children = [];
  ScrollPhysics? physics;
  int? durationMS = 380;
  double? scrollSpeed = 2;
  Curve? animationCurve;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DynMouseScroll(
      animationCurve: animationCurve??Curves. easeOutQuart,
      durationMS: durationMS??380,
      scrollSpeed: scrollSpeed??2,
      mobilePhysics: physics??BouncingScrollPhysics(),
      builder: (buildContext , scrollController , scrollPhysics ) {
        return ListView(
          controller: scrollController,
          physics: scrollPhysics,
          children: children??[],
        );
      },
    );
  }
}
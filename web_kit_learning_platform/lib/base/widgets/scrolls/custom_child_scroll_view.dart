import 'package:flutter/cupertino.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

class CustomChildScrollView extends StatelessWidget{
  CustomChildScrollView({
    this.child,
    this.animationCurve,
    this.durationMS,
    this.physics, 
    this.scrollSpeed
  });
  Widget? child;
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
        return SingleChildScrollView(
          controller: scrollController,
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
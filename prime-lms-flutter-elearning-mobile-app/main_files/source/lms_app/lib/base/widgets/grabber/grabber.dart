
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

import '../../base.export.dart';
/// A draggable widget that accepts vertical drag gestures
/// and this is only visible on desktop and web platforms.
class DraggableScrollableWidget extends StatefulWidget{
  double minChildSize = 0.25;
  double? initialChildSize = 0.5;
  Color? boxColor;
  Widget child;
  DraggableScrollableWidget(
    {
      super.key,
      this.minChildSize= 0.25,
      this.initialChildSize,
      this.boxColor,
      required this.child
    })
  {
    boxColor??= ColorConst.greyColor.withOpacity(0.2);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DraggableScrollableWidgetState();
  }

}
class DraggableScrollableWidgetState extends State<DraggableScrollableWidget>{
  final double _sheetPosition = 0.25;
  final double _dragSensitivity = 310;
  DraggableScrollableController draggableScrollController = DraggableScrollableController();
  double _maxSize = 1;

  void _setMaxChildSize(Size size) {
    setState(() {
      // get height of the container.
      double boxHeight = size.height;
      // get height of the screen from mediaQuery.
      double screenHeight = MediaQuery.of(context).size.height;
      // get the ratio to set as max size.
      double ratio = (boxHeight)/screenHeight;
      _maxSize = ratio+0.005;
      _animateToMaxHeight(ratio );
    });
  }

  void _animateToMaxHeight(double ratio) {
    draggableScrollController.animateTo(ratio, duration: const Duration(seconds: 1), curve: Curves.linear);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DraggableScrollableSheet(
      maxChildSize: _maxSize,
      controller: draggableScrollController,
      minChildSize: widget.minChildSize,
      initialChildSize: widget.initialChildSize??_maxSize,
      expand: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: MeasureSize(
              onChange: _setMaxChildSize,
              child: Column(
                children: [
                  ColoredBox(
                      color: widget.boxColor!,
                      child: widget.child),
                ],
              )),
        );
      },
    );
  }

}


typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    super.key,
    required this.onChange,
    required Widget super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant MeasureSizeRenderObject renderObject) {
    renderObject.onChange = onChange;
  }
}
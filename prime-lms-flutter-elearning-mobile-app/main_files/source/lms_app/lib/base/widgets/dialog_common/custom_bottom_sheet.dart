
import 'package:flutter/material.dart';
import 'package:lms_app/base/base.export.dart';

import '../common/stateless_widget_common.dart';

class CustomBottomSheet extends StatelessWidgetCommon {
  /// The isScrollControlled parameter specifies whether this is a route for a bottom sheet that will utilize [DraggableScrollableSheet]. If you wish to have a bottom sheet that has a scrollable child such as a [ListView] or a [GridView] and have the bottom sheet be draggable, you should set this parameter to true.
  final bool isScrollControlled;

  /// The [enableDrag] parameter specifies whether the bottom sheet can be dragged up and down and dismissed by swiping downwards.
  final bool enableDrag;

  /// The [height] height bottom sheet, if it is null , it will automatic scale with height of screen * 0.7
  ///
  /// Final _defaultHeight = MediaQuery.of(context).size.height * 0.7;
  final double? height;

  /// The [childContent] content bottom sheet to show
  final Widget childContent;

  final BorderRadius? borderRadius;

  /// This [CustomBottomSheet] for show bottomsheet with child content [childContent]
  const CustomBottomSheet({
    super.key,
    required this.childContent,
    this.height,
    this.isScrollControlled = true,
    this.enableDrag = true,
    this.borderRadius
  });

  void show(BuildContext context) {
    final defaultHeight = MediaQuery.of(context).size.height * 0.7;
    showModalBottomSheet(
        enableDrag: enableDrag,
        isScrollControlled: isScrollControlled,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ??  BorderRadius.only(
              topLeft: Radius.circular(Dimens.size15),
              topRight: Radius.circular(Dimens.size15)),
        ),
        builder: (BuildContext buildContext) =>
            SizedBox(height: height ?? defaultHeight, child: this));
        (BuildContext buildContext) => SizedBox(height: height ?? defaultHeight, child: this);
  }

  @override
  Widget rootWidget(BuildContext context) {
    return childContent;
  }
}

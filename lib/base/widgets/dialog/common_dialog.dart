import 'package:flutter/material.dart';

import '../../base.export.dart';

class CommonDialog extends StatelessWidget{
  Widget child;
  String? title;
  double? width, height, maxHeight, maxWidth;
  Color? headerColor;
  Color? bgColor;
  bool? barrierDismissible;
  double? headerHeight;
  AlignmentGeometry? alignment;
  CommonDialog(
      {super.key, 
        required this.child,
        this.title,
        this.height,
        this.width,
        this.maxHeight,
        this.maxWidth,
        this.headerColor,
        this.bgColor,
        this.barrierDismissible,
        this.headerHeight,
        this.alignment
      });
  @override
  Widget build(BuildContext context) {
    Color defaultBgColor = ColorConst.whiteColor;
    Color defaultHeaderColor = ColorConst.mainColor;
    Color defaultTitleColor = ColorConst.whiteColor;

    headerColor??= defaultHeaderColor;
    bgColor??= defaultBgColor;
    // TODO: implement build
    return AlertDialog(
      insetPadding:EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal:0),
      actionsPadding: EdgeInsets.symmetric(vertical: 0, horizontal:0),
      alignment: alignment??Alignment.center,
      content: Container(
        width: width??MediaQuery.of(context).size.width*10/11,
        height:  height??MediaQuery.of(context).size.height*3/4,
        decoration: BoxDecoration(
          color: ColorConst.bgColor,
        ),
        constraints: BoxConstraints(
          maxHeight: maxHeight??MediaQuery.of(context).size.height*3/4,
          maxWidth: maxWidth??MediaQuery.of(context).size.width,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: headerHeight??Dimens.size40,
              decoration: BoxDecoration(
                color: headerColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    width: 40,
                    height: 40,
                  ),
                  Expanded(
                      child: Text(
                        title??"",
                        textAlign: TextAlign.center,
                        style: TextStyleConstant.normalTextOnBackGroundColorStyle16w600.copyWith(
                            color: defaultTitleColor),)
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: defaultTitleColor,
                        size: Dimens.size20,
                      ),
                    ),
                  )
                ],
              ),
            ),
            child
          ],
        ),
      ),
    );
  }

  static Future<void> show(
      {
        required BuildContext context,
        required Widget child,
        String? title,
        double? width,
        double? height,
        double?maxHeight,
        double?maxWidth,
        double? headerHeight,
        bool? barrierDismissible,
        AlignmentGeometry? alignment
      })async {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible??true,
        useRootNavigator: false,
        builder: (BuildContext context) {
          return CommonDialog(
            height: height,
            width: width,
            title: title,
            maxHeight: maxHeight,
            maxWidth: maxWidth,
            headerHeight: headerHeight,
            alignment: alignment,
            child: child,
          );
        });

}
}
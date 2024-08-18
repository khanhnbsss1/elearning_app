import 'package:flutter/cupertino.dart';
import 'package:webkit/base/base.export.dart';

class StaticView{
  static Widget buildLogo({double? size}){
    size??=Dimens.size40;
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {  
        return SizedBox(
          width: size,
          height: size,
          child: Padding(
            padding:  EdgeInsets.all(Dimens.size8),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size!/2),
                  color: ColorConst.whiteColor
              ),
              clipBehavior: Clip.hardEdge,
              child: ImageManager().getPngImage(ImageManager.logo),
            ),
          ),
        );
      },
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:webkit/base/base.export.dart';

class StaticView{
  static Widget buildLogo({double? size = 35}){
    size??35;
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {  
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.size30),
                color: ColorConst.whiteColor
            ),
            clipBehavior: Clip.hardEdge,
            child: ImageManager().getPngImage(ImageManager.logo, height: size,),
          ),
        );
      },
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:webkit/base/base.export.dart';

class StaticView{
  static Widget buildLogo({double? size = 35}){
    size??35;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.size30),
          color: ColorConst.primaryColor
      ),
      clipBehavior: Clip.hardEdge,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0),
        child: ImageManager().getPngImage(ImageManager.logo, height: size),
      ),
    );
  }
}
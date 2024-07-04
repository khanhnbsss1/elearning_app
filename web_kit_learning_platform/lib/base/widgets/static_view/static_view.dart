import 'package:flutter/cupertino.dart';
import 'package:webkit/base/base.export.dart';

class StaticView{
  static Widget buildLogo(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.size30),
          color: Color(0xF4930202)
      ),
      clipBehavior: Clip.hardEdge,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0),
        child: ImageManager().getPngImage(ImageManager.logo, height:Dimens.size35 ),
      ),
    );
  }
}
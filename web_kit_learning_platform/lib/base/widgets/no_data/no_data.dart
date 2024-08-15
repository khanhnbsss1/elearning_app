import 'package:webkit/base/base.export.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
class NoData extends StatelessWidget {

  String? title;
  double? height;
  double? size;
  TextAlign? textAlign;
  Widget? icon;
   NoData({super.key, this.title, this.height,this.size, this.textAlign, this.icon});

  @override
  Widget build(BuildContext context) {
    title??= L10nX.of().getStringByKey("no_search_result");
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
              height: height,
              child: SizedBox(
                width: size?? Dimens.size80,
                  height: size?? Dimens.size80,
                  child: icon??Icon(Icons.note_alt_outlined, size: size?? Dimens.size80,))),
           Gap(Dimens.size16),
          Text(
              title!,
              textAlign: textAlign??TextAlign.center,
              style: TextStyleConstant.normalTextOnBackGroundColorStyle14w400),
        ],
      ),
    );
  }

}
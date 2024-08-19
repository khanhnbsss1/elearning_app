import 'package:flutter/material.dart';
import 'package:lms_app/base/base.export.dart';
class NoData extends StatelessWidget {

  String? title;
  double? height;
  double? width;
  TextAlign? textAlign;
   NoData({super.key, this.title, this.height,this.width, this.textAlign});

  @override
  Widget build(BuildContext context) {
    title??= L10nX.of(context).getStringByKey("no_search_result");
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width,
              height: height,
              child: Image.asset(ImagesNameConst.getPngImage(ImagesNameConst.icNoData))),
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
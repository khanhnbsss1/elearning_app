
import 'package:lms_app/base/base.export.dart';
import 'package:flutter/material.dart';
class NotifyDialog2 extends StatelessWidget {
  final String title, content, textButton;

  const NotifyDialog2({
    super.key,
    required this.title,
    required this.content,
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      insetPadding:  EdgeInsets.symmetric(horizontal: Dimens.size10),
      child: dialogContent(context, title, content, textButton),
    );
  }
}

dialogContent(BuildContext context,String title,  String content, String textButton) {
  Size size = MediaQuery.of(context).size;

  return Container(
    width: ResponsiveInfo.isTablet() ? size.width * 0.4 : size.width * 0.95,
    padding:  EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: ColorConst.whiteColor,
      shape: BoxShape.rectangle,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0)),
      boxShadow: [
        BoxShadow(
          color: ColorConst.blackColor26,
          blurRadius: 10.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // To make the card compact
      children: [
        Text(
          title,
          style: baseStyle.copyWithCustom(
              fontSize: Dimens.size20, color: Colors.red),
        ),
        const SizedBox(
          height: 5,
        ),
        Divider(
          thickness: 1,
          color: ColorConst.dividerColor,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          content,
          style: TextStyleConstant.normalTextOnBackGroundColorStyle16w400,
        ),
        const SizedBox(
          height: 15,
        ),
        RoundedButton(
          text: textButton,
          bgColor: ColorConst.mainColor,
          fontSize: Dimens.size17,
          height: Dimens.size45,
          press: (){
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';

class BackButtonCustom extends StatelessWidget{
  BuildContext buildContext;
  Function()? onTap;
  Color? color;
  double? width;
  bool? enableBackground;
  BackButtonCustom({super.key, required this.buildContext, this.onTap, this.color, this.width, this.enableBackground}){
   enableBackground??=false;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child:SizedBox(
        width: width??(Dimens.size30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Dimens.size30,
              height: Dimens.size30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.size20),
                  color: (enableBackground??false)?ColorConst.whiteColor: Colors.transparent
              ),
              alignment: Alignment.center,
              child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: Dimens.size15,
                  color: color??ColorConst.blackColor
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if(onTap!=null)
          {
            onTap!();
          }
        else
          {
            Navigator.maybePop(context);// Constant.backToPrev(buildContext);
          }
      },
    );
  }

}

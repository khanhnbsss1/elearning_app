import 'package:lms_app/base/base.export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  /// This [ToastUtils] for show snackbar message event
  ///
  /// The [showToastSuccess]
  ///
  /// The [showSnackBar]
  ///
  /// The [showToast]
  ///
  /// The [showToastError]
  ToastUtils();

  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorConst.blackColor,
       textColor: ColorConst.whiteColor,
        fontSize: 16.0);
  }

  static showSnackBar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  /// The [showToastSuccess] show message with success event
  ///
  /// Params [msg] msg for show, [position] [ToastGravity] position show msg, [inTime] [Toast] time for show
  static Future<bool?> showToastSuccess(String msg,
      {position = ToastGravity.BOTTOM, inTime = Toast.LENGTH_LONG, timeShow = 3}) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: inTime,
        gravity: position,
        timeInSecForIosWeb: timeShow,
        backgroundColor: Colors.green,
       textColor: ColorConst.whiteColor,
        fontSize: 16.0);
  }

  /// The [showToastError] show message with error event
  ///
  /// Params [msg] msg for show, [position] [ToastGravity] position show msg, [inTime] [Toast] time for show
  static Future<bool?> showToastError(String msg,
      {
        ToastGravity position = ToastGravity.TOP,
      Toast inTime = Toast.LENGTH_LONG
      }) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: inTime,
        gravity: position,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red, textColor: ColorConst.whiteColor,
        fontSize: 16.0);
  }


  static showToastIcon({required BuildContext context,required String mes,ToastType? toastType=ToastType.NORMAL}) {
    FToast().init(context).showToast(
        child: Container(
          width: Dimens.size343,
          // height: DimensHeight.size36,
          padding: EdgeInsets.symmetric(horizontal: Dimens.size11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.size4),
            color: getBackground(toastType),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getIcon(toastType),
              Padding(
                padding:  EdgeInsets.all(Dimens.size10),
                child: Text(mes,style: getMesStyle(toastType),),
              ),
            ],
          ),
        ),
        toastDuration: const Duration(seconds: 2),
        gravity: ToastGravity.TOP,
        positionedToastBuilder: (context,widget){
          return Positioned(
              top: ResponsiveInfo.isTablet() ? Dimens.size32 : Dimens.size56,
              left: Dimens.size16,
              right: Dimens.size16,
              child: widget);
        }

    );
  }



  static Color getBackground(ToastType? toastType){
    if(toastType==null || toastType ==ToastType.NORMAL){
      return ColorConst.blackColor12;
    }else if(toastType== ToastType.ERROR){
      return ColorConst.bgToastError;
    }
    return ColorConst.bgToastSuccess;
  }static Widget getIcon(ToastType? toastType){
    if(toastType==null || toastType ==ToastType.NORMAL){
      return SvgPicture.asset(ImagesNameConst.getSvgImage(ImagesNameConst.ic_success));
    }else if(toastType== ToastType.ERROR){
      return SvgPicture.asset(ImagesNameConst.getSvgImage(ImagesNameConst.ic_error));
    }
    return SvgPicture.asset(ImagesNameConst.getSvgImage(ImagesNameConst.ic_success));
  }

  static TextStyle getMesStyle(ToastType? toastType){
    if(toastType==null || toastType ==ToastType.NORMAL){
      return typeNormal;
    }else if(toastType== ToastType.ERROR){
      return typeError;
    }
    return typeSuccess;
  }

  static final typeSuccess=baseStyle.copyWithCustom(
    color: ColorConst.colorTextRadioButton,
    fontWeight: FontWeight.w400,
    fontSize: Dimens.size22,
  );
  static final typeNormal=baseStyle.copyWithCustom(
    color: ColorConst.colorTextRadioButton,
    fontWeight: FontWeight.w400,
    fontSize: Dimens.size22,
  );
  static final typeError=baseStyle.copyWithCustom(
    color: ColorConst.whiteColor,
    fontWeight: FontWeight.w400,
    fontSize: Dimens.size22,
  );
}
enum ToastType{NORMAL,SUCCESS,ERROR}

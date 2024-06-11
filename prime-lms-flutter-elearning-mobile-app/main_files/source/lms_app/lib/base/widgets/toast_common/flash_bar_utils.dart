import 'package:lms_app/base/base.export.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum FlashBarType { NORMAL, SUCCESS, ERROR }

class FlashBarUtils {
  static void showTopFlash(
      {
        required BuildContext context,
      required String message,
      FlashBarType? flashType = FlashBarType.NORMAL}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 2),
      persistent: true,
      builder: (_, controller) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: Dimens.size16),
          child: Flash(
            controller: controller,
            position: FlashPosition.top,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getIcon(flashType),
                  SizedBox(width: Dimens.size10,),
                  Flexible(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: _getMesStyle(flashType),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Color _getBackground(FlashBarType? toastType) {
    if (toastType == null || toastType == FlashBarType.NORMAL) {
      return ColorConst.blackColor12;
    } else if (toastType == FlashBarType.ERROR) {
      return ColorConst.bgToastError;
    }
    return ColorConst.bgToastSuccess;
  }

  static Widget _getIcon(FlashBarType? toastType) {
    if (toastType == null || toastType == FlashBarType.NORMAL) {
      return SvgPicture.asset(
          ImagesNameConst.getSvgImage(ImagesNameConst.ic_success));
    } else if (toastType == FlashBarType.ERROR) {
      return SvgPicture.asset(ImagesNameConst.getSvgImage(ImagesNameConst.ic_ban));
    }
    return SvgPicture.asset(ImagesNameConst.getSvgImage(ImagesNameConst.ic_success));
  }

  static TextStyle _getMesStyle(FlashBarType? toastType) {
    if (toastType == null || toastType == FlashBarType.NORMAL) {
      return typeNormal;
    } else if (toastType == FlashBarType.ERROR) {
      return typeError;
    }
    return typeSuccess;
  }

  static final typeSuccess =baseStyle.copyWithCustom(
    color: ColorConst.colorTextRadioButton,
    fontWeight: FontWeight.w400,
    fontSize: ResponsiveInfo.isTablet()? Dimens.size16 : Dimens.size14,
  );
  static final typeNormal =baseStyle.copyWithCustom(
    color: ColorConst.colorTextRadioButton,
    fontWeight: FontWeight.w400,
    fontSize: ResponsiveInfo.isTablet()? Dimens.size16 : Dimens.size14,
  );
  static final typeError =baseStyle.copyWithCustom(
    color: ColorConst.nameRoomAvailable.withOpacity(0.85),
    fontWeight: FontWeight.w400,
    fontSize: ResponsiveInfo.isTablet()? Dimens.size16 : Dimens.size14,
  );
}

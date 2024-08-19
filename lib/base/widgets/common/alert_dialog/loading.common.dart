import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:flutter/material.dart';

import 'loading_logo.dart';

class MonitorLoading implements ILoading {
  static final MonitorLoading _instance = MonitorLoading._internal();

  factory MonitorLoading() {
    return _instance;
  }

  MonitorLoading._internal();

  @override
  void dismiss() {
    EasyLoading.dismiss();
  }

  @override
  void showLoading(String? message) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 60
      ..textColor = ColorConst.blackColor
      ..radius = 20
      ..backgroundColor = Colors.transparent
      ..maskColor = Colors.transparent
      ..indicatorColor = ColorConst.blackColor54
      ..userInteractions = false
      ..dismissOnTap = true
      ..boxShadow = <BoxShadow>[]
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid;

    EasyLoading.show(
      // status: message,
      indicator: LoadingLogo(
        title: message ?? "",
        textSize: Dimens.size14,
        assetImage: ImagesNameConst.getPngImage(ImagesNameConst.icLoading),
        sizeImage: Dimens.size60,
      ),
    );
  }

  OverlayEntry? showOverLayDialogByPostion(BuildContext context, double left, double top,String? message){
    OverlayState? overlayStateForSearchBox = Overlay.of(context);
    OverlayEntry? overlayEntryForSearchBox = OverlayEntry(builder: (context) {
      return Positioned(
        left: left,//MediaQuery.of(context).size.width * 0.1,
        top: top,
        child: LoadingLogo(
          title: message ?? "",
          textSize: Dimens.size14,
          assetImage: ImagesNameConst.getPngImage(ImagesNameConst.icLoading),
          sizeImage: Dimens.size60,
        ),
      );
    });
    // inserting overlay entry
    overlayStateForSearchBox.insert(overlayEntryForSearchBox);
    return overlayEntryForSearchBox;
  }
  @override
  void showError(String message) {
    EasyLoading.showError(message);
  }

  @override
  void showInfo(String message) {
    EasyLoading.showInfo(message);
  }

  @override
  void showProgress(String? message, double? progress) {
    EasyLoading.showProgress(progress ?? 0, status: message);
  }

  @override
  void showSuccess(String message) {
    EasyLoading.showSuccess(message);
  }

  @override
  void showToast(String message) {
    EasyLoading.showToast(message);
  }
}

abstract class ILoading {
  void showLoading(String? message);

  void dismiss();

  void showProgress(String? message, double? progress);

  void showSuccess(String message);

  void showError(String message);

  void showInfo(String message);

  void showToast(String message);
}


import 'package:lms_app/base/base.export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../instance_mananger/instance_mananger.dart';
import 'loading.common.dart';
class NotifyDialog {
  static List<BuildContext>showContextList = List.empty(growable: true);
  static bool isShowingDialog = false;
  static int countTimeShowDialogButton = 0;
  static void showDialogButtonWithMessageKeys({
        String ? keyTitle,
        String? descriptionKey,
        String? buttonTextKey})
  {
    BuildContext dialogContext = InstanceManager.getInstance.navigatorKey.currentState!.context;
    String titleStr = (keyTitle!=null&& keyTitle.isNotEmpty)?L10nX.of(dialogContext).getStringByKey(keyTitle):"";
    String description = (descriptionKey!=null&& descriptionKey.isNotEmpty)?L10nX.of(dialogContext).getStringByKey(descriptionKey):"";
    String buttonText = (buttonTextKey!=null&& buttonTextKey.isNotEmpty)?L10nX.of(dialogContext).getStringByKey(buttonTextKey):"";
    showDialogOneButton(title: titleStr, description: description, buttonText: buttonText);
  }
  static void showDialogOneButton(
      {BuildContext? context, String? title,
      String? description, String? buttonText}) {
    if(isShowingDialog) {
      return;
    }
    isShowingDialog = true;
    String buttonText0 = "OK";
    BuildContext? dialogContext;
    if(context!=null){
      dialogContext = context;
    }
    else
      {
        dialogContext = InstanceManager.getInstance.navigatorKey.currentState!.context;
      }
    if(buttonText==null || buttonText.isEmpty) {
      buttonText0 = S.of(dialogContext).str_accept;
    } else {
      buttonText0 = buttonText;
    }
    // set up the button
    Widget okButton = TextButton(
      style: ButtonStyle(
        backgroundColor:  MaterialStateProperty.resolveWith((states) {
          // If the button is pressed, return green, otherwise blue
          return ColorConst.mainColor;
        }),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
            buttonText0,
          style: TextStyleConstant.textStyleWhite15w500
        ),
      ),
      onPressed: () {
        isShowingDialog = false;
        Navigator.pop(dialogContext!);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Text(
          title??"",
        style: TextStyleConstant.textStyleBlack13w500,
      ),

      content: Text(
          description??"",
        textAlign: TextAlign.center,
        style: TextStyleConstant.textStyleBlack13w400,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            okButton,
          ],
        )

      ],
    );
    showDialog(
      context: dialogContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
        return alert;
      },
    );
  }

  static void showOnLoadingBase(String content,{BuildContext? mainContext}) {
    MonitorLoading().showLoading(content);
  }

  static void hideOnLoadingBase(ValueSetter<bool> hideLoadingCallback) {
    MonitorLoading().dismiss();
  }

  static void showOnLoadingEasyloading(
      BuildContext mainContext, String content) {
    EasyLoading.init();
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.fadingCircle;
    EasyLoading.show(
      status: content,
    );
  }

  static void hideOnLoadingEasyloading() {
    EasyLoading.dismiss();
  }
}

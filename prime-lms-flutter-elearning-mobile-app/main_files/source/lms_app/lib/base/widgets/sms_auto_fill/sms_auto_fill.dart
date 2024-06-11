import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../base.export.dart';

/// This is the basic usage of Pinput
/// For more examples check out the demo directory
class SMSAutoFill extends StatefulWidget {

  final Function(String) ?onSubmit;
  final Function(String) ?onChange;
  String? initText = "";
  bool? obscureText = false;
  SMSAutoFill({super.key, this.onSubmit, this.onChange, this.initText, this.obscureText});

  @override
  State<SMSAutoFill> createState() => _SMSAutoFillState();
}

class _SMSAutoFillState extends State<SMSAutoFill> {
  TextEditingController pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    pinController.dispose();
    focusNode.unfocus();
    focusNode.dispose();
    super.dispose();
  }
  @override
  void initState() {
    focusNode.requestFocus();
    pinController = TextEditingController(text: widget.initText);
    if(widget.initText?.length == 6)
    {
      if(widget.onSubmit!=null)
      {
        widget.onSubmit!(widget.initText!);
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (buildContext, boxConstraints){
          Color focusedBorderColor = const Color(0xFF1A1F31).withOpacity(0.15);
           Color fillColor = ColorConst.bgSettingButtonColor;
          Color borderColor =  const Color(0xFF1A1F31).withOpacity(0.15);
          double size = [ boxConstraints.maxHeight,  boxConstraints.maxWidth/6 -10,].reduce(min);
          final defaultPinTheme = PinTheme(
            width: size,
            height: size,
            textStyle: TextStyle(
              fontSize: 22,
              color: ColorConst.blackColor,
            ),
            decoration: BoxDecoration(
              color: ColorConst.bgSettingButtonColor,
              borderRadius:  BorderRadius.all(Radius.circular(size/2)),
              border: Border.all(color: borderColor),
            ),
          );

          /// Optionally you can use form to validate the Pinput
          return Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Directionality(
                    // Specify direction if desired
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      length: 6,
                      controller: pinController,
                      focusNode: focusNode,
                      //androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                      //listenForMultipleSmsOnAndroid: true,
                      autofocus: false,
                      defaultPinTheme: defaultPinTheme,

                      obscureText: widget.obscureText??false,
                      validator: (value) {
                        return null;
                      },
                      // onClipboardFound: (value) {
                      //   FileUtils.PrintLog('onClipboardFound: $value');
                      //   pinController.setText(value);
                      // },
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        FileUtils.PrintLog('onCompleted: $pin');
                        focusNode.unfocus();
                        if(widget.onSubmit!=null)
                          {
                            widget.onSubmit!(pin);
                          }
                      },
                      onChanged: (value) {
                        FileUtils.PrintLog('onChanged: $value');
                        if(widget.onChange!=null)
                        {
                          widget.onChange!(value);
                        }
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: ColorConst.progressColor,
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(
                            color: borderColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );

  }
}
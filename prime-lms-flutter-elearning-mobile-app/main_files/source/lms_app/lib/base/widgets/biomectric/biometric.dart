import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/helper/auth.dart';
import 'package:lms_app/base/widgets/widgets.export.dart';

import 'button_biometric.dart';

class BiometricAuthentication extends StatelessWidget {

  final GestureTapCallback press;
  double ?biometricSize;
  BiometricAuthentication({
    super.key, required this.press,
    this.biometricSize
  }){
    biometricSize??=Dimens.size50;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder(
          // 1. Thực hiện kiểm tra device có hỗ trợ FaceID hoặc vân tay hay không.
          // Nếu có thì show icon, ngược lại ẩn
          future: AuthService.inforSupportAuthentication(),
          builder: (context, snap){
            if (snap.hasData){
              InfoBiometric data = snap.data as InfoBiometric;
              if(data.canAuthen??false){
               return buildIconBiometric(data);
              }
              else
                {
                  IdentifierConst.biometricType = BiometricTypeDevice.none;
                  return ButtonBiometric(
                    biometricSize: biometricSize,
                    icon:Image.asset(
                      ImagesNameConst.getPngImage(ImagesNameConst.ic_biometric),
                      color: ColorConst.mainColor,
                      width:  biometricSize,
                      height:  biometricSize,
                    ),
                    press: (){

                    },
                  );
                }
            } else {
              IdentifierConst.biometricType = BiometricTypeDevice.none;
              return ButtonBiometric(
                biometricSize: biometricSize,
                icon: Image.asset(
                  ImagesNameConst.getPngImage(
                    ImagesNameConst.ic_biometric),
                  width: biometricSize,
                  height:  biometricSize,
                ),
                press: (){

                },
              );
            }
          },
        ),
      ],
    );
  }

  Widget buildIconBiometric(data) {
    if (data.biometricTypes.length > 0){
/*      return ButtonBiometric(
        biometricSize: biometricSize,
        icon: Image.asset(
          ImagesNameConst.getPngImage(
              ImagesNameConst.ic_biometric),
          color: ColorLightConst.mainColor,
          width: biometricSize!=null?biometricSize!:Dimens.size50,
          height: biometricSize!=null?biometricSize!:Dimens.size50,
        ),
        press: press,
      );*/
      if (!Platform.isAndroid) {
        if (data.biometricTypes.contains(BiometricType.fingerprint)){
          IdentifierConst.biometricType = BiometricTypeDevice.fingerprint;
          return ButtonBiometric(
            biometricSize: biometricSize,
            icon: Icon (
              Icons.fingerprint,
              color: ColorConst.mainColor,
              size: biometricSize,
            ),
            press: press,
          );
        } else if (data.biometricTypes.contains(BiometricType.face)){
          IdentifierConst.biometricType = BiometricTypeDevice.face;
          return ButtonBiometric(
            biometricSize: biometricSize,
            icon: Image.asset(
              ImagesNameConst.getPngImage(
                  ImagesNameConst.ic_biometric),
                  color: ColorConst.mainColor,
                  width: biometricSize,
                  height: biometricSize,
            ),
            press: press,
          );
        } else {
          IdentifierConst.biometricType = BiometricTypeDevice.none;
          return ButtonBiometric(
            biometricSize: biometricSize,
            icon: Image.asset(
              ImagesNameConst.getPngImage(
                  ImagesNameConst.ic_biometric),
              color: ColorConst.mainColor,
              width: biometricSize,
              height: biometricSize,
            ),
            press: press,
          );
        }
      } else {
        // Trường hợp máy có cả vân tay và faceid nhưng chỉ bật faceid
        if (data.biometricTypes.length == 1 && data.biometricTypes.contains(BiometricType.weak)){
          IdentifierConst.biometricType = BiometricTypeDevice.face;
          return ButtonBiometric(
            biometricSize: biometricSize,
            icon: Image.asset(ImagesNameConst.getPngImage(
                ImagesNameConst.ic_face_id),
              color: ColorConst.mainColor,
              width: biometricSize!=null?biometricSize!:Dimens.size50,
              height: biometricSize!=null?biometricSize!:Dimens.size50,
            ),
            press: press,
          );
        }
        // Trường hợp máy có cả vân tay và faceid nhưng chỉ bật vân tay hoặc cả 2 thì ưu tiên hiển thị vân tay
        if (data.biometricTypes.contains(BiometricType.strong) || data.biometricTypes.contains(BiometricType.weak)){
          IdentifierConst.biometricType = BiometricTypeDevice.fingerprint;
          return ButtonBiometric(
            biometricSize: biometricSize,
            icon: Icon (
              Icons.fingerprint,
              color: ColorConst.mainColor,
              size: biometricSize!=null?biometricSize!:Dimens.size50,
            ),
            press: press,
          );
        } else {
          IdentifierConst.biometricType = BiometricTypeDevice.none;
          return ButtonBiometric(
            biometricSize: biometricSize,
            icon: Image.asset(
              ImagesNameConst.getPngImage(
                  ImagesNameConst.ic_biometric),
              color: ColorConst.mainColor,
              width: biometricSize,
              height: biometricSize,
            ),
            press: press,
          );
        }
      }
    } else {
      IdentifierConst.biometricType = BiometricTypeDevice.none;
      return const SizedBox.shrink();
    }
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/store/store.exports.dart';

class OptionBiometric extends StatefulWidget {

  const OptionBiometric({super.key});

  @override
  State<OptionBiometric> createState() => _OptionBiometricState();
}

class _OptionBiometricState extends State<OptionBiometric> {

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return  Visibility(
      visible: IdentifierConst.biometricType != BiometricTypeDevice.none,
      child: Row(
        children: [
          getIconBiometric(context),
           SizedBox(width: Dimens.size5),
          Text(
              getTitleBiometric(context),
              style: baseStyle.copyWithCustom(
                fontSize: Dimens.size14,
                color: ColorConst.blackColor,
              )),
          const Spacer(),
          buildCustomSwitch(context)
        ],
      )
    );
  }

  FutureBuilder<Object?> buildCustomSwitch(BuildContext context) {
    return FutureBuilder(
        future: _checkEnableBiometric(),
        builder: (context, snapData){
          if (snapData.hasData){
            return SizedBox(
              width: 50,
              height: 32,
              child: FittedBox(
                fit: BoxFit.fill,
                child: CupertinoSwitch(
                  activeColor: ColorConst.mainColor,
                  value: status,
                  onChanged: (value) async {
                    // Nếu value = true thực hiện lưu lại password của user đang đăng nhập và on biometric
                    // Nếu value = false thực hiện xóa password
                    if (value){
                      // 1. Thực hiện lưu lại mật khẩu của user đăng nhập sau khi on tính năng
                      SecureStorage.saveValue(IdentifierConst.username, IdentifierConst.password);
                      // 2. Thực hiện lưu lại trạng thái để không show popup fingerprint/faceid nữa
                      DataAccess.saveBiometricPopupStatus(IdentifierConst.username, false);
                    } else {
                      // 2. Xóa mật khẩu và hủy quyền đăng nhập vân tay/faceID
                      SecureStorage.deleteValueAll();
                    }
                    setState(() {
                      status = value;
                    });
                  },
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
  String getTitleBiometric(context) {
    if (IdentifierConst.biometricType == BiometricTypeDevice.fingerprint){
      return S.of(context).title_popup_fingerprint;
    } else if (IdentifierConst.biometricType == BiometricTypeDevice.face){
      return S.of(context).title_popup_faceid;
    }
    return "";
  }

  Widget getIconBiometric(BuildContext context) {
    if (IdentifierConst.biometricType == BiometricTypeDevice.fingerprint){
      return  Icon (
        Icons.fingerprint,
        size: Dimens.size35,
        color: ColorConst.mainColor,
      );
    } else if (IdentifierConst.biometricType == BiometricTypeDevice.face){
      return Row(
        children: [
          SvgPicture.asset(
            ImagesNameConst.getSvgImage(ImagesNameConst.ic_face_id),
            color: ColorConst.mainColor,
            width: Dimens.size30,
            height: Dimens.size30,
          ),
          const SizedBox(width: 5)
        ],
      );
    }
    return const SizedBox.shrink();
  }


  Future<bool> _checkEnableBiometric() async {
    // Thực hiện kiểm tra xem account này đã bật tính năng vân tay hay chưa???
    String pass = await SecureStorage.readValue(IdentifierConst.username);
    status = pass.isNotEmpty;
    return status;
  }
}
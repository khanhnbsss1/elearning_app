
import 'package:flutter/material.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/store/store.exports.dart';
import 'package:lms_app/base/widgets/common/alert_dialog/notify_dialog2.dart';
import 'package:lms_app/base/widgets/dialog_common/common_dialog1.dart';
import 'package:lms_app/base/widgets/dialog_common/custom_bottom_sheet.dart';

import 'biometric.dart';

class BiometricHandler{
  static final BiometricHandler _singletonBiometricHandler = BiometricHandler._internal();
  static BiometricHandler get getInstance => _singletonBiometricHandler;
  factory BiometricHandler() {
    return _singletonBiometricHandler;
  }
  BiometricHandler._internal();

  Future<void> showBiometricNeedSettingDialog(BuildContext context) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return NotifyDialog2(
            title: S.of(context).notify_lable,
            content: getContentDialog(context),
            textButton: S.of(context).button_close,
          );
        });
  }
  Future<void> showBiometricNeedSettingDialogNewDesign(BuildContext context, {bool? isGotoSetting}) async {
    if(!ResponsiveInfo.isTablet()){
      CustomBottomSheet(
          height: MediaQuery.of(context).size.height*1/3,
          borderRadius:   BorderRadius.only(
              topLeft: Radius.circular(Dimens.size15),
              topRight: Radius.circular(Dimens.size15)),
          childContent: buildBiometricSettingNewDesign(context, isGotoSetting: isGotoSetting)
      ).show(context);
    }
    else
    {
      CustomDialog1(
          canBackdrop: false,
          radius: Dimens.size8,
          width: MediaQuery.of(context).size.width*0.6,
          height: MediaQuery.of(context).size.height*0.5,
          child: buildBiometricSettingNewDesign(context, isGotoSetting: isGotoSetting)
      ).show(context);
    }

  }
  Widget buildBiometricSettingNewDesign(BuildContext context, {bool? isGotoSetting}){
    isGotoSetting??=true;
    double titleSize = ResponsiveInfo.isTablet()?Dimens.size20:Dimens.size16;
    double contentSize = ResponsiveInfo.isTablet()?Dimens.size14:Dimens.size16;

    return Container(
        width: ResponsiveInfo.isTablet()?MediaQuery.of(context).size.width*0.6:MediaQuery.of(context).size.width,
        height: ResponsiveInfo.isTablet()?MediaQuery.of(context).size.height*1/3:MediaQuery.of(context).size.height*0.4,
        decoration: BoxDecoration(
          color: ColorConst.whiteColor,
          borderRadius: BorderRadius.circular(
            Dimens.size16,
          ),
        ),
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width/3,
          minHeight: 150,
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: !ResponsiveInfo.isTablet()?Dimens.size50:Dimens.size64,
                decoration: BoxDecoration(
                  color: ColorConst.mainColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Dimens.size16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 1,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: ResponsiveInfo.isTablet()?Dimens.size40:Dimens.size22, vertical: Dimens.size8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  S.of(context).title_popup_biometric,
                                  style:baseStyle.copyWithCustom(
                                      fontSize: titleSize,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConst.whiteColor,
                                      fontFamily: TextStyleConstant.fontFamily)),
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Icon(
                                  Icons.close,
                                  size: Dimens.size15,
                                  color: ColorConst.whiteColor,)
                                ),
                              ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: ColorConst.dividerColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:ResponsiveInfo.isTablet()?Dimens.size40:Dimens.size22, vertical: Dimens.size1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BiometricAuthentication(
                      press: () async {
                      },
                      biometricSize:  ResponsiveInfo.isTablet()?Dimens.size100:Dimens.size80,
                    ),
                    Gap(10),
                    Text(
                      S.of(context).header_popup_biometric,
                      textAlign: TextAlign.center,
                      style:baseStyle.copyWithCustom(
                          fontSize: contentSize,
                          fontWeight: FontWeight.w400,
                          color: ColorConst.subtext,
                          fontFamily: TextStyleConstant.fontFamily
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:ResponsiveInfo.isTablet()?Dimens.size40:Dimens.size22, vertical: Dimens.size16),
                child: SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        flex:1,
                        child: RoundedButton(
                          text:  S.of(context).setting_text,
                          bgColor: ColorConst.mainColor,
                          fontSize: Dimens.size14,
                          height: Dimens.size45,
                          press: (){
                            if(isGotoSetting!=null && isGotoSetting==true)
                            {

                            }
                            else{
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex:1,
                        child: RoundedButton(
                          text:  S.of(context).string_cancel,
                          bgColor: ColorConst.mainColor.withOpacity(0.2),
                          textColor: ColorConst.mainColor,
                          fontSize: Dimens.size14,
                          height: Dimens.size45,
                          width: ResponsiveInfo.isTablet()?Dimens.size100:null,
                          press: (){
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]));
  }

  String getContentDialog(BuildContext context) {
    if (IdentifierConst.biometricType == BiometricTypeDevice.fingerprint){
      return S.of(context).notify_setup_fingerprint;
    } else if (IdentifierConst.biometricType == BiometricTypeDevice.face){
      return S.of(context).notify_setup_faceid;
    }
    return S.of(context).notify_setup_biometric;
  }
  Future<bool> checkHasSettingBiometric() async {
    //SecureStorage.saveValue(IdentifierConst.username, IdentifierConst.password);
    /// neu co setting Biometric, userName va password se duoc luu
    String password = await SecureStorage.readValue(IdentifierConst.username,);
    return password.isNotEmpty;

  }
  Future<void> settingActiveBiometric(bool isActive) async {
    //SecureStorage.saveValue(IdentifierConst.username, IdentifierConst.password);
    /// neu co setting Biometric, userName va password se duoc luu
    if(isActive){
      // 1. Thực hiện lưu lại mật khẩu của user đăng nhập sau khi on tính năng
      SecureStorage.saveValue(IdentifierConst.username, IdentifierConst.password);
      // 2. Thực hiện lưu lại trạng thái để không show popup fingerprint/faceid nữa
      DataAccess.saveBiometricPopupStatus(IdentifierConst.username, false);
    }
    else
      {
        // 2. Xóa mật khẩu và hủy quyền đăng nhập vân tay/faceID
        SecureStorage.deleteValueAll();
      }

  }
  Future<bool> getSettingActiveBiometric() async {
    String password = await SecureStorage.readValue(IdentifierConst.username);
    return password.isNotEmpty;
  }
  
  String getTitleBiometric(context) {
    if (IdentifierConst.biometricType == BiometricTypeDevice.fingerprint){
      return S.of(context).title_popup_fingerprint;
    } else if (IdentifierConst.biometricType == BiometricTypeDevice.face){
      return S.of(context).title_popup_faceid;
    }
    return S.of(context).title_popup_biometric;
  }
  Widget getIconBiometric(BuildContext context,{bool? isActive, double ?iconSize}) {
    isActive??=true;
    Color inativeColor = ColorConst.greyColor1;
    if (IdentifierConst.biometricType == BiometricTypeDevice.fingerprint){
      return Icon (
        Icons.fingerprint,
        size: iconSize??Dimens.size25,
        color: isActive?ColorConst.mainColor:inativeColor,
      );
    } else if (IdentifierConst.biometricType == BiometricTypeDevice.face){
      return
          Image.asset(
            ImagesNameConst.getPngImage(ImagesNameConst.ic_face_id),
            width: iconSize??Dimens.size25,
            color:isActive?ColorConst.mainColor:inativeColor,
            height: iconSize??Dimens.size25,
          );
    }
    return Image.asset(
      ImagesNameConst.getPngImage(ImagesNameConst.ic_biometric),
      width: iconSize??Dimens.size25,
      color: isActive?ColorConst.mainColor:inativeColor,
      height: iconSize??Dimens.size25,
    );
  }

}
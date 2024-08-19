import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lms_app/theme/text_stype_constant.dart';

import '../base/store/cache_storage.dart';
import 'colors_app_light.dart';
import 'colors_app_night.dart';
export 'color_extentions.dart';
class ColorConst{
  static bool? isDarkMode;
  static Color backGroundColor = getLightMode()?ColorLightConst.backGroundColor:ColorNightConst.backGroundColor;
  static Color primaryColor = getLightMode()?ColorLightConst.primaryColor:ColorNightConst.primaryColor;
  static Color mainColor = primaryColor;
  static Color mainColorWithOpacity50 = mainColor.withOpacity(0.5);
  static Color iconColor = getLightMode()?ColorLightConst.iconColor:ColorNightConst.iconColor;
  static Color buttonbgColor = getLightMode()?ColorLightConst.buttonbgColor:ColorNightConst.buttonbgColor;
  static Color homeBg =  getLightMode()?ColorLightConst.homeBg:ColorNightConst.homeBg;
  static Color bgColor =  getLightMode()?ColorLightConst.bgColor:ColorNightConst.bgColor;
  static Color bgColor2 =  getLightMode()?ColorLightConst.bgColor2:ColorNightConst.bgColor2;
  static Color textColorOnMainButton =   getLightMode()?ColorLightConst.textColorOnMainButton:ColorNightConst.textColorOnMainButton;
  static Color buttonColor =  getLightMode()?ColorLightConst.buttonColor:ColorNightConst.buttonColor;
  static Color textColor =   getLightMode()?ColorLightConst.textColor:ColorNightConst.textColor;
  static Color subtext = getLightMode()?ColorLightConst.subtext:ColorNightConst.subtext;
  static Color shadowColor =  getLightMode()?ColorLightConst.shadowColor:ColorNightConst.shadowColor;
  static Color borderColor =  getLightMode()?ColorLightConst.borderColor:ColorNightConst.borderColor;
  static Color progressColor =  getLightMode()?ColorLightConst.progressColor:ColorNightConst.progressColor;
  static Color containerShadow =  getLightMode()?ColorLightConst.containerShadow:ColorNightConst.containerShadow;
  static Color whiteColor =  getLightMode()?ColorLightConst.whiteColor:ColorNightConst.whiteColor;
  static Color whiteColor70 = getLightMode()?ColorLightConst.whiteColor70:ColorNightConst.whiteColor70;
  static Color whiteColor10 = getLightMode()?ColorLightConst.whiteColor10:ColorNightConst.whiteColor10;
  static Color blackColor =  getLightMode()?ColorLightConst.blackColor:ColorNightConst.blackColor;
  static Color blackColor26 =  getLightMode()?ColorLightConst.blackColor26:ColorNightConst.blackColor26;
  static Color blackColor54 =  getLightMode()?ColorLightConst.blackColor54:ColorNightConst.blackColor54;
  static Color blackColor12 =  getLightMode()?ColorLightConst.blackColor12:ColorNightConst.blackColor12;
  static Color blackColor45 =  getLightMode()?ColorLightConst.blackColor45:ColorNightConst.blackColor45;
  static Color blackColor87 =  getLightMode()?ColorLightConst.blackColor87:ColorNightConst.blackColor87;
  static Color dividerColor =  getLightMode()?ColorLightConst.dividerColor:ColorNightConst.dividerColor;
  static Color normalTextColorOnMainColor =  getLightMode()?ColorLightConst.normalTextColorOnMainColor:ColorNightConst.normalTextColorOnMainColor;
  static Color colorHintTextSearch =  getLightMode()?ColorLightConst.colorHintTextSearch:ColorNightConst.colorHintTextSearch;
  static Color colorIconGrays = getLightMode()?ColorLightConst.colorIconGrays:ColorNightConst.colorIconGrays;
  static Color bgToastSuccess = getLightMode()?ColorLightConst.bgToastSuccess:ColorNightConst.bgToastSuccess;
  static Color bgToastError = getLightMode()?ColorLightConst.bgToastError:ColorNightConst.bgToastError;
  static Color bgToastDangerous = getLightMode()?ColorLightConst.bgToastDangerous:ColorNightConst.bgToastDangerous;
  static Color colorTextRadioButton = getLightMode()?ColorLightConst.colorTextRadioButton:ColorNightConst.colorTextRadioButton;
  static Color nameRoomAvailable = getLightMode()?ColorLightConst.nameRoomAvailable:ColorNightConst.nameRoomAvailable;
  static Color normalTextBlackColorOnBackgroundColorWithOpacity70 = getLightMode()?ColorLightConst.normalTextBlackColorOnBackgroundColorWithOpacity70:ColorNightConst.normalTextBlackColorOnBackgroundColorWithOpacity70;
  static Color gray01ColorOnBackgroundColor = getLightMode()?ColorLightConst.gray01ColorOnBackgroundColor:ColorNightConst.gray01ColorOnBackgroundColor;
  static Color greyColor1 =  getLightMode()?ColorLightConst.greyColor1:ColorNightConst.greyColor1;
  static Color greyColor2 = getLightMode()?ColorLightConst.greyColor2:ColorNightConst.greyColor2;
  static Color greyColor = getLightMode()?ColorLightConst.greyColor:ColorNightConst.greyColor;
  static Color deviceAvailableColor = getLightMode()?ColorLightConst.paymentManagerAvailableColor:ColorNightConst.paymentManagerAvailableColor;
  static Color deviceFullColor = getLightMode()?ColorLightConst.paymentManagerFullColor:ColorNightConst.paymentManagerFullColor;
  static Color deviceRepairColor = getLightMode()?ColorLightConst.paymentManagerRepairColor:ColorNightConst.paymentManagerRepairColor;
  static Color deviceNotActiveColor = getLightMode()?ColorLightConst.paymentManagerNotActiveColor:ColorNightConst.paymentManagerNotActiveColor;
  static Color deviceClosedColor = getLightMode()?ColorLightConst.paymentManagerClosedColor:ColorNightConst.paymentManagerClosedColor;
  static Color colorLinear1 = getLightMode()?ColorLightConst.colorLinear1:ColorNightConst.colorLinear1;
  static Color colorLinear2 = getLightMode()?ColorLightConst.colorLinear2:ColorNightConst.colorLinear2;
  static Color colorLinear3 = getLightMode()?ColorLightConst.colorLinear3:ColorNightConst.colorLinear3;

  static Color colorLinear4 = getLightMode()?ColorLightConst.colorLinear4:ColorNightConst.colorLinear4;
  static Color colorLinear5 = getLightMode()?ColorLightConst.colorLinear5:ColorNightConst.colorLinear5;
  static Color colorLinear6 = getLightMode()?ColorLightConst.colorLinear6:ColorNightConst.colorLinear6;
  static Color colorLinear7 = getLightMode()?ColorLightConst.colorLinear7:ColorNightConst.colorLinear7;
  static Color colorLinear8 = getLightMode()?ColorLightConst.colorLinear8:ColorNightConst.colorLinear8;
  static Color colorLinear9 = getLightMode()?ColorLightConst.colorLinear9:ColorNightConst.colorLinear9;
  
  static Color yellowColor =  getLightMode()?ColorLightConst.yellowColor:ColorNightConst.yellowColor;
  static Color mainColorForText = getLightMode()?ColorLightConst.mainColorForText:ColorNightConst.mainColorForText;
  static Color textColorSelectTabBar = getLightMode()?ColorLightConst.textColorSelectTabBar:ColorNightConst.textColorSelectTabBar;
  static Color backGroundColorUnSelectTabBar = getLightMode()?ColorLightConst.backGroundColorUnSelectTabBar:ColorNightConst.backGroundColorUnSelectTabBar;
  static Color bgSettingButtonColor = getLightMode()?ColorLightConst.bgSettingButtonColor:ColorNightConst.bgSettingButtonColor;
  static Color bgDialogColor = getLightMode()?ColorLightConst.bgDialogColor:ColorNightConst.bgDialogColor;
  static Color bgSelectButtonColor = getLightMode()?ColorLightConst.bgSelectButtonColor:ColorNightConst.bgSelectButtonColor;

  static void setColorByFlavorType() {
    if(getLightMode())
      {
        ColorLightConst.setColorByFlavorType();
      }
    else
      {
        ColorNightConst.setColorByFlavorType();
      }
    resetColor();
    TextStyleConstant.resetStyle();
  }
  
  static void resetColor(){
    backGroundColor = getLightMode()?ColorLightConst.backGroundColor:ColorNightConst.backGroundColor;
    primaryColor = getLightMode()?ColorLightConst.primaryColor:ColorNightConst.primaryColor;
    mainColor = primaryColor;
    mainColorWithOpacity50 = mainColor.withOpacity(0.5);
    iconColor = getLightMode()?ColorLightConst.iconColor:ColorNightConst.iconColor;
    buttonbgColor = getLightMode()?ColorLightConst.buttonbgColor:ColorNightConst.buttonbgColor;
    homeBg =  getLightMode()?ColorLightConst.homeBg:ColorNightConst.homeBg;
    bgColor =  getLightMode()?ColorLightConst.bgColor:ColorNightConst.bgColor;
    bgColor2 =  getLightMode()?ColorLightConst.bgColor2:ColorNightConst.bgColor2;
    textColorOnMainButton =   getLightMode()?ColorLightConst.textColorOnMainButton:ColorNightConst.textColorOnMainButton;
    buttonColor =  getLightMode()?ColorLightConst.buttonColor:ColorNightConst.buttonColor;
    textColor =   getLightMode()?ColorLightConst.textColor:ColorNightConst.textColor;
    subtext = getLightMode()?ColorLightConst.subtext:ColorNightConst.subtext;
    shadowColor =  getLightMode()?ColorLightConst.shadowColor:ColorNightConst.shadowColor;
    borderColor =  getLightMode()?ColorLightConst.borderColor:ColorNightConst.borderColor;
    progressColor =  getLightMode()?ColorLightConst.progressColor:ColorNightConst.progressColor;
    containerShadow =  getLightMode()?ColorLightConst.containerShadow:ColorNightConst.containerShadow;
    whiteColor =  getLightMode()?ColorLightConst.whiteColor:ColorNightConst.whiteColor;
    whiteColor70 = getLightMode()?ColorLightConst.whiteColor70:ColorNightConst.whiteColor70;
    whiteColor10 = getLightMode()?ColorLightConst.whiteColor10:ColorNightConst.whiteColor10;
    blackColor =  getLightMode()?ColorLightConst.blackColor:ColorNightConst.blackColor;
    blackColor26 =  getLightMode()?ColorLightConst.blackColor26:ColorNightConst.blackColor26;
    blackColor54 =  getLightMode()?ColorLightConst.blackColor54:ColorNightConst.blackColor54;
    blackColor12 =  getLightMode()?ColorLightConst.blackColor12:ColorNightConst.blackColor12;
    blackColor45 =  getLightMode()?ColorLightConst.blackColor45:ColorNightConst.blackColor45;
    blackColor87 =  getLightMode()?ColorLightConst.blackColor87:ColorNightConst.blackColor87;
    dividerColor =  getLightMode()?ColorLightConst.dividerColor:ColorNightConst.dividerColor;
    normalTextColorOnMainColor =  getLightMode()?ColorLightConst.normalTextColorOnMainColor:ColorNightConst.normalTextColorOnMainColor;
    colorHintTextSearch =  getLightMode()?ColorLightConst.colorHintTextSearch:ColorNightConst.colorHintTextSearch;
    colorIconGrays = getLightMode()?ColorLightConst.colorIconGrays:ColorNightConst.colorIconGrays;
    bgToastSuccess = getLightMode()?ColorLightConst.bgToastSuccess:ColorNightConst.bgToastSuccess;
    bgToastError = getLightMode()?ColorLightConst.bgToastError:ColorNightConst.bgToastError;
    bgToastDangerous = getLightMode()?ColorLightConst.bgToastDangerous:ColorNightConst.bgToastDangerous;
    colorTextRadioButton = getLightMode()?ColorLightConst.colorTextRadioButton:ColorNightConst.colorTextRadioButton;
    nameRoomAvailable = getLightMode()?ColorLightConst.nameRoomAvailable:ColorNightConst.nameRoomAvailable;
    normalTextBlackColorOnBackgroundColorWithOpacity70 = getLightMode()?ColorLightConst.normalTextBlackColorOnBackgroundColorWithOpacity70:ColorNightConst.normalTextBlackColorOnBackgroundColorWithOpacity70;
    gray01ColorOnBackgroundColor = getLightMode()?ColorLightConst.gray01ColorOnBackgroundColor:ColorNightConst.gray01ColorOnBackgroundColor;
    greyColor1 =  getLightMode()?ColorLightConst.greyColor1:ColorNightConst.greyColor1;
    greyColor2 = getLightMode()?ColorLightConst.greyColor2:ColorNightConst.greyColor2;
    greyColor = getLightMode()?ColorLightConst.greyColor:ColorNightConst.greyColor;
    deviceAvailableColor = getLightMode()?ColorLightConst.paymentManagerAvailableColor:ColorNightConst.paymentManagerAvailableColor;
    deviceFullColor = getLightMode()?ColorLightConst.paymentManagerFullColor:ColorNightConst.paymentManagerFullColor;
    deviceRepairColor = getLightMode()?ColorLightConst.paymentManagerRepairColor:ColorNightConst.paymentManagerRepairColor;
    deviceNotActiveColor = getLightMode()?ColorLightConst.paymentManagerNotActiveColor:ColorNightConst.paymentManagerNotActiveColor;
    deviceClosedColor = getLightMode()?ColorLightConst.paymentManagerClosedColor:ColorNightConst.paymentManagerClosedColor;
    colorLinear1 = getLightMode()?ColorLightConst.colorLinear1:ColorNightConst.colorLinear1;
    colorLinear2 = getLightMode()?ColorLightConst.colorLinear2:ColorNightConst.colorLinear2;
    colorLinear3 = getLightMode()?ColorLightConst.colorLinear3:ColorNightConst.colorLinear3;

    colorLinear4 = getLightMode()?ColorLightConst.colorLinear4:ColorNightConst.colorLinear4;
    colorLinear5 = getLightMode()?ColorLightConst.colorLinear5:ColorNightConst.colorLinear5;
    colorLinear6 = getLightMode()?ColorLightConst.colorLinear6:ColorNightConst.colorLinear6;
    colorLinear7 = getLightMode()?ColorLightConst.colorLinear7:ColorNightConst.colorLinear7;
    colorLinear8 = getLightMode()?ColorLightConst.colorLinear8:ColorNightConst.colorLinear8;
    colorLinear9 = getLightMode()?ColorLightConst.colorLinear9:ColorNightConst.colorLinear9;
    
    yellowColor =  getLightMode()?ColorLightConst.yellowColor:ColorNightConst.yellowColor;
    mainColorForText = getLightMode()?ColorLightConst.mainColorForText:ColorNightConst.mainColorForText;
    textColorSelectTabBar = getLightMode()?ColorLightConst.textColorSelectTabBar:ColorNightConst.textColorSelectTabBar;
    backGroundColorUnSelectTabBar = getLightMode()?ColorLightConst.backGroundColorUnSelectTabBar:ColorNightConst.backGroundColorUnSelectTabBar;
    bgSettingButtonColor = getLightMode()?ColorLightConst.bgSettingButtonColor:ColorNightConst.bgSettingButtonColor;
    bgDialogColor = getLightMode()?ColorLightConst.bgDialogColor:ColorNightConst.bgDialogColor;
    bgSelectButtonColor = getLightMode()?ColorLightConst.bgSelectButtonColor:ColorNightConst.bgSelectButtonColor;
}

  static bool getLightMode(){
    isDarkMode ??= SharedPreferencesStorage().getBoolean(Storage.darkModeKey,);
    return !(isDarkMode??false);
  }
  
  static bool getDarkMode(){
    return !getLightMode();
  }
  
  static void setDarkMode(bool isDarkModeInput){
    isDarkMode = isDarkModeInput;
    SharedPreferencesStorage().saveBoolean(Storage.darkModeKey,isDarkModeInput);
  }
  
}


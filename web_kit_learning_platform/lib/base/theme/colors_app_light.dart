
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
export 'color_extentions.dart';
class ColorLightConst{
  static Color backGroundColor =  const Color(0xffFFFFFF);
  static Color primaryColor = const Color(0xF4930202);
  static Color mainColor = primaryColor;
  static Color mainColorWithOpacity50 = mainColor.withOpacity(0.5);
  static Color iconColor = primaryColor;
  static Color buttonbgColor = primaryColor;
  static Color homeBg =  const Color(0xffc9b9b9);
  static Color bgColor =  const Color(0x00f5f5f5);

  static Color buttonColor =  primaryColor;
  static Color textColor =   Colors.black87;
  static Color subtext = const Color(0xff545454);
  static Color shadowColor =  const Color(0xffE4EBE4);
  static Color borderColor =  const Color(0xffCFCFCF);
  static Color progressColor =  const Color(0xfff8ecec);
  static Color containerShadow =  const Color(0x3882A483);
  static Color whiteColor =  Colors.white;
  static Color whiteColor70 =  Colors.white70;
  static Color whiteColor10 =  Colors.white10;
  static Color textColorOnMainButton =  const Color(0xFFFFFFFF);

  
  static Color dividerColor =  const Color(0xff9B9B9B);
  static Color normalTextColorOnMainColor =  blackColor54;
  static Color blackColor =  Colors.black;
  static Color blackColor54 =  Colors.black54;
  static Color blackColor45 =  Colors.black45;
  static Color blackColor12 =  Colors.black12;
  static Color blackColor26 =  Colors.black26;
  static Color blackColor87 =  Colors.black87;


  static Color colorHintTextSearch =  blackColor45;
  static Color colorIconGrays =  Colors.black87;
  static Color bgToastSuccess = const Color(0xFFE9F7F0);
  static Color bgToastError = const Color(0xFFFFE8E7);
  static Color bgToastDangerous = const Color(0xFFFFF3E9);
  static Color colorTextRadioButton = const Color(0xFF393939);
  static Color nameRoomAvailable = const Color(0xFF151132);
  static Color normalTextBlackColorOnBackgroundColorWithOpacity70 = blackColor.withOpacity(0.7);
  static Color gray01ColorOnBackgroundColor = const Color(0xFFF6F6F6);
  static Color greyColor1 =  Colors.grey;
  static Color greyColor2 = const Color(0xFF8E8E8E);
  static Color greyColor = const Color(0xFF808080);
  
  static Color colorLinear1 = const Color(0xffb93838);
  static Color colorLinear2 = const Color(0xffad2121);
  static Color colorLinear3 = const Color(0xF4930202);

  static Color mainColorForText =mainColor;
  static Color textColorSelectTabBar = const Color(0xffda4545);
  static Color backGroundColorUnSelectTabBar = const Color(0xffd08c8c);

  static Color bgSettingButtonColor =  Colors.white;
  static Color bgDialogColor = const Color(0xFFF4FDF5);
  static Color bgSelectButtonColor = const Color(0xFFE7E7E7);
  static Color yellowColor = const Color(0xFFE2BD07);
  
  static Color colorLinear4 = const Color(0xFF36D1DC);
  static Color colorLinear5 = const Color(0xFF15CFDC);
  static Color colorLinear6 = const Color(0xFF5B86E5);

  static Color colorLinear7 = const Color(0xFF80DAF3);
  static Color colorLinear8 = const Color(0xFF3CD0F8);
  static Color colorLinear9 = const Color(0xFF00C5FF);
  static Color onHoverColor = const Color(0xfffff1f1);

  static setColorByFlavorType() {
    FlavorType flavorType = FlavorSettings().getFlavorType();
    switch (flavorType) {
      case FlavorType.webAdmin:
      // TODO: Handle this case.
        {
          mainColor =  const Color(0xF4930202);
          whiteColor = Colors.white;
          blackColor = Colors.black;
          backGroundColor = const Color(0xFFFFFFFF);
          mainColorWithOpacity50 = const Color(0xffa84747); //mainColor.withOpacity(0.5);
          buttonbgColor = const Color(0xffffeeee);
          homeBg = const Color(0xffffeeee);
          bgColor = const Color(0x00f5f5f5);
          buttonColor =  const Color(0xF4930202);
          textColor = Colors.black87;
          subtext = const Color(0xff545454);
          shadowColor = const Color(0xffE4EBE4);
          borderColor = const Color(0xffCFCFCF);
          progressColor = const Color(0xfff5a1a1);
          containerShadow = const Color(0x3882A483);
          textColorOnMainButton =   Colors.black87;
          colorLinear1 = const Color(0xffb93838);
          colorLinear2 = const Color(0xffad2121);
          colorLinear3 = const Color(0xF4930202);
          
          yellowColor = Colors.amber;
          mainColorForText =mainColor;
          textColorSelectTabBar = const Color(0xF4930202);
          backGroundColorUnSelectTabBar = const Color(0xfff5a1a1);
          colorIconGrays =  blackColor54;
          bgSettingButtonColor =  Colors.white;
          bgDialogColor = const Color(0xFFF7FCF7);
          bgSelectButtonColor = const Color(0xFFE7E7E7);
          
          colorLinear4 = const Color(0xFF36D1DC);
          colorLinear5 = const Color(0xFF15CFDC);
          colorLinear6 = const Color(0xFF5B86E5);
          
          colorLinear7 = const Color(0xFF80DAF3);
          colorLinear8 = const Color(0xFF3CD0F8);
          colorLinear9 = const Color(0xFF00C5FF);
          onHoverColor = const Color(0xfffff1f1);
        }
        break;
      case FlavorType.webUser:
        // TODO: Handle this case.
      case FlavorType.mobileUser:
        // TODO: Handle this case.
    }
  }

}



import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
export 'color_extentions.dart';

class ColorNightConst{
  static Color backGroundColor = Colors.black87;
  static Color primaryColor = const Color(0xF4930202);
  static Color mainColor = primaryColor;
  static Color mainColorWithOpacity50 = mainColor.withOpacity(0.5);
  static Color iconColor = const Color(0xF4930202);

  static Color buttonbgColor = primaryColor;
  static Color homeBg =  const Color(0xffBDE3BF);
  static Color bgColor =  const Color(0xFF242A24);
  static Color bgColor2 =  Colors.white24;

  static Color textColorOnMainButton = Colors.black87;

  static Color buttonColor =  const Color(0xff17721A);
  static Color textColor =   Colors.white;
  static Color subtext = Colors.white;
  static Color shadowColor =  const Color(0xffE4EBE4);
  static Color borderColor =  const Color(0xffCFCFCF);
  static Color progressColor =  const Color(0xffC2ECC4);
  static Color containerShadow =  const Color(0x3882A483);
  static Color whiteColor =  Colors.black;
  static Color whiteColor70 =  const Color(0xFFFFFFFF).withOpacity(0.7);
  static Color whiteColor10 =  Colors.black12;
  static Color blackColor =  Colors.white;
  static Color blackColor54 =  Colors.white54;
  static Color blackColor26 =  Colors.white24;
  static Color blackColor12 =  Colors.white12;
  static Color blackColor45 =  Colors.white38;
  static Color blackColor87 =  Colors.white70;
  
  static Color dividerColor =  const Color(0xff9B9B9B);
  static Color normalTextColorOnMainColor =  blackColor54;
  static Color colorHintTextSearch =  Colors.white;
  static Color colorIconGrays =  Colors.white;
  static Color bgToastSuccess = const Color(0xFFE9F7F0);
  static Color bgToastError = const Color(0xFFFFE8E7);
  static Color bgToastDangerous = const Color(0xFFFFF3E9);
  static Color colorTextRadioButton = const Color(0xFF393939);
  static Color nameRoomAvailable = const Color(0xFF151132);
  static Color normalTextBlackColorOnBackgroundColorWithOpacity70 = const Color(0xFFFFFFFF).withOpacity(0.7);
  static Color gray01ColorOnBackgroundColor = const Color(0xFFF6F6F6);
  static Color greyColor1 =  Colors.grey;
  static Color greyColor2 = const Color(0xFF8E8E8E);
  static Color greyColor = const Color(0xFF808080);
  
  static Color colorLinear1 = const Color(0xffb0dcb1);
  static Color colorLinear2 = const Color(0xff9bdc9e);
  static Color colorLinear3 = const Color(0xff8DDB90);


  static Color yellowColor = Colors.white;
  static Color mainColorForText =Colors.white;
  static Color textColorSelectTabBar = Colors.black;
  static Color backGroundColorUnSelectTabBar = const Color(0xFFEAEAEA);
  static Color bgSettingButtonColor =  const Color(0xFF333131);
  static Color bgDialogColor =  bgSettingButtonColor;
  static Color bgSelectButtonColor = const Color(0xFF383838);

  static Color colorLinear4 = const Color(0xFF36D1DC);
  static Color colorLinear5 = const Color(0xFF15CFDC);
  static Color colorLinear6 = const Color(0xFF5B86E5);
  static Color colorLinear7 = const Color(0xFF80DAF3);
  static Color colorLinear8 = const Color(0xFF3CD0F8);
  static Color colorLinear9 = const Color(0xFF00C5FF);
  static Color onHoverColor = const Color(0xffd08c8c);

  static setColorByFlavorType() {
    FlavorType flavorType = FlavorSettings().getFlavorType();
    switch (flavorType) {
      case FlavorType.webAdmin:
      // TODO: Handle this case.
        {
          backGroundColor = Colors.black87;
          primaryColor = const Color(0xF4930202);
          mainColor = primaryColor;
          mainColorWithOpacity50 = mainColor.withOpacity(0.5);
          iconColor = const Color(0xF4930202);

          buttonbgColor = primaryColor;
          homeBg =  const Color(0xF4FFF4F4);
          bgColor =  const Color(0xFF242A24);
          bgColor2 =  Colors.white24;

          textColorOnMainButton = Colors.black87;

          buttonColor =  const Color(0xff17721A);
          textColor =   Colors.white;
          subtext = Colors.white;
          shadowColor =  const Color(0xffE4EBE4);
          borderColor =  const Color(0xffCFCFCF);
          progressColor =  const Color(0xffC2ECC4);
          containerShadow =  const Color(0x3882A483);
          whiteColor =  Colors.black;
          whiteColor70 =  const Color(0xFFFFFFFF).withOpacity(0.7);
          whiteColor10 =  Colors.black12;
          blackColor =  Colors.white;
          blackColor54 =  Colors.white54;
          blackColor26 =  Colors.white24;
          blackColor12 =  Colors.white12;
          blackColor45 =  Colors.white38;
          blackColor87 =  Colors.white70;

          dividerColor =  const Color(0xff9B9B9B);
          normalTextColorOnMainColor =  blackColor54;
          colorHintTextSearch =  Colors.white60;
          colorIconGrays =  Colors.white;
          bgToastSuccess = const Color(0xFFE9F7F0);
          bgToastError = const Color(0xFFFFE8E7);
          bgToastDangerous = const Color(0xFFFFF3E9);
          colorTextRadioButton = const Color(0xFF393939);
          nameRoomAvailable = const Color(0xFF151132);
          normalTextBlackColorOnBackgroundColorWithOpacity70 = const Color(0xFFFFFFFF).withOpacity(0.7);
          gray01ColorOnBackgroundColor = const Color(0xFFF6F6F6);
          greyColor1 =  Colors.grey;
          greyColor2 = const Color(0xFF8E8E8E);
          greyColor = const Color(0xFF808080);
          
          colorLinear1 = const Color(0xffb0dcb1);
          colorLinear2 = const Color(0xff9bdc9e);
          colorLinear3 = const Color(0xff8DDB90);

          yellowColor = Colors.white;
          mainColorForText =Colors.white;
          textColorSelectTabBar = Colors.black;
          backGroundColorUnSelectTabBar = const Color(0xFFEAEAEA);
          bgSettingButtonColor =  const Color(0xFF333131);
          bgDialogColor =  bgSettingButtonColor;
          bgSelectButtonColor = const Color(0xFF383838);


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
        {
          backGroundColor = Colors.black87;
          primaryColor = const Color(0xff8DDB90);
          mainColor = primaryColor;
          mainColorWithOpacity50 = mainColor.withOpacity(0.5);
          iconColor = const Color(0xff17721A);
          buttonbgColor = const Color(0xffbcf6be);
          homeBg =  const Color(0xffBDE3BF);
          bgColor =  const Color(0xFF242A24);
          bgColor2 =  Colors.white24;
          textColorOnMainButton = Colors.black87;
          buttonColor =  const Color(0xff17721A);
          textColor =   Colors.white;
          subtext = Colors.white;
          shadowColor =  const Color(0xffE4EBE4);
          borderColor =  const Color(0xffCFCFCF);
          progressColor =  const Color(0xffC2ECC4);
          containerShadow =  const Color(0x3882A483);
          whiteColor =  Colors.black;
          whiteColor70 =  const Color(0xFFFFFFFF).withOpacity(0.7);
          whiteColor10 =  Colors.black12;
          blackColor =  Colors.white;
          blackColor54 =  Colors.white54;
          blackColor26 =  Colors.white24;
          blackColor12 =  Colors.white12;
          blackColor45 =  Colors.white38;
          blackColor87 =  Colors.white70;

          dividerColor =  const Color(0xff9B9B9B);
          normalTextColorOnMainColor =  blackColor54;
          colorHintTextSearch =  Colors.white60;
          colorIconGrays =  Colors.white;
          bgToastSuccess = const Color(0xFFE9F7F0);
          bgToastError = const Color(0xFFFFE8E7);
          bgToastDangerous = const Color(0xFFFFF3E9);
          colorTextRadioButton = const Color(0xFF393939);
          nameRoomAvailable = const Color(0xFF151132);
          normalTextBlackColorOnBackgroundColorWithOpacity70 = const Color(0xFFFFFFFF).withOpacity(0.7);
          gray01ColorOnBackgroundColor = const Color(0xFFF6F6F6);
          greyColor1 =  Colors.grey;
          greyColor2 = const Color(0xFF8E8E8E);
          greyColor = const Color(0xFF808080);
          
          colorLinear1 = const Color(0xffb0dcb1);
          colorLinear2 = const Color(0xff9bdc9e);
          colorLinear3 = const Color(0xff8DDB90);

          yellowColor = Colors.white;
          mainColorForText =Colors.white;
          textColorSelectTabBar = Colors.black;
          backGroundColorUnSelectTabBar = const Color(0xFFEAEAEA);
          bgSettingButtonColor =  const Color(0xFF333131);
          bgDialogColor =  bgSettingButtonColor;
          bgSelectButtonColor = const Color(0xFF383838);


          colorLinear4 = const Color(0xFF36D1DC);
          colorLinear5 = const Color(0xFF15CFDC);
          colorLinear6 = const Color(0xFF5B86E5);
          
          colorLinear7 = const Color(0xFF80DAF3);
          colorLinear8 = const Color(0xFF3CD0F8);
          colorLinear9 = const Color(0xFF00C5FF);
          onHoverColor = const Color(0xfffff1f1);
        }
        break;
      case FlavorType.mobileUser:
        // TODO: Handle this case.
    }
  }

}

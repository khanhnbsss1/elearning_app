import 'package:flutter/material.dart';

import '../base.export.dart';

class WebFonts {
  WebFonts._(){
    avertaStdCY =avertaStdCY;
    baseStyle = getBaseTextStyle();
  }
  static String avertaStdCY = "AvertaStdCY";

}

class AppThemes {
  AppThemes._();
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      primaryColor: ColorConst.primaryColor,
      scaffoldBackgroundColor:ColorConst.backGroundColor,
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
        backgroundColor: ColorConst.primaryColor,
        iconTheme:  IconThemeData(color: ColorConst.primaryColor),
        centerTitle: true,
        toolbarTextStyle: Theme.of(context).textTheme.apply(bodyColor: ColorConst.primaryColor,).bodyMedium,
        titleTextStyle: Theme.of(context).textTheme.apply(bodyColor: ColorConst.primaryColor,).titleLarge,
      ),
      iconTheme:  IconThemeData(color: ColorConst.primaryColor),
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: ColorConst.primaryColor,
      ),
      colorScheme:  ColorScheme.light(
        primary: ColorConst.primaryColor,
        secondary: ColorConst.primaryColor,
      ),
      cardColor: ColorConst.primaryColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorConst.whiteColor,
        selectedItemColor: ColorConst.primaryColor.withOpacity(0.7),
        unselectedItemColor: ColorConst.primaryColor.withOpacity(0.32),
        selectedIconTheme:  IconThemeData(color: ColorConst.primaryColor),
        showUnselectedLabels: true,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      primaryColor: ColorConst.primaryColor,
      scaffoldBackgroundColor: ColorConst.backGroundColor,
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
        backgroundColor: ColorConst.backGroundColor,
        iconTheme:  IconThemeData(color: ColorConst.backGroundColor),
        centerTitle: true, toolbarTextStyle: Theme.of(context).textTheme.apply(
        bodyColor: ColorConst.backGroundColor,
      ).bodyMedium, titleTextStyle: Theme.of(context).textTheme.apply(
        bodyColor: ColorConst.backGroundColor,
      ).titleLarge,
      ),
      iconTheme:  IconThemeData(color: ColorConst.backGroundColor),
      textTheme: Theme.of(context)
          .textTheme
          .apply(bodyColor: ColorConst.backGroundColor, displayColor: ColorConst.backGroundColor),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: ColorConst.primaryColor,
        secondary: ColorConst.primaryColor,
      ),
      cardColor: ColorConst.backGroundColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorConst.primaryColor,
        selectedItemColor: ColorConst.primaryColor,
        unselectedItemColor: ColorConst.primaryColor.withOpacity(0.52),
        selectedIconTheme:  IconThemeData(color: ColorConst.primaryColor),
        showUnselectedLabels: true,
      ),
    );
  }
}


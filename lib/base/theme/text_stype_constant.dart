import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../base.export.dart';

// Simple
TextStyle baseStyle =  getBaseTextStyle();
TextStyle getBaseTextStyle({FontWeight? fontWeight}){
  return GoogleFonts.inter(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight??fontWeight400,
      color: ColorConst.blackColor,
      height: height_1_4
    ).copyWithCustom(
      fontWeight: fontWeight??fontWeight400,
    )
  );
}

const double? textScaleFactorConst =null;
const double height_1_0= 1.1;
const double height_1_1= 1.1;
const double height_1_2= 1.2;
const double height_1_3= 1.3;
const double height_1_4= 1.4;

double fontSize36 = Dimens.size36;
double fontSize35 = Dimens.size35;
double fontSize30 = Dimens.size32;
double fontSize24 = Dimens.size26;
double fontSize20 = Dimens.size22;
double fontSize18 = Dimens.size18;
double fontSize17 = Dimens.size17;
double fontSize16 = Dimens.size16;
double fontSize15 = Dimens.size15;
double fontSize14 = Dimens.size14;
double fontSize13 = Dimens.size13;
double fontSize12 = Dimens.size22;
double fontSize10 = Dimens.size10;

 FontWeight fontWeight200 = FontWeight.w200;
 FontWeight fontWeight300 = FontWeight.w300;
 FontWeight fontWeight400 = FontWeight.w400;
 FontWeight fontWeight500 = FontWeight.w500;
 FontWeight fontWeight600 = FontWeight.w600;
 FontWeight fontWeight700 = FontWeight.w700;
 FontWeight fontWeight800 = FontWeight.w800;
 FontWeight fontWeight900 = FontWeight.w900;

class TextStyleConstant{
  static const String fontFamily = "AvertaStdCY";
  static 	TextStyle textOnBackGroundColorStyle14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.backGroundColor, fontWeight: fontWeight400);
  static 	TextStyle normalTextOnBackGroundColorStyle14w600 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight600);
  static 	TextStyle normalTextOnBackGroundColorStyle14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight400);
  static 	TextStyle normalTextOnBackGroundColorStyle16w400 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight400);
  static 	TextStyle normalTextOnBackGroundColorStyle16w600 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight600);
  static 	TextStyle normalTextOnBackGroundColorStyle15w500 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight400);
  static 	TextStyle normalTextOnBackGroundColorStyle20w700 = baseStyle.copyWithCustom(fontSize: fontSize20, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight700);

  static 	TextStyle textStyleWhite14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.whiteColor, fontWeight: fontWeight400);
  static 	TextStyle textStyleWhite14w600 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.whiteColor, fontWeight: fontWeight600);
  static 	TextStyle textStyleWhite16w400 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.whiteColor, fontWeight: fontWeight400);
  static 	TextStyle textStyleWhite16w700 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.whiteColor, fontWeight: fontWeight700);

  static 	TextStyle  textStyleWhite15w500 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.whiteColor, fontWeight: fontWeight400);
  static 	TextStyle  textStyleWhite13w500 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.whiteColor, fontWeight: fontWeight500);
  static 	TextStyle  textStyleWhite13w400 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.whiteColor, fontWeight: fontWeight400);

  static 	TextStyle  textStyleWhite20w700 = baseStyle.copyWithCustom(fontSize: fontSize20, color: ColorConst.whiteColor, fontWeight: fontWeight700);
  static 	TextStyle  textStyleBlack12w200 = baseStyle.copyWithCustom(fontSize: fontSize12, color: ColorConst.blackColor, fontWeight: fontWeight200);
  static 	TextStyle  textStyleBlack12w400 = baseStyle.copyWithCustom(fontSize: fontSize12, color: ColorConst.blackColor, fontWeight: fontWeight400);
  static 	TextStyle  textStyleBlack12w500 = baseStyle.copyWithCustom(fontSize: fontSize12, color: ColorConst.blackColor, fontWeight: fontWeight500);
  static 	TextStyle  textStyleBlack12w600 = baseStyle.copyWithCustom(fontSize: fontSize12, color: ColorConst.blackColor, fontWeight: fontWeight600);
  static 	TextStyle  textStyleBlack12w800 = baseStyle.copyWithCustom(fontSize: fontSize12, color: ColorConst.blackColor, fontWeight: fontWeight800);

  static 	TextStyle  textStyleBlack13w500 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.blackColor, fontWeight: fontWeight500);
  static 	TextStyle  textStyleBlack13w400 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.blackColor, fontWeight: fontWeight400);
  static 	TextStyle  textStyleBlack14w300 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.blackColor, fontWeight: fontWeight300);
  static 	TextStyle  textStyleBlack13w300 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.blackColor, fontWeight: fontWeight300);

  static 	TextStyle  textStyleBlack14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.blackColor, fontWeight: fontWeight400);
  static 	TextStyle  textStyleBlack14w500 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.blackColor, fontWeight: fontWeight500);

  static 	TextStyle  textStyleBlack14w600 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.blackColor, fontWeight: fontWeight600);
  static 	TextStyle  textStyleBlack16w600 = baseStyle.copyWithCustom( fontSize: fontSize13, color: ColorConst.blackColor, fontWeight: fontWeight600);
  static 	TextStyle  textStyleBlack16w500 = baseStyle.copyWithCustom( fontSize: fontSize16, color: ColorConst.blackColor, fontWeight: fontWeight600);

  static 	TextStyle  textStyleBlack16w700 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.blackColor, fontWeight: fontWeight700);

  static 	TextStyle  textStyleBlack16w400 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.blackColor, fontWeight: fontWeight400);
  static 	TextStyle  textStyleBlack14w700 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.blackColor, fontWeight: fontWeight700);

  static 	TextStyle  textStyleBlack20w700 = baseStyle.copyWithCustom(fontSize: fontSize20, color: ColorConst.blackColor, fontWeight: fontWeight700);
  static 	TextStyle  textStyleBlack20w500 = baseStyle.copyWithCustom(fontSize: fontSize20, color: ColorConst.blackColor, fontWeight: fontWeight500);

  static 	TextStyle  textStyleBlack24w700 = baseStyle.copyWithCustom(fontSize: fontSize24, color: ColorConst.blackColor, fontWeight: fontWeight700);


  static 	TextStyle  textStyleMainColor14w600 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.mainColor, fontWeight: fontWeight600);
  static 	TextStyle textStyleMainColor18w700 = baseStyle.copyWithCustom(fontSize: fontSize18, color: ColorConst.mainColor, fontWeight: fontWeight700);

  static 	TextStyle titleTextColorOnBackgroundColorStyle14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight400);
  static 	TextStyle titleTextColorOnBackgroundColorStyle14w700 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight700);
  static 	TextStyle titleTextColorOnBackgroundColorStyle16w600 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight600);

  static 	TextStyle mainTextColorOnBackgroundStyle18w700 = baseStyle.copyWithCustom(fontSize: fontSize18, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight700);
  static 	TextStyle textColorbackGroundColorStyle14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight400);

  static 	TextStyle  textStyleYellow14w500 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.yellowColor, fontWeight: fontWeight500);
  static 	TextStyle  textStyleYellow14w600 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.yellowColor, fontWeight: fontWeight600);

  static 	TextStyle  textStyleYellow13w300 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.yellowColor, fontWeight: fontWeight300);
  static 	TextStyle  textStyleYellow13w400 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.yellowColor, fontWeight: fontWeight500);
  static 	TextStyle  textStyleYellow13w500 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.yellowColor, fontWeight: fontWeight400);
  static 	TextStyle  textStyleMainColor13w400 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.mainColorForText, fontWeight: fontWeight400);
  static 	TextStyle  textStyleMainColor14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.mainColorForText, fontWeight: fontWeight400);
  static 	TextStyle  textStyleMainColor14w500 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.mainColorForText, fontWeight: fontWeight500);
  static 	TextStyle  textStyleMainColor13w500 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.mainColorForText, fontWeight: fontWeight500);


  static 	TextStyle  textStyleBlack15w400 = baseStyle.copyWithCustom(fontSize: fontSize15, color: ColorConst.blackColor, fontWeight: fontWeight400);

  static 	TextStyle  textStyleBlack15w700 = baseStyle.copyWithCustom(fontSize: fontSize15, color: ColorConst.blackColor, fontWeight: fontWeight700);
  static 	TextStyle  textStyleBlack17w700 = baseStyle.copyWithCustom(fontSize: fontSize17, color: ColorConst.blackColor, fontWeight: fontWeight700);
  static 	TextStyle  textStyleBlack36w700 = baseStyle.copyWithCustom(fontSize: fontSize36, color: ColorConst.blackColor, fontWeight: fontWeight700);
  static 	TextStyle  textStyleBlack18w600 = baseStyle.copyWithCustom(fontSize: fontSize18, color: ColorConst.blackColor, fontWeight: fontWeight600);
  static 	TextStyle  textStyleBlack30w700 = baseStyle.copyWithCustom(fontSize: fontSize30, color: ColorConst.blackColor, fontWeight: fontWeight700);
  static 	TextStyle  textStyleBlack10w500 = baseStyle.copyWithCustom(fontSize: fontSize10, color: ColorConst.blackColor, fontWeight: fontWeight500);
  static 	TextStyle  textStyleBlack30w500 = baseStyle.copyWithCustom(fontSize: fontSize30, color: ColorConst.blackColor, fontWeight: fontWeight500);

  static void resetStyle(){
     fontSize36 = Dimens.size36;
     fontSize35 = Dimens.size35;
     fontSize30 = Dimens.size30;
     fontSize24 = Dimens.size24;
     fontSize20 = Dimens.size22;
     fontSize18 = Dimens.size19;
     fontSize17 = Dimens.size18;
     fontSize16 = Dimens.size17;
     fontSize15 = Dimens.size16;
     fontSize14 = Dimens.size15;
     fontSize13 = Dimens.size14;
     fontSize12 = Dimens.size13;
     fontSize10 = Dimens.size11;

     FontWeight fontWeight200 = FontWeight.w200;
     fontWeight300 = FontWeight.w300;
     fontWeight400 = FontWeight.w400;
     fontWeight500 = FontWeight.w500;
     fontWeight600 = FontWeight.w600;
     fontWeight700 = FontWeight.w700;
     fontWeight800 = FontWeight.w800;
     fontWeight900 = FontWeight.w900;
     textOnBackGroundColorStyle14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.backGroundColor, fontWeight: fontWeight400);
     normalTextOnBackGroundColorStyle14w600 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight600);
     normalTextOnBackGroundColorStyle14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight400);
     normalTextOnBackGroundColorStyle16w400 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight400);
     normalTextOnBackGroundColorStyle16w600 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight600);
     normalTextOnBackGroundColorStyle15w500 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight400);
     normalTextOnBackGroundColorStyle20w700 = baseStyle.copyWithCustom(fontSize: fontSize20, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight700);

     textStyleWhite14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.whiteColor, fontWeight: fontWeight400);
     textStyleWhite14w600 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.whiteColor, fontWeight: fontWeight600);
     textStyleWhite16w400 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.whiteColor, fontWeight: fontWeight400);
     textStyleWhite16w700 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.whiteColor, fontWeight: fontWeight700);

     textStyleWhite15w500 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.whiteColor, fontWeight: fontWeight400);
     textStyleWhite13w500 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.whiteColor, fontWeight: fontWeight500);
     textStyleWhite13w400 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.whiteColor, fontWeight: fontWeight400);

     textStyleWhite20w700 = baseStyle.copyWithCustom(fontSize: fontSize20, color: ColorConst.whiteColor, fontWeight: fontWeight700);

     textStyleBlack12w200 = baseStyle.copyWithCustom(fontSize: fontSize12, color: ColorConst.blackColor, fontWeight: fontWeight300);
     textStyleBlack12w400 = baseStyle.copyWithCustom(fontSize: fontSize12, color: ColorConst.blackColor, fontWeight: fontWeight400);
     textStyleBlack12w500 = baseStyle.copyWithCustom(fontSize: fontSize12, color: ColorConst.blackColor, fontWeight: fontWeight500);
     textStyleBlack12w600 = baseStyle.copyWithCustom(fontSize: fontSize12, color: ColorConst.blackColor, fontWeight: fontWeight600);
     textStyleBlack12w800 = baseStyle.copyWithCustom(fontSize: fontSize12, color: ColorConst.blackColor, fontWeight: fontWeight800);

     textStyleBlack13w500 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.blackColor, fontWeight: fontWeight500);
     textStyleBlack13w400 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.blackColor, fontWeight: fontWeight400);
     textStyleBlack14w300 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.blackColor, fontWeight: fontWeight300);
     textStyleBlack13w300 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.blackColor, fontWeight: fontWeight300);

     textStyleBlack14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.blackColor, fontWeight: fontWeight400);
     textStyleBlack14w500 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.blackColor, fontWeight: fontWeight500);

     textStyleBlack14w600 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.blackColor, fontWeight: fontWeight600);
     textStyleBlack16w600 = baseStyle.copyWithCustom( fontSize: fontSize13, color: ColorConst.blackColor, fontWeight: fontWeight600);
     textStyleBlack16w500 = baseStyle.copyWithCustom( fontSize: fontSize16, color: ColorConst.blackColor, fontWeight: fontWeight600);

     textStyleBlack16w700 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.blackColor, fontWeight: fontWeight700);

     textStyleBlack16w400 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.blackColor, fontWeight: fontWeight400);
     textStyleBlack14w700 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.blackColor, fontWeight: fontWeight700);

     textStyleBlack20w700 = baseStyle.copyWithCustom(fontSize: fontSize20, color: ColorConst.blackColor, fontWeight: fontWeight700);
     textStyleBlack20w500 = baseStyle.copyWithCustom(fontSize: fontSize20, color: ColorConst.blackColor, fontWeight: fontWeight500);

     textStyleBlack24w700 = baseStyle.copyWithCustom(fontSize: fontSize24, color: ColorConst.blackColor, fontWeight: fontWeight700);


     textStyleMainColor14w600 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.mainColor, fontWeight: fontWeight600);
     textStyleMainColor18w700 = baseStyle.copyWithCustom(fontSize: fontSize18, color: ColorConst.mainColor, fontWeight: fontWeight700);

     titleTextColorOnBackgroundColorStyle14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight400);
     titleTextColorOnBackgroundColorStyle14w700 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight700);
     titleTextColorOnBackgroundColorStyle16w600 = baseStyle.copyWithCustom(fontSize: fontSize16, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight600);

     mainTextColorOnBackgroundStyle18w700 = baseStyle.copyWithCustom(fontSize: fontSize18, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight700);
     textColorbackGroundColorStyle14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.normalTextColorOnMainColor, fontWeight: fontWeight400);

     textStyleYellow14w500 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.yellowColor, fontWeight: fontWeight500);
     textStyleYellow14w600 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.yellowColor, fontWeight: fontWeight600);

     textStyleYellow13w300 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.yellowColor, fontWeight: fontWeight300);
     textStyleYellow13w400 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.yellowColor, fontWeight: fontWeight500);
     textStyleYellow13w500 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.yellowColor, fontWeight: fontWeight400);
     textStyleMainColor13w400 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.mainColorForText, fontWeight: fontWeight400);
     textStyleMainColor14w400 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.mainColorForText, fontWeight: fontWeight400);
     textStyleMainColor14w500 = baseStyle.copyWithCustom(fontSize: fontSize14, color: ColorConst.mainColorForText, fontWeight: fontWeight500);
     textStyleMainColor13w500 = baseStyle.copyWithCustom(fontSize: fontSize13, color: ColorConst.mainColorForText, fontWeight: fontWeight500);
     
     textStyleBlack15w400 = baseStyle.copyWithCustom(fontSize: fontSize15, color: ColorConst.blackColor, fontWeight: fontWeight400);
     textStyleBlack15w700 = baseStyle.copyWithCustom(fontSize: fontSize15, color: ColorConst.blackColor, fontWeight: fontWeight700);
     textStyleBlack17w700 = baseStyle.copyWithCustom(fontSize: fontSize17, color: ColorConst.blackColor, fontWeight: fontWeight700);
     textStyleBlack36w700 = baseStyle.copyWithCustom(fontSize: fontSize36, color: ColorConst.blackColor, fontWeight: fontWeight700);
     textStyleBlack18w600 = baseStyle.copyWithCustom(fontSize: fontSize18, color: ColorConst.blackColor, fontWeight: fontWeight600);
     textStyleBlack30w700 = baseStyle.copyWithCustom(fontSize: fontSize30, color: ColorConst.blackColor, fontWeight: fontWeight700);
     textStyleBlack10w500 = baseStyle.copyWithCustom(fontSize: fontSize10, color: ColorConst.blackColor, fontWeight: fontWeight500);
     textStyleBlack30w500 = baseStyle.copyWithCustom(fontSize: fontSize30, color: ColorConst.blackColor, fontWeight: fontWeight500);
  }
}
extension StringX on TextStyle {
  TextStyle copyWithCustom({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }){
    return copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations?? [
          FontVariation(
              'wght', (((fontWeight??fontWeight400).index) * 100).toDouble())
        ],
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow
    );
  }
}
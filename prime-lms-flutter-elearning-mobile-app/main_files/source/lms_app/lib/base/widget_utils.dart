import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'base.export.dart';

Widget getVerSpace(double verSpace) {
  return SizedBox(
    height: verSpace,
  );
}
Widget getImageByUrl(
    String url,
    {
      double? width,
      double? height,
      Color? color,
      BoxFit boxFit = BoxFit.contain,
      Function()? onTap
    }) {
  return InkWell(
    onTap: onTap,
    child: Image.network(
      url,
      color: color,
      width: width,
      height: height,
      fit: boxFit,
      scale: FetchPixels.getScale(),
    ),
  );
}
Widget getPngImage(String image,
    {
      double? width,
      double? height,
      Color? color,
      BoxFit boxFit = BoxFit.contain,
      Function()? onTap,
    }) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        Constant.assetImagePngPath + image,
        color: color,
        width: width,
        height: height,
        fit: boxFit,
        scale: FetchPixels.getScale(),
      ),
    ),
  );
}

Widget getSvgImage(String image,
    {
      double? width,
      double? height,
      Color? color,
      BoxFit boxFit = BoxFit.contain,
      Function()? onTap
    }) {
  return InkWell(
    onTap: onTap,
    child: SvgPicture.asset(
      Constant.assetImageSvgPath + image,
      color: color,
      width: width,
      height: height,
      fit: boxFit,
    ),
  );
}

Widget getPaddingWidget(EdgeInsets edgeInsets, Widget widget) {
  return Padding(
    padding: edgeInsets,
    child: widget,
  );
}

DecorationImage getDecorationAssetImage(BuildContext buildContext, String image,
    {BoxFit fit = BoxFit.contain}) {
  String folderPath = Constant.assetImageSvgPath;
  if(image.contains(".png")) {
    folderPath = Constant.assetImagePngPath;
  }
  return DecorationImage(
      image: AssetImage(folderPath + image),
      fit: fit,
      scale: FetchPixels.getScale());
}

class BackButtonCustom extends StatelessWidget{
  BuildContext buildContext;
  Function()? onTap;
  Color? color;
  double? width;
  bool? enableBackground;
  BackButtonCustom({super.key, required this.buildContext, this.onTap, this.color, this.width, this.enableBackground}){
   enableBackground??=false;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child:SizedBox(
        width: width??(Dimens.size30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Dimens.size30,
              height: Dimens.size30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.size20),
                  color: (enableBackground??false)?ColorConst.whiteColor: Colors.transparent
              ),
              alignment: Alignment.center,
              child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: Dimens.size15,
                  color: color??ColorConst.blackColor
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if(onTap!=null)
          {
            onTap!();
          }
        else
          {
            Navigator.maybePop(context);// Constant.backToPrev(buildContext);
          }
      },
    );
  }

}
Widget getCustomText(
    String text, 
    double fontSize, 
    Color fontColor, 
    int maxLine,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight
    }) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight
    ),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
  );
}

Widget getMultilineCustomText(String text, double fontSize, Color fontColor,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight = 1.0}) {
  return Text(
    text,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    textAlign: textAlign,
    textScaleFactor: FetchPixels.getTextScale(),
  );
}

BoxDecoration getButtonDecoration(
    {
      Color? bgColor,
      BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow> shadow = const [],
    DecorationImage? image}) {
  return BoxDecoration(
      color: bgColor??ColorConst.buttonbgColor,
      borderRadius: borderRadius,
      border: border,
      boxShadow: shadow,
      image: image);
}


Widget getButtonWithIconWidget(
    {
      required Color bgColor,
      required String text,
      Color? textColor,
      Function()? onTap,
      required double fontsize,
      bool isBorder = false,
      EdgeInsetsGeometry? insetsGeometry,
      borderColor = Colors.transparent,
      FontWeight weight = FontWeight.normal,
      bool?prefixIcon,
      bool? sufixIcon,
      Widget? prefixImage,
      Widget? suffixImage,
      Color? imageColor,
      double? sufixIconWidth,
      double? sufixIconHeight,
      double? prefixIconWidth,
      double? prefixIconHeight,
      bool smallFont = false,
      double? buttonHeight,
      double? buttonWidth,
      List<BoxShadow> boxShadow = const [],
      EdgeInsetsGeometry? insetsGeometrypadding,
      double? borderWidth,
      double? elevation,
      double? radius,
      double? verticalPadding, 
      String fontFamily = Constant.fontsFamily}) {
  prefixIcon ??= true;
  sufixIcon ??= true;
  buttonHeight??=Dimens.size56;
  sufixIconHeight??=Dimens.size50;
  sufixIconWidth??=Dimens.size50;
  prefixIconWidth??=Dimens.size50;
  prefixIconHeight??=Dimens.size50;
  radius??=Dimens.size30;
  verticalPadding??= Dimens.size4;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: verticalPadding),
    child: Card(
      elevation: elevation??1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: InkWell(
        onTap: () {
          if(onTap!=null)
          {
            onTap();
          }
        },
        child: Container(
          margin: insetsGeometry,
          padding: insetsGeometrypadding,
          width: buttonWidth,
          height: buttonHeight,
          decoration: getButtonDecoration(
            bgColor: bgColor,
            borderRadius: BorderRadius.circular(radius),
            shadow: boxShadow,
            border: (isBorder)
                ? Border.all(color: ColorConst.borderColor, width: borderWidth!)
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            clipBehavior: Clip.hardEdge,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    getHorSpace((Dimens.size8)),
                    (prefixIcon) ?
                    SizedBox(
                        height: prefixIconHeight,
                        width: prefixIconWidth,
                        child:prefixImage!) : getHorSpace(0),
                    (prefixIcon)
                        ? getHorSpace((Dimens.size8))
                        : getHorSpace(0),
                    Text(text,
                        style: TextStyleConstant.textStyleBlack12w500.copyWith(color: textColor??ColorConst.textColorOnMainButton, fontWeight: weight, fontSize: fontsize),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                    )
                  ],
                ),
                Row(
                  children: [
                    (sufixIcon) ? SizedBox(
                        height: sufixIconHeight,
                        width: sufixIconWidth,
                        child:suffixImage??const SizedBox()) : getHorSpace(0),
                    (sufixIcon)
                        ? getHorSpace((Dimens.size8))
                        : getHorSpace(0),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget getButtonWithIcon(BuildContext context, Color bgColor, String text,
    Color? textColor, Function function, double fontsize,
    {bool isBorder = false,
    EdgeInsetsGeometry? insetsGeometry,
    borderColor = Colors.transparent,
    FontWeight weight = FontWeight.bold,
    bool prefixIcon = false,
    bool sufixIcon = false,
    String? prefixImage,
    String? suffixImage,
    Color? imageColor,
    double? imageWidth,
    double? imageHeight,
    bool smallFont = false,
    double? buttonHeight,
    double? buttonWidth,
    List<BoxShadow> boxShadow = const [],
    EdgeInsetsGeometry? insetsGeometrypadding,
    BorderRadius? borderRadius,
      Color? iconColor,
    double? borderWidth,
      double? elevation,
    String fontFamily = Constant.fontsFamily}) {
  imageHeight??=Dimens.size20;
  imageWidth??=Dimens.size20;
  iconColor??=ColorConst.mainColor;
  borderRadius??=BorderRadius.circular(Dimens.size22);
  return Card(
    elevation: elevation??1,
    shape: RoundedRectangleBorder(
        borderRadius: borderRadius!),
    child: InkWell(
      onTap: () {
        function();
      },
      child: Container(
        margin: insetsGeometry,
        padding: insetsGeometrypadding,
        width: buttonWidth,
        height: buttonHeight,
        decoration: getButtonDecoration(
          bgColor: bgColor,
          borderRadius: borderRadius,
          shadow: boxShadow,
          border: (isBorder)
              ? Border.all(color: ColorConst.borderColor, width: borderWidth!)
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  getHorSpace((Dimens.size15)),
                  (prefixIcon) ? getSvgImage(prefixImage!, height: imageHeight, width: imageWidth, color: iconColor) : getHorSpace(0),
                  (prefixIcon)
                      ? getHorSpace((Dimens.size10))
                      : getHorSpace(0),
                  Text(text,
                      style: TextStyleConstant.textStyleBlack14w500.copyWith(
                          color: textColor??ColorConst.textColorOnMainButton, fontWeight: weight, fontSize: fontsize),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                  )
                ],
              ),
              Row(
                children: [
                  (sufixIcon) ? getSvgImage(suffixImage!, height: imageHeight, width: imageWidth,  color: iconColor) : getHorSpace(0),
                  (sufixIcon)
                      ? getHorSpace((Dimens.size15))
                      : getHorSpace(0),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildLineRowInfo(
    {
      required String title,
      required String value,
      double?padding,
      TextStyle? titleStyle,
      TextStyle? contentStyle
    }) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: padding??Dimens.size8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, 
          style: titleStyle??TextStyleConstant.textStyleBlack12w500,maxLines: 4,),
        Gap(Dimens.size10),
        Expanded(
            child: Text(
              value, 
              style: contentStyle??TextStyleConstant.textStyleBlack12w400.copyWith(color: ColorConst.greyColor1),
              maxLines: 4, 
              textAlign: TextAlign.end,))
      ],
    ),
  );
}
Widget buildLineColumnInfo({required String title, required String value, int? maxlineContent}) {
  maxlineContent??=1;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: Dimens.size8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            title,
            style: TextStyleConstant.textStyleBlack14w700.copyWith(height: 2),
            textAlign: TextAlign.start),
        Text(
            value,
            style: TextStyleConstant.textStyleBlack14w400.copyWith(height: 1.7),
            maxLines: (maxlineContent),
            textAlign: TextAlign.justify
        ),
      ],
    ),
  );
}

Widget getCustomTextFiledWithLabel(
    BuildContext context,

    {
      String? initialValue,
      TextEditingController? textEditingController,
      String? hintText,
      TextStyle? hintStyle,
      TextStyle? style,
      bool withprefix = false,
    bool withSufix = false,
    bool minLines = false,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool isPass = false,
    bool isEnable = true,
    double? height,
    double? imageHeight,
    double? imageWidth,
    String? image,
    String? suffiximage,
    Function? imagefunction,
    TextInputType? keyboardType,
      Color? fillColor,
      int? maxLenght,
      Color? suffixImageColor,
      Color? prefixImageColor,
    AlignmentGeometry alignmentGeometry = Alignment.centerLeft,
      Function(String)? onSubmitted,
      Function()? onEditingComplete,
      Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,bool defFocus=false,FocusNode? focus1, FocusNode? focusNode}) {

  FocusNode myFocusNode =(focus1==null)?FocusNode():focus1;
  Color color = ColorConst.borderColor;
  
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew = mqData.copyWith(textScaler: TextScaler.linear(FetchPixels.getTextScale()));
      return Focus(
        onFocusChange: (hasFocus) {
          if (hasFocus) {
            setState(() {
              myFocusNode.canRequestFocus = true;
              color = ColorConst.buttonColor;
            });
          } else {
            setState(() {
              myFocusNode.canRequestFocus = false;
              color = ColorConst.borderColor;
            });
          }
        },
         focusNode: myFocusNode,
        child: Container(
          height: height,
          margin: margin,
          decoration: BoxDecoration(
              color: fillColor??ColorConst.bgDialogColor,
              border: Border.all(
                  color: color, width:(Dimens.size1)),
              borderRadius:
                  BorderRadius.circular((Dimens.size30))),
          child: MediaQuery(
            data: mqDataNew,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (!withprefix)
                    ? getHorSpace((Dimens.size16))
                    : Padding(
                        padding: EdgeInsets.only(
                            right:(Dimens.size8),
                            left:(Dimens.size18)),
                        child: getSvgImage(image!,
                            color: prefixImageColor??(ColorConst.getDarkMode()?ColorConst.colorIconGrays:null),
                            height:(Dimens.size24),
                            width:(Dimens.size24)),
                      ),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    initialValue: initialValue,
                    enabled: true,
                    keyboardType: keyboardType,
                    inputFormatters: inputFormatters,
                    maxLines: (minLines) ? null : 1,
                    controller: textEditingController,
                    obscuringCharacter: "*",
                    autofocus: false,
                    focusNode: focusNode,
                    maxLength: maxLenght,
                    obscureText: isPass,
                    showCursor: true,
                    onChanged: onChanged,
                    onFieldSubmitted: onSubmitted,
                    onEditingComplete: onEditingComplete,
                    style: style??TextStyle(
                        color: ColorConst.blackColor,
                        fontWeight: fontWeight500,
                        fontSize:fontSize14,
                        fontFamily: Constant.fontsFamily),
                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: hintText,
                        filled: true,
                        fillColor: fillColor??ColorConst.bgDialogColor,
                        counterText: "",
                        hintStyle: hintStyle??TextStyle(
                            color: ColorConst.colorHintTextSearch,
                            fontWeight: fontWeight500,
                            fontSize:fontSize14,
                            fontFamily: Constant.fontsFamily)),
                  ),
                ),
                (!withSufix)
                    ? getHorSpace((Dimens.size16))
                    : Padding(
                        padding: EdgeInsets.only(
                            right:(Dimens.size14),
                            left:(Dimens.size22)),
                        child: InkWell(
                          onTap: () {
                            if (imagefunction != null) {
                              imagefunction();
                            }
                          },
                          child: getSvgImage(suffiximage!,
                              color: suffixImageColor,
                              height:(Dimens.size24),
                              width:(Dimens.size24)),
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


Widget getCustomRichText(
    String firstText,
    Color firstColor,
    FontWeight firstWeight,
    double firstSize,
    String secondText,
    Color secondColor,
    FontWeight secondWeight,
    double secondSize,
    {TextAlign textAlign = TextAlign.center,
    double? txtHeight}) {
  return RichText(
    textScaleFactor: FetchPixels.getTextScale(),
    textAlign: textAlign,
    text: TextSpan(
        text: firstText,
        style: TextStyle(
          color: firstColor,
          fontWeight: firstWeight,
          fontFamily: Constant.fontsFamily,
          fontSize: firstSize,
          height: txtHeight,
        ),
        children: [
          TextSpan(
              text: secondText,
              style: TextStyle(
                  color: secondColor,
                  fontWeight: secondWeight,
                  fontFamily: Constant.fontsFamily,
                  fontSize: secondSize,
                  height: txtHeight))
        ]),
  );
}

Widget getCardDateTextField(
  BuildContext context,
  String s,
  TextEditingController textEditingController,
  Color fontColor, {
  bool minLines = false,
  EdgeInsetsGeometry margin = EdgeInsets.zero,
  bool isPass = false,
  bool isEnable = true,
  double? height,
  required Function function,
}) {
  FocusNode myFocusNode = FocusNode();
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew =
          mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());

      return AbsorbPointer(
        absorbing: isEnable,
        child: Container(
          height: height,
          margin: margin,
          alignment: Alignment.centerLeft,
          padding:
              EdgeInsets.symmetric(horizontal:(Dimens.size18)),
          decoration: BoxDecoration(
              color: ColorConst.whiteColor,
              boxShadow: [
                BoxShadow(
                    color: ColorConst.blackColor12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              borderRadius:
                  BorderRadius.circular((Dimens.size22))),
          child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  setState(() {
                    myFocusNode.canRequestFocus = true;
                  });
                } else {
                  setState(() {
                    myFocusNode.canRequestFocus = false;
                  });
                }
              },
              child: MediaQuery(
                data: mqDataNew,
                child: TextField(
                  maxLines: (minLines) ? null : 1,
                  controller: textEditingController,
                  obscuringCharacter: "*",
                  autofocus: false,
                  focusNode: myFocusNode,
                  obscureText: isPass,
                  showCursor: false,
                  onTap: () {
                    function();
                  },
                  style: TextStyle(
                      color: ColorConst.blackColor,
                      fontWeight: fontWeight400,
                      fontSize:fontSize16,
                      fontFamily: Constant.fontsFamily),
                  // textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: s,
                      hintStyle: TextStyle(
                          color: ColorConst.textColor,
                          fontWeight: fontWeight400,
                          fontSize:fontSize16,
                          fontFamily: Constant.fontsFamily)),
                ),
              )),
        ),
      );
    },
  );
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

Widget getCardEditText(BuildContext context, String s,
    TextEditingController textEditingController, Color fontColor,
    {bool withprefix = false,
    bool withSufix = false,
    bool minLines = false,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool isPass = false,
    bool isEnable = true,
    double? height,
    double? imageHeight,
    double? imageWidth,
    String? image,
    String? suffiximage,
    required Function function,
    Function? imagefunction}) {
  FocusNode myFocusNode = FocusNode();
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew =
          mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());

      return AbsorbPointer(
        absorbing: isEnable,
        child: Container(
          height: height,
          margin: margin,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: ColorConst.whiteColor,
              boxShadow: [
                BoxShadow(
                    color: ColorConst.blackColor12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              borderRadius:
                  BorderRadius.circular((Dimens.size22))),
          child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  setState(() {
                    myFocusNode.canRequestFocus = true;
                  });
                } else {
                  setState(() {
                    myFocusNode.canRequestFocus = false;
                  });
                }
              },
              child: MediaQuery(
                data: mqDataNew,
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberFormatter(),
                  ],
                  maxLines: (minLines) ? null : 1,
                  controller: textEditingController,
                  maxLength: 19,
                  obscuringCharacter: "*",
                  autofocus: false,
                  focusNode: myFocusNode,
                  obscureText: isPass,
                  showCursor: false,
                  onTap: () {
                    function();
                  },
                  style: TextStyle(
                      color: ColorConst.blackColor,
                      fontWeight: fontWeight400,
                      fontSize:fontSize16,
                      fontFamily: Constant.fontsFamily),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      counterText: "",
                      prefixIcon: (withprefix)
                          ? Padding(
                              padding: EdgeInsets.only(
                                  right:(Dimens.size22),
                                  left:(Dimens.size18)),
                              child: getSvgImage(image!,
                                  height:(Dimens.size24),
                                  width:(Dimens.size24)),
                            )
                          : null,
                      suffixIcon: (withSufix)
                          ? Padding(
                              padding: EdgeInsets.only(
                                  right:(Dimens.size18),
                                  left:(Dimens.size22)),
                              child: InkWell(
                                onTap: () {
                                  imagefunction!();
                                },
                                child: getSvgImage(suffiximage!,
                                    height:(Dimens.size24),
                                    width:(Dimens.size24)),
                              ),
                            )
                          : null,
                      border: InputBorder.none,
                      hintText: s,
                      hintStyle: TextStyle(
                          color: ColorConst.textColor,
                          fontWeight: fontWeight400,
                          fontSize:fontSize16,
                          fontFamily: Constant.fontsFamily)),
                ),
              )),
        ),
      );
    },
  );
}

Widget getSearchWidget(
    BuildContext context,
    TextEditingController searchController,
    Function filterClick,
    ValueChanged<String> onChanged,
    {
      bool withPrefix = true,
      List<BoxShadow>? boxShadow,
      bool isborder = true,
      String hint = "Search",
      bool? enableAdvanceSearch,
    }) {
  double height = (Dimens.size50);
  FocusNode myFocusNode = FocusNode();
  enableAdvanceSearch??= true;
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew =
          mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
      return Container(
        width: double.infinity,
        height: height,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: ColorConst.whiteColor,
            border: isborder == true
                ? Border.all(color: ColorConst.borderColor, width:(Dimens.size1))
                : null,
            borderRadius:
                BorderRadius.circular((Dimens.size15)),
            boxShadow: boxShadow),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: MediaQuery(
                  data: mqDataNew,
                  child: TextField(
                    onTap: () {
                      filterClick();
                    },
                    autofocus: false,
                    onChanged: onChanged,
                    focusNode: myFocusNode,
                    textInputAction: TextInputAction.search,
                    controller: searchController,
                    decoration: InputDecoration(
                      isDense: true,
                        hintText: hint,
                        suffixIconConstraints:(enableAdvanceSearch??true)? BoxConstraints(
                          maxWidth: Dimens.size40,
                          maxHeight: Dimens.size40,
                        ):null,
                        prefixIconConstraints: BoxConstraints(
                          maxWidth: Dimens.size40,
                          maxHeight: Dimens.size40,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimens.size10),
                          child: getSvgImage(ImagesNameConst.ic_serach_svg,color: ColorConst.mainColor),
                        ),
                        suffixIcon: (enableAdvanceSearch??true)?Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimens.size10),
                          child: getPngImage(
                              ImagesNameConst.ic_ic_filter_png,
                          ),
                        ):null,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: ColorConst.textColor,
                            fontWeight: fontWeight400,
                            fontSize:fontSize14,
                            fontFamily: Constant.fontsFamily)),
                    style: TextStyle(
                        color: ColorConst.blackColor,
                        fontWeight: fontWeight500,
                        fontSize:fontSize14,
                        fontFamily: Constant.fontsFamily),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  )),
            ),
            getHorSpace((Dimens.size3)),
          ],
        ),
      );
    },
  );
}

Widget getsearchVehicle(
    BuildContext context,
    TextEditingController searchController,
    Function filterClick,
    ValueChanged<String> onChanged,
    {bool withPrefix = true}) {
  double height = (Dimens.size56);
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew =
          mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());
      return AbsorbPointer(
        absorbing: false,
        child: Container(
          width: double.infinity,
          height: height,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: ColorConst.whiteColor,
              border: Border.all(
                  color: ColorConst.borderColor, width:(Dimens.size1)),
              borderRadius:
                  BorderRadius.circular((Dimens.size22))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getHorSpace((Dimens.size15)),
              Expanded(
                flex: 1,
                child: MediaQuery(
                    data: mqDataNew,
                    child: TextField(
                      onTap: () {
                        filterClick();
                      },
                      autofocus: false,
                      onChanged: onChanged,
                      textInputAction: TextInputAction.search,
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "OLA s1",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: ColorConst.textColor,
                              fontWeight: fontWeight500,
                              fontSize:fontSize14,
                              fontFamily: Constant.fontsFamily)),
                      style: TextStyle(
                          color: ColorConst.blackColor,
                          fontWeight: fontWeight500,
                          fontSize:fontSize14,
                          fontFamily: Constant.fontsFamily),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right:(Dimens.size15),
                    left:(Dimens.size15)),
                child:getSvgImage(ImagesNameConst.ic_serach_svg,
                    height:(Dimens.size24),
                    width:(Dimens.size24)),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget gettoolbarMenu(BuildContext context, String image, Function function,
    {bool istext = false,
    double? fontsize,
    String? title,
    Color? textColor,
    FontWeight? weight,
    String fontFamily = Constant.fontsFamily,
    bool isrightimage = false,
    String? rightimage,
    Function? rightFunction,
    bool isleftimage = true}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      (isleftimage)
          ? InkWell(
              onTap: () {
                function();
              },
              child: getSvgImage(image,
                  height:(Dimens.size24),
                  width:(Dimens.size24)))
          : Container(),
      Expanded(
        child: Container(
          alignment: Alignment.center,
          child: (istext)
              ? Text(title!,
              style: TextStyleConstant.textStyleBlack14w500.copyWith(
                  color: textColor, fontWeight: weight, fontSize: fontsize),
              maxLines: 1,
          )
              : null,
        ),
      ),
      (isrightimage)
          ? InkWell(
              onTap: () {
                rightFunction!();
              },
              child: getSvgImage(rightimage!,
                  height:(Dimens.size24),
                  width:(Dimens.size24)))
          : Container(),
    ],
  );
}

Widget withoutleftIconToolbar(BuildContext context,
    {bool istext = false,
    double? fontsize,
    String? title,
    Color?textColor,
    FontWeight? weight,
    String fontFamily = Constant.fontsFamily,
    bool isrightimage = false,
    String? rightimage,
    Function? rightFunction}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Container(
          alignment: Alignment.center,
          child: (istext)
              ? Text(title!,
              style: TextStyleConstant.textStyleBlack14w500.copyWith(
                  color: textColor, fontWeight: weight, fontSize: fontsize),
              maxLines: 1,
          )
              : null,
        ),
      ),
      (isrightimage)
          ? InkWell(
              onTap: () {
                rightFunction!();
              },
              child: getSvgImage(rightimage!,
                  height:(Dimens.size24),
                  width:(Dimens.size24)))
          : Container(),
    ],
  );
}

Widget getHorSpace(double verSpace) {
  return SizedBox(
    width: verSpace,
  );
}

Widget getDivider(Color color, double height, double thickness) {
  return Divider(
    color: color,
    height: height,
    thickness: thickness,
  );
}

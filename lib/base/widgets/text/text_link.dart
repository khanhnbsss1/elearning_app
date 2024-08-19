import 'package:lms_app/base/base.export.dart';
import 'package:flutter/material.dart';

class TextLink extends StatelessWidget{
  Function()? onTap;
  bool? isUnderLine;
  final String? text;
  TextStyle? style;
  bool? enable;
  final StrutStyle? strutStyle;
  TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;

  final TextWidthBasis? textWidthBasis;
  final Color? selectionColor;
  TextLink(
      {super.key, 
        this.onTap,
        this.isUnderLine,
        this.enable,
        this.text,
        this.style,
        this.strutStyle,
        this.textAlign,
        this.textDirection,
        this.locale,
        this.softWrap,
        this.overflow,
        this.textScaleFactor,
        this.maxLines,
        this.semanticsLabel,
        this.textWidthBasis,
        this.selectionColor}){
    enable??=true;
    isUnderLine??=true;
    style??=TextStyleConstant.textStyleMainColor14w600;
    if(enable == false)
      {
        style = style?.copyWith(
            color: (style?.color??ColorConst.mainColor).withOpacity(0.2),
        );
      }
    style = style?.copyWith(
      decoration: isUnderLine!?TextDecoration.underline:TextDecoration.none,
    );
    textAlign??=TextAlign.start;
    overflow??=TextOverflow.ellipsis;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: (){
        if(enable==false)
          {
            return;
          }
        if(onTap!=null){
          onTap!();
        }
      },
      child: Text(
          text??"",
        style: style,
        strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        selectionColor: selectionColor,
      ),
    );
  }

}
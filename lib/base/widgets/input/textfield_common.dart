import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:lms_app/base/base.export.dart';

class TextfieldCommon extends StatefulWidget {

  final String initInput;
  String? title;
  final Function(String value) onSubmitted;
  final Function(String value)? onTapOutSide;
  bool ?enable;
  final Function(String value) onChange;
  final String hintText;
  double? height;
  bool ?enablePrefixIcon = true;
  bool? enableSuffixIcon = true;
  int? maxLength;
  double? fontSize;
  int? maxLine;
  String value = "";
  FocusNode? focusNode;
  Color? bgColor;
  bool? isRequirement;
  double? radius =Dimens.size4;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  TextfieldCommon({
    super.key,
    required this.initInput,
    required this.onSubmitted,
    required this.onChange,
    this.onTapOutSide,
    this.hintText= "",
    this.enable,
    this.enablePrefixIcon,
    this.height,
    this.maxLength,
    this.maxLine,
    this.focusNode,
    this.bgColor,
    this.radius,
    this.textInputAction,
    this.fontSize,
    this.title,
    this.isRequirement,
    this.keyboardType,
    this.enableSuffixIcon,
    this.inputFormatters
  }){
    enablePrefixIcon= enablePrefixIcon??true;
    height = height??Dimens.size44;
    bgColor ??=ColorConst.whiteColor;
    radius??=Dimens.size20;
    enable??=true;
    fontSize??=Dimens.size14;
    title??="";
    isRequirement??=false;
    if(!enable!){
      enablePrefixIcon = false;
      enableSuffixIcon = false;
    }
  }

  @override
  State<TextfieldCommon> createState() => _TextfieldCommonState();
}

class _TextfieldCommonState extends State<TextfieldCommon> {

  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initInput;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title!.isNotEmpty?
        Padding(
          padding: EdgeInsets.symmetric(horizontal:0.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyleConstant.textStyleBlack14w400),
              Gap(Dimens.size2),
              Visibility(
                  visible: widget.isRequirement??false,
                  child:  Icon(
                    Icons.star,
                    size: Dimens.size10,
                    color: Colors.red,)
              ),


            ],
          ),
        ):
        const SizedBox.shrink(),
        SizedBox(
          height: widget.height??Dimens.size40,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: !widget.enable!,
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLine,
                  textInputAction:widget.textInputAction??TextInputAction.done,
                  keyboardType: widget.keyboardType,
                  onTapOutside: (event){
                    if(widget.onTapOutSide!=null) {
                      widget.onTapOutSide!(widget.value);
                    }
                  },
                  onChanged: (value) {
                    widget.value = value;
                    widget.onChange(value);
                    setState(() {});
                  },
                  onFieldSubmitted: (value){
                    widget.onSubmitted(value);
                  },
                  controller: _controller,
                  style: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(
                      fontSize: widget.fontSize,
                      //overflow: !widget.enable!?TextOverflow.ellipsis:TextOverflow.clip
                  ),

                  inputFormatters: widget.inputFormatters,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    contentPadding: EdgeInsets.symmetric(horizontal: Dimens.size8, vertical: Dimens.size10),
                    isDense: true,
                    hintStyle:baseStyle.copyWithCustom(
                      overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        fontSize: widget.fontSize,
                        color: ColorConst.colorHintTextSearch),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius!),
                      borderSide: BorderSide(color: ColorConst.greyColor1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius!),
                      borderSide: BorderSide(color: ColorConst.mainColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius!),
                      borderSide: BorderSide(color:  ColorConst.greyColor),
                    ),
                    prefixIcon: widget.enablePrefixIcon!?Padding(
                      padding: EdgeInsets.all(Dimens.size22),
                      child:Image.asset(
                          width: Dimens.size20,
                          height: Dimens.size20,
                          ImagesNameConst.getPngImage(ImagesNameConst.icSearch)),
                    ):null,
                    suffixIcon: widget.enableSuffixIcon??false?
                    InkWell(
                      onTap: (){
                        setState(() {
                          _controller.text = "";
                        });
                        widget.onSubmitted("");
                      },
                      child: Padding(
                        padding:  EdgeInsets.all(Dimens.size13),
                        child: Icon(
                            Icons.close,
                            size: Dimens.size15,
                            color: _controller.text.isNotEmpty
                                ? ColorConst.colorIconGrays : Colors.transparent)
                      ),
                    ):null,
                    filled: true,
                    fillColor: ColorConst.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
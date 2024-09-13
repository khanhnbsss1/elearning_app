import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';

import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text.dart';
import '../../../helpers/widgets/my_text_style.dart';

class BuildTextField extends StatefulWidget {
  final String? fieldTitle;
  final String? hintText;
  bool? enableHintText;
  final bool? enableEdit;
  Function()? onTap;
  Widget? suffixIcon;
  TextEditingController? controller;
  BuildTextField({
    this.fieldTitle,
    this.hintText,
    this.enableEdit,
    this.controller,
    this.onTap,
    this.suffixIcon,
    this.enableHintText
  }){
    enableHintText??=true;
  }

  @override
  _BuildTextFieldState createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> with TickerProviderStateMixin, UIMixin{
  bool _enableEdit = true;

  @override
  void initState() {
    super.initState();
    _enableEdit = widget.enableEdit ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: widget.enableHintText??true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText.labelMedium(widget.fieldTitle??""),
                MySpacing.height(8),
              ],
            )),
        Container(
          constraints: BoxConstraints(
            maxHeight: Dimens.size40
          ),
          child: TextFormField(
            controller: widget.controller,
            onTap: widget.onTap,
            style: TextStyleConstant.textStyleBlack14w400,
            decoration: InputDecoration(
              enabled: _enableEdit,
              hintText: widget.hintText,
              hintStyle: MyTextStyle.bodySmall(xMuted: true),
              border: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              focusedBorder: focusedInputBorder,
              contentPadding: MySpacing.all(Dimens.size16),
              suffixIcon: widget.suffixIcon,
              suffixIconConstraints: BoxConstraints(
                maxWidth: Dimens.size40,
                maxHeight: Dimens.size40,
              ),
              floatingLabelAlignment: FloatingLabelAlignment.center,
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ),
      ],
    );
  }
}
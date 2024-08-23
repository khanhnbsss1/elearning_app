import 'package:flutter/material.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';

import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text.dart';
import '../../../helpers/widgets/my_text_style.dart';

class BuildTextField extends StatefulWidget {
  final String fieldTitle;
  final String hintText;
  final bool? enableEdit;
  Function()? onTap;
  Widget? suffixIcon;
  TextEditingController? controller;
  BuildTextField({
    required this.fieldTitle,
    required this.hintText,
    this.enableEdit,
    this.controller,
    this.onTap,
    this.suffixIcon
  });

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
      children: [
        MyText.labelMedium(widget.fieldTitle),
        MySpacing.height(8),
        TextFormField(
          controller: widget.controller,
          onTap: widget.onTap,
          decoration: InputDecoration(
            enabled: _enableEdit,
            hintText: widget.hintText,
            hintStyle: MyTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: focusedInputBorder,
            contentPadding: MySpacing.all(16),
            suffixIcon: widget.suffixIcon,
            isCollapsed: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }
}
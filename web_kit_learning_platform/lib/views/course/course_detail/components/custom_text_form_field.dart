import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../controller/ui/add_lecture_controller.dart';
import '../../../../helpers/widgets/my_spacing.dart';
import '../../../../helpers/widgets/my_text_style.dart';

class CustomTextFormField extends StatefulWidget {
  final AddLectureController addLectureController;
  final String controller;
  final String label;
  final bool attachLink;
  final bool attachFile;

  CustomTextFormField({
    required this.addLectureController,
    required this.controller,
    required this.label,
    this.attachLink = false,
    this.attachFile = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField>
with SingleTickerProviderStateMixin, UIMixin{
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.addLectureController.basicValidator.getValidation(widget.controller),
      controller: widget.addLectureController.basicValidator.getController(widget.controller),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: MyTextStyle.bodySmall(xMuted: true),
        border: outlineInputBorder.copyWith(
          borderRadius: BorderRadius.circular(25),
        ),
        contentPadding: MySpacing.all(16),
        isCollapsed: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: (widget.attachFile)
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (widget.addLectureController.basicValidator.getController(widget.controller)?.text != "")
                ? IconButton(
              onPressed: () {
                setState(() {
                  widget.addLectureController.basicValidator.getController(widget.controller)?.text = "";
                });
              },
              icon: Icon(
                Icons.close_sharp,
                color: Colors.red,
              ),
            )
                : SizedBox(),
            Opacity(
              opacity: !widget.attachLink ? 0.1 : 1,
              child: IgnorePointer(
                ignoring: !widget.attachLink,
                child: IconButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type: FileType.any,
                    );
                    setState(() {
                      if (result != null) {
                        widget.addLectureController.basicValidator.getController(widget.controller)?.text = result.names[0]!;
                      } else {}
                    });
                  },
                  icon: Icon(Icons.upload_file),
                ),
              ),
            ),
          ],
        )
            : SizedBox(),
      ),
    );
  }
}
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../constants/custom_colors.dart';

class TextFormShowPassword extends StatefulWidget {
  const TextFormShowPassword({super.key, required this.controller, required this.hintText, });

  final TextEditingController controller;
  final String hintText;


  @override
  State<TextFormShowPassword> createState() => _TextFormShowPasswordState();
}

class _TextFormShowPasswordState extends State<TextFormShowPassword> {

  IconData lockIcon = LineIcons.lock;
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.container,
      child: TextFormField(
        obscureText: !obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
            hintText: widget.hintText.tr(),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 12),
            suffixIcon: IconButton(
              padding: const EdgeInsets.all(0),
              style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(0)),
              icon: Icon(
                lockIcon,
                size: 20,
              ),
              onPressed: () => {
                if (obscureText == true)
                  {
                    setState(() {
                      obscureText = false;
                      lockIcon = LineIcons.lockOpen;
                    })
                  }
                else
                  {
                    setState(() {
                      obscureText = true;
                      lockIcon = LineIcons.lock;
                    })
                  }
              },
            )),
      ),
    );
  }
}

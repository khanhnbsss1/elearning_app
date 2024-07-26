import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';

import '../../../../helpers/widgets/my_spacing.dart';
import '../../../../helpers/widgets/my_text_style.dart';

class CustomDropDownSearch extends StatefulWidget {
  final List<String?> list;
  final String hintText;
  final bool check;

  CustomDropDownSearch({
    required this.list,
    required this.hintText,
    this.check = true,
  });

  @override
  _CustomDropDownSearchState createState() => _CustomDropDownSearchState();
}

class _CustomDropDownSearchState extends State<CustomDropDownSearch>
with SingleTickerProviderStateMixin, UIMixin{
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      enabled: widget.check,
      popupProps: PopupProps.menu(
        constraints: BoxConstraints(
          maxHeight: (65 + widget.list.length * 50 < 210) ? 65 + widget.list.length * 50 : 210,
        ),
        showSearchBox: true,
        searchDelay: Duration(seconds: 0),
        showSelectedItems: true,
      ),
      items: widget.list.map((e) => e ?? '').toList(),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.book,
            size: 20,
            color: Color.fromRGBO(163, 20, 19, 1.0),
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
      onChanged: (value) {
        setState(() {
          _controller.text = value ?? "";
        });
      },
    );
  }
}
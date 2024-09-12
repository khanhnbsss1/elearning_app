import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';

class DropDownSearch extends StatelessWidget with UIMixin{
  Map<int, String> list;
  String? hintText;
  TextEditingController? controller;
  Function(MapEntry)? onChange;
  dynamic selectItem;
  DropDownSearch({required this.list, this.controller,this.hintText, this.selectItem, this.onChange});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  customDropDownSearch(list: list, hintText: hintText??'', controller: controller, selectItem: selectItem);
  }
  Widget customDropDownSearch({required Map<int, String> list, required String hintText, required TextEditingController? controller, dynamic selectItem}) {
    String selectString = (selectItem??"").toString();
    if (selectItem.runtimeType == int) {
      selectString = list[selectItem as int] ?? "";
    }
    return DropdownSearch<String>(
      // enabled: (state.courseInfo?.mode??"PREMIUM")=="PREMIUM",
      dropdownButtonProps: DropdownButtonProps(
          padding: EdgeInsets.zero
      ),
      popupProps: PopupProps.menu(
        constraints: BoxConstraints(
          maxHeight: (65 + list.length * 50 < 210) ? 65 + list.length * 50 : 210,
        ),
        showSearchBox: true,
        searchDelay: Duration(seconds: 0),
        showSelectedItems: true,
      ),
      items: list.values.toList(),
      selectedItem: selectString.isNotEmpty ? selectString : null,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText,
          labelText: hintText,
          hintTextDirection: AppTheme.textDirection,
          labelStyle: TextStyleConstant.textStyleBlack14w400,
          hintStyle: TextStyleConstant.textStyleBlack14w400,
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.book,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          suffixIcon: Icon(
            LucideIcons.search,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          // isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
      onChanged: (value) {
        controller?.text = value ?? "";
        MapEntry valueOnchange = list.entries.toList().firstWhere((element) => element.value == value,);
        if(onChange!=null)
          {
            onChange!(valueOnchange);
          }
      },
    );
  }
}
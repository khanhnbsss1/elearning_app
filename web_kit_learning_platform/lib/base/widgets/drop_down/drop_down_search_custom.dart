import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';

class DropDownSearchCustom<T> extends DropdownSearch<T> with UIMixin{
  String? hintText;
  bool? enable;
  IconData? prefixIcon;
  List<T>? itemsData;
  Widget Function(BuildContext, T, bool, bool)? dropDownItemBuilder;
  DropDownSearchCustom(
      {
        this.hintText, 
        this.dropDownItemBuilder,
        this.prefixIcon,
        this.enable,
        this.itemsData,
        super.key,
        super.items,
        super.mode = Mode.form,
        super.autoValidateMode = AutovalidateMode.disabled,
        super.onChanged,
        super.dropdownBuilder,
        super.suffixProps = const DropdownSuffixProps(),
        super.clickProps = const ClickProps(),
        super.enabled = true,
        super.filterFn,
        super.itemAsString,
        super.compareFn,
        super.onBeforeChange,
        super.onBeforePopupOpening,
        //form properties
        super.onSaved,
        super.validator,
        super.selectedItem,
        super.decoratorProps,
        super.popupProps
      }){
    super.decoratorProps = DropDownDecoratorProps(
      decoration: InputDecoration(
        //hintText: hintText,
        labelText: hintText,
        floatingLabelStyle:  TextStyleConstant.textStyleBlack13w400,
        //hintTextDirection: AppTheme.textDirection,
        labelStyle: TextStyleConstant.textStyleBlack14w400,
        hintStyle: TextStyleConstant.textStyleBlack14w400,
        helperStyle: TextStyleConstant.textStyleBlack14w400,

        border: outlineInputBorder.copyWith(borderRadius: BorderRadius.circular(Dimens.size16)),
        prefixIcon: Icon(
          prefixIcon,
          size: Dimens.size20,
          color: ColorConst.colorIconRed,
        ),
        suffixIcon: Icon(
          LucideIcons.search,
          size: Dimens.size20,
          color: ColorConst.colorIconRed,
        ),
        contentPadding: EdgeInsets.symmetric( vertical:  Dimens.size4, horizontal: Dimens.size16),
        constraints: BoxConstraints(
          minHeight: Dimens.size30,
          maxHeight: Dimens.size40,
        ),
        prefixIconConstraints: BoxConstraints(
          minHeight: Dimens.size30,
          maxHeight: Dimens.size40,
          minWidth: Dimens.size30,
          maxWidth: Dimens.size40,
        ),
        // isCollapsed: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
    super.suffixProps = DropdownSuffixProps(
      dropdownButtonProps: DropdownButtonProps(
        padding: EdgeInsets.zero,
        style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(TextStyleConstant.textStyleBlack13w400,)
        ),
        constraints: BoxConstraints(
          minHeight: Dimens.size20,
          maxHeight: Dimens.size40,
        ),
      ),
    );
    super.popupProps = PopupPropsMultiSelection.from( 
      PopupProps.menu(
          constraints: BoxConstraints(
            maxHeight: (65 + (itemsData??[]).length * 50 < 210) ? 65 + (itemsData??[]).length * 50 : 210,
          ),
      showSearchBox: true,
      searchFieldProps: TextFieldProps(
        decoration: InputDecoration(
          //hintText: hintText,
          //labelText: hintText,
          floatingLabelStyle:  TextStyleConstant.textStyleBlack13w400,
          //hintTextDirection: AppTheme.textDirection,
          labelStyle: TextStyleConstant.textStyleBlack14w400,
          hintStyle: TextStyleConstant.textStyleBlack14w400,
          helperStyle: TextStyleConstant.textStyleBlack14w400,

          border: outlineInputBorder.copyWith(borderRadius: BorderRadius.circular(Dimens.size16)),
          contentPadding: EdgeInsets.symmetric( vertical:  Dimens.size4, horizontal: Dimens.size16),
          constraints: BoxConstraints(
            minHeight: Dimens.size30,
            maxHeight: Dimens.size40,
          ),
          prefixIconConstraints: BoxConstraints(
            minHeight: Dimens.size30,
            maxHeight: Dimens.size40,
            minWidth: Dimens.size30,
            maxWidth: Dimens.size40,
          ),
          // isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
      searchDelay: Duration(seconds: 0),
      showSelectedItems: true,
      itemBuilder: dropDownItemBuilder
    ),);
  }
}
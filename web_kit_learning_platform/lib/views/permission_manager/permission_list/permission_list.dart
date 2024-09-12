import 'package:flutter/material.dart';

import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/views/layouts/layout.dart';

import 'components/permission_group_list.dart';

class PermissionListPage extends StatefulWidget {
  PermissionListPage({super.key});
  @override
  State<PermissionListPage> createState() => _PermissionListPageState();
}

class _PermissionListPageState extends State<PermissionListPage> with SingleTickerProviderStateMixin, UIMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        isScroll: false,
        title: Center(
          child: Text(L10nX.getStr.permission_list_str,
            style: TextStyleConstant.textStyleBlack18w600,),),
        padding: EdgeInsets.only(top: Dimens.size60),
        child: PermissionGroupListPage()
        );
  }

}

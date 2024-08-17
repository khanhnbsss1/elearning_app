import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/common/alert_dialog/loading.export.dart';
import 'package:webkit/views/layouts/layout.dart';

class PermissionPage extends StatelessWidget{
  PermissionPage({this.permissionList, this.child});
  Widget? child;
  List<String>?permissionList=[];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(!UserManager().userContainPermission(permissionList: permissionList??[]))  /// neu nguười dùng không có quyê truy cập vào page
    {
      return Layout(
        isScroll: false,
        child: Center(child: NoData(
          title: L10nX.getStr.not_access_permission,
          icon: Icon(Icons.no_encryption_gmailerrorred_outlined,color: ColorConst.mainColor,size: 80,),
          size: Dimens.size80,
        ),
      ));
    }
    else
    {
      return child??SizedBox();
    }
     
  }
  
}
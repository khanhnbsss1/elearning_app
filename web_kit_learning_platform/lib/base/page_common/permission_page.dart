import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/common/alert_dialog/loading.export.dart';

class PermissionPage extends StatelessWidget{
  PermissionPage({this.permissionList, this.child});
  Widget? child;
  List<String>?permissionList=[];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: UserManager().getUserProfile(), 
        builder: (context, snapshot) {
          if(snapshot.hasError || !snapshot.hasData)
            {
              return Center(child: LoadingLogo(loadingType:LoadingType.loadOnPage ,));
            }
          else
            {
              UserProfile? userProfile = snapshot.data;
              if((permissionList??[]).isNotEmpty && (permissionList??[]).where((element) => !((userProfile?.getPermission()??'').contains(element))).isNotEmpty)  /// neu nguười dùng không có quyê truy cập vào page
                {
                  return Center(child: NoData(
                    title: L10nX.getStr.not_access_permission,
                    icon: Icon(Icons.no_encryption_gmailerrorred_outlined,color: ColorConst.mainColor,),
                  ));
                }
              else
                {
                  return child??SizedBox();
                }
            }
        },);
     
  }
  
}
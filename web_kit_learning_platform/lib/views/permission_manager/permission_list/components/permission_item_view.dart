import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/landing_page/components/colornotifier.dart';
import 'package:webkit/services/apis/permission/models/permission_info.dart';
import 'package:flutter_switch/flutter_switch.dart';

class GroupPermissionItemView extends StatelessWidget {
  GroupPermissionItemView({
    required this.info,
    this.onViewDetail,
    this.onChange,
    this.onDelete,
    this.controller,
    this.enableEdit
  }){
    enableEdit??=false;
  }
  ScrollController? controller;
  Function(PermissionGroupInfo)?onViewDetail;
  Function(PermissionGroupInfo)?onChange;
  Function(PermissionGroupInfo)?onDelete;

  bool? enableEdit;
  PermissionGroupInfo info;
  late ColorNotifier notifier;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { 
      return  LayoutBuilder(builder: (context, constraints) {
        List<Widget> permissionList = [];
        for(PermissionInfo permissionInfo in info.permission??[])
          {
            permissionList.add(
                PermissionItemWidget(
                  permissionInfo: permissionInfo,
                  enableEdit: enableEdit,
                  onChange: (p0) {
                    int index = (info.permission??[]).indexWhere((element) => element.value == p0.value,);
                    (info.permission??[])[index] = p0;
                    if(onChange!=null){
                      onChange!(info);
                    }
                  },
                ));
          }
        return Container(
          decoration: BoxDecoration(
              color: notifier.whitecolor,
              border: Border(
                  bottom: BorderSide(
                      color: ColorConst.dividerColor,
                      width: 0.5
                  )
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        info.descriptionType??"",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleConstant.normalTextOnBackGroundColorStyle16w400.copyWith(
                          color: ColorConst.mainColor,
                          fontSize: ResponsiveInfo.isPhone()?Dimens.size18:Dimens.size16,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    FlutterSwitch(
                      width: Dimens.size60,
                      height: Dimens.size30,
                      valueFontSize: Dimens.size14,
                      toggleSize: Dimens.size25,
                      value: info.isActivate??false,
                      borderRadius: Dimens.size20,
                      padding: Dimens.size4,
                      showOnOff: true,
                      disabled: !(enableEdit??true),
                      activeColor: Colors.green,
                      activeIcon: Icon(Icons.check_circle_outline_outlined, color: Colors.green,),
                      onToggle: (val) {
                        setState(() {
                          info.setActiveAllPermission(val);
                          if(onChange!=null){
                            onChange!(info);
                          }
                        });
                      },
                    ),
                  ],
                ),
                Gap(Dimens.size16),
                GridView.count(
                  //controller: controller,
                  crossAxisSpacing: Dimens.size24,
                  childAspectRatio: (constraints.maxWidth/3 -24) / (60),
                  mainAxisSpacing: Dimens.size16,
                  crossAxisCount: MediaQuery.of(context).size.width>Dimens.size900?3: 1,
                  shrinkWrap: true,
                  children: permissionList,
                ),
              ],
            ),
          ),
        );
      },);
    },
    );
  }
}
class PermissionItemWidget extends StatefulWidget{
  PermissionInfo? permissionInfo;
  bool? enableEdit;
  Function(PermissionInfo)?onChange;
  PermissionItemWidget({this.permissionInfo, this.onChange, this.enableEdit}){
    enableEdit??=true;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PermissionItemWidgetState();
  }
  
}
class PermissionItemWidgetState extends State<PermissionItemWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Row(
     mainAxisSize: MainAxisSize.min,
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       FlutterSwitch(
         width: Dimens.size60,
         height: Dimens.size30,
         valueFontSize: Dimens.size14,
         toggleSize: Dimens.size25,
         value: widget.permissionInfo?.isActivate??false,
         borderRadius: Dimens.size20,
         padding: Dimens.size4,
         showOnOff: true,
         disabled: !(widget.enableEdit??true),
         activeColor: Colors.green,
         activeIcon: Icon(Icons.check_circle_outline_outlined, color: Colors.green,),
         onToggle: (val) {
           setState(() {
             widget.permissionInfo?.isActivate = val;
             if(widget.onChange!=null)
               {
                 widget.onChange!( widget.permissionInfo!);
               }
           });
         },
       ),
       Gap(Dimens.size8),
       Expanded(child: Text(widget.permissionInfo?.descriptionValue??"", style: TextStyleConstant.textStyleBlack13w400,))
     ],
   );
  }

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/services/apis/roles/models/roles_info.dart';
import 'package:webkit/views/permission_manager/permission_list/components/permission_group_list.dart';
import '../../../base/widgets/widget_common/widget_with_title_common.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import 'bloc/role_detail_bloc.dart';

class CreateEditRole extends StatefulWidget {
   RoleInfo? roleInfo;
   ActionType? roleActionType;
   CreateEditRole({super.key, this.roleInfo, this.roleActionType}){
     roleActionType??= ActionType.create;
   }

  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          double width = MediaQuery.of(context).size.width * (ResponsiveInfo.isTablet() ? 0.7 : 0.9);
          if(width<500) {
            width = 500;
          }
          return Dialog(
            child: SizedBox(
                width: width,
                height: MediaQuery.of(context).size.height * (ResponsiveInfo.isTablet() ? 0.9 : 0.9),
                key: UniqueKey(),
                child: this
            ),
          );
        });
  }

  @override
  State<CreateEditRole> createState() => _CreateEditRole();
}

class _CreateEditRole extends State<CreateEditRole>
    with TickerProviderStateMixin, UIMixin {
  
  late bool enableEdit;
  late RoleDetailState _state;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enableEdit = widget.roleActionType!=ActionType.view;

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.size20))
      ),
      clipBehavior: Clip.antiAlias,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConst.mainColor,
          iconTheme: IconThemeData(
            color: ColorConst.whiteColor, //change your color here
          ),
          title: Text( widget.roleInfo?.id!=null?L10nX.getStr.role_edit_str:L10nX.getStr.role_create_str, style: TextStyleConstant.textStyleBlack20w700.copyWith(color: ColorConst.whiteColor),),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: ColorConst.dividerColor, width: 1)),
            color: ColorConst.whiteColor
          ), 
            child: roleDetail()),
      ),
    );
  }
  
  Widget roleDetail() {
    return BlocProvider(
      create: (context) {
        return RoleDetailBloc(RoleDetailState(roleInfo: widget.roleInfo, roleActionType: widget.roleActionType))
          ..add(RoleDetailInitEvent());
      },
      child: BlocConsumer<RoleDetailBloc, RoleDetailState>(
        listener: (context, state) {
          switch (state.blocStatus) {
            case RoleDetailStatus.initial:
              break;
            case RoleDetailStatus.onCreateRole:
              Navigator.of(context).pop();
              break;
            case RoleDetailStatus.onUpdateRole:
              Navigator.of(context).pop();
              break;
            default:
              break;
          }
          state.blocStatus = RoleDetailStatus.unKnown;
        },
        builder: (BuildContext context, state) {
          _state = state;
          return LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: buildRoleName(context: context)),
                              Gap(Dimens.size50),
                              Expanded(child: buildRoleDescription(context: context)),
                            ],
                          ),
                          MySpacing.height(16), 
                          Expanded(child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimens.size16),
                                border: Border.all(color: ColorConst.colorIconGrays.withOpacity(0.5), width: 0.5)
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 8.0),
                                child: PermissionGroupListPage(
                                  scrollController: scrollController,
                                  enableEdit: true,
                                  onChangePermission: (p0) {
                                    
                                  },
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildRoleName({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: L10nX.getStr.role_str,
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _state.editingControllerRoleName,
        enabled: enableEdit,
        decoration: InputDecoration(
          labelText: L10nX.getStr.role_str,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            Icons.title,
            size: Dimens.size20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }

  Widget buildRoleDescription({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: L10nX.getStr.description,
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        keyboardType: TextInputType.text,
        enabled: enableEdit,
        controller: _state.editingControllerRoleDescription,
        decoration: InputDecoration(
          labelText: L10nX.getStr.description,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            Icons.note_alt_outlined,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }

  Widget buildRoleNormalizedName({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: L10nX.getStr.content_str,
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        enabled: enableEdit,
        controller: _state.editingControllerNormalizedName,
        minLines: 5,
        maxLines: 10,
        decoration: InputDecoration(
          labelText: L10nX.getStr.content_str,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          alignLabelWithHint: true,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}

part of 'role_detail_bloc.dart';

enum RoleDetailStatus {
  initial,
  onCreateRole,
  onUpdateRole,
  onChangePermission,
  unKnown
}

@immutable
class RoleDetailState extends Equatable {
  RoleDetailStatus? blocStatus;
  RoleInfo? roleInfo;
  ActionType? roleActionType;
  TextEditingController? editingControllerRoleName;
  TextEditingController? editingControllerRoleDescription ;
  TextEditingController? editingControllerNormalizedName ;
  PermissionListResponseModel? permissionList;
  RoleDetailState({
    this.blocStatus,
    this.roleInfo,
    this.roleActionType,
    this.permissionList
  }){
    editingControllerRoleName??=TextEditingController(text: roleInfo?.name??'');
    editingControllerRoleDescription??=TextEditingController(text: roleInfo?.name??'');
    editingControllerNormalizedName??=TextEditingController(text: roleInfo?.normalizedName??'');

  }


  RoleDetailState copyWith({
    RoleDetailStatus? blocStatus,
    RoleInfo? roleInfo,
    ActionType? roleActionType,
    PermissionListResponseModel? permissionList
  })
  {
    return RoleDetailState(
      blocStatus: blocStatus??this.blocStatus,
      roleInfo: roleInfo??this.roleInfo,
      roleActionType: roleActionType??this.roleActionType,
      permissionList: permissionList??this.permissionList,

    );
  }
  @override
  List<Object?> get props => [blocStatus, permissionList, roleInfo, roleActionType];

}
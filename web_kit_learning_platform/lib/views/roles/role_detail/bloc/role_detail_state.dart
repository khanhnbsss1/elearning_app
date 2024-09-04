part of 'role_detail_bloc.dart';

enum RoleDetailStatus {
  initial,
  onCreateRole,
  onUpdateRole,
  onChangePermission,
  onUpdateRoleInfo,
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
  List<PermissionInfo>? permissionAdd;
  List<PermissionInfo>? permissionRemove;

  RoleDetailState({
    this.blocStatus,
    this.roleInfo,
    this.roleActionType,
    this.permissionList,
    this.permissionAdd,
    this.editingControllerRoleName,
    this.editingControllerNormalizedName,
    this.editingControllerRoleDescription,
    this.permissionRemove
  }){
    editingControllerRoleName??=TextEditingController(text: roleInfo?.name??'');
    editingControllerRoleDescription??=TextEditingController(text: roleInfo?.name??'');
    editingControllerNormalizedName??=TextEditingController(text: roleInfo?.normalizedName??'');
    permissionAdd??=[];
    permissionRemove??=[];
  }


  RoleDetailState copyWith({
    RoleDetailStatus? blocStatus,
    RoleInfo? roleInfo,
    ActionType? roleActionType,
    PermissionListResponseModel? permissionList,
    List<PermissionInfo>? permissionAdd,
    List<PermissionInfo>? permissionRemove,
    TextEditingController? editingControllerRoleName,
    TextEditingController? editingControllerRoleDescription ,
    TextEditingController? editingControllerNormalizedName ,
  })
  {
    return RoleDetailState(
      blocStatus: blocStatus??this.blocStatus,
      roleInfo: roleInfo??this.roleInfo,
      roleActionType: roleActionType??this.roleActionType,
      //permissionList: permissionList??this.permissionList,
      permissionAdd: permissionAdd??this.permissionAdd,
      permissionRemove: permissionRemove??this.permissionRemove,
      editingControllerRoleName: editingControllerRoleName??this.editingControllerRoleName,
      editingControllerRoleDescription: editingControllerRoleDescription??this.editingControllerRoleDescription,
      editingControllerNormalizedName: editingControllerNormalizedName??this.editingControllerNormalizedName,

    );
  }
  @override
  List<Object?> get props => [
    blocStatus, 
    permissionList, 
    roleInfo, 
    roleActionType, 
    permissionAdd, 
    permissionRemove, 
    editingControllerNormalizedName,
    editingControllerRoleName,
    editingControllerRoleDescription
  ];

}
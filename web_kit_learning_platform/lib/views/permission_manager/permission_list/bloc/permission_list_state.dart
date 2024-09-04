part of 'permission_list_bloc.dart';

enum PermissionListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
  onSelectTag,
  onChangePermission,
  unKnow
}

@immutable
class PermissionListState extends Equatable {
  PermissionListResponseModel? permissionListResponseModel;
  PermissionListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  List<PermissionGroupInfo>? contentView;
  List<PermissionInfo>? childRolePermissions;
  bool? enableEdit;
  PermissionActionType? permissionActionType;
  String? roleId;
  PermissionListState({
      this.blocStatus, 
    this.permissionListResponseModel,
    this.searchCommonRequest,
    this.contentView,
    this.childRolePermissions,
    this.enableEdit,
    this.permissionActionType,
    this.roleId
  }){
    enableEdit??=false;
    permissionListResponseModel??= PermissionListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 10, keyword: "");
    permissionActionType??=PermissionActionType.vieMyselfPermission;
  }


  PermissionListState copyWith({
    PermissionListResponseModel? permissionListResponseModel,
    PermissionListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    GradeInfo? selectInfo,
    List<PermissionGroupInfo>? contentView,
    List<PermissionInfo>? childRolePermissions,
    bool? enableEdit,
    PermissionActionType? permissionActionType,
    String? roleId
  })
  {
    return PermissionListState(
      blocStatus: blocStatus??this.blocStatus,
      permissionListResponseModel: permissionListResponseModel??this.permissionListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      contentView: contentView??this.contentView,
      childRolePermissions: childRolePermissions??this.childRolePermissions,
      enableEdit: enableEdit??this.enableEdit,
      permissionActionType: permissionActionType??this.permissionActionType,
      roleId: roleId??this.roleId,

    );
  }
  @override
  List<Object?> get props => [
    blocStatus, 
    permissionListResponseModel, 
    searchCommonRequest,
    contentView, 
    childRolePermissions, 
    enableEdit, 
    permissionActionType,
    roleId
  ];

}
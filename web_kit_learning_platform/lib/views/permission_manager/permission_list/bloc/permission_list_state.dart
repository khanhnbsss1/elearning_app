part of 'permission_list_bloc.dart';

enum PermissionListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
  onSelectTag
}

@immutable
class PermissionListState extends Equatable {
  PermissionListResponseModel? tagListResponseModel;
  PermissionListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  List<PermissionGroupInfo>? contentView;
  List<PermissionInfo>? childRolePermissions;

  PermissionListState({
      this.blocStatus, 
    this.tagListResponseModel,
    this.searchCommonRequest,
    this.contentView,
    this.childRolePermissions,
  }){
    tagListResponseModel??= PermissionListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 10, keyword: "");
  }


  PermissionListState copyWith({
    PermissionListResponseModel? tagListResponseModel,
    PermissionListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    GradeInfo? selectInfo,
    List<PermissionGroupInfo>? contentView,
    List<PermissionInfo>? childRolePermissions
  })
  {
    return PermissionListState(
      blocStatus: blocStatus??this.blocStatus,
      tagListResponseModel: tagListResponseModel??this.tagListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      contentView: contentView??this.contentView,
      childRolePermissions: childRolePermissions??this.childRolePermissions,

    );
  }
  @override
  List<Object?> get props => [blocStatus, tagListResponseModel, searchCommonRequest,contentView, childRolePermissions];

}
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
  PermissionListState({
      this.blocStatus, 
    this.tagListResponseModel,
    this.searchCommonRequest,
    this.contentView
  }){
    tagListResponseModel??= PermissionListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 10, keyword: "");
  }


  PermissionListState copyWith({
    PermissionListResponseModel? tagListResponseModel,
    PermissionListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    GradeInfo? selectInfo,
    List<PermissionGroupInfo>? contentView
  })
  {
    return PermissionListState(
      blocStatus: blocStatus??this.blocStatus,
      tagListResponseModel: tagListResponseModel??this.tagListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      contentView: contentView??this.contentView,

    );
  }
  @override
  List<Object?> get props => [blocStatus, tagListResponseModel, searchCommonRequest,contentView];

}
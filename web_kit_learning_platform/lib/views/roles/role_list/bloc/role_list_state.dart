part of 'role_list_bloc.dart';

enum LessonListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
  onSelectLesson
}

@immutable
class RoleListState extends Equatable {
  RolesListResponseModel? roleListResponseModel;
  LessonListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  List<RoleInfo>? contentView;
  RoleListState({
      this.blocStatus, 
    this.roleListResponseModel,
    this.searchCommonRequest,
    this.contentView
  }){
    roleListResponseModel??= RolesListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 10, keyword: "");
  }


  RoleListState copyWith({
    RolesListResponseModel? roleListResponseModel,
    LessonListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    List<RoleInfo>? contentView,
  })
  {
    return RoleListState(
      blocStatus: blocStatus??this.blocStatus,
      roleListResponseModel: roleListResponseModel??this.roleListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      contentView: contentView??this.contentView,

    );
  }
  @override
  List<Object?> get props => [
    blocStatus, 
    roleListResponseModel,
    searchCommonRequest,
    contentView];

}
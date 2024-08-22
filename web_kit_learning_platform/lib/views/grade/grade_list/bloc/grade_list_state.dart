part of 'grade_list_bloc.dart';

enum GradeListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
  onSelectTag
}

@immutable
class GradeListState extends Equatable {
  GradeListResponseModel? tagListResponseModel;
  GradeListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  GradeInfo? selectInfo;
  GradeListState({
      this.blocStatus, 
    this.tagListResponseModel,
    this.searchCommonRequest,
    this.selectInfo
  }){
    tagListResponseModel??= GradeListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 10, keyword: "");
  }


  GradeListState copyWith({
    GradeListResponseModel? tagListResponseModel,
    GradeListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    GradeInfo? selectInfo
  })
  {
    return GradeListState(
      blocStatus: blocStatus??this.blocStatus,
      tagListResponseModel: tagListResponseModel??this.tagListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectInfo: selectInfo??this.selectInfo,

    );
  }
  @override
  List<Object?> get props => [blocStatus, tagListResponseModel, searchCommonRequest, selectInfo];

}
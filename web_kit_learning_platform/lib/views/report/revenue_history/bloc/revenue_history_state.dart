part of 'revenue_history_bloc.dart';

enum RevenueHistoryListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
}

@immutable
class RevenueHistoryListState extends Equatable {
  RevenueHistoryListResponseModel? lessonListResponseModel;
  RevenueHistoryListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  RevenueHistoryInfo? selectLessonInfo;
  RevenueHistoryListState({
      this.blocStatus, 
    this.lessonListResponseModel,
    this.searchCommonRequest,
    this.selectLessonInfo
  }){
    lessonListResponseModel??= RevenueHistoryListResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 20, keyword: "");
  }


  RevenueHistoryListState copyWith({
    RevenueHistoryListResponseModel? lessonListResponseModel,
    RevenueHistoryListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    RevenueHistoryInfo? selectLessonInfo
  })
  {
    return RevenueHistoryListState(
      blocStatus: blocStatus??this.blocStatus,
      lessonListResponseModel: lessonListResponseModel??this.lessonListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectLessonInfo: selectLessonInfo??this.selectLessonInfo,

    );
  }
  @override
  List<Object?> get props => [blocStatus, lessonListResponseModel, searchCommonRequest, selectLessonInfo];

}
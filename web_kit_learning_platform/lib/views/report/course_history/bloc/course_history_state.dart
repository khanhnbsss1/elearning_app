part of 'course_history_bloc.dart';

enum CourseHistoryListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
}

@immutable
class CourseHistoryListState extends Equatable {
  CourseHistoryListResponseModel? lessonListResponseModel;
  CourseHistoryListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  RevenueHistoryInfo? selectLessonInfo;
  CourseHistoryListState({
      this.blocStatus, 
    this.lessonListResponseModel,
    this.searchCommonRequest,
    this.selectLessonInfo
  }){
    lessonListResponseModel??= CourseHistoryListResponseModel(content: []);
    DateTime endTime = DateTime.now();
    DateTime startTime = DateTime.now().copyWith(month: endTime.month -1,);

    String startTimeStr = DateTimeHelper.dateFormat(date: startTime, dateType: DateTimeHelper.yyyyMMDD);
    String endTimeStr = DateTimeHelper.dateFormat(date: endTime, dateType: DateTimeHelper.yyyyMMDD);
    searchCommonRequest??= SearchCommonRequest(
        pageNumber: 0, 
        pageSize: 20,
        keyword: "",
      startDate: startTimeStr,
      endDate: endTimeStr
    );
  }


  CourseHistoryListState copyWith({
    CourseHistoryListResponseModel? lessonListResponseModel,
    CourseHistoryListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    RevenueHistoryInfo? selectLessonInfo
  })
  {
    return CourseHistoryListState(
      blocStatus: blocStatus??this.blocStatus,
      lessonListResponseModel: lessonListResponseModel??this.lessonListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectLessonInfo: selectLessonInfo??this.selectLessonInfo,

    );
  }
  
  
  @override
  List<Object?> get props => [blocStatus, lessonListResponseModel, searchCommonRequest, selectLessonInfo];

}
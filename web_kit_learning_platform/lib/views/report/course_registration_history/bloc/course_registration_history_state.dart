part of 'course_registration_history_bloc.dart';

enum CourseRegistrationHistoryListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
}

@immutable
class CourseRegistrationHistoryListState extends Equatable {
  CourseRegisteredHistoryListResponseModel? lessonListResponseModel;
  CourseRegistrationHistoryListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  RevenueHistoryInfo? selectLessonInfo;
  CourseRegistrationHistoryListState({
      this.blocStatus, 
    this.lessonListResponseModel,
    this.searchCommonRequest,
    this.selectLessonInfo
  }){
    lessonListResponseModel??= CourseRegisteredHistoryListResponseModel(content: []);
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


  CourseRegistrationHistoryListState copyWith({
    CourseRegisteredHistoryListResponseModel? lessonListResponseModel,
    CourseRegistrationHistoryListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    RevenueHistoryInfo? selectLessonInfo
  })
  {
    return CourseRegistrationHistoryListState(
      blocStatus: blocStatus??this.blocStatus,
      lessonListResponseModel: lessonListResponseModel??this.lessonListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectLessonInfo: selectLessonInfo??this.selectLessonInfo,

    );
  }
  
  
  @override
  List<Object?> get props => [blocStatus, lessonListResponseModel, searchCommonRequest, selectLessonInfo];

}
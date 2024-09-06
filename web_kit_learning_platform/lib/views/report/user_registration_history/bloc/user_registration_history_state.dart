part of 'user_registration_history_bloc.dart';

enum UserRegistrationHistoryListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
}

@immutable
class UserRegistrationHistoryListState extends Equatable {
  RegisterTimePeriodResponseModel? lessonListResponseModel;
  UserRegistrationHistoryListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  RevenueHistoryInfo? selectLessonInfo;
  UserRegistrationHistoryListState({
      this.blocStatus, 
    this.lessonListResponseModel,
    this.searchCommonRequest,
    this.selectLessonInfo
  }){
    lessonListResponseModel??= RegisterTimePeriodResponseModel(content: []);
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


  UserRegistrationHistoryListState copyWith({
    RegisterTimePeriodResponseModel? lessonListResponseModel,
    UserRegistrationHistoryListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    RevenueHistoryInfo? selectLessonInfo
  })
  {
    return UserRegistrationHistoryListState(
      blocStatus: blocStatus??this.blocStatus,
      lessonListResponseModel: lessonListResponseModel??this.lessonListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectLessonInfo: selectLessonInfo??this.selectLessonInfo,

    );
  }
  
  
  @override
  List<Object?> get props => [blocStatus, lessonListResponseModel, searchCommonRequest, selectLessonInfo];

}
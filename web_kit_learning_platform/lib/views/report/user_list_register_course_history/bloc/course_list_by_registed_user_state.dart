part of 'course_list_by_registed_user_bloc.dart';

enum CourseListByRegistedUserStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
}

@immutable
class CourseListByRegistedUserState extends Equatable {
  CourseResponseModel? courseResponseModel;
  CourseListByRegistedUserStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  RevenueHistoryInfo? selectLessonInfo;
  CourseListByRegistedUserState({
      this.blocStatus, 
    this.courseResponseModel,
    this.searchCommonRequest,
    this.selectLessonInfo
  }){
    courseResponseModel??= CourseResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(
        pageNumber: 0, 
        pageSize: 20,
        keyword: "",
    );
  }


  CourseListByRegistedUserState copyWith({
    CourseResponseModel? courseResponseModel,
    CourseListByRegistedUserStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    RevenueHistoryInfo? selectLessonInfo
  })
  {
    return CourseListByRegistedUserState(
      blocStatus: blocStatus??this.blocStatus,
      courseResponseModel: courseResponseModel??this.courseResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectLessonInfo: selectLessonInfo??this.selectLessonInfo,

    );
  }
  
  
  @override
  List<Object?> get props => [blocStatus, courseResponseModel, searchCommonRequest, selectLessonInfo];

}
part of 'course_list_bloc.dart';

enum CourseStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd
}
enum CourseType{
  courseList,
  myCourseList
}

@immutable
class CourseListState extends Equatable {
  CourseResponseModel? courseResponseModel;
  CourseStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  CourseType? courseType;
  UserProfile? userProfile;
  CourseListState({
      this.blocStatus, 
    this.courseResponseModel,
    this.searchCommonRequest,
    this.courseType,
    this.userProfile
  }){
    courseResponseModel??= CourseResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(filterType: "ALL", pageNumber: 0, pageSize: 10, keyword: "");
    courseType??= CourseType.courseList;
  }


  CourseListState copyWith({
    CourseResponseModel? courseResponseModel,
    CourseStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    CourseType? courseType,
    UserProfile? userProfile
  })
  {
    return CourseListState(
      blocStatus: blocStatus??this.blocStatus,
      courseResponseModel: courseResponseModel??this.courseResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      courseType: courseType??this.courseType,
      userProfile: userProfile??this.userProfile,
    );
  }
  @override
  List<Object?> get props => [blocStatus, courseResponseModel, searchCommonRequest,courseType,userProfile];

}
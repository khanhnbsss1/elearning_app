part of 'course_list_bloc.dart';

enum CourseStatus {
  initial,
  onLoading
}

@immutable
class CourseListState extends Equatable {
  CourseResponseModel? courseResponseModel;
  CourseStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  CourseListState({
      this.blocStatus, 
    this.courseResponseModel,
    this.searchCommonRequest
  }){
    courseResponseModel??= CourseResponseModel(content: []);
    searchCommonRequest??= SearchCommonRequest(filterType: "ALL", pageNumber: 0, pageSize: 10, keyword: "");
  }


  CourseListState copyWith({
    CourseResponseModel? courseResponseModel,
    CourseStatus? blocStatus,
  })
  {
    return CourseListState(
      blocStatus: blocStatus??this.blocStatus,
      courseResponseModel: courseResponseModel??this.courseResponseModel,
    );
  }
  @override
  List<Object?> get props => [blocStatus, courseResponseModel];

}
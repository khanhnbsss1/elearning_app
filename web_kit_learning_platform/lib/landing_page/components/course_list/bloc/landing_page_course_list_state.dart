part of 'landing_page_course_list_bloc.dart';

enum CourseListStatus {
  onLoading, 
  initial,
  onExpand
}

@immutable
class LandingPageCourseListState extends Equatable {
  CourseListStatus? blocStatus;
  CourseListResponseModel? courseListLandingPageResponseModel;
  bool? isExpand;
  LandingPageCourseListState({
      this.blocStatus,
    this.courseListLandingPageResponseModel,
    this.isExpand
  });


  LandingPageCourseListState copyWith({
    CourseListStatus? blocStatus,
    CourseListResponseModel? courseListLandingPageResponseModel,
    bool? isExpand
  })
  {
    return LandingPageCourseListState(
      blocStatus: blocStatus??this.blocStatus,
      courseListLandingPageResponseModel: courseListLandingPageResponseModel??this.courseListLandingPageResponseModel,
      isExpand: isExpand??this.isExpand,

    );
  }
  @override
  List<Object?> get props => [blocStatus, courseListLandingPageResponseModel, isExpand];

}
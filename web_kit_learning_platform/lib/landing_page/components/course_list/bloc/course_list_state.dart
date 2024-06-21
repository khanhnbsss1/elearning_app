part of 'course_list_bloc.dart';

enum CourseListStatus {
  onLoading, 
  initial,
  onExpand
}

@immutable
class CourseListState extends Equatable {
  CourseListStatus? blocStatus;
  CourseListLandingPageResponseModel? courseListLandingPageResponseModel;
  bool? isExpand;
  CourseListState({
      this.blocStatus,
    this.courseListLandingPageResponseModel,
    this.isExpand
  });


  CourseListState copyWith({
    CourseListStatus? blocStatus,
    CourseListLandingPageResponseModel? courseListLandingPageResponseModel,
    bool? isExpand
  })
  {
    return CourseListState(
      blocStatus: blocStatus??this.blocStatus,
      courseListLandingPageResponseModel: courseListLandingPageResponseModel??this.courseListLandingPageResponseModel,
      isExpand: isExpand??this.isExpand,

    );
  }
  @override
  List<Object?> get props => [blocStatus, courseListLandingPageResponseModel, isExpand];

}
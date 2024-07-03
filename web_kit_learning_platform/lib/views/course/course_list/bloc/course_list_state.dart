part of 'course_list_bloc.dart';

enum CourseListStatus {
  initial,
}

@immutable
class CourseListState extends Equatable {
  CourseResponseModel? courseResponseModel;
  CourseListStatus? blocStatus;
  CourseListState({
      this.blocStatus, CourseResponseModel? courseResponseModel,});


  CourseListState copyWith({
    CourseResponseModel? courseResponseModel,
    CourseListStatus? blocStatus,
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
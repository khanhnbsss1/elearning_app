part of 'course_study_bloc.dart';

enum CourseStudyStatus {
  initial,
  onLoading
}

@immutable
class CourseStudyState extends Equatable {
  CourseStudyStatus? blocStatus;
  CourseInfo? courseInfo;
  CourseStudyState({
    this.blocStatus,
    this.courseInfo
  });


  CourseStudyState copyWith({
    CourseStudyStatus? blocStatus,
    CourseInfo? courseInfo
  })
  {
    return CourseStudyState(
      blocStatus: blocStatus??this.blocStatus,
      courseInfo: courseInfo??this.courseInfo,

    );
  }
  @override
  List<Object?> get props => [blocStatus, courseInfo];

}
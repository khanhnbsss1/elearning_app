part of 'course_list_bloc.dart';

enum CourseListStatus {
  initial,
}

@immutable
class CourseListState extends Equatable {
  CourseListStatus? blocStatus;
  CourseListState({
      this.blocStatus,});


  CourseListState copyWith({
    CourseListStatus? blocStatus,
  })
  {
    return CourseListState(
      blocStatus: blocStatus??this.blocStatus,
    );
  }
  @override
  List<Object?> get props => [blocStatus];

}
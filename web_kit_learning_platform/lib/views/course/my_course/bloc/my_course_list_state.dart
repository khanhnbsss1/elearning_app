part of 'my_course_list_bloc.dart';

enum MyCourseListStatus {
  initial,
}

@immutable
class MyCourseListState extends Equatable {
  MyCourseListStatus? blocStatus;
  MyCourseListState({
      this.blocStatus,});


  MyCourseListState copyWith({
    MyCourseListStatus? blocStatus,
  })
  {
    return MyCourseListState(
      blocStatus: blocStatus??this.blocStatus,
    );
  }
  @override
  List<Object?> get props => [blocStatus];

}
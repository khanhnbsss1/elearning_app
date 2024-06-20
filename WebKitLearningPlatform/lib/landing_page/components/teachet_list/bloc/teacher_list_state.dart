part of 'teacher_list_bloc.dart';

enum TeacherListStatus {
  initial,
}

@immutable
class TeacherListState extends Equatable {
  TeacherListStatus? blocStatus;
  TeacherListState({
      this.blocStatus,});


  TeacherListState copyWith({
    TeacherListStatus? blocStatus,
  })
  {
    return TeacherListState(
      blocStatus: blocStatus??this.blocStatus,
    );
  }
  @override
  List<Object?> get props => [blocStatus];

}
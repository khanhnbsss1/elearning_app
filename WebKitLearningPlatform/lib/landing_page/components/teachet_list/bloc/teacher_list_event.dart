part of 'teacher_list_bloc.dart';

abstract class TeacherListEvent extends Equatable {
  const TeacherListEvent();
  @override
  List<Object?> get props => [];
}

class TeacherListInitEvent extends TeacherListEvent {
  TeacherListInitEvent()
  {
  }
  List<Object?> get props => [];
}
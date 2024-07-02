part of 'my_course_list_bloc.dart';

abstract class MyCourseListEvent extends Equatable {
  const MyCourseListEvent();
  @override
  List<Object?> get props => [];
}

class MyCourseListInitEvent extends MyCourseListEvent {
  MyCourseListInitEvent()
  {
  }
  List<Object?> get props => [];
}
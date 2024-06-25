part of 'course_list_bloc.dart';

abstract class CourseListEvent extends Equatable {
  const CourseListEvent();
  @override
  List<Object?> get props => [];
}

class CourseListInitEvent extends CourseListEvent {
  CourseListInitEvent(); 
  @override
  List<Object?> get props => [];
}
class CourseListOnExpandEvent extends CourseListEvent {
  bool isExpand; 
  CourseListOnExpandEvent({required this.isExpand});
  @override
  List<Object?> get props => [isExpand];
}
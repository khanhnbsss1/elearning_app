part of 'course_study_bloc.dart';

abstract class CourseStudyEvent extends Equatable {
  CourseStudyEvent();
  @override
  List<Object?> get props => [];
}

class CourseStudyInitEvent extends CourseStudyEvent {
  CourseStudyInitEvent();
  @override
  List<Object?> get props => [];
}

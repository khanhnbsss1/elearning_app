part of 'course_detail_bloc.dart';

abstract class CourseDetailEvent extends Equatable {
  const CourseDetailEvent();
  @override
  List<Object?> get props => [];
}

class CourseDetailInitEvent extends CourseDetailEvent {
  CourseDetailInitEvent();
  @override
  List<Object?> get props => [];
}
class CourseDetailSelectLessonEvent extends CourseDetailEvent {
  LessonInfo selectLessonInfo;
  CourseDetailSelectLessonEvent({required this.selectLessonInfo});
  @override
  List<Object?> get props => [selectLessonInfo];
}

class CourseDetailUpdateInfoSelectLessonEvent extends CourseDetailEvent {
  LessonInfo selectLessonInfo;
  CourseDetailUpdateInfoSelectLessonEvent({required this.selectLessonInfo});
  @override
  List<Object?> get props => [selectLessonInfo];
}
class CourseDetailUpdateFinishLessonEvent extends CourseDetailEvent {
  LessonInfo selectLessonInfo;
  CourseDetailUpdateFinishLessonEvent({required this.selectLessonInfo});
  @override
  List<Object?> get props => [selectLessonInfo];
}
part of 'course_registration_history_bloc.dart';

abstract class CourseRegistrationHistoryListEvent extends Equatable {
  const CourseRegistrationHistoryListEvent();
  @override
  List<Object?> get props => [];
}

class CourseRegistrationHistoryListInitEvent extends CourseRegistrationHistoryListEvent {
  CourseRegistrationHistoryListInitEvent();  
  @override
  List<Object?> get props => [];
}
class CourseRegistrationHistoryListOnSearchByFilterEvent extends CourseRegistrationHistoryListEvent {
  SearchCommonRequest searchCommonRequest;
  CourseRegistrationHistoryListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class LessonListOnSelectLessonEvent extends CourseRegistrationHistoryListEvent {
  LessonInfo selectLessonInfo;
  LessonListOnSelectLessonEvent({required this.selectLessonInfo} );
  @override
  List<Object?> get props => [selectLessonInfo];
}
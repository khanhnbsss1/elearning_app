part of 'course_history_bloc.dart';

abstract class CourseHistoryListEvent extends Equatable {
  const CourseHistoryListEvent();
  @override
  List<Object?> get props => [];
}

class CourseHistoryListInitEvent extends CourseHistoryListEvent {
  CourseHistoryListInitEvent();  
  @override
  List<Object?> get props => [];
}
class CourseHistoryListOnSearchByFilterEvent extends CourseHistoryListEvent {
  SearchCommonRequest searchCommonRequest;
  CourseHistoryListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class LessonListOnSelectLessonEvent extends CourseHistoryListEvent {
  LessonInfo selectLessonInfo;
  LessonListOnSelectLessonEvent({required this.selectLessonInfo} );
  @override
  List<Object?> get props => [selectLessonInfo];
}
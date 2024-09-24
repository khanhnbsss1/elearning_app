part of 'course_list_by_registed_user_bloc.dart';

abstract class CourseListByRegistedUserEvent extends Equatable {
  const CourseListByRegistedUserEvent();
  @override
  List<Object?> get props => [];
}

class CourseListByRegistedUserInitEvent extends CourseListByRegistedUserEvent {
  CourseListByRegistedUserInitEvent();  
  @override
  List<Object?> get props => [];
}
class CourseListByRegistedUserOnSearchByFilterEvent extends CourseListByRegistedUserEvent {
  SearchCommonRequest searchCommonRequest;
  CourseListByRegistedUserOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class LessonListOnSelectLessonEvent extends CourseListByRegistedUserEvent {
  LessonInfo selectLessonInfo;
  LessonListOnSelectLessonEvent({required this.selectLessonInfo} );
  @override
  List<Object?> get props => [selectLessonInfo];
}
part of 'lesson_list_bloc.dart';

abstract class LessonListEvent extends Equatable {
  const LessonListEvent();
  @override
  List<Object?> get props => [];
}

class LessonListInitEvent extends LessonListEvent {
  LessonListInitEvent();  
  @override
  List<Object?> get props => [];
}
class LessonListOnSearchByFilterEvent extends LessonListEvent {
  SearchCommonRequest searchCommonRequest;
  LessonListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class LessonListOnSelectLessonEvent extends LessonListEvent {
  LessonInfo selectLessonInfo;
  LessonListOnSelectLessonEvent({required this.selectLessonInfo} );
  @override
  List<Object?> get props => [selectLessonInfo];
}
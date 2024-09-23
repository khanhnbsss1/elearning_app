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
class CourseListOnSearchByFilterEvent extends CourseListEvent {
  SearchCommonRequest searchCommonRequest;
  CourseListOnSearchByFilterEvent({required this.searchCommonRequest} );
  @override
  List<Object?> get props => [searchCommonRequest];
}
class CourseListOnCallApiEvent extends CourseListEvent {
  CourseResponseModel courseResponseModel;
  CourseListOnCallApiEvent({required this.courseResponseModel});
  @override
  List<Object?> get props => [courseResponseModel];
}
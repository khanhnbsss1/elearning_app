part of 'landing_page_course_list_bloc.dart';

abstract class LandingPageCourseListEvent extends Equatable {
  const LandingPageCourseListEvent();
  @override
  List<Object?> get props => [];
}

class LandingPageCourseListInitEvent extends LandingPageCourseListEvent {
  LandingPageCourseListInitEvent(); 
  @override
  List<Object?> get props => [];
}
class LandingPageCourseListOnExpandEvent extends LandingPageCourseListEvent {
  bool isExpand; 
  LandingPageCourseListOnExpandEvent({required this.isExpand});
  @override
  List<Object?> get props => [isExpand];
}
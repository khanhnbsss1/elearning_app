import 'package:webkit/views/course/course_list/bloc/course_list_bloc.dart';
import 'package:webkit/views/course/course_list/course_list.dart';

class InactiveCourseList extends CourseList{
  InactiveCourseList({super.key}):super(courseType: CourseType.courseList, isActivate: false);
}

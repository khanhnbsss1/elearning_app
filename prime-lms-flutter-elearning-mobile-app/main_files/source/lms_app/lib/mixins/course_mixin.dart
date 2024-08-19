import 'package:lms_app/models/course.dart';
import 'package:lms_app/models/lesson.dart';
import 'package:lms_app/models/user_model.dart';
import 'package:lms_app/services_elearning/apis/course/course_detail/models/course_detail_model.dart';

import '../models_elearning/user/UserProfile.dart';

mixin CourseMixin {

  bool isLessonCompleted(Lesson lesson, UserProfile? user) {
    if (user != null && user.completedLessons!.isNotEmpty && user.completedLessons!.any((element) => element.toString().contains(lesson.id))) {
      return true;
    } else {
      return false;
    }
  }

  static String enrollButtonText(CourseInfo course, UserProfile? user) {
    if (user == null || !user.enrolledCourses!.contains(course.id)) {
      return 'enroll-now';
    } else {
      List validIds = user.completedLessons!.where((element) => element.toString().contains(course.id.toString())).toList();
      final double courseProgess = validIds.isEmpty ? 0 : (validIds.length / (course.totalLectures!).toDouble());
      if (courseProgess == 0) {
        return 'start-course';
      } else if (courseProgess > 0 && courseProgess < 1) {
        return 'continue-course';
      } else {
        return 'restart-course';
      }
    }
  }
}

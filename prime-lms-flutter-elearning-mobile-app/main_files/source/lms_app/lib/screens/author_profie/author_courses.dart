import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/services/apis/course/course_fillter/models/course_filtter_info.dart';
import 'package:pinput/pinput.dart';
import '../../models/course.dart';
import '../../models/user_model.dart';
import '../../models/user/UserProfile.dart';
import '../../services/api_service.dart';
import '../../services/apis/course/course_detail/models/course_detail_model.dart';
import '../../services/apis/teacher_list/models/landing_page_teacher_list_model.dart';
import '../../services/apis/teacher_list/models/teacher_model.dart';
import '../../utils/loading_widget.dart';
import '../../utils/next_screen.dart';
import '../all_courses.dart/courses_view.dart';
import '../all_courses.dart/grid_list_course_tile.dart';

final authorCoursesProvider = FutureProvider.autoDispose.family<List<CourseInfo>, int>((ref, authorId) async {
  final courses = await ApiService().getCoursesByAuthorId(authorId);
  return courses??[];
});

class AuthorCourses extends ConsumerWidget {
  const AuthorCourses({super.key, required this.teacherDetail});

  final TeacherDetail teacherDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authorCourses = ref.watch(authorCoursesProvider(teacherDetail.id!));
    return authorCourses.when(
      data: (courses) {
        return Column(
          children: [
            if (courses.isNotEmpty) Column(
              children: courses
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GridListCourseTile(course: e),
                    ),
                  )
                  .toList(),
            ),
            Visibility(
              visible: courses.isNotEmpty && courses.length > 3,
              child: Center(
                child: TextButton(
                  child: const Text('view-all').tr(),
                  onPressed: () => NextScreen.iOS(
                      context,
                      AllCoursesView(
                        filter: 'Author',
                        subFilterInfo: SubFilterInfo(
                          id: teacherDetail.id,
                          name: teacherDetail.fullName,
                        ),
                      )),
                  // onPressed: (){},
                ),
              ),
            )
          ],
        );
      },
      error: (error, stackTrace) => Text('error: $error'),
      loading: () => const LoadingIndicatorWidget(),
    );
  }
}

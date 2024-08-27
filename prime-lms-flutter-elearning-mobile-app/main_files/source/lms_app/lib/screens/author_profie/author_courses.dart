import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/course.dart';
import '../../models/user_model.dart';
import '../../models/user/UserProfile.dart';
import '../../services/api_service.dart';
import '../../utils/loading_widget.dart';
import '../../utils/next_screen.dart';
import '../all_courses.dart/courses_view.dart';
import '../all_courses.dart/grid_list_course_tile.dart';

final authorCoursesProvider = FutureProvider.autoDispose.family<List<Course>, String>((ref, authorId) async {
  final courses = await ApiService().getCoursesByAuthorId(authorId: authorId);
  return courses;
});

class AuthorCourses extends ConsumerWidget {
  const AuthorCourses({super.key, required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesRef = ref.watch(authorCoursesProvider(user.id.toString()));
    return coursesRef.when(
      data: (courses) {
        return Column(
          children: [
            // Column(
            //   children: courses
            //       .map(
            //         (e) => Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 10),
            //           child: GridListCourseTile(course: c),
            //         ),
            //       )
            //       .toList(),
            // ),
            Visibility(
              visible: coursesRef.value != null && coursesRef.value!.length >= 3,
              child: Center(
                child: TextButton(
                  child: const Text('view-all').tr(),
                  // onPressed: () => NextScreen.iOS(
                  //     context,
                  //     AllCoursesView(
                  //       title: user.fullName!,
                  //       authorId: user.id.toString(),
                  //     )),
                  onPressed: (){},
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_list_tile.dart';
import 'package:lms_app/configs/app_assets.dart';
import 'package:lms_app/mixins/course_mixin.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/utils/empty_animation.dart';
import 'package:quiver/iterables.dart';
import '../../../services/apis/course/course_detail/models/course_detail_model.dart';
import '../../../theme/theme_provider.dart';
import 'my_course_tile.dart';
import '../../../providers/user_data_provider.dart';

// final myCoursesProvider = FutureProvider.autoDispose<List<Course>>((ref) async {
//   final List<Course> courses = [];
//   final user = ref.watch(userDataProvider);
//   final courseIds = user?.enrolledCourses ?? [];
//   final chunks = partition(courseIds, 10);
//
//   final querySnapshots = await Future.wait(chunks.map((chunk) => FirebaseService().getCoursesQuery(chunk)).toList());
//   for (var element in querySnapshots) {
//     courses.addAll(element.docs.map((e) => Course.fromFirestore(e)).toList());
//   }
//   return courses;
// }
// );

final myCoursesProvider = FutureProvider.autoDispose<List<CourseInfo>?>((ref) async {
  return await ApiService().getMyCourses();
});

class MyCoursesTab extends ConsumerWidget {
  const MyCoursesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider);
    final myCourses = ref.watch(myCoursesProvider);
    final isDarkMode = ref.watch(themeProvider).isDarkMode;

    return RefreshIndicator.adaptive(
      displacement: 60,
      onRefresh: () async {
        ref.invalidate(myCoursesProvider);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('my-courses').tr(),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
        ),
        body: user == null
            ? const EmptyAnimation(
            animationString: emptyAnimation, title: 'No courses found')
            : myCourses.when(
          skipLoadingOnRefresh: false,
          loading: () => const LoadingListTile(height: 200),
          error: (error, stackTrace) => Center(
            child: Text('Error: ${error.toString()}'),
          ),
          data: (data) {
            if (data == null || data.isEmpty) {
              return const EmptyAnimation(
                animationString: emptyAnimation,
                title: 'No courses found',
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 50,
                      top: 25,
                    ),
                    itemCount: data.length,
                    separatorBuilder: (context, index) => const Divider(height: 50),
                    itemBuilder: (context, index) {
                      data.length;
                      final CourseInfo course = data[index];
                      return MyCourseTile(courseInfo: course, user: user);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
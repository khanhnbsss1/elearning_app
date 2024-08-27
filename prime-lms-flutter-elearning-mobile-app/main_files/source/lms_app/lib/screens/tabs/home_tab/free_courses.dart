import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/services/firebase_service.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/utils/next_screen.dart';
import '../../../components/horizontal_course_tile.dart';
import '../../all_courses.dart/courses_view.dart';

final freeCoursesProvider = FutureProvider.autoDispose<List<CourseInfo>>((ref) async {
  final List<CourseInfo>? courses = await ApiService().getFreeCourses();
  return courses??[];
});

class FreeCourses extends ConsumerWidget {
  const FreeCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(freeCoursesProvider);
    return courses.when(
        skipLoadingOnRefresh: false,
        data: (courses) {
          return (courses.isNotEmpty && courses != []) ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                            text: TextSpan(
                                text: 'explore'.tr(),
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                children: [
                              const TextSpan(text: ' '),
                              TextSpan(
                                text: 'free-courses'.tr(),
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                              )
                            ])),
                      ),
                      TextButton(
                        onPressed: () => NextScreen.iOS(context, const AllCoursesView(filter: 'Free_course')),
                        // onPressed: () {},
                        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                        child: Text(
                          'view-all',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ).tr(),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: courses.map((course) {
                      return HorizontalCourseTile(course: course, widthPercentage: 0.60, imageHeight: 130);
                    }).toList(),
                  ),
                )
              ],
            ),
          ) : const SizedBox();
        },
        error: (e, x) => Text('error: $e, $x'),
        loading: () => const LoadingTile(height: 200));
  }
}

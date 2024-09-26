import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/models/course.dart';
import '../../components/course_tile.dart';
import '../../services/api_service.dart';
import '../../services/apis/course/course_detail/models/course_detail_model.dart';

final relatedCoursesProvider = FutureProvider.family
    .autoDispose<List<CourseInfo>?, CourseInfo>((ref, course) async {
  List<CourseInfo>? courses =
      await ApiService().getRelatedCoursesByCategory(course);
  return courses;
});

class RelatedCourses extends ConsumerWidget {
  const RelatedCourses({super.key, required this.course});

  final CourseInfo course;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesRef = ref.watch(relatedCoursesProvider(course));
    return coursesRef.when(
      skipError: true,
      error: (error, stackTrace) => Container(),
      loading: () => Container(),
      data: (data) {
        if (data!.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'related-courses',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ).tr(),
                ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 50),
                  itemBuilder: (context, index) {
                    final CourseInfo course = data[index];
                    return CourseTile(course: course);
                  },
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

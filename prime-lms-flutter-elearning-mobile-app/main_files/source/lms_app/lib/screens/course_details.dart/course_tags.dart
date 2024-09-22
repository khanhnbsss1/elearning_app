import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/models/tag.dart';
import 'package:lms_app/screens/all_courses.dart/courses_view.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/utils/next_screen.dart';
import '../../models/course.dart';

// final courseTagsProvider = FutureProvider.family.autoDispose<List<Tag>, List>((ref, tagIds) async {
//   List<Tag> tags = await FirebaseService().getCourseTags(tagIds);
//   return tags;
// });

class CourseTags extends ConsumerWidget {
  const CourseTags({
    super.key,
    required this.course,
  });

  final CourseInfo course;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final tagsRef = ref.watch(courseTagsProvider(course.tags ?? []));
    return Visibility(
      visible: course.tags != [],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'course-tag',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ).tr(),
            const SizedBox(
              height: 10,
            ),
            (course.tags != null)
                ? Wrap(
              spacing: 10,
              runSpacing: 8,
              children: course.tags!.map((tag) {
                return Chip(
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 15),
                  label: Text('${tag.name}'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                );
              }).toList(),
            )
                : Container(), // Display an empty container if course.tags is null
          ],
        )
      ),
    );
  }
}

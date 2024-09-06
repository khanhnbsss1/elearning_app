import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/constants/custom_colors.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/services/apis/lessson/models/lesson_info.dart';
import 'package:lms_app/theme/theme_provider.dart';
import 'lessons.dart';

final isSectionExpnadedProvider = StateProvider.autoDispose.family<bool, String>((ref, sectionId) => false);

class Sections extends ConsumerWidget {
  const Sections({super.key, required this.course, required this.isInitialSectionOpen});

  final CourseInfo course;
  final bool isInitialSectionOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    int sectionCount = 0;
    final Map<String, List<LessonInfo>> lessons = {};

    for (final lesson in course.lectures!) {
      if (lessons.containsKey(lesson.subName)) {
        lessons[lesson.subName]!.add(lesson);
      } else {
        sectionCount++;
        lessons[lesson.subName!] = [lesson];
      }
    }

    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: sectionCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (BuildContext context, int index) {
          const bool isExpanded = true;
          return ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: isDarkMode ? CustomColor.borderDark : CustomColor.border),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: isDarkMode ? CustomColor.borderDark : CustomColor.border),
            ),
            maintainState: true,
            title: Text(
              '${index + 1}. ${lessons.keys.elementAt(index)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isExpanded ? Colors.blueAccent : Theme.of(context).expansionTileTheme.textColor,
                  fontSize: 17
              ),
            ),
            initiallyExpanded: index == 0 && isInitialSectionOpen ? true : false,
            children: [Lessons(lectures: lessons.entries.elementAt(index).value, course: course,)],
            // onExpansionChanged: (bool value) => ref.read(isSectionExpnadedProvider((section.id??0).toString()).notifier).update((state) => value),
          );
        },
      );
  }

}

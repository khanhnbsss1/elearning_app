import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_list_tile.dart';
import 'package:lms_app/configs/app_assets.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/screens/search/search_view.dart';
import 'package:lms_app/services_elearning/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/utils/empty_animation.dart';

import '../../components/course_tile.dart';

class SearchedCourses extends ConsumerWidget {
  const SearchedCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesProvider = ref.watch(searchedCoursesProvider);
    return coursesProvider.when(
      loading: () => const LoadingListTile(height: 160),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
      data: (courses) {
        if (courses!.isEmpty) return EmptyAnimation(animationString: emptyAnimation, title: 'no-course'.tr());
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: courses.length,
          separatorBuilder: (context, index) => const Divider(height: 50),
          itemBuilder: (context, index) {
            final CourseInfo course = courses[index];
            return CourseTile(course: course);
          },
        );
      },
    );
  }
}

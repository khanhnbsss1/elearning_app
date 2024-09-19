import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/price_tag.dart';
import 'package:lms_app/mixins/course_mixin.dart';
import 'package:lms_app/mixins/user_mixin.dart';
import 'package:lms_app/screens/test/test_list_screen.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/utils/loading_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../base/base.export.dart';
import '../../../components/loading_list_tile.dart';
import '../../../models/course.dart';
import '../../../models/user_model.dart';
import '../../../models/user/UserProfile.dart';
import '../../../services/apis/course_progress/models/course_proccess_info.dart';
import '../../../services/apis/lessson/models/lesson_info.dart';
import '../../course_details.dart/details_view.dart';
import '../../../utils/custom_cached_image.dart';
import '../../../utils/next_screen.dart';
import '../../test/test_detail_screen.dart';

final myCoursesDetailProvider = FutureProvider.family
    .autoDispose<CourseInfo, CourseInfo>((ref, courseInfo) async {
  CourseInfo courseDetail =
      await ApiService().getCourseDetail(course: courseInfo);
  return courseDetail;
});

class MyCourseTile extends ConsumerWidget with UserMixin {
  MyCourseTile({required this.courseInfo, required this.user});

  final CourseInfo courseInfo;
  final UserProfile user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heroTag = UniqueKey();
    final courseDetail = ref.watch(myCoursesDetailProvider(courseInfo));
    return courseDetail.when(
      data: (courseDetail) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: 90,
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
                  child: Hero(
                      tag: heroTag,
                      child: (courseDetail.image != null && courseDetail.image != "")
                          ? CustomCacheImage(imageUrl: courseDetail.image, radius: 3)
                          : Image.asset("assets/images/noImage1.jpg",
                          fit: BoxFit.cover)),
                ),
                PremiumTag(course: courseDetail),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseDetail.name??"",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'By ${courseDetail.producerName}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.blueAccent),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildProccess(courseDetail),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          side: BorderSide(color: Theme.of(context).primaryColor),
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      child: Text(
                        CourseMixin.enrollButtonText(courseDetail, user),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ).tr(),
                      onPressed: () =>
                          handleOpenCourse(context, user: user, courseDetail: courseDetail),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const LoadingListTile(),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
    );
  }

  Widget buildProccess(CourseInfo course) {
    int finished = 0;
    int process = 0;
    if (course.lectures != null) {
      for (LessonInfo lecture in course.lectures!) {
        if (lecture.isFinnish == true) {
          finished++;
        }
      }
      (course.lectures!.isNotEmpty) ? process = (finished * 100 / (course.lectures!.length)).ceil() : process = 0;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: LinearProgressIndicator(
            value: process / 100,
            borderRadius: BorderRadius.circular(20),
            minHeight: 8,
            color: Colors.orange.shade300,
          ),
        ),
        const Text('percent-completed').tr(args: [process.toString()]),
      ],
    );
  }
}

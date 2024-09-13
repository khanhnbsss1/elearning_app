import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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

class MyCourseTile extends StatelessWidget with UserMixin {
  const MyCourseTile({super.key, required this.course, required this.user});

  final CourseInfo course;
  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    final heroTag = UniqueKey();

    return InkWell(
      onTap: () => NextScreen.iOS(
          context, CourseDetailsView(courses: course, heroTag: heroTag)),
      // onTap: () {},
      child: FutureBuilder(
          future: getCourseDetail(course),
          builder: (context, snapshot) {
           if (snapshot.hasData) {
             CourseInfo courseDetail = snapshot.data!;
             return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 90,
                      width: 100,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(3)),
                      child: Hero(
                          tag: heroTag,
                          child: (course.image != null && course.image != "")
                              ? CustomCacheImage(
                                  imageUrl: course.image, radius: 3)
                              : Image.asset("assets/images/noImage.jpg",
                                  fit: BoxFit.cover)),
                    ),
                    PremiumTag(course: course),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'By ${course.producerName}',
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
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          child: Text(
                            CourseMixin.enrollButtonText(course, user),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ).tr(),
                          onPressed: () => handleOpenCourse(context,
                              user: user, course: course),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // OutlinedButton(
                        //   style: OutlinedButton.styleFrom(
                        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        //       side: BorderSide(color: Theme.of(context).primaryColor),
                        //       textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)
                        //   ),
                        //   child: Text('do-test'.tr(), style: TextStyle(color: Theme.of(context).primaryColor),).tr(),
                        //   onPressed: () {
                        //     NextScreen.normal(context, const TestListScreen());
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            );
           }
           else {
             return const LoadingListTile(height: 200);
           }
          }),
    );
  }

  Future<CourseInfo> getCourseDetail(CourseInfo courseInfo) async {
    CourseInfo courseDetail =
        await ApiService().getCourseDetail(course: courseInfo);
    return courseDetail;
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
      process = (finished*100/course.lectures!.length).ceil();
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

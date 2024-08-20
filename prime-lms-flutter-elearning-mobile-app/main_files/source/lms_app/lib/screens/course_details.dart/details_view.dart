import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/ads/ad_manager.dart';
import 'package:lms_app/ads/banner_ad.dart';
import 'package:lms_app/screens/course_details.dart/course_info.dart';
import 'package:lms_app/screens/course_details.dart/course_share_button.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../services/firebase_service.dart';
import '../../services_elearning/apis/course/course_detail/models/course_detail_model.dart';
import '../../utils/loading_widget.dart';
import '../tabs/my_courses_tab/my_courses_tab.dart';
import 'bookmark_button.dart';
import 'course_description.dart';
import 'course_reviews.dart';
import 'course_tags.dart';
import 'curriculam.dart';
import 'learnings.dart';
import 'preview_box.dart';
import 'related_courses.dart';
import 'requirements.dart';
import 'review_button.dart';
import 'title_info.dart';

class CourseDetailsView extends ConsumerWidget {
  const CourseDetailsView({super.key, required this.courses, this.heroTag});

  final CourseInfo courses;
  final Object? heroTag;

  Future<CourseInfo> getCourseDetail(CourseInfo courses) async {
    CourseInfo courseInfo = await FirebaseService().getCourseDetail(course: courses);
    return courseInfo;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: Wrap(
        alignment: WrapAlignment.center,
        children: [
          AdManager.isBannerEnbaled(ref) ? const BannerAdWidget() : Container(),
          // EnrollButton(course: course),
        ],
      ),
      body: FutureBuilder(
        future: getCourseDetail(courses),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            CourseInfo courseInfo = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: false,
                  floating: true,
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(FeatherIcons.chevronLeft),
                  ),
                  actions: [
                    BookmarkButton(course: courseInfo),
                    ReviewButton(course: courseInfo),
                    CourseShareButton(course: courseInfo),
                    const SizedBox(width: 10),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PreviewBox(course: courseInfo, heroTag: heroTag),
                          const SizedBox(height: 20),
                          TitleInfo(course: courseInfo),
                          CourseInfoScreen(course: courseInfo),
                          Learnings(course: courseInfo),
                          const SizedBox(height: 40),
                          Curriculam(course: courseInfo),
                          Requirements(course: courseInfo),
                          CourseDescription(course: courseInfo),
                          CourseTags(course: courseInfo),
                          RelatedCourses(course: courseInfo),
                        ],
                      )),
                ),
              ],
            );
          } else {
            return const LoadingIndicatorWidget();
          }
        }
      )
    );
  }
}

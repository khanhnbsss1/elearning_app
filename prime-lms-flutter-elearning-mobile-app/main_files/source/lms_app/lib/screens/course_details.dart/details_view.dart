import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/ads/ad_manager.dart';
import 'package:lms_app/ads/banner_ad.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/base_request_elearning/models/search_common_request.dart';
import 'package:lms_app/base/widgets/common/alert_dialog/loading.common.dart';
import 'package:lms_app/base/widgets/toast_common/toast_utils.dart';
import 'package:lms_app/models/review_user.dart';
import 'package:lms_app/models/user/UserProfile.dart';
import 'package:lms_app/screens/course_details.dart/course_info.dart';
import 'package:lms_app/screens/course_details.dart/course_share_button.dart';
import 'package:lms_app/screens/course_details.dart/register_button.dart';
import 'package:lms_app/screens/curricullam_screen.dart';
import 'package:lms_app/services/apis/course/register_course/register_course.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../base/widgets/my_button.dart';
import '../../helper/services/navigation_service.dart';
import '../../models/review.dart';
import '../../services/api_service.dart';
import '../../services/apis/course/course_detail/models/course_detail_model.dart';
import '../../services/apis/rating/models/rating_info.dart';
import '../../utils/loading_widget.dart';
import '../reviews/rating_form.dart';
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

final courseDetailProvider =
    FutureProvider.family<CourseInfo, CourseInfo>((ref, course) async {
  CourseInfo courseInfo = await ApiService().getCourseDetail(course: course);
  return courseInfo;
});

class CourseDetailsView extends ConsumerWidget {
  const CourseDetailsView({super.key, required this.courses, this.heroTag});

  final CourseInfo courses;
  final Object? heroTag;

  // Future<CourseInfo> getCourseDetail(CourseInfo courses) async {
  //   CourseInfo courseInfo = await ApiService().getCourseDetail(course: courses);
  //   return courseInfo;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refCourseDetail = ref.watch(courseDetailProvider(courses));
    final myCourse = ref.watch(myCoursesProvider);

    return myCourse.when(
      data: (myCourses) => refCourseDetail.when(
        data: (courseDetail) {
          return Scaffold(
              // bottomNavigationBar: Wrap(
              //   alignment: WrapAlignment.center,
              //   children: [
              //     AdManager.isBannerEnbaled(ref)
              //         ? const BannerAdWidget()
              //         : Container(),
              //     // EnrollButton(course: course),
              //   ],
              // ),
              bottomNavigationBar: SizedBox(
                height: 50,
                child: (!UserManager()
                        .checkRegisteredCourse(courseDetail, myCourses ?? []))
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (courseDetail.originalPrice != 0 &&
                              courseDetail.originalPrice != null)
                            Text(
                              '${NumberFormat.decimalPattern('vi').format(courseDetail.originalPrice ?? 0)} VND',
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black45,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          if (courseDetail.payment != 0 &&
                              courseDetail.payment != null)
                            Text(
                              '${NumberFormat.decimalPattern('vi').format(courseDetail.payment ?? 0)} VND',
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xFFFFC711),
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFFFFC711),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          RegisterButton(
                            course: courseDetail,
                            myCourses: myCourses ?? [],
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                        ],
                      )
                    : Center(
                        child: RegisterButton(
                          course: courseDetail,
                          myCourses: myCourses ?? [],
                          width: MediaQuery.of(context).size.width * 0.6,
                        ),
                      ),
              ),
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    pinned: false,
                    // forceMaterialTransparency: true,
                    floating: true,
                    leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(FeatherIcons.chevronLeft),
                    ),
                    actions: [
                      // RegisterButton(
                      //     course: courseInfo,
                      //     myCourses: myCourses ?? [],
                      // ),
                      // BookmarkButton(course: courseInfo),
                      ReviewButton(
                        contexts: context,
                        courseDetail: courseDetail,
                        myCourses: myCourses ?? [],
                      ),
                      CourseShareButton(course: courseDetail),
                      const SizedBox(width: 10),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PreviewBox(course: courseDetail, heroTag: heroTag),
                            const SizedBox(height: 20),
                            TitleInfo(
                              course: courseDetail,
                            ),
                            // RegisterButton(
                            //     course: courseInfo,
                            //     myCourses: myCourses ?? []),
                            CourseInfoScreen(course: courseDetail),
                            Learnings(course: courseDetail),
                            const SizedBox(height: 40),
                            CurriculamPreview(course: courseDetail),
                            Requirements(course: courseDetail),
                            // CourseDescription(course: courseInfo),
                            CourseTags(course: courseDetail),
                            // FutureBuilder(
                            //   future: getReviewDetail(),
                            //   builder: (context, snapshot) {
                            //     if (snapshot.hasData) {
                            //       List<RatingInfo> reviewList =
                            //           snapshot.data ?? [];
                            //       return FloatingActionButton(
                            //         onPressed: () {
                            //           NextScreen.normal(
                            //             context,
                            //             RatingForm(
                            //               reviewList: reviewList,
                            //               course: courseDetail,
                            //             ),
                            //           );
                            //         },
                            //       );
                            //     } else {
                            //       return const SizedBox();
                            //     }
                            //   },
                            // ),
                            RelatedCourses(course: courseDetail),
                          ],
                        )),
                  ),
                ],
              ));
        },
        error: (error, stackTrace) => Container(),
        loading: () {
          return Scaffold(
              body:
                  const LoadingIndicatorWidget()); // display loading indicator
        },
      ),
      error: (error, stackTrace) => Container(),
      loading: () {
        return Scaffold(
            body: const LoadingIndicatorWidget()); // display loading indicator
      },
    );
  }
}

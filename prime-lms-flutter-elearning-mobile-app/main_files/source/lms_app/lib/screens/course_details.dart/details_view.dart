import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/ads/ad_manager.dart';
import 'package:lms_app/ads/banner_ad.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/widgets/common/alert_dialog/loading.common.dart';
import 'package:lms_app/base/widgets/toast_common/toast_utils.dart';
import 'package:lms_app/models/user/UserProfile.dart';
import 'package:lms_app/screens/course_details.dart/course_info.dart';
import 'package:lms_app/screens/course_details.dart/course_share_button.dart';
import 'package:lms_app/screens/course_details.dart/register_button.dart';
import 'package:lms_app/screens/curricullam_screen.dart';
import 'package:lms_app/services/apis/course/register_course/register_course.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../base/widgets/my_button.dart';
import '../../helper/services/navigation_service.dart';
import '../../services/api_service.dart';
import '../../services/apis/course/course_detail/models/course_detail_model.dart';
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
    CourseInfo courseInfo = await ApiService().getCourseDetail(course: courses);
    return courseInfo;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myCourse = ref.watch(myCoursesProvider);
    return myCourse.when(
        data: (myCourses) {
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
                child: (!UserManager().checkRegisteredCourse(courses, myCourses??[])) ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Visibility(
                      visible: courses.originalPrice != 0 && courses.originalPrice != null,
                      // visible: true,
                      child: Text(
                        '${NumberFormat.decimalPattern('vi').format(courses.originalPrice??0)} VND',
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.black45,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Visibility(
                      visible: courses.payment != 0 && courses.payment != null,
                      // visible: true,
                      child: Text(
                        '${NumberFormat.decimalPattern('vi').format(courses.payment??0)} VND',
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFFFFC711),
                            fontStyle: FontStyle.italic,
                            color: Color(0xFFFFC711),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    RegisterButton(course: courses, myCourses: myCourses ?? [], width: MediaQuery.of(context).size.width * 0.4,),
                  ],
                ) : Center(
                  child: RegisterButton(course: courses, myCourses: myCourses ?? [], width: MediaQuery.of(context).size.width * 0.6,),
                ),
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
                            backgroundColor: Colors.white,
                            pinned: false,
                            // forceMaterialTransparency: true,
                            floating: true,
                            leading: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(FeatherIcons.chevronLeft),
                            ),
                            actions: [
                              RegisterButton(
                                  course: courseInfo,
                                  myCourses: myCourses ?? [],
                              ),
                              // BookmarkButton(course: courseInfo),
                              // ReviewButton(course: courseInfo),
                              CourseShareButton(course: courseInfo),
                              const SizedBox(width: 10),
                            ],
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PreviewBox(
                                        course: courseInfo, heroTag: heroTag),
                                    const SizedBox(height: 20),
                                    TitleInfo(course: courseInfo),
                                    RegisterButton(
                                        course: courseInfo,
                                        myCourses: myCourses ?? []),
                                    CourseInfoScreen(course: courseInfo),
                                    Learnings(course: courseInfo),
                                    const SizedBox(height: 40),
                                    Curriculam(course: courseInfo),
                                    Requirements(course: courseInfo),
                                    // CourseDescription(course: courseInfo),
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
                  }));
        },
        error: (error, stackTrace) => Text('error: $error'),
        loading: () {
          return const Scaffold(
            body: LoadingIndicatorWidget(),
          );
        });
  }
}

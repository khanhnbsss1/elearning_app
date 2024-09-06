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

  Future<UserProfile?> getUserDetail() async {
    UserProfile? user = await UserManager().getUserProfile();
    return user;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool check = false;
    final myCourses = ref.watch(myCoursesProvider);
    return Scaffold(
        bottomNavigationBar: Wrap(
          alignment: WrapAlignment.center,
          children: [
            AdManager.isBannerEnbaled(ref)
                ? const BannerAdWidget()
                : Container(),
            // EnrollButton(course: course),
          ],
        ),
        body: FutureBuilder(
            future: Future.wait([getCourseDetail(courses), getUserDetail()]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                CourseInfo courseInfo = snapshot.data?[0]!;
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: false,
                      floating: true,
                      leading: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(FeatherIcons.chevronLeft),
                      ),
                      title: (!checkRegisteredCourse(
                              courseInfo, myCourses.value ?? []))
                          ? MyButton(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('register'.tr()),
                                      content:
                                          Text('register-content-popup'.tr()),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MyButton(
                                              backgroundColor: Colors.white,
                                              child: Text(
                                                'cancel'.tr(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                            ),
                                            MyButton(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              child: Text(
                                                'confirm'.tr(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onTap: () async {
                                                Navigator.of(context).pop(true);
                                                RegisterCourseApi
                                                    registerCourseApi =
                                                    RegisterCourseApi(
                                                        courseId:
                                                            courseInfo.id!);
                                                check =
                                                    await registerCourseApi
                                                        .call();
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                ).then((confirm) {
                                  if (confirm) {
                                    if (courseInfo.isPayment == 0) {
                                      ToastUtils.showSnackBar(
                                          context,
                                          "register-success".tr());
                                      NavigationService()
                                          .navigateToScreen(
                                          CurriculamScreen(
                                            course: courseInfo,
                                          ));
                                    } else {
                                      ToastUtils.showSnackBar(context, 'message');
                                    }
                                  }
                                });
                              },
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Text('register-course'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                      )))
                          : MyButton(
                              onTap: () {
                                NavigationService().navigateToScreen(CurriculamScreen(course: courseInfo));
                              },
                              child: Text('lets-study'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                      ))),
                      centerTitle: true,
                      actions: [
                        // BookmarkButton(course: courseInfo),
                        // ReviewButton(course: courseInfo),
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
            }));
  }

  static bool checkRegisteredCourse(CourseInfo courseInfo, List<CourseInfo> myCourse) {
    print(courseInfo.id);
    return myCourse.any((e) => e.id == courseInfo.id);
  }
}

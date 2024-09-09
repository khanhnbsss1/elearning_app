import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/base/widgets/my_button.dart';
import 'package:lms_app/models/user/UserProfile.dart';
import 'package:lms_app/screens/reviews/rating_form.dart';
import 'package:lms_app/constants/custom_colors.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/theme/theme_provider.dart';
import '../../base/widgets/toast_common/toast_utils.dart';
import '../../components/rating_bar.dart';
import '../../helper/services/navigation_service.dart';
import '../../services/apis/course/register_course/register_course.dart';
import '../curricullam_screen.dart';
import '../tabs/my_courses_tab/my_courses_tab.dart';

class TitleInfo extends ConsumerWidget {
  const TitleInfo({super.key, required this.course});

  final CourseInfo course;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool check = false;
    final myCourses = ref.watch(myCoursesProvider);
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    final rating = ref.watch(courseRatingProvider(course));
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        course.name ?? "-",
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 24,
              height: 1.5,
              wordSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              RatingViewer(rating: rating),
            ],
          ),
          const SizedBox(width: 20),
          Text(
            'total-lectures',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ).tr(args: [course.totalLectures.toString()]),
        ],
      ),
      const SizedBox(height: 10,),
      Center(
        child: (!UserManager().checkRegisteredCourse(
            course, myCourses.value ?? []))
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
                                  course.id!);
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
                  if (course.isPayment == 0) {
                    ToastUtils.showSnackBar(
                        context,
                        "register-success".tr());
                    NavigationService()
                        .navigateToScreen(
                        CurriculamScreen(
                          course: course,
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
              NavigationService().navigateToScreen(CurriculamScreen(course: course));
            },
            child: Text('lets-study'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                  color: Colors.white,
                ))),
      ),
      const SizedBox(height: 20),
      Text(
        course.introduction.toString(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 17,
              color: isDarkMode
                  ? CustomColor.paragraphColorDark
                  : CustomColor.paragraphColor,
              height: 1.7,
              fontWeight: FontWeight.w400,
            ),
      )
    ]);
  }
}


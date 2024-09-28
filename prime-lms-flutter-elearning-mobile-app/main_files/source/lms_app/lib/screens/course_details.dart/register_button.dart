import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/utils/next_screen.dart';

import '../../base/author/user_helper.dart';
import '../../base/widgets/my_button.dart';
import '../../base/widgets/toast_common/toast_utils.dart';
import '../../helper/services/navigation_service.dart';
import '../../services/apis/course/course_detail/models/course_detail_model.dart';
import '../../services/apis/course/register_course/register_course.dart';
import '../curricullam_screen.dart';
import '../tabs/my_courses_tab/my_courses_tab.dart';

class RegisterButton extends ConsumerWidget {
  const RegisterButton(
      {super.key, required this.course, required this.myCourses, this.width});

  final CourseInfo course;
  final List<CourseInfo> myCourses;
  final double? width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: (!UserManager().checkRegisteredCourse(course, myCourses))
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Colors.red,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              width: width,
              child: MyButton(
                  borderRadiusAll: 10,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('register'.tr()),
                          content: Text('register-content-popup'.tr()),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                  borderRadiusAll: 10,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    'cancel'.tr(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                MyButton(
                                  borderRadiusAll: 10,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Text(
                                    'confirm'.tr(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () async {
                                    Navigator.of(context).pop(true);
                                    RegisterCourseApi registerCourseApi =
                                        RegisterCourseApi(courseId: course.id!);
                                    // await registerCourseApi.call();
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
                          ToastUtils.showToast("register-success".tr());
                          course.isPayment = 1;
                          NextScreen.replace(
                              context,
                              CurriculamStudy(
                                courseDetail: course,
                              ));
                        } else {
                          ToastUtils.showToast('message');
                        }
                      }
                    });
                  },
                  elevation: 5,
                  backgroundColor: Colors.transparent,
                  child: Text('register-course'.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ))),
            )
          : Container(
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColor, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: MyButton(
                borderRadiusAll: 10,
                  onTap: () {
                    NavigationService().navigateToScreen(
                        CurriculamStudy(courseDetail: course));
                  },
                  elevation: 10,
                  backgroundColor: Colors.transparent,
                  child: Text('lets-study'.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ))),
            ),
    );
  }
}

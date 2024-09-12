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
  const RegisterButton({super.key, required this.course, required this.myCourses});
  final CourseInfo course;
  final List<CourseInfo> myCourses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool check;
    return Center(
      child: (!UserManager().checkRegisteredCourse(course, myCourses ))
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
                  NextScreen.replace(context, CurriculamScreen(
                    course: course,
                  ));
                } else {
                  ToastUtils.showSnackBar(context, 'message');
                }
              }
            });
          },
          elevation: 5,
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
          elevation: 5,
          borderColor: Colors.black,
          backgroundColor: Colors.white,
          child: Text('lets-study'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                color: Colors.black,
              ))),
    );
  }
}

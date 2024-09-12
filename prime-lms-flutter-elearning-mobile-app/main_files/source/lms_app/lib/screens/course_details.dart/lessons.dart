import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/base/widgets/common/alert_dialog/loading.common.dart';
import 'package:lms_app/base/widgets/toast_common/toast_utils.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/mixins/course_mixin.dart';
import 'package:lms_app/mixins/user_mixin.dart';
import 'package:lms_app/screens/course_details.dart/vocabulary.dart';
import 'package:lms_app/screens/pdf_screen.dart';
import 'package:lms_app/screens/tabs/my_courses_tab/my_courses_tab.dart';
import 'package:lms_app/screens/test/test_screen.dart';
import 'package:lms_app/screens/video_lesson.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/services/apis/lessson/models/lesson_info.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../base/image_manager/images_constant.dart';
import '../../base/theme/colors_app.dart';
import '../../base/widgets/common/alert_dialog/loading_logo.dart';
import '../../services/apis/test/get_test_detail.dart';
import '../../services/apis/test/models/test_detail.dart';

class Lessons extends ConsumerWidget with CourseMixin, UserMixin {
  const Lessons({
    super.key,
    required this.lectures,
    required this.course,
  });

  final CourseInfo course;
  final List<LessonInfo> lectures;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> notes = [];
    // final user = ref.watch(userDataProvider);
    return Column(children: [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 0, bottom: 20),
        itemCount: lectures.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
              future: getLessonDetail(lectures[index].id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  LessonInfo lessonDetail = snapshot.data!;
                  if (lessonDetail.note != null) notes = lessonDetail.note!.split('&&&&---&&&&');
                  return ListTile(
                      onTap: () => {
                        if (_onCheck(context, lessonDetail, course, ref)) {
                          _openLesson(context, lessonDetail, ref)
                        }
                      },
                      // onTap: (){},
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      horizontalTitleGap: 10,
                      title: Text(
                        lessonDetail.lectureName!,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lectures[index].subName ?? "_").tr(),
                          const SizedBox(
                            height: 8,
                          ),
                          if (notes.length > 1)
                            InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  if (_onCheck(context, lessonDetail, course, ref)) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) {
                                              return PdfScreen(
                                                  link: notes[1],
                                                  name: "content".tr());
                                            }
                                        ));
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(12)),
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.menu_book_rounded,
                                        color: Theme.of(context)
                                            .primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text('content',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                              fontWeight:
                                              FontWeight
                                                  .w400,
                                              fontSize: 16))
                                          .tr(),
                                    ],
                                  ),
                                )),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    if (_onCheck(context, lessonDetail, course, ref)) {
                                      NextScreen.normal(
                                          context,
                                          Vocabulary(
                                              lessonDetail: lessonDetail,
                                              sectionId: index));
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.menu_book_rounded,
                                          color:
                                              Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text('vocabulary',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16))
                                            .tr(),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                width: 16,
                              ),
                              if (lessonDetail.docLink != "" &&
                                      lessonDetail.docLink != null)
                                  InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        if (_onCheck(context, lessonDetail, course, ref)) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      PdfScreen(
                                                          link: lessonDetail
                                                              .docLink!,
                                                          name: lessonDetail
                                                              .docName ??
                                                              "-")));
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(12)),
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.menu_book_rounded,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text('document',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400,
                                                            fontSize: 16))
                                                .tr(),
                                          ],
                                        ),
                                      )),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          if (lessonDetail.testId != null)
                            InkWell(
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  // if (_onCheck(context, lessonDetail, course, ref)) {
                                    openDialog(context, lessonDetail);
                                  // }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(12)),
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.menu_book_rounded,
                                        color: Theme.of(context)
                                            .primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text('do-test',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                              fontWeight:
                                              FontWeight
                                                  .w400,
                                              fontSize: 16))
                                          .tr(),
                                    ],
                                  ),
                                )),
                        ],
                      ),
                      leading: Text(
                        '${index + 1}.',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      trailing: _trailingIcon(lessonDetail));
                } else {
                  return const LoadingTile();
                }
              });
        },
      ),
    ]);
  }

  Future<LessonInfo?> getLessonDetail(int lectureId) async {
    final LessonInfo? lessons = await ApiService().getLessonDetail(lectureId);
    return lessons;
  }

  Future<TestDetail> getTestDetail(int testId) async {
    GetTestDetailApi getTestDetailApi = GetTestDetailApi(testId: testId);
    TestDetail testDetail = await getTestDetailApi.call();
    return testDetail;
  }

  bool _onCheck(BuildContext context, LessonInfo lesson, CourseInfo course, WidgetRef ref) {
    final myCourses = ref.watch(myCoursesProvider);
    if (UserManager().checkRegisteredCourse(course, myCourses.value??[])) {
      return true;
    } else {
      ToastUtils.showSnackBar(context, 'Please sign up course to learn it');
      return false;
    }
  }

  void _openLesson(BuildContext context, LessonInfo lesson, WidgetRef ref) {
    NextScreen.iOS(context, VideoLesson(course: course, lesson: lesson));
  }

  Icon _trailingIcon(LessonInfo lesson) {
    return const Icon(FeatherIcons.playCircle);
  }

  Future<void> openDialog(BuildContext context, LessonInfo lessonDetail) {
    return Dialogs.materialDialog(
      context: context,
      title: 'Do-test-title'.tr(),
      msg: 'Do-test-subtitle'.tr(),
      titleAlign: TextAlign.center,
      titleStyle: Theme.of(context).textTheme.titleLarge!,
      msgAlign: TextAlign.center,
      msgStyle: Theme.of(context).textTheme.titleMedium,
      barrierDismissible: true,
      color: Theme.of(context).scaffoldBackgroundColor,
      actions: <Widget>[
        IconsOutlineButton(
          onPressed: () => Navigator.pop(context),
          text: 'close'.tr(),
        ),
        IconsOutlineButton(
          onPressed: () async {
            Navigator.pop(context);
            EasyLoading.instance
              ..displayDuration = const Duration(milliseconds: 2000)
              ..loadingStyle = EasyLoadingStyle.custom
              ..indicatorSize = 60
              ..textColor = ColorConst.blackColor
              ..radius = 20
              ..backgroundColor = Colors.transparent
              ..maskColor = Colors.transparent
              ..indicatorColor = ColorConst.blackColor54
              ..userInteractions = false
              ..dismissOnTap = true
              ..boxShadow = <BoxShadow>[]
              ..indicatorType = EasyLoadingIndicatorType.cubeGrid;
            EasyLoading.show(
              indicator: LoadingLogo(
                title: "",
                textSize: 14,
                assetImage: ImagesNameConst.getPngImage(ImagesNameConst.icLoading),
                sizeImage: 60,
                imageColor: Theme.of(context).primaryColor,
              ),
            );
            // MonitorLoading().showLoading('');
            TestDetail test = await getTestDetail(lessonDetail.testId!);
            EasyLoading.dismiss();
            // MonitorLoading().dismiss();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) {
                      return TestScreen(test: test, courseId: course.id!, lectureId: lessonDetail.id!,);
                    }
                ));
          },
          text: 'yes'.tr(),
          color: Theme.of(context).primaryColor,
          textStyle:
          const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ],
    );
  }
}

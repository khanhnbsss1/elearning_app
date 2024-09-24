import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/base/widgets/common/alert_dialog/loading.common.dart';
import 'package:lms_app/base/widgets/my_button.dart';
import 'package:lms_app/base/widgets/toast_common/toast_utils.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/mixins/course_mixin.dart';
import 'package:lms_app/mixins/user_mixin.dart';
import 'package:lms_app/screens/course_details.dart/vocabulary.dart';
import 'package:lms_app/screens/pdf_screen.dart';
import 'package:lms_app/screens/tabs/dictionary/word_screen.dart';
import 'package:lms_app/screens/tabs/my_courses_tab/my_courses_tab.dart';
import 'package:lms_app/screens/test/test_detail_screen.dart';
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
import '../../services/apis/question/models/question_info.dart';
import '../../services/apis/test/get_test_detail.dart';
import '../../services/apis/test/models/test_detail.dart';
import '../test/quiz_lesson/quiz_screen.dart';

class Lessons extends ConsumerWidget with CourseMixin, UserMixin {
  const Lessons({
    super.key,
    required this.listLectureInfo,
    required this.courseDetail,
  });

  final CourseInfo courseDetail;
  final List<LessonInfo> listLectureInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> notes = [];
    // final user = ref.watch(userDataProvider);
    return Column(children: [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 0, bottom: 20),
        itemCount: listLectureInfo.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
              future: getLessonDetail(listLectureInfo[index].id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  LessonInfo lessonDetail = snapshot.data!;
                  if (lessonDetail.note != null) {
                    notes = lessonDetail.note!.split('&&&&---&&&&');
                  }
                  return ListTile(
                      onTap: () => {
                            if (_onCheck(
                                context, lessonDetail, courseDetail, ref))
                              {_openLesson(context, lessonDetail, ref)}
                          },
                      // onTap: (){},
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      horizontalTitleGap: 10,
                      title: Row(
                        children: [
                          Text(
                            '${index + 1}.',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.black),
                          ),
                          Text(
                            lessonDetail.lectureName!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notes[0]??""),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Wrap(
                              spacing:  8.0,
                              runSpacing: 8.0,
                              children: [
                                if (notes.length > 1)
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      if (_onCheck(context, lessonDetail,
                                          courseDetail, ref)) {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (builder) {
                                          return PdfScreen(
                                              link: notes[1],
                                              name: "content".tr());
                                        }));
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
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.description,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                                              FontWeight.w400,
                                                          fontSize: 16))
                                              .tr(),
                                        ],
                                      ),
                                    ),
                                  ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    if (_onCheck(context, lessonDetail,
                                        courseDetail, ref)) {
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
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.language,
                                          color: Theme.of(context).primaryColor,
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
                                  ),
                                ),
                                if (lessonDetail.docLink != "" &&
                                    lessonDetail.docLink != null)
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      if (_onCheck(context, lessonDetail,
                                          courseDetail, ref)) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) => PdfScreen(
                                                    link: lessonDetail.docLink!,
                                                    name:
                                                        lessonDetail.docName ??
                                                            "-")));
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
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.folder,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                                              FontWeight.w400,
                                                          fontSize: 16))
                                              .tr(),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (lessonDetail.testId != null &&
                                    courseDetail.isPayment == 1)
                                  InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () async {
                                        if (_onCheck(context, lessonDetail,
                                            courseDetail, ref)) {
                                          _getTest(context, lessonDetail);
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
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.quiz,
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
                                                                FontWeight.w400,
                                                            fontSize: 16))
                                                .tr(),
                                          ],
                                        ),
                                      )),
                              ],
                            ),
                          )
                        ],
                      ),
                      trailing:
                          (listLectureInfo[index].isFinnish == false)
                              ? Icon(
                                  FeatherIcons.playCircle,
                                  color: Theme.of(context).primaryColor,
                                )
                              : Icon(
                                  FeatherIcons.checkCircle,
                                  color: Theme.of(context).primaryColor,
                                ));
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
    TestDetail testDetail = await ApiService().getTestDetail(testId);
    return testDetail;
  }

  bool _onCheck(BuildContext context, LessonInfo lesson, CourseInfo course,
      WidgetRef ref) {
    final myCourses = ref.watch(myCoursesProvider);
    if (UserManager().checkRegisteredCourse(course, myCourses.value ?? [])) {
      return true;
    } else {
      ToastUtils.showSnackBar(context, 'Please sign up course to learn it');
      return false;
    }
  }

  void _openLesson(BuildContext context, LessonInfo lesson, WidgetRef ref) {
    NextScreen.iOS(context, VideoLesson(course: courseDetail, lesson: lesson));
  }

  void _getTest(BuildContext context, LessonInfo lessonDetail) async {
    MonitorLoading().showLoading('');
    TestDetail test = await getTestDetail(lessonDetail.testId!);
    MonitorLoading().dismiss();
    showDialog(
      context: context,
      builder: (context) => TestDetailDialog(
        test: test,
        courseId: courseDetail.id!,
        lectureId: lessonDetail.id!,
      ),
    );
    // NextScreen.normal(
    //     context,
    //     TestDetailScreen(
    //       test: test,
    //       courseId: courseDetail.id!,
    //       lectureId: lessonDetail.id!,
    //     ));
  }
}

class TestDetailDialog extends StatefulWidget {
  const TestDetailDialog(
      {super.key,
        required this.test,
        required this.courseId,
        required this.lectureId});

  final TestDetail test;
  final int courseId;
  final int lectureId;

  @override
  State<TestDetailDialog> createState() => _TestDetailDialogState();
}

class _TestDetailDialogState extends State<TestDetailDialog> {
  @override
  Widget build(BuildContext context) {
    TestDetail test = widget.test;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'test-detail'.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'test-name'.tr(args: [test.name ?? "-"]),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'test-durian'.tr(args: [
                test.durian == '0' || test.durian == null
                    ? "10:00"
                    : test.durian!
              ]),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'test-type'.tr(args: [test.typeTest?.tr() ?? "-"]),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'test-length'
                  .tr(args: [(test.quizs?.length ?? 0).toString()]),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    backgroundColor: Colors.white,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text('cancel'.tr(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).primaryColor
                    ),),
                  ),
                  MyButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    onTap: () {
                        Navigator.pop(context);
                        List<QuestionInfo>? questions = widget.test.quizs;
                        NextScreen.normal(
                            context,
                            QuizLesson(
                              questions: questions,
                              test: widget.test,
                              courseId: widget.courseId,
                              lectureId: widget.lectureId,
                            ));
                    },
                    child: Text('confirm'.tr(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white
                    ),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> beginTestDialog(BuildContext context) {
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
          onPressed: () {
            Navigator.pop(context);
            List<QuestionInfo>? questions = widget.test.quizs;
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizLesson(
                  questions: questions,
                  test: widget.test,
                  courseId: widget.courseId,
                  lectureId: widget.lectureId,
                )));
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

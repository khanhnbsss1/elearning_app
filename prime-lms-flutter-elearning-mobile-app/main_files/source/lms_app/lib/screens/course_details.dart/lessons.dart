import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/base/widgets/common/alert_dialog/loading.export.dart';
import 'package:lms_app/base/widgets/toast_common/toast_utils.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/mixins/course_mixin.dart';
import 'package:lms_app/mixins/user_mixin.dart';
import 'package:lms_app/screens/course_details.dart/details_view.dart';
import 'package:lms_app/screens/course_details.dart/title_info.dart';
import 'package:lms_app/screens/course_details.dart/vocabulary.dart';
import 'package:lms_app/screens/pdf_screen.dart';
import 'package:lms_app/screens/tabs/my_courses_tab/my_courses_tab.dart';
import 'package:lms_app/screens/video_lesson.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/services/apis/lessson/models/lesson_info.dart';
import 'package:lms_app/utils/loading_widget.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../models/user/UserProfile.dart';
import '../../providers/user_data_provider.dart';

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
          final LessonInfo lesson = lectures[index];
          return FutureBuilder(
              future: getLessonDetail(lectures[index].id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  LessonInfo lessonDetail = snapshot.data!;
                  if (lessonDetail.note != null) notes = lessonDetail.note!.split('&&&&---&&&&');
                  return ListTile(
                      onTap: () => _onTap(context, lessonDetail, course, ref),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) {
                                            return PdfScreen(
                                                link: notes[1],
                                                name: "content".tr());
                                          }
                                      ));
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
                                    NextScreen.normal(
                                        context,
                                        Vocabulary(
                                            lessonDetail: lessonDetail,
                                            sectionId: index));
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
                        ],
                      ),
                      leading: Text(
                        '${index + 1}.',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      trailing: _trailingIcon(lesson));
                } else {
                  return LoadingTile();
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

  void _onTap(BuildContext context, LessonInfo lesson, CourseInfo course, WidgetRef ref) {
    final myCourses = ref.watch(myCoursesProvider);
    if (UserManager().checkRegisteredCourse(course, myCourses.value??[])) {
      _openLesson(context, lesson, ref);
    } else {
      ToastUtils.showSnackBar(context, 'Please sign up course to learn it');
    }
  }

  void _openLesson(BuildContext context, LessonInfo lesson, WidgetRef ref) {
    NextScreen.iOS(context, VideoLesson(course: course, lesson: lesson));
  }

  Icon _trailingIcon(LessonInfo lesson) {
    return const Icon(FeatherIcons.playCircle);
  }
}

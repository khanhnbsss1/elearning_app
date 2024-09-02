import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lms_app/ads/ad_manager.dart';
import 'package:lms_app/constants/app_constants.dart';
import 'package:lms_app/mixins/course_mixin.dart';
import 'package:lms_app/mixins/user_mixin.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/models/user_model.dart';
import 'package:lms_app/screens/article_lesson.dart';
import 'package:lms_app/screens/auth/login.dart';
import 'package:lms_app/screens/course_details.dart/vocabulary.dart';
import 'package:lms_app/screens/pdf_screen.dart';
import 'package:lms_app/screens/quiz_lesson/quiz_screen.dart';
import 'package:lms_app/screens/video_lesson.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/services/apis/lessson/models/lesson_info.dart';
import 'package:lms_app/utils/loading_widget.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:lms_app/utils/snackbars.dart';
import '../../models/lesson.dart';
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
    final user = ref.watch(userDataProvider);
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
                  return ListTile(
                      onTap: () =>
                          _onTap(context, lessonDetail, course, user, ref),
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
                          Text(lessonDetail.subName!).tr(),
                          const SizedBox(
                            height: 4,
                          ),
                          InkWell(
                              onTap: () {
                                NextScreen.normal(
                                    context,
                                    Vocabulary(
                                        lessonDetail: lessonDetail, sectionId: index));
                              },
                              child: Text('vocabulary',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16))
                                  .tr()),
                          (lessonDetail.docLink != "" && lessonDetail.docLink != null)
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => PdfScreen(
                                                link: lessonDetail.docLink!,
                                                name: lessonDetail.docName ??
                                                    "-")));
                                  },
                                  child: Text('document',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16))
                                      .tr())
                              : const SizedBox(),
                        ],
                      ),
                      leading: Text(
                        '${index + 1}.',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      trailing: _trailingIcon(lesson, user));
                } else {
                  return const SizedBox();
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

  void _onTap(BuildContext context, LessonInfo lesson, CourseInfo course,
      UserProfile? user, WidgetRef ref) {
    // if (user != null) {
    //   if (course.mode == "FREE") {
    //     // Free
    //     if (hasEnrolled(user, course)) {
    //       _openLesson(context, lesson, ref);
    //     } else {
    //       openSnackbar(context, 'Enroll to open lesson');
    //     }
    //   } else {
    //     // Premium
    //     if (hasEnrolled(user, course) && !UserMixin.isExpired(user)) {
    _openLesson(context, lesson, ref);
    //     } else {
    //       openSnackbar(context, 'Enroll to open lesson');
    //     }
    //   }
    // }
  }

  void _openLesson(BuildContext context, LessonInfo lesson, WidgetRef ref) {
    // if (lesson.contentType == 'video' && lesson.videoUrl != null) {
    //   NextScreen.iOS(context, VideoLesson(course: course, lesson: lesson));
    // } else if (lesson.contentType == 'article') {
    //   NextScreen.iOS(context, ArticleLesson(lesson: lesson, course: course));
    // } else {
    //   NextScreen.popup(context, QuizLesson(course: course, lesson: lesson));
    // }
    NextScreen.iOS(context, VideoLesson(course: course, lesson: lesson));
    //Placed interstitial ads when open any lesson
    // AdManager.initInterstitailAds(ref);
  }

  Icon _trailingIcon(LessonInfo lesson, UserProfile? user) {
    // if (isLessonCompleted(lesson, user)) {
    if (false) {
      return const Icon(Icons.check_box, color: Colors.orange);
    } else {
      // if (lesson.contentType == 'video') {
      return const Icon(FeatherIcons.playCircle);
      // } else if (lesson.contentType == 'article') {
      //   return const Icon(LineIcons.stickyNote);
      // } else {
      //   return const Icon(LineIcons.lightbulb);
      // }
    }
  }
}

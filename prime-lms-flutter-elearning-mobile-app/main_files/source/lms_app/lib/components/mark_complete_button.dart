import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/mixins/course_mixin.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/models/lesson.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/services/apis/lessson/models/lesson_info.dart';
import '../providers/user_data_provider.dart';
import '../services/api_service.dart';
import '../services/apis/question/models/question_info.dart';

class MarkCompleteButton extends ConsumerWidget with CourseMixin {
  const MarkCompleteButton(this.questions, {super.key, });

  final List<QuestionInfo>? questions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider);
    // final bool isCompleted = isLessonCompleted(lesson, user);
    final bool isCompleted = true;
    final IconData icon = isCompleted ? Icons.clear : Icons.done;
    final String buttonText = isCompleted ? 'unmark-complete' : 'mark-complete';
    return SizedBox();
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: Center(
        child: TextButton.icon(
          style: TextButton.styleFrom(backgroundColor: Colors.black38),
          icon: Icon(icon),
          label: Text(buttonText).tr(),
          onPressed: () async {
            final navigator = Navigator.of(context);
            // await ApiService().updateLessonMarkComplete(user!, course, lesson);
            await ref.read(userDataProvider.notifier).getData();
            navigator.pop();
          },
        ),
      ),
    );
  }
}

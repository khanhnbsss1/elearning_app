import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/models/lesson.dart';
import 'package:lms_app/models/question.dart';
import 'package:lms_app/screens/quiz_lesson/question_tile.dart';
import 'package:lms_app/screens/quiz_lesson/quiz_complete.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/services/apis/lessson/models/lesson_info.dart';
import 'package:lms_app/services/apis/question/models/question_info.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:lms_app/utils/snackbars.dart';

import '../../services/apis/test/models/test_detail.dart';
import '../../services/content_security_service.dart';

final selectedOptionProvider = StateProvider.autoDispose<int?>((ref) => null);
final questionPageControllerProvider = Provider((ref) => PageController(initialPage: 0));
final correctAnswerCountProvider = StateProvider<int>((ref) => 0);
final currentPageIndexProvider = StateProvider.autoDispose<int>((ref) => 0);


class QuizLesson extends ConsumerStatefulWidget {
  const QuizLesson({super.key, required this.questions,});

  final List<QuestionInfo>? questions;

  @override
  ConsumerState<QuizLesson> createState() => _QuizLessonState();
}

class _QuizLessonState extends ConsumerState<QuizLesson> {
  @override
  void initState() {
    ContentSecurityService().initContentSecurity(ref);
    super.initState();
  }

  @override
  void dispose() {
    ContentSecurityService().disposeContentSecurity();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<QuestionInfo> questions = widget.questions ?? [];
    final pageController = ref.watch(questionPageControllerProvider);
    final selectedOption = ref.watch(selectedOptionProvider);
    final currentPageIndex = ref.watch(currentPageIndexProvider);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('title'),
        ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () => _onNextBtnPressed(context, selectedOption, currentPageIndex, questions, ref, pageController),
            // onPressed: () {},
            child: Text('next',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )).tr(),
          ),
        ),
        body: PageView.builder(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: questions.length,
          onPageChanged: (value) => ref.read(currentPageIndexProvider.notifier).update((state) => value),
          itemBuilder: (context, questionIndex) {
            final QuestionInfo question = questions[questionIndex];
            return QuestionTile(
              ref: ref,
              questions: questions,
              currentPageIndex: currentPageIndex,
              question: question,
              questionIndex: questionIndex,
              selectedOption: selectedOption,
            );
          },
        ));
  }

  void _onNextBtnPressed(
    BuildContext context,
    int? selectedOption,
    int currentPageIndex,
    List<QuestionInfo> questions,
    WidgetRef ref,
    PageController pageController,
  ) {
    if (selectedOption != null) {
      if ((currentPageIndex + 1) >= questions.length) {
        NextScreen.replaceAnimation(context, QuizComplete(questions: widget.questions));
      } else {
        ref.invalidate(selectedOptionProvider);
        pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
    } else {
      openSnackbar(context, "choose-answer".tr());
    }
  }
}

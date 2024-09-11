import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/base/widgets/common/alert_dialog/loading.export.dart';
import 'package:lms_app/screens/test/count_down_clock.dart';
import 'package:lms_app/screens/test/quiz_lesson/question_tile.dart';
import 'package:lms_app/screens/test/quiz_lesson/quiz_complete.dart';
import 'package:lms_app/services/apis/question/models/question_info.dart';
import 'package:lms_app/services/apis/scores/create_score_api.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:lms_app/utils/snackbars.dart';
import '../../../services/apis/scores/models/score_info.dart';
import '../../../services/apis/scores/models/score_result.dart';
import '../../../services/apis/test/models/test_info.dart';
import '../../../services/content_security_service.dart';

final selectedOptionProvider = StateProvider.autoDispose<int?>((ref) => null);
final questionPageControllerProvider = Provider((ref) => PageController(initialPage: 0));
final correctAnswerCountProvider = StateProvider<int>((ref) => 0);
final currentPageIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
final selectedAnswerProvider = StateProvider<List<ScoreItem>>((ref) => []);

class QuizLesson extends ConsumerStatefulWidget {
  const QuizLesson({super.key, required this.questions,required this.test});

  final List<QuestionInfo>? questions;
  final TestInfo test;

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
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('test'.tr(), style: const TextStyle(color: Colors.white),),
          actions: const [
            CountDownClock(endTime: Duration(minutes: 10))
          ],
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
  ) async {
    if (selectedOption != null) {
      if ((currentPageIndex + 1) >= questions.length) {
        ScoreResultInfo result = ScoreResultInfo();
        if (result == ScoreResultInfo()) {
          NextScreen.replaceAnimation(context, LoadingView());
        } else {
        result = await _getResult(ref);
        NextScreen.replaceAnimation(context, QuizComplete(questions: widget.questions, result: result, test: widget.test));
      }

      } else {
        ref.invalidate(selectedOptionProvider);
        pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
    } else {
      openSnackbar(context, "choose-answer".tr());
    }
  }

  Future<ScoreResultInfo> _getResult(WidgetRef ref) async{
    List<ScoreItem> list = ref.watch(selectedAnswerProvider);
    CreateScoreApi createScoreApi = CreateScoreApi(info: ScoresInfo(
      testId: widget.test.id,
      lectureId: widget.test.lectureId,
      courseId: widget.test.courseId,
      scores: list,
    ));
    ScoreResultInfo? result = await createScoreApi.call();
    return result ?? ScoreResultInfo();
  }

  void _onChanged(int? value, WidgetRef ref, int questionIndex,AnswerInfo answer, String answerText, QuestionInfo question) {
    ref.read(selectedOptionProvider.notifier).update((state) => value);
    ref.read(selectedAnswerProvider.notifier).update((state)  {
      List<ScoreItem> list = state;
      list.add(ScoreItem(
          questionId: question.id,
          answerId: answer.answerId,
          answerName: answerText,
          questionType: question.typeQuestion!.toLowerCase() == "audio" ? QuestionType.audio :
          question.typeQuestion!.toLowerCase() == "text" ? QuestionType.text :
          question.typeQuestion!.toLowerCase() == "image" ? QuestionType.image :
          QuestionType.fill
      ));
      return list;
    });
  }
}

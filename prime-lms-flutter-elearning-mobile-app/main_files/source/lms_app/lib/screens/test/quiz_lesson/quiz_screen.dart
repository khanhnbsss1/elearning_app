import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/base/widgets/common/alert_dialog/loading.export.dart';
import 'package:lms_app/screens/test/count_down_clock.dart';
import 'package:lms_app/screens/test/quiz_lesson/question_tile.dart';
import 'package:lms_app/screens/test/quiz_lesson/quiz_complete.dart';
import 'package:lms_app/services/apis/question/models/question_info.dart';
import 'package:lms_app/services/apis/scores/create_score_api.dart';
import 'package:lms_app/services/apis/test/models/test_detail.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:lms_app/utils/snackbars.dart';
import '../../../base/image_manager/images_constant.dart';
import '../../../services/apis/scores/models/score_info.dart';
import '../../../services/apis/scores/models/score_result.dart';
import '../../../services/content_security_service.dart';

final selectedOptionProvider = StateProvider.autoDispose<int?>((ref) => null);
final questionPageControllerProvider = Provider((ref) => PageController(initialPage: 0));
final correctAnswerCountProvider = StateProvider<int>((ref) => 0);
final currentPageIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
final selectedAnswerProvider = StateProvider<List<ScoreItem>>((ref) => []);

class QuizLesson extends ConsumerStatefulWidget {
  const QuizLesson({super.key, required this.questions,required this.test, required this.courseId, required this.lectureId});

  final List<QuestionInfo>? questions;
  final TestDetail test;
  final int courseId;
  final int lectureId;

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
          title: Text('${widget.test.name}', style: const TextStyle(color: Colors.white),),
          actions: [
            CountDownClock(
                endTime: Duration(seconds: int.parse((widget.test.durian != "0" && widget.test.durian != null) ? widget.test.durian! : "600")),
                timeOut: () {
                  _onNextBtnPressed(context, 0, questions.length + 1, questions, ref, pageController);
                },
            )
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
            child: (currentPageIndex + 1 < questions.length) ? Text('next',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )).tr() : Text('submit-test',
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
            return SingleChildScrollView(
              child: QuestionTile(
                ref: ref,
                questions: questions,
                currentPageIndex: currentPageIndex,
                question: question,
                questionIndex: questionIndex,
                selectedOption: selectedOption,
              ),
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
          MonitorLoading().showLoading('');
          result = await _getResult(ref);
          MonitorLoading().dismiss();
          NextScreen.replaceAnimation(context, QuizComplete(questions: widget.questions, result: result, test: widget.test, lectureId: widget.lectureId, courseId: widget.courseId));
      }

      } else {
        ref.invalidate(selectedOptionProvider);
        pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
        setState(() {

        });
      }
    } else {
      openSnackbar(context, "choose-answer".tr());
    }
  }

  Future<ScoreResultInfo> _getResult(WidgetRef ref) async{
    List<ScoreItem> list = ref.watch(selectedAnswerProvider);
    CreateScoreApi createScoreApi = CreateScoreApi(info: ScoresInfo(
      testId: widget.test.id,
      lectureId: widget.lectureId,
      courseId: widget.courseId,
      scores: list,
    ));
    ScoreResultInfo? result = await createScoreApi.call();
    return result ?? ScoreResultInfo();
  }
}

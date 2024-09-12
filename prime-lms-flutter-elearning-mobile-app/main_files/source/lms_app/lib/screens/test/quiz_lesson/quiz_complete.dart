import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/ads/ad_manager.dart';
import 'package:lms_app/components/mark_complete_button.dart';
import 'package:lms_app/screens/test/quiz_lesson/quiz_screen.dart';
import 'package:lms_app/services/apis/test/models/test_detail.dart';
import 'package:lms_app/utils/next_screen.dart';

import '../../../services/apis/question/models/question_info.dart';
import '../../../services/apis/scores/models/score_result.dart';
import '../../../services/apis/test/models/test_info.dart';


class QuizComplete extends ConsumerWidget {
  const QuizComplete({super.key, required this.questions, required this.result, required this.test});
  final List<QuestionInfo>? questions;
  final ScoreResultInfo result;
  final TestInfo test;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isPassed = (result.point??0) >= 5.0 ? true : false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        title: Text(test.name!),
      ),
      bottomNavigationBar: isPassed
          ? MarkCompleteButton(questions)
          : BottomAppBar(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  'try-again',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18, color: Colors.white),
                ).tr(),
                onPressed: () {
                  // Placed ads when user failed the test
                  ref.invalidate(selectedAnswerProvider);
                  AdManager.initInterstitailAds(ref);
                  NextScreen.replaceAnimation(context, QuizLesson(questions: questions, test: test,));
                },
              ),
            ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Text(
                    'your-score',
                    style: Theme.of(context).textTheme.titleLarge,
                  ).tr(),
                  const SizedBox(height: 10),
                  Text('score-count', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.green))
                      .tr(args: [((result.point??0) * 10).toStringAsFixed(0)]),
                  const SizedBox(height: 20),
                  Text(
                    isPassed ? 'passed-test' : "failed-test",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
                  ).tr(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

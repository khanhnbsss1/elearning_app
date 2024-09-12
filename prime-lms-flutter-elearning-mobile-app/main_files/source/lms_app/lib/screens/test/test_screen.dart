import 'package:flutter/material.dart';
import 'package:lms_app/screens/test/quiz_lesson/quiz_screen.dart';
import 'package:lms_app/services/apis/test/models/test_detail.dart';
import '../../services/apis/question/models/question_info.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key, required this.test, required this.courseId, required this.lectureId});

  final TestDetail test;
  final int courseId;
  final int lectureId;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int totalQuiz = 4;
  int currentQuiz = 0;
  DateTime currentTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<QuestionInfo>? questions = widget.test.quizs;
    return QuizLesson(questions: questions,test: widget.test, courseId: widget.courseId, lectureId: widget.lectureId,);
  }
}

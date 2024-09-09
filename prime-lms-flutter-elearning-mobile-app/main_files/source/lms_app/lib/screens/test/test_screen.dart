import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/base/widgets/audio/audio_speaker.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/components/user_avatar.dart';
import 'package:lms_app/screens/quiz_lesson/question_tile.dart';
import 'package:lms_app/screens/test/progression_bar.dart';
import 'package:lms_app/screens/test/question_widget.dart';
import 'package:lms_app/services/apis/question/models/question_info.dart';
import 'package:lms_app/services/apis/test/get_test_detail.dart';
import 'package:lms_app/services/apis/test/models/test_detail.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../base/widgets/my_button.dart';
import '../../services/apis/test/models/test_info.dart';
import 'count_down_clock.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key, required this.testId});

  final int testId;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int totalQuiz = 4;
  int currentQuiz = 0;
  final DateTime _endTime =
      DateTime.now().add(const Duration(minutes: 60, seconds: 0));
  DateTime currentTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var progress = currentQuiz / totalQuiz;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'test',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.close),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: FutureBuilder(
            future: getTestDetail(widget.testId),
            builder: (builder, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingTile();
              } else {
                List<QuestionInfo>? questions = snapshot.data?.quizs;
                return Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ProgressionBar(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 25,
                        radius: 12,
                        progress: progress,
                      ),
                      CountDownClock(
                          endTime: _endTime.difference(DateTime.now())),

                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height-200,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: questions?.length,
                          itemBuilder: (context, index) {
                            return QuestionWidget(question: questions![index], index: index,);
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      right: 20,
                      left: 20,
                      bottom: 20,
                      child: (progress < 1)
                          ? InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  currentQuiz++;
                                });
                              },
                              child: Container(
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Center(
                                      child: Text(
                                    'next-question'.tr(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ))),
                            )
                          : InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                setState(() => openDialog(context));
                              },
                              child: Container(
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Center(
                                      child: Text(
                                    'submit-test'.tr(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ))),
                            ))
                ]);
                return SizedBox();
              }
            }));
  }

  Future<TestDetail> getTestDetail(int testId) async {
    GetTestDetailApi getTestDetailApi = GetTestDetailApi(testId: testId);
    TestDetail testDetail = await getTestDetailApi.call();
    return testDetail;
  }

  Future<void> openDialog(BuildContext context) {
    return Dialogs.materialDialog(
      context: context,
      title: 'submit-title'.tr(),
      msg: 'submit-subtitle'.tr(),
      titleAlign: TextAlign.center,
      titleStyle: Theme.of(context).textTheme.headlineMedium!,
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
            showDialog(
                context: context,
                builder: (context) {
                  return Text('data');
                });
            Navigator.pop(context);
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

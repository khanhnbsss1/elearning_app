import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/screens/test/quiz_lesson/quiz_screen.dart';
import 'package:lms_app/services/apis/test/models/test_detail.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import '../../services/apis/question/models/question_info.dart';
import '../../services/apis/scores/get_score_api.dart';
import '../../services/apis/scores/models/test_score_list.dart';

class TestDetailScreen extends StatefulWidget {
  const TestDetailScreen(
      {super.key,
      required this.test,
      required this.courseId,
      required this.lectureId});

  final TestDetail test;
  final int courseId;
  final int lectureId;

  @override
  State<TestDetailScreen> createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen> {
  @override
  Widget build(BuildContext context) {
    TestDetail test = widget.test;
    TestScoreList testScoreList = TestScoreList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'test-detail'.tr(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        'test-type'.tr(args: [test.typeTest ?? "-"]),
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
                        height: 8,
                      ),
                      FutureBuilder(
                          future: Future.wait([getScoreList()]),
                          builder:
                              (context, AsyncSnapshot<List<dynamic>> snapshot) {
                            if (snapshot.hasData) {
                              testScoreList = snapshot.data![0];
                              List<TestHistory> point = getPointFromTestScoreId(
                                  testScoreList, widget.test.id!);
                              return Column(
                                children: [
                                  Text(
                                    'test-taking-history'.tr(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    itemCount: point.length,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, _) =>
                                        const SizedBox(height: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            point[point.length - 1 - index]
                                                .time,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                    fontSize: 17),
                                          ),
                                          Text(
                                            '${point[point.length - 1 - index].point}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                    fontSize: 17),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          })
                    ],
                  ),
                ),
              ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
        child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              beginTestDialog(context);
            },
            child: Text('Do-test-title',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )).tr()),
      ),
    );
  }

  List<TestHistory> getPointFromTestScoreId(
      TestScoreList testScoreList, int id) {
    List<TestHistory> list = [];
    if (testScoreList.list != null) {
      for (TestScore testScore in testScoreList.list!) {
        if (testScore.testId == id) {
          String dateFormat = DateFormat('dd-MM-yyyy').format(DateTime.now());
          String timeFormat = DateFormat('HH:mm:ss').format(DateTime.now());
          list.add(TestHistory(
            time: testScore.createdAt ?? ("$dateFormat $timeFormat"),
            point: testScore.point,
          ));
        }
      }
    }
    return list;
  }

  Future<TestScoreList> getScoreList() async {
    GetScoreApi getScoreApi = GetScoreApi();
    TestScoreList testScoreList = await getScoreApi.call();
    return testScoreList;
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
          onPressed: () async {
            Navigator.pop(context);
            List<QuestionInfo>? questions = widget.test.quizs;
            NextScreen.replace(
                context,
                QuizLesson(
                  questions: questions,
                  test: widget.test,
                  courseId: widget.courseId,
                  lectureId: widget.lectureId,
                ));
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

class TestHistory {
  String time;
  dynamic point;

  TestHistory({required this.time, this.point});
}

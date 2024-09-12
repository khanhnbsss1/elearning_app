import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import 'package:webkit/services/apis/topic/model/topic_info.dart';
import 'package:webkit/views/lessson/lesson_detail/lesson_detail_bloc/lesson_detail_bloc.dart';
import 'package:webkit/views/test/test_detail_work/test_work_page.dart';

class SubjectItemWidget extends StatefulWidget{
  SubjectItemWidget({
    required this.subjectIndex, 
    required this.subject,
    required this.onFinishLecture,
    this.selectLessonInfo,
    required this.onSelectLesson,
    this.subjectScrollController
  });
  Subjects subject;
  int subjectIndex =0;
  Function(int)onFinishLecture;
  Function(LessonInfo)onSelectLesson;
  LessonInfo? selectLessonInfo;
  ScrollController? subjectScrollController;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SubjectItemWidgetState();
  }
  
}
class SubjectItemWidgetState extends State<SubjectItemWidget>{
  bool showSubject = true;
  List<bool>?checkLecture = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size16),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: ColorConst.blackColor, width: 0.2))
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${L10nX.getStr.subject_str} ${widget.subjectIndex+1}: ${widget.subject.subName}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleConstant.textStyleBlack14w600,
                      ),
                    ),
                    Gap(Dimens.size16),

                    Icon((!showSubject)?Icons.arrow_drop_down:Icons.arrow_drop_up, size: Dimens.size30,),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    (MediaQuery.of(context).size.width > 1050) ? Text(
                      '${L10nX.getStr.proccess_str}: ', 
                      style: TextStyleConstant.textStyleBlack14w400, ) : SizedBox(),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                         return buildSubjectProccess();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            setState(() {
              showSubject = !showSubject;
            });
          },
        ),
        buildLessonItemList(subjectIndex: widget.subjectIndex, subject: widget.subject,)
      ],
    );
  }
  Widget buildLessonItemList({required Subjects subject, required int subjectIndex, }) {
    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 200),
      child: showSubject
          ? Container(
        margin: EdgeInsets.all(0),
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: ListView.builder(
          shrinkWrap: true,
           controller: widget.subjectScrollController,
          itemCount: (subject.lectures ?? []).length,
          itemBuilder: (context, lectureIndex) {
            LessonInfo lessonInfo = (subject.lectures ?? []).elementAt(lectureIndex);
            bool isSelectLesson = lessonInfo.id == widget.selectLessonInfo?.id;
            bool isFinishLesson = lessonInfo.isFinnish??false;
            return InkWell(
              onTap: () {
                widget.onSelectLesson(lessonInfo);
              },
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        color: isSelectLesson?ColorConst.greyColor1.withOpacity(0.2): ColorConst.whiteColor,
                        border: Border(bottom: BorderSide(color: ColorConst.blackColor,width: 0.2))
                    ),
                    padding: EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size32),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${subjectIndex+1}.${lectureIndex+1}. ${lessonInfo.lectureName}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleConstant.textStyleBlack14w400,
                          ),
                        ),
                        Gap(Dimens.size10),
                        Center(
                          child: Icon(
                            isFinishLesson?Icons.check_box_outlined:Icons.check_box_outline_blank,
                            color:isFinishLesson? ColorConst.mainColor:ColorConst.colorIconGrays ,
                            size: Dimens.size20,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      )
          : SizedBox(),
    );
  }
  Widget buildSubjectProccess(){
    List<LessonInfo> listQuestionChooesed = [...((widget.subject.lectures??[])).where((element) => element.isFinnish==true,)];
    double percent = listQuestionChooesed.length /  (widget.subject.lectures??[]).length;
    return Center(
      child:  new LinearPercentIndicator(
        animation: true,
        lineHeight: Dimens.size20,
        animationDuration: 1000,
        percent: percent,
        center: Text(
            "${L10nX.getStr.learned_str} ${listQuestionChooesed.length} / ${(widget.subject.lectures??[]).length} ${L10nX.getStr.lesson_str}",
          style: TextStyleConstant.textStyleBlack13w400.copyWith(color: ColorConst.whiteColor),
        ),
        barRadius: Radius.circular(Dimens.size8),
        progressColor: Colors.green,
      ),
    );

  }
}


class TestItemWidget extends StatefulWidget{
  TestItemWidget({
    required this.subjectIndex,
    required this.testInfos,
    required this.onSelectTest,
    this.courseInfo, 
    this.lessonInfo,
    this.testTitle
  });
  List<TestInfo> testInfos;
  CourseInfo? courseInfo;
  LessonInfo? lessonInfo;
  String? testTitle;
  int subjectIndex =0;
  Function(TestInfo)onSelectTest;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestItemWidgetState();
  }

}
class TestItemWidgetState extends State<TestItemWidget>{
  bool showSubject = true;
  List<bool>?checkLecture = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size16),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: ColorConst.blackColor, width: 0.2), top: BorderSide(color: ColorConst.blackColor, width: 0.2))
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "II. ${widget.testTitle ?? L10nX.getStr.output_test_str} ",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleConstant.textStyleBlack16w500,
                      ),
                    ),
                    Gap(Dimens.size16),

                    Icon((!showSubject)?Icons.arrow_drop_down:Icons.arrow_drop_up, size: Dimens.size30,),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    (MediaQuery.of(context).size.width > 1050) ? Text('Tiến độ: ') : SizedBox(),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return buildTestProccess();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            setState(() {
              showSubject = !showSubject;
            });
          },
        ),
        buildTestItemList(subjectIndex: widget.subjectIndex,)
      ],
    );
  }
  Widget buildTestItemList({ required int subjectIndex, }) {
    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 200),
      child: showSubject
          ? Container(
        margin: EdgeInsets.all(0),
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: (widget.testInfos ?? []).length,
            itemBuilder: (context, testIndex) {
              TestInfo testInfo = (widget.testInfos??[]).elementAt(testIndex);
              bool isFinishTest = testInfo.isFinish??false;
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        color: ColorConst.whiteColor,
                        border: Border(bottom: BorderSide(color: ColorConst.blackColor,width: 0.2))
                    ),
                    padding: EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size32),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${subjectIndex+1}.${testIndex+1}. ${testInfo.name}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleConstant.textStyleBlack14w400,
                          ),
                        ),
                        Gap(Dimens.size10),
                        Stack(
                          children: [
                            Visibility(
                              visible: testInfo.isFinish??false,
                                child: ActionButton1(
                                  text: L10nX.getStr.view_str,
                                  height: Dimens.size40,
                                  enableBgColor: ColorConst.greyColor,
                                  textStype: TextStyleConstant.textStyleBlack16w600,
                                  onTap: () {
                                    TestWorkPage(
                                      testInfo: testInfo,enableShowResult: true,).show(context);
                                    },
                                )),
                            Visibility(
                                visible: !(testInfo.isFinish??false),
                                child: ActionButton1(
                                  text: L10nX.getStr.start_test,
                                  height: Dimens.size40,
                                  onTap: () {
                                    TestWorkPage(testInfo: testInfo,enableShowResult: false,).show(context);
                                  },
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      )
          : SizedBox(),
    );
  }
  Widget buildTestProccess(){
    List<TestInfo> listQuestionChooesed = [...((widget.testInfos??[])).where((element) => element.isFinish==true,)];
    double percent = listQuestionChooesed.length /  (widget.testInfos??[]).length;
    return Center(
      child:  Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: new LinearPercentIndicator(
          //width: Dimens.size250,
          animation: true,
          lineHeight: Dimens.size20,
          animationDuration: 1000,
          percent: percent,
          center: Text(
              "${L10nX.getStr.finished_str} ${listQuestionChooesed.length} / ${(widget.testInfos??[]).length} ${L10nX.getStr.test_str.toLowerCase()}",
            style: TextStyleConstant.textStyleBlack13w400,
          ),
          barRadius: Radius.circular(Dimens.size8),
          progressColor: Colors.green,
        ),
      ),
    );

  }
}
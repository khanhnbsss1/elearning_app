
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import 'package:webkit/views/question/question_detail/question_work/question_work_item.dart';
import 'bloc/test_work_bloc.dart';

class TestWorkPage extends StatefulWidget {
  void show(BuildContext context) {
    if(enableShowResult!=true) /// truong hop chua lam bai test
      {
        ConfirmPopupPage(
          content: "${L10nX.getStr.start_test_confirm} ${testInfo.durian??0} (${L10nX.getStr.time_in_minute_str})",
          onAccept: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Dialog(
                    child: this,
                  );
                });
          },
          
        ).show(context);
      }
    else
      {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                child: this,
              );
            });
      }

  }

  TestInfo testInfo;
  bool? enableCloseButton;
  bool? enableShowResult;
  TestWorkPage({
    required this.testInfo, 
    this.enableCloseButton, 
    this.enableShowResult
  }) {
    enableCloseButton ??= false;
    enableShowResult??false;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestWorkPageState();
  }
}

class TestWorkPageState extends State<TestWorkPage> with UIMixin{
  ScrollController controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) {
        return TestWorkBloc(TestWorkState(testInfo: widget.testInfo))..add(TestWorkInitEvent());
      },
      child: PointerInterceptor(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(Dimens.size20))
          ),
          width: MediaQuery.of(context).size.width * (ResponsiveInfo.isTablet() ? 0.8 : 1),
          height: MediaQuery.of(context).size.height * (ResponsiveInfo.isTablet() ? 1 : 1),
          constraints: BoxConstraints(
              maxWidth: Dimens.size1200
          ),
          clipBehavior: Clip.antiAlias,
          child: BlocConsumer<TestWorkBloc, TestWorkState>(
              listener: (context, state) {
                switch (state.blocStatus) {
                  case TestWorkStatus.initial:
                    break;
                  case TestWorkStatus.onLoading:
                    // TODO: Handle this case.
                    break;
                  case TestWorkStatus.onScoring:
                    // TODO: Handle this case.
                    break;
                  case TestWorkStatus.onShowResult:
                    // TODO: Handle this case.
                    break;
                  case TestWorkStatus.onChangePage:
                    // TODO: Handle this case.
                    state.blocStatus = TestWorkStatus.unKnown;
                    break;
                    
                  case TestWorkStatus.onUpdateChooseQuestion:
                    state.blocStatus = TestWorkStatus.unKnown;
                    break;
                  default:
                      break;
                }
                
              },
              builder: (BuildContext context, state) {
                return Scaffold(
                    appBar: AppBar(
                      backgroundColor: ColorConst.mainColor,
                      iconTheme: IconThemeData(
                        color: ColorConst.whiteColor, //change your color here
                      ),
                      title: Text(widget.testInfo.name??"", style: TextStyleConstant.textStyleBlack20w700.copyWith(color: ColorConst.whiteColor),),
                      centerTitle: true,
                      actions: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ActionButton1(
                              text: L10nX.getStr.prev,
                              height: Dimens.size40,
                              enableBgColor: ColorConst.whiteColor,
                              textStype: TextStyleConstant.textStyleBlack14w400.copyWith(color: ColorConst.mainColor),
                              enable: (state.page??0)>=1,
                              onTap: () {
                                if((state.page??0)<=0) {
                                  return;
                                }
                                BlocProvider.of<TestWorkBloc>(context).add(TestWorkOnChangePageTestEvent(page: (state.page??0)-1));
                              },
                            ),
                            Gap(Dimens.size20),
                            Stack(
                              children: [
                                Visibility(
                                  visible: (state.page??0)<(state.quizDTOsForView??[]).length-1,
                                  child: ActionButton1(
                                    text: L10nX.getStr.next,
                                    height: Dimens.size40,
                                    enableBgColor: ColorConst.whiteColor,
                                    textStype: TextStyleConstant.textStyleBlack14w400.copyWith(color: ColorConst.mainColor),
                                    
                                    onTap: () {
                                      if((state.page??0)>=(state.quizDTOsForView??[]).length-1) {
                                        return;
                                      }
                                      BlocProvider.of<TestWorkBloc>(context).add(TestWorkOnChangePageTestEvent(page: (state.page??0)+1));
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: (state.page??0)>=(state.quizDTOsForView??[]).length-1,
                                  child: ActionButton1(
                                    text: L10nX.getStr.submit,
                                    height: Dimens.size40,
                                    enableBgColor: ColorConst.whiteColor,
                                    textStype: TextStyleConstant.textStyleBlack14w400.copyWith(color: ColorConst.mainColor),
                                    onTap: () {
                                      ConfirmPopupPage(
                                        content: L10nX.getStr.you_are_ready_finish_test,
                                        onAccept: () {
                                          BlocProvider.of<TestWorkBloc>(context).add(TestWorkOnSubmitResultTestEvent());
                                        },
                                      ).show(context);
                                    },
                                  ),
                                )
                              ],
                            ),
                            Gap(Dimens.size20),
                          ],
                        )
                      ],
                    ),
                    body: Container(
                        decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: ColorConst.dividerColor, width: 1)),
                            color: ColorConst.gray01ColorOnBackgroundColor
                        ),
                        padding: EdgeInsets.symmetric(vertical: Dimens.size16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildTestProccess(state: state, context: context),
                            Expanded(child: buildQuestionList(state: state, context: context)),
                          ],
                        ))


                );
              })

        ),
      ),
    );


  }
  Widget buildQuestionList({required TestWorkState state, required BuildContext context}){

    List<QuestionInfo>? quiz= (state.quizDTOsForView?.elementAt(state.page??0)??[]);
    return RawScrollbar(
      controller: controller,
      thickness: Dimens.size15,
      trackVisibility: true,
      thumbVisibility: true,
      thumbColor: ColorConst.colorIconGrays.withOpacity(0.2),
      trackColor: ColorConst.whiteColor,
      radius: Radius.circular(Dimens.size8),
      child: ListView.builder(
        controller: controller,
        shrinkWrap: true,
        itemCount: quiz.length,
        itemBuilder: (context, index) {
          QuestionInfo questionInfo = quiz.elementAt(index);
          int questionIndex = (state.page??0)* (state.pageSize??0) +index;
          return Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.size8, horizontal: Dimens.size40),
            child: SizedBox(
              width: Dimens.size800,
              child: QuestionWorkItem(
                questionInfo: questionInfo,
                enableShowResultAnswer: widget.enableShowResult,
                questionIndex: questionIndex+1,
                onChangeAnswer: (p0) {
                  BlocProvider.of<TestWorkBloc>(context).add(TestWorkOnUpdateChooseQuestionEvent(questionInfo: p0));
                },
              ),
            ),
          );
        },),
    );
  }
  Widget buildTestProccess({required TestWorkState state, required BuildContext context}){
    List<QuestionInfo> listQuestionChooesed = [...(state.testInfo?.quizDTOs??[]).where((element) => element.answerIdChoose!=null,)];
    double percent = listQuestionChooesed.length /  (state.testInfo?.quizDTOs??[]).length;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.size34, vertical: Dimens.size16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child:  new LinearPercentIndicator(
                // width: Dimens.size350,
                animation: true,
                lineHeight: Dimens.size20,
                animationDuration: 100,
                percent: percent,
                center: Text("${L10nX.getStr.choosed_str} ${listQuestionChooesed.length} / ${(state.testInfo?.quizDTOs??[]).length} ${L10nX.getStr.question_str}"),
                barRadius: Radius.circular(Dimens.size8),
                progressColor: Colors.green,
              ),
            ),
          ),
          Gap(Dimens.size16),
          buildTimerTest(state: state, context: context)
        ],
      ),
    );

  }
  Widget buildTimerTest({required TestWorkState state, required BuildContext context}){
    return SizedBox(
      height: Dimens.size50,
      child: TimerCountdown(
        format: CountDownTimerFormat.minutesSeconds,
        minutesDescription: "m",
        secondsDescription: "s",
        enableDescriptions: false,
        colonsTextStyle: TextStyleConstant.textStyleBlack16w600,
        timeTextStyle: TextStyleConstant.textStyleBlack16w600,
        endTime: DateTime.now().add(
          Duration(
            minutes: state.testInfo?.durian??10,
          ),
        ),
        onEnd: () {
          ConfirmPopupPage(
            content: L10nX.getStr.time_test_end,
            onAccept: () {
              BlocProvider.of<TestWorkBloc>(context).add(TestWorkOnSubmitResultTestEvent());
            },
            onCancel: () {
              
            },
          ).show(context);
        },
      ),
    );
  }
}

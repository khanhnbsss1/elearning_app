import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/audio/audio_speaker.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import 'package:webkit/views/question/question_detail/question_work/question_work_item.dart';

import 'bloc/test_work_bloc.dart';

class TestWorkPage extends StatefulWidget {
  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: this,
          );
        });
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.size20))
      ),
      width: MediaQuery.of(context).size.width * (ResponsiveInfo.isTablet() ? 0.8 : 1),
      height: MediaQuery.of(context).size.height * (ResponsiveInfo.isTablet() ? 1 : 1),
      constraints: BoxConstraints(
        maxWidth: Dimens.size1200
      ),
      clipBehavior: Clip.antiAlias,
      child: Scaffold(
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
                ),
                Gap(Dimens.size20),
                Stack(
                  children: [
                    ActionButton1(
                      text: L10nX.getStr.next,
                      height: Dimens.size40,
                      enableBgColor: ColorConst.whiteColor,
                      textStype: TextStyleConstant.textStyleBlack14w400.copyWith(color: ColorConst.mainColor),
                    ),
                    Visibility(
                      visible: false,
                      child: ActionButton1(
                        text: L10nX.getStr.submit,
                        height: Dimens.size40,
                        enableBgColor: ColorConst.whiteColor,
                        textStype: TextStyleConstant.textStyleBlack14w400.copyWith(color: ColorConst.mainColor),
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
            child: buildQuestionList()),
      ),
    );

  }
  Widget buildQuestionList(){
    return BlocProvider(
        create: (context) {
          return TestWorkBloc(TestWorkState(testInfo: widget.testInfo))
            ..add(TestWorkInitEvent());
        },
        child: BlocConsumer<TestWorkBloc, TestWorkState>(
            listener: (context, state) {
              switch (state.blocStatus) {
                case TestWorkStatus.initial:
                  break;
                default:
                  break;
              }
            },
            builder: (BuildContext context, state) {
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
                  itemCount: (state.testInfo?.quizDTOs??[]).length,
                  itemBuilder: (context, index) {
                    QuestionInfo questionInfo = (state.testInfo?.quizDTOs??[]).elementAt(index);
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimens.size8, horizontal: Dimens.size40),
                      child: SizedBox(
                        width: Dimens.size800,
                        child: QuestionWorkItem(
                          questionInfo: questionInfo,
                          enableShowRightAnswer: widget.enableShowResult,
                          questionIndex: index+1,
                          onChangeAnswer: (p0) {
                                        
                          },
                        ),
                      ),
                    );
                  },),
              );
            }));
   
  }
}

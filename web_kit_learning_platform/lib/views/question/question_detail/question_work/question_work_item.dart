import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/audio/audio_speaker.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';

class QuestionWorkItem extends StatefulWidget {
  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * (ResponsiveInfo.isTablet() ? 0.4 : 0.6),
                //height: MediaQuery.of(context).size.height * (ResponsiveInfo.isTablet() ? 0.4 : 1),
                key: UniqueKey(),
                child: this),
          );
        });
  }

  QuestionInfo questionInfo;
  bool? enableCloseButton;
  bool? enableShowResultAnswer;
  Function(QuestionInfo)? onChangeAnswer;
  int? questionIndex;
  bool? isSelect;
  QuestionWorkItem({
    required this.questionInfo, 
    this.enableCloseButton, 
    this.onChangeAnswer, 
    this.isSelect,
    this.enableShowResultAnswer,
    this.questionIndex
  }) {
    enableCloseButton ??= false;
    enableShowResultAnswer??false;
    questionIndex??=0;

  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QuestionWorkItemState();
  }
}

class QuestionWorkItemState extends State<QuestionWorkItem> with UIMixin{
  TextEditingController controller = TextEditingController();
  AnswerInfo? rightAnswerInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if((widget.questionInfo.answerGetDetail??[]).isNotEmpty && ((widget.questionInfo.answerGetDetail??[]).where((element) => element.rightAnswer ==1).isNotEmpty))
    {
      rightAnswerInfo=(widget.questionInfo.answerGetDetail??[]).where((element) => element.rightAnswer ==1).first;
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: Dimens.size400,
      child: Container(
        decoration: BoxDecoration(
            color: ColorConst.whiteColor,
            borderRadius: BorderRadius.circular(Dimens.size16),
          border: Border.all(color: ColorConst.greyColor, width: 0.5)
        ),
        padding: EdgeInsets.all(Dimens.size16),
        constraints: BoxConstraints(
          minHeight: Dimens.size150,
          maxWidth: Dimens.size400
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    "${widget.questionIndex.toString()}. ${(widget.questionInfo.questionName ?? "").isNotEmpty ?
                    (widget.questionInfo.questionName ?? "") : " Đáp án này sau đây là đúng ?"}",
                    style: TextStyleConstant.textStyleBlack14w400,
                  ),
                ),
                Gap(Dimens.size12),
                Visibility(
                    visible: (widget.enableCloseButton ?? false),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: ColorConst.colorIconGrays,
                      ),
                    )),
                Visibility(
                    visible: !(widget.enableCloseButton ?? false),
                    child: InkWell(
                      child: Icon(
                        Icons.flag_circle_outlined,
                        color: ColorConst.colorIconGrays,
                      ),
                    )),
              ],
            ),
            Gap(Dimens.size12),
            Visibility(
              visible:widget.questionInfo.questionType == QuestionType.image || widget.questionInfo.questionType == QuestionType.audio, 
                child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) { 
                  double imageWidth = 350>constraints.maxWidth/4?300:constraints.maxWidth/4;
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                       // height: widget.questionInfo.questionType == QuestionType.image? Dimens.size90:Dimens.size60,
                        width: imageWidth,
                        child: Stack(children:[
                          Visibility(
                            visible: widget.questionInfo.questionType == QuestionType.image,
                            child: ImageManager().getImageByUrl(widget.questionInfo.questionLink??"", boxFit: BoxFit.contain),
                          ),
                          Visibility(
                            visible: widget.questionInfo.questionType == QuestionType.audio,
                            child: AudioSpeaker(url:  widget.questionInfo.questionLink??""),
                          ),
                        ] ),),
                    ],
                  );
                },
                )),
            
            Divider(color: ColorConst.greyColor,thickness: 0.1,),
            Gap(Dimens.size16),
            buildAnswerList(),
          ],
        ),
      ),
    );
  }

  Widget buildAnswerList() {
    if ((widget.questionInfo.answerGetDetail ?? []).isEmpty) {
      return Center(child: NoData());
    }
    int itemHeight = (widget.questionInfo.answerGetDetail ?? []).first.answerType == AnswerType.image ? 120 : 90;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: Dimens.size16),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if(widget.questionInfo.questionType ==QuestionType.fill )
            {
              return Column(
                children: [
                  Row(
                    children: [
                      Text("${L10nX.getStr.answer_str_1}: ", style: TextStyleConstant.textStyleBlack14w400,),
                      Gap(Dimens.size12),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: controller,
                          onTapOutside: (event) {
                            if(widget.onChangeAnswer!=null && widget.questionInfo.questionType == QuestionType.fill)
                            {
                              widget.questionInfo.answerChoose = controller.text;
                              widget.onChangeAnswer!(widget.questionInfo);
                            }
                          },
                          onChanged: (value) {
                            if(widget.onChangeAnswer!=null && widget.questionInfo.questionType == QuestionType.fill)
                            {
                              widget.questionInfo.answerChoose = controller.text;
                              widget.onChangeAnswer!(widget.questionInfo);
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "${L10nX.getStr.answer_str_1}...",
                            labelStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                  buildCorrectAnswer()
      
                ],
              );
            }
          
          return GridView.builder(
            shrinkWrap: true,
            itemCount: (widget.questionInfo.answerGetDetail ?? []).length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: constraints.maxWidth / 2 / itemHeight,
            ),
            itemBuilder: (context, index) {
              AnswerInfo answerInfo = (widget.questionInfo.answerGetDetail ?? []).elementAt(index);
              bool isChoose = widget.questionInfo.answerIdChoose == answerInfo.answerId;
              return Visibility(
                visible: widget.questionInfo.questionType != QuestionType.fill,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: widget.enableShowResultAnswer==true,
                      child: SizedBox(
                        width: Dimens.size20,
                        height: Dimens.size20,
                        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) { 
                          bool isRightAnswer=  answerInfo.rightAnswer == 1;
                          int radioState =0; ///0: chọn đúng, 1: Chọn sai, 2, không chọn
                          if(isRightAnswer)
                            {
                              radioState = 0;
                            }
                          else if(!isRightAnswer && isChoose){
                            radioState = 1;
                          }
                          else
                            {
                              radioState = 2;
                            }
                          return Icon(
                              (radioState==0 || radioState==1?Icons.check_circle : Icons.radio_button_off),
                            color: (radioState ==0 ? Colors.green:
                            (radioState==1?ColorConst.colorIconRed:
                            ColorConst.colorIconGrays))
                          );
                        },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.enableShowResultAnswer!=true,
                      child: InkWell(
                        onTap: () {
                          if (widget.onChangeAnswer != null) {
                            setState(() {
                              widget.questionInfo.answerIdChoose = answerInfo.answerId;
                              widget.onChangeAnswer!(widget.questionInfo);
                            });
                          }
                        },
                        child: SizedBox(
                          width: Dimens.size20,
                          height: Dimens.size20,
                          child: Icon(
                            isChoose ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: ColorConst.colorIconGrays,
                          ),
                        ),
                      ),
                    ),
                    Gap(
                      Dimens.size16,
                    ),
                    Expanded(
                        child: Stack(
                          children: [
                            Visibility(
                                visible: answerInfo.answerType == AnswerType.text,
                                child: Text(
                                  answerInfo.answer ?? "",
                                  style: TextStyleConstant.textStyleBlack14w400,
                                )),
                            Visibility(
                                visible: answerInfo.answerType == AnswerType.audio,
                                child: AudioSpeaker(
                                  url: answerInfo.answer ?? "",
                                )),
                            Visibility(
                                visible: answerInfo.answerType == AnswerType.image, 
                                child: SizedBox(
                                    width: Dimens.size120, 
                                    height: Dimens.size100, 
                                    child: ImageManager().getImageByUrl(answerInfo.answer ?? ""))),
                          ],
                        ))
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
  Widget buildCorrectAnswer(){
    return Visibility(
      visible: (widget.questionInfo.questionType == QuestionType.fill)&&
          (widget.enableShowResultAnswer??false) && 
          rightAnswerInfo!=null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(Dimens.size16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(L10nX.getStr.right_answer, style: TextStyleConstant.textStyleBlack14w400,),
              Gap(Dimens.size8),
              Text(rightAnswerInfo?.answer??"", style: TextStyleConstant.textStyleBlack14w400,)
            ],
          ),
        ],
      ),
    );
  }
}

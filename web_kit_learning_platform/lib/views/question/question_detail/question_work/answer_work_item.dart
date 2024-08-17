import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/audio/audio_speaker.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';

class AnswerWorkItem extends StatefulWidget{
  AnswerInfo answerInfo;
  QuestionInfo questionInfo;
  Function(AnswerInfo)onChoose;
  AnswerWorkItem({required this.answerInfo, required this.questionInfo, required this.onChoose});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AnswerWorkItemState();
  }

}
class AnswerWorkItemState extends State<AnswerWorkItem>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      child: Stack(
        children: [
          Visibility(
            visible: widget.questionInfo.questionType != QuestionType.fill,
            child: Row(
              children: [
                Stack(
                  children: [
                    Visibility(
                        visible: widget.questionInfo.answerIdChoose == widget.answerInfo.answerId,
                        child: Icon(Icons.radio_button_checked, color: ColorConst.colorIconRed,)),
                    Visibility(
                        visible: widget.questionInfo.answerIdChoose != widget.answerInfo.answerId,
                        child: Icon(Icons.radio_button_off, color: ColorConst.greyColor,)),
                  ],
                ),
                
                /// hien thi cho type anser la text
                Visibility(
                  visible: widget.answerInfo.answerType == AnswerType.text,
                    child: Text(widget.answerInfo.name??"", style: TextStyleConstant.textStyleBlack13w400,)),
                /// hien thi cho type anser la text
                Visibility(
                    visible: widget.answerInfo.answerType == AnswerType.image,
                    child: ImageManager().getImageByUrl(widget.answerInfo.name??"", width: Dimens.size150, boxFit: BoxFit.contain)),
                /// hien thi cho type anser la text
                Visibility(
                    visible: widget.answerInfo.answerType == AnswerType.audio,
                    child: AudioSpeaker(url:widget.answerInfo.name??"",)),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
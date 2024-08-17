import 'package:flutter/cupertino.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';

class QuestionWorkItem extends StatefulWidget{
  QuestionInfo questionInfo;
  QuestionWorkItem({required this.questionInfo});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QuestionWorkItemState();
  }
  
}
class QuestionWorkItemState extends State<QuestionWorkItem>{
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
    );
  }
}
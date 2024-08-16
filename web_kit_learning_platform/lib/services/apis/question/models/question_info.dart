
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/models/page_model.dart';
enum QuestionType{
  text,
  audio,
  image,
  
}
enum AnswerType{
  text,
  audio,
  image,
  selfEssay
}

Map<QuestionType, String>mapQuestionTypeToStrKey={
  QuestionType.text:"text",
  QuestionType.audio:"audio",
  QuestionType.image:"image",
};
Map< String,QuestionType>mapStrKeyQuestionType={
  "text":QuestionType.text,
  "audio":QuestionType.audio,
  "image":QuestionType.image,
};

Map<AnswerType, String>mapAnswerTypeToStrKey={
  AnswerType.text:"text",
  AnswerType.audio:"audio",
  AnswerType.image:"image",
  AnswerType.selfEssay:"self_essay",

};
Map<String,AnswerType>mapStrKeyAnswerType={
  "text":AnswerType.text,
  "audio":AnswerType.audio,
  "image":AnswerType.image,
  "self_essay":AnswerType.selfEssay,

};
class QuestionInfo {
  int? id;
  String? questionName;
  int? weightage;
  QuestionType? questionType;
  String? questionLink;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  int? fileId;
  int? gradeId;
  List<AnswerInfo>? answerGetDetail;
  QuestionInfo(
      {this.id,
        this.questionName,
        this.weightage,
        this.questionLink,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.answerGetDetail,
        this.questionType,
        this.fileId,
        this.gradeId
      }){
    questionType??=QuestionType.image;
    answerGetDetail??=[];
  }
  QuestionType getQuestionType(){
    return questionType??QuestionType.text;
  }

  QuestionInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionName = json['question_name'];
    weightage = json['weightage'];
    questionType = json['type_question'];
    questionType = mapStrKeyQuestionType[json['type_question']??'']??QuestionType.text;
    questionLink = json['question_link'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    answerGetDetail = [];
    if (json['answer'] != null) {
      answerGetDetail = <AnswerInfo>[];
      json['answer'].forEach((v) {
        answerGetDetail!.add(new AnswerInfo.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(id!=null)
    {
      data['id']= id;
    }
    data['question_name']= questionName;
    data['name']= questionName;
    if(fileId!=null&&questionType!=QuestionType.text)
      {
        data['file_id']= fileId;
      }

    if(gradeId!=null)
    {
      data['grade_id']= gradeId;
    }
    if(weightage!=null)
      {
        data['weightage']= weightage;
      }
    if(questionType!=null)
    {
      data['type_question']= mapQuestionTypeToStrKey[questionType];
    }
    if (answerGetDetail != null) {
      data['answers'] = answerGetDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnswerInfo {
  int? answerId;
  String? name;
  int? questionId;
  int? fileId;
  int? rightAnswer;
  AnswerType? answerType;
  AnswerInfo({this.name, this.questionId, this.fileId, this.rightAnswer, this.answerId, this.answerType});

  AnswerInfo.fromJson(Map<String, dynamic> json) {
    name = json['name']??json['answer'];
    answerType = mapStrKeyAnswerType[json['type_answer']]??AnswerType.text;
    questionId = json['question_id'];
    fileId = json['file_id'];
    rightAnswer = json['right_answer'];
    answerId = json['answer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name']= name??"";
    if(answerType!=null)
      {
        data['type_answer']= mapAnswerTypeToStrKey[answerType];
      }
    if(questionId!=null)
    {
      data['question_id']= questionId;
    }   
    if(fileId!=null && answerType!=AnswerType.text)
    {
      data['file_id']= fileId;
    }  
    if(rightAnswer!=null)
    {
      data['right_answer']= rightAnswer;
    }
    if(answerId!=null && answerId!>0)
    {
      data['answer_id']= answerId;
    }
    return data;
  }
  AnswerType getAnswerType(){
    return answerType??AnswerType.text;
  }
}


class QuestionListResponseModel extends PageModel{
  List<QuestionInfo>? content;

  QuestionListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  QuestionListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <QuestionInfo>[];
      json['content'].forEach((v) {
        content!.add(new QuestionInfo.fromJson(v));
      });
    }
  }
  QuestionListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <QuestionInfo>[];
      json.forEach((v) {
        content!.add(new QuestionInfo.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['pageSize'] = pageSize;
    data['pageNumber'] = pageNumber;
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}
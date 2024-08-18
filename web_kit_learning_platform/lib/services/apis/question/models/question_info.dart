
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
enum QuestionType{
  text,
  audio,
  image,
  fill
  
}
enum AnswerType{
  text,
  audio,
  image,
  selfEssay
}

Map<QuestionType, String>mapQuestionTypeToStrKey={
  QuestionType.text:"Text",
  QuestionType.audio:"Audio",
  QuestionType.image:"Image",
  QuestionType.fill:"Fill",

};

Map< String,QuestionType>mapStrKeyQuestionType={
  "Text":QuestionType.text,
  "Audio":QuestionType.audio,
  "Image":QuestionType.image,
  "Fill":QuestionType.fill,

};

Map<AnswerType, String>mapAnswerTypeToStrKey={
  AnswerType.text:"Text",
  AnswerType.audio:"Audio",
  AnswerType.image:"Image",
  AnswerType.selfEssay:"Self_essay",

};
Map<String,AnswerType>mapStrKeyAnswerType={
  "Text":AnswerType.text,
  "Audio":AnswerType.audio,
  "Image":AnswerType.image,
  "Self_essay":AnswerType.selfEssay,

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
  int? answerIdChoose;
  String? answerChoose;

  UploadFileResponseInfo? uploadInfo;
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
        this.gradeId,
        this.answerIdChoose,
        this.answerChoose,
        this.uploadInfo
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
    //questionType = json['type_question'];
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

    if (answerGetDetail != null && (answerGetDetail??[]).isNotEmpty) {
      if(questionType== QuestionType.fill)
      {
        /// Neu la cau hoi dien tu thi chi co 1 dap an
        List<AnswerInfo>answerGetDetailTemp =[ answerGetDetail!.elementAt(0)];
        data['answers'] = answerGetDetailTemp.map((v) => v.toJson()).toList();
      }
      else
      {
        data['answers'] = answerGetDetail!.map((v) => v.toJson()).toList();
      }
    }
    return data;
  }
}

class AnswerInfo {
  int? answerId;
  String? name;
  int? questionId;
  String? answer;
  int? fileId;
  int? rightAnswer;
  AnswerType? answerType;
  UploadFileResponseInfo? uploadInfo;
  AnswerInfo({
    this.name, this.questionId, this.fileId,
    this.rightAnswer, this.answerId, this.answerType,
    this.uploadInfo, this.answer
  });

  AnswerInfo.fromJson(Map<String, dynamic> json) {
    name = json['name']??json['answer'];
    answerType = mapStrKeyAnswerType[json['type_answer']]??AnswerType.text;
    questionId = json['question_id'];
    fileId = json['file_id'];
    rightAnswer = json['right_answer'];
    answerId = json['answer_id'];
    answer = json['answer'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    else
    {
      data['name']= name??"";
    }
    if(answer!=null)
    {
      data['answer']= answer;
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
    total = json['total']??0;
    pageSize = json['pageSize']??=10;
    pageNumber = json['pageNumber']??=0;
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
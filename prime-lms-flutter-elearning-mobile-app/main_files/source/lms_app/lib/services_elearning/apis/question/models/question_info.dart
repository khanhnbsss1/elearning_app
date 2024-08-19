
import '../../../../base/base_request_elearning/models/page_model.dart';

class QuestionInfo {
  int? id;
  String? questionName;
  int? weightage;
  String? typeQuestion;
  String? questionLink;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  List<AnswerInfo>? answerGetDetail;
  List<AnswerUploadInfo>?answerUpload;
  QuestionInfo(
      {this.id,
        this.questionName,
        this.weightage,
        this.typeQuestion,
        this.questionLink,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.answerGetDetail,
        this.answerUpload
      });

  QuestionInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionName = json['question_name'];
    weightage = json['weightage'];
    typeQuestion = json['type_question'];
    questionLink = json['question_link'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    if (json['answer'] != null) {
      answerGetDetail = <AnswerInfo>[];
      json['answer'].forEach((v) {
        answerGetDetail!.add(new AnswerInfo.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']= id;
    data['question_name']= questionName;
    data['weightage']= weightage;
    data['type_question']= typeQuestion;
    data['question_link']= questionLink;
    data['created_at']= createdAt;
    data['created_by']= createdBy;
    data['updated_at']= updatedAt;
    if (answerGetDetail != null) {
      data['answer'] = answerGetDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnswerInfo {
  int? answerId;
  String? answer;
  String? typeAnswer;
  int? rightAnswer;

  AnswerInfo({this.answerId, this.answer, this.typeAnswer, this.rightAnswer});

  AnswerInfo.fromJson(Map<String, dynamic> json) {
    answerId = json['answer_id'];
    answer = json['answer'];
    typeAnswer = json['type_answer'];
    rightAnswer = json['right_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer_id']= answerId;
    data['answer']= answer;
    data['type_answer']= typeAnswer;
    data['right_answer']= rightAnswer;
    return data;
  }
}
class AnswerUploadInfo {
  String? name;
  String? typeAnwer;
  int? questionId;
  int? fileId;

  AnswerUploadInfo({this.name, this.typeAnwer, this.questionId, this.fileId});

  AnswerUploadInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    typeAnwer = json['type_anwer'];
    questionId = json['question_id'];
    fileId = json['file_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name']= name;
    data['type_anwer']= typeAnwer;
    data['question_id']= questionId;
    data['file_id']= fileId;
    return data;
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
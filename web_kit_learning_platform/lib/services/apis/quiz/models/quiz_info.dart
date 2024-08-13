import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';

import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';

class QuizInfo {
  int? id;
  String? questionName;
  int? weightage;
  String? typeQuestion;
  String? questionLink;
  String? createdAt;
  String? createdBy;
  Null? updatedAt;
  List<Answer>? answer;

  QuizInfo(
      {this.id,
        this.questionName,
        this.weightage,
        this.typeQuestion,
        this.questionLink,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.answer});

  QuizInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionName = json['question_name'];
    weightage = json['weightage'];
    typeQuestion = json['type_question'];
    questionLink = json['question_link'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    if (json['answer'] != null) {
      answer = <Answer>[];
      json['answer'].forEach((v) {
        answer!.add(new Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_name'] = this.questionName;
    data['weightage'] = this.weightage;
    data['type_question'] = this.typeQuestion;
    data['question_link'] = this.questionLink;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    if (this.answer != null) {
      data['answer'] = this.answer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answer {
  int? answerId;
  String? answer;
  String? typeAnswer;
  int? rightAnswer;

  Answer({this.answerId, this.answer, this.typeAnswer, this.rightAnswer});

  Answer.fromJson(Map<String, dynamic> json) {
    answerId = json['answer_id'];
    answer = json['answer'];
    typeAnswer = json['type_answer'];
    rightAnswer = json['right_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer_id'] = this.answerId;
    data['answer'] = this.answer;
    data['type_answer'] = this.typeAnswer;
    data['right_answer'] = this.rightAnswer;
    return data;
  }
}
class QuizListResponseModel extends PageModel{
  List<QuizInfo>? content;
  QuizListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  QuizListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <QuizInfo>[];
      json['content'].forEach((v) {
        content!.add(new QuizInfo.fromJson(v));
      });
    }
  }
  QuizListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <QuizInfo>[];
      json.forEach((v) {
        content!.add(new QuizInfo.fromJson(v));
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


import '../../../../base/base_request_elearning/models/page_model.dart';
import '../../test/models/test_info.dart';

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
  String? subName;
  String? level;
  String? typeQuestion;
  int? fileId;
  int? gradeId;
  String? gradeName;
  int? categoryId;
  String? categoryName;
  String? questionLink;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  int? totalRecord;
  List<AnswerInfo>? answer;

  QuestionInfo(
      {this.id,
        this.questionName,
        this.weightage,
        this.subName,
        this.level,
        this.typeQuestion,
        this.fileId,
        this.gradeId,
        this.gradeName,
        this.categoryId,
        this.categoryName,
        this.questionLink,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.totalRecord,
        this.answer});

  QuestionInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionName = json['question_name'];
    weightage = json['weightage'];
    subName = json['sub_name'];
    level = json['level'];
    typeQuestion = json['type_question'];
    fileId = json['file_id'];
    gradeId = json['grade_id'];
    gradeName = json['grade_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    questionLink = json['question_link'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    totalRecord = json['total_record'];
    if (json['answer'] != null) {
      answer = <AnswerInfo>[];
      json['answer'].forEach((v) {
        answer!.add(new AnswerInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_name'] = this.questionName;
    data['weightage'] = this.weightage;
    data['sub_name'] = this.subName;
    data['level'] = this.level;
    data['type_question'] = this.typeQuestion;
    data['file_id'] = this.fileId;
    data['grade_id'] = this.gradeId;
    data['grade_name'] = this.gradeName;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['question_link'] = this.questionLink;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['total_record'] = this.totalRecord;
    if (this.answer != null) {
      data['answer'] = answer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnswerInfo {
  int? answerId;
  String? answer;
  int? fileId;
  String? typeAnswer;
  int? rightAnswer;

  AnswerInfo(
      {this.answerId,
        this.answer,
        this.fileId,
        this.typeAnswer,
        this.rightAnswer});

  AnswerInfo.fromJson(Map<String, dynamic> json) {
    answerId = json['answer_id'];
    answer = json['answer'];
    fileId = json['file_id'];
    typeAnswer = json['type_answer'];
    rightAnswer = json['right_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer_id'] = answerId;
    data['answer'] = answer;
    data['file_id'] = fileId;
    data['type_answer'] = typeAnswer;
    data['right_answer'] = rightAnswer;
    return data;
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
  QuestionListResponseModel.fromFilter(FilterResponseModel json) {
    content = <QuestionInfo>[];
    for (TestFilterItem v in (json.data??[])) {
      for(SubTestFilter subTestFilter in v.subFilter??[]) {
        content!.add(new QuestionInfo(id: subTestFilter.id, questionName: subTestFilter.name));
      }
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

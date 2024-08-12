import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';

class QuizInfo {
  int? id;
  int? courseId;
  int? lectureId;
  String? language;
  String? typeQuiz;
  String? name;
  String? courseName;
  String? subName;
  String? lectureName;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  List<QuestionInfo>? quizDTOs;

  QuizInfo(
      {this.id,
        this.courseId,
        this.lectureId,
        this.language,
        this.typeQuiz,
        this.name,
        this.courseName,
        this.subName,
        this.lectureName,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy,
        this.quizDTOs});

  QuizInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    lectureId = json['lecture_id'];
    language = json['language'];
    typeQuiz = json['type_quiz'];
    name = json['name'];
    courseName = json['course_name'];
    subName = json['sub_name'];
    lectureName = json['lecture_name'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    if (json['quizDTOs'] != null) {
      quizDTOs = <QuestionInfo>[];
      json['quizDTOs'].forEach((v) {
        quizDTOs!.add(new QuestionInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] =id;
    data['course_id'] =courseId;
    data['lecture_id'] =lectureId;
    data['language'] =language;
    data['type_quiz'] =typeQuiz;
    data['name'] =name;
    data['course_name'] =courseName;
    data['sub_name'] =subName;
    data['lecture_name'] =lectureName;
    data['created_at'] =createdAt;
    data['created_by'] =createdBy;
    data['updated_at'] =updatedAt;
    data['updated_by'] =updatedBy;
    if (quizDTOs != null) {
      data['quizDTOs'] =quizDTOs!.map((v) => v.toJson()).toList();
    }
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


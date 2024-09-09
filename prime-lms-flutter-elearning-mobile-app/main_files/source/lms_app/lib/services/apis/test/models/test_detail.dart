import 'package:lms_app/services/apis/question/models/question_info.dart';

class TestDetail {
  int? id;
  String? language;
  String? typeTest;
  String? name;
  String? durian;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  List<QuestionInfo>? quizs;

  TestDetail(
      {this.id,
        this.language,
        this.typeTest,
        this.name,
        this.durian,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy,
        this.quizs});

  TestDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'];
    typeTest = json['type_test'];
    name = json['name'];
    durian = json['durian'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    if (json['quizs'] != null) {
      quizs = <QuestionInfo>[];
      json['quizs'].forEach((v) {
        quizs!.add(new QuestionInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language'] = this.language;
    data['type_test'] = this.typeTest;
    data['name'] = this.name;
    data['durian'] = this.durian;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    if (this.quizs != null) {
      data['quizs'] = this.quizs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

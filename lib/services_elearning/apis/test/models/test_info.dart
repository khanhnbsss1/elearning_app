import 'package:lms_app/services_elearning/apis/question/models/question_info.dart';
import '../../../../base/base_request_elearning/models/page_model.dart';


enum TestLevel{
  easy,
  normal,
  hard
}
Map<TestLevel, String>mapTestLevelToStrKey={
  TestLevel.easy:"easy",
  TestLevel.normal:"normal",
  TestLevel.hard:"difficulty",
};
class TestInfo {
  int? id;
  int? courseId;
  int? lectureId;
  String? language;
  String? typeTest;
  String? name;
  String? courseName;
  String? subName;
  String? lectureName;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  List<QuestionInfo>? quizDTOs;
  
  TestInfo(
      {this.id,
        this.courseId,
        this.lectureId,
        this.language,
        this.typeTest,
        this.name,
        this.courseName,
        this.subName,
        this.lectureName,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy,
        this.quizDTOs});

  TestInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    lectureId = json['lecture_id'];
    language = json['language'];
    typeTest = json['type_test'];
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
    } else if (json['quizs'] != null) {
      quizDTOs = <QuestionInfo>[];
      json['quizs'].forEach((v) {
        quizDTOs!.add(new QuestionInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(id!=null) {
      data['id'] =id;
    }
    //data['course_id'] =courseId;
    //data['lecture_id'] =lectureId;
   // data['language'] =language;
    data['type_test'] =typeTest;
    data['name'] =name;
   // data['course_name'] =courseName;
   // data['sub_name'] =subName;
    //data['lecture_name'] =lectureName;
   // data['created_at'] =createdAt;
    //data['created_by'] =createdBy;
    //data['updated_at'] =updatedAt;
    //data['updated_by'] =updatedBy;
    if (quizDTOs != null) {
      data['question_ids'] =quizDTOs!.map((e) => e.id,).toList().join(',');
    }
    
    return data;
  }
}
class TestListResponseModel extends PageModel{
  List<TestInfo>? content;
  TestListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  TestListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <TestInfo>[];
      json['content'].forEach((v) {
        content!.add(new TestInfo.fromJson(v));
      });
    }
  }
  TestListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <TestInfo>[];
      json.forEach((v) {
        content!.add(new TestInfo.fromJson(v));
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
import '../../../../base/base_request_elearning/models/page_model.dart';

class TestScoreListModel extends PageModel{
  List<TestScore>? content;
  TestScoreListModel({super.total, super.pageSize, super.pageNumber, this.content});
  TestScoreListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <TestScore>[];
      json['content'].forEach((v) {
        content!.add(new TestScore.fromJson(v));
      });
    }
  }

  TestScoreListModel.fromList( dynamic json) {
    if (json!= null) {
      content = <TestScore>[];
      json.forEach((v) {
        content!.add(new TestScore.fromJson(v));
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

class TestScoreList {
  List<TestScore>? list;

  TestScoreList({
    this.list,
  });

  TestScoreList.fromJson(List<dynamic> json) {
    list = <TestScore>[];
    json.forEach((v) {
      list!.add(TestScore.fromJson(v));
    });
  }
}

class TestScore {
  int? id;
  int? userId;
  int? courseId;
  int? lectureId;
  int? totalRight;
  int? total;
  int? testId;
  int? totalNumberTest;
  dynamic point;
  String? typeTest;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? courseName;
  String? subName;
  String? lectureName;
  String? language;
  String? testName;

  TestScore({this.id,
    this.userId,
    this.lectureId,
    this.totalRight,
    this.total,
    this.testId,
    this.point,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.courseName,
    this.subName,
    this.lectureName,
    this.language,
    this.testName});

  TestScore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalRight = json['total_right'];
    total = json['total'];
    testId = json['test_id'];
    point = json['point'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    courseName = json['course_name'];
    subName = json['sub_name'];
    lectureName = json['lecture_name'];
    language = json['language'];
    testName = json['test_name'];
    typeTest = json['type_test'];
    lectureId = json['lecture_id'];
    courseId = json['course_id'];
    totalNumberTest = json['totalNumberTest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['total_right'] = totalRight;
    data['total'] = total;
    data['test_id'] = testId;
    data['point'] = point;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['course_name'] = courseName;
    data['sub_name'] = subName;
    data['lecture_name'] = lectureName;
    data['language'] = language;
    data['test_name'] = testName;
    return data;
  }

  List<TestScore> fromJsonList(Map<String, dynamic> json) {
    List<TestScore> list = <TestScore>[];
    json['quizs'].forEach((v) {
      list.add(new TestScore.fromJson(v));
    });
    return list;
  }
}
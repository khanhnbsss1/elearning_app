class ScoreResultInfo {
  int? id;
  int? userId;
  int? totalRight;
  int? total;
  int? testId;
  dynamic point;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? courseName;
  String? subName;
  String? lectureName;
  String? language;
  String? testName;

  ScoreResultInfo(
      {this.id,
        this.userId,
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

  ScoreResultInfo.fromJson(Map<String, dynamic> json) {
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
}

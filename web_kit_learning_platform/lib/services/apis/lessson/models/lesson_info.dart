class LessonInfo {
  int? id;
  String? subName;
  int? courseId;
  String? lectureName;
  String? link;
  String? mode;
  String? note;
  String? createdBy;

  LessonInfo(
      {this.id,
        this.subName,
        this.courseId,
        this.lectureName,
        this.link,
        this.mode,
        this.note,
        this.createdBy});

  LessonInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subName = json['sub_name'];
    courseId = json['course_id'];
    lectureName = json['lecture_name'];
    link = json['link'];
    mode = json['mode'];
    note = json['note'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sub_name'] = subName;
    data['course_id'] = courseId;
    data['lecture_name'] = lectureName;
    data['link'] = link;
    data['mode'] = mode;
    data['note'] = note;
    data['created_by'] = createdBy;
    return data;
  }
}

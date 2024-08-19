import 'package:lms_app/services_elearning/apis/lessson/models/lesson_info.dart';

class Subjects {
  String? subName;
  List<LessonInfo>? lectures;
  Subjects({this.subName, this.lectures}){
    lectures??=[];
  }
  Subjects.fromJson(Map<String, dynamic> json) {
    subName = json['sub_name'];
    if (json['lectures'] != null) {
      lectures = <LessonInfo>[];
      json['lectures'].forEach((v) {
        lectures!.add(new LessonInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_name'] = subName;
    if (lectures != null) {
      data['lectures'] = lectures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

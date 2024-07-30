
import 'package:webkit/base/services/base_request/models/page_model.dart';

class LessonListResponseModel extends PageModel{
  List<LessonInfo>? content;

  LessonListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  LessonListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <LessonInfo>[];
      json['content'].forEach((v) {
        content!.add(new LessonInfo.fromJson(v));
      });
    }
  }
  LessonListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <LessonInfo>[];
      json.forEach((v) {
        content!.add(new LessonInfo.fromJson(v));
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

class LessonInfo {
  int? id;
  String? subName;
  String? lectureName;
  String? lectureLink;
  String? lectureMode;
  String? document;

  LessonInfo(
      {this.id,
        this.subName,
        this.lectureName,
        this.lectureLink,
        this.lectureMode,
        this.document
      });

  LessonInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subName = json['sub_name'];
    lectureName = json['lecture_name']?? json['name'];
    lectureLink = json['lecture_link'];
    lectureMode = json['lecture_mode'];
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sub_name'] = subName;
    data['lecture_name'] = lectureName;
    data['lecture_link'] = lectureLink;
    data['lecture_mode'] = lectureMode;
    data['document'] = document;
    return data;
  }
}

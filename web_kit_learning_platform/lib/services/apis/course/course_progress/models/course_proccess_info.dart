
import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class CourseProgressResponseModel extends PageModel{
  List<CourseProgressInfo>? content;
  CourseProgressResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  CourseProgressResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <CourseProgressInfo>[];
      json['content'].forEach((v) {
        content!.add(new CourseProgressInfo.fromJson(v));
      });
    }
  }
  
  CourseProgressResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <CourseProgressInfo>[];
      json.forEach((v) {
        content!.add(new CourseProgressInfo.fromJson(v));
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

class CourseProgressInfo {
  int? courseId;
  String? courseName;
  double? progress;

  CourseProgressInfo({this.courseId, this.courseName, this.progress});

  CourseProgressInfo.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    progress = (json['progress']??0).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_id'] = courseId;
    data['course_name'] = courseName;
    data['progress'] = progress;
    return data;
  }
}



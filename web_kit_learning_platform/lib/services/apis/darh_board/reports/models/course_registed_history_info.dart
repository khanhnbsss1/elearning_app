
import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class CourseRegisteredHistoryListResponseModel extends PageModel{
  List<CourseRegisteredHistoryInfo>? content;

  CourseRegisteredHistoryListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  CourseRegisteredHistoryListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <CourseRegisteredHistoryInfo>[];
      json['content'].forEach((v) {
        content!.add(new CourseRegisteredHistoryInfo.fromJson(v));
      });
    }
  }
  CourseRegisteredHistoryListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <CourseRegisteredHistoryInfo>[];
      json.forEach((v) {
        content!.add(new CourseRegisteredHistoryInfo.fromJson(v));
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

class CourseRegisteredHistoryInfo {
  int? courseId;
  String? courseName;
  int? userId;
  String? userName;
  String? timeCreated;

  CourseRegisteredHistoryInfo(
      {this.courseId,
        this.courseName,
        this.userId,
        this.userName,
        this.timeCreated});

  CourseRegisteredHistoryInfo.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    userId = json['user_id'];
    userName = json['user_name'];
    timeCreated = json['time_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['time_created'] = this.timeCreated;
    return data;
  }
}




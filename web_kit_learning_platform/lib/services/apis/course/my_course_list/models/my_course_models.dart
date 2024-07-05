

import '../../course_list/models/course_models.dart';

class MyCourseResponseModel {
  List<CourseInfo>? data;

  MyCourseResponseModel({this.data});
  MyCourseResponseModel.fromJsonList(dynamic json) {
    if (json != null) {
      data = <CourseInfo>[];
      json.forEach((v) {
        data!.add(new CourseInfo.fromJson(v));
      });
    }
  }
  MyCourseResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CourseInfo>[];
      json['data'].forEach((v) {
        data!.add(new CourseInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataOutput = <String, dynamic>{};
    if (data != null) {
      dataOutput['data'] = data!.map((v) => v.toJson()).toList();
    }
    return dataOutput;
  }
}
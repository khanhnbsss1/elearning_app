
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';

class CourseListResponseModel {
  List<CourseLandingPageInfo>? data;

  CourseListResponseModel({this.data});
  CourseListResponseModel.fromJsonList(dynamic json) {
    if (json != null) {
      data = <CourseLandingPageInfo>[];
      json.forEach((v) {
        data!.add(new CourseLandingPageInfo.fromJson(v));
      });
    }
  }
  CourseListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CourseLandingPageInfo>[];
      json['data'].forEach((v) {
        data!.add(new CourseLandingPageInfo.fromJson(v));
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

class CourseLandingPageInfo {
  int? id;
  String? name;
  String? image;
  String? producerName;
  int? totalLectures;
  int? totalSubjects;
  String? language;
  int? payment;
  String? createdAt;
  String? updatedAt;
  double? ratePoint;
  String? introduction;
  int? courseId;
  int? isShow;
  String? courseName;
  int? fileId;

  CourseLandingPageInfo(
      {this.id,
        this.name,
        this.image,
        this.producerName,
        this.totalLectures,
        this.totalSubjects,
        this.language,
        this.payment,
        this.createdAt,
        this.updatedAt,
        this.ratePoint,
        this.introduction,
        this.courseId,
        this.isShow,
        this.courseName,
        this.fileId
      });

  CourseLandingPageInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    producerName = json['producer_name'];
    totalLectures = json['total_lectures'];
    totalSubjects = json['total_subjects'];
    language = json['language'];
    payment = json['payment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ratePoint = (json['rate_point']??5).toDouble();
    introduction = json['introduction'];
    courseId = json['course_id'];
    isShow = json['is_show'];
    courseName = json['course_name'];
    fileId = json['file_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(id!=null)
    {
      data['id'] =id;
    }
    data['name'] =name;
    data['image'] =image;
    data['producer_name'] =producerName;
    data['total_lectures'] =totalLectures;
    data['total_subjects'] =totalSubjects;
    data['payment'] =payment;
    data['rate_point'] =ratePoint;
    data['introduction'] =introduction;
    data['course_id'] =courseId;
    data['is_show'] =isShow;
    data['course_name'] =courseName;
    data['file_id'] =fileId;

    return data;
  }

  CourseLandingPageInfo.fromCourseInfo(CourseInfo courseInfo){
    courseId = courseInfo.id;
    courseName = courseInfo.name;
    name = courseInfo.name;
    image = courseInfo.image;
    producerName = courseInfo.producerName;
    totalLectures = courseInfo.totalLectures;
    totalSubjects = courseInfo.totalSubjects;
    language = courseInfo.language;
    payment = courseInfo.price;
    createdAt = courseInfo.createdAt;
    updatedAt = courseInfo.updatedAt;
    ratePoint = courseInfo.rating;
    introduction = courseInfo.introduction;
  }
}


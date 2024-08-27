
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

@override
class CourseLandingPageInfo extends CourseInfo{
  
  CourseLandingPageInfo(
      {super.id,
        super.name,
        super.image,
        super.producerName,
        super.totalLectures,
        super.totalSubjects,
        super.language,
        super.payment,
        super.createdAt,
        super.updatedAt,
        super.introduction,
        super.ratePoint,});

  CourseLandingPageInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image']??"";
    producerName = json['producer_name'];
    totalLectures = json['total_lectures'];
    totalSubjects = json['total_subjects'];
    language = json['language'];
    payment = json['payment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ratePoint = json['rate_point'];
    introduction = json['introduction'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['producer_name'] = producerName;
    data['total_lectures'] = totalLectures;
    data['total_subjects'] = totalSubjects;
    data['language'] = language;
    data['payment'] = payment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['rate_point'] = ratePoint;
    data['introduction'] = introduction;

    return data;
  }
}

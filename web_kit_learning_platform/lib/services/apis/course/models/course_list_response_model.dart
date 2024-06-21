
class CourseListLandingPageResponseModel {
  List<CourseLandingPageInfo>? data;

  CourseListLandingPageResponseModel({this.data});

  CourseListLandingPageResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? ratePoint;

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
        this.ratePoint});

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
  }

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
    return data;
  }
}



class CourseResponseModel {
  List<CourseInfo>? data;

  CourseResponseModel({this.data});
  CourseResponseModel.fromJsonList(dynamic json) {
    if (json != null) {
      data = <CourseInfo>[];
      json.forEach((v) {
        data!.add(new CourseInfo.fromJson(v));
      });
    }
  }
  CourseResponseModel.fromJson(Map<String, dynamic> json) {
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

  String toString() {
    return 'CourseResponseModel(data: ${data?.map((course) => course.toString()).join(', ')})';
  }
}

class CourseInfo {
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
  String?introduction;

  CourseInfo(
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
        this.introduction,
        this.ratePoint,});
  CourseInfo.fromJson(Map<String, dynamic> json) {
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

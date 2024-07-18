class AddCourseRequest {
  int? id;
  String? name;
  String? image;
  int? totalLectures;
  int? totalSubjects;
  String? producerName;
  String? language;
  String? introduction;
  String? infoObj;
  String? infoResult;
  String? dayFrom;
  String? dayTo;
  int? payment;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  int? ratePoint;
  String? durian;
  String? videoPreview;
  String? courseMode;
  String? gradeName;
  int? categoryId;
  int? isStandard;
  String? categoryName;
  String? typeName;
  int? isActive;
  List<Lectures>? lectures;
  List<Tags>? tags;

  AddCourseRequest(
      {this.id,
        this.name,
        this.image,
        this.totalLectures,
        this.totalSubjects,
        this.producerName,
        this.language,
        this.introduction,
        this.infoObj,
        this.infoResult,
        this.dayFrom,
        this.dayTo,
        this.payment,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.ratePoint,
        this.durian,
        this.videoPreview,
        this.courseMode,
        this.gradeName,
        this.categoryId,
        this.isStandard,
        this.categoryName,
        this.typeName,
        this.isActive,
        this.lectures,
        this.tags,
      });

  AddCourseRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    totalLectures = json['total_lectures'];
    totalSubjects = json['total_subjects'];
    producerName = json['producer_name'];
    language = json['language'];
    introduction = json['introduction'];
    infoObj = json['info_obj'];
    infoResult = json['info_result'];
    dayFrom = json['day_from'];
    dayTo = json['day_to'];
    payment = json['payment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    ratePoint = json['rate_point'];
    durian = json['durian'];
    videoPreview = json['video_preview'];
    courseMode = json['course_mode'];
    gradeName = json['grade_name'];
    categoryId = json['category_id'];
    isStandard = json['is_standard'];
    categoryName = json['category_name'];
    typeName = json['type_name'];
    isActive = json['is_active'];
    if (json['lectures'] != null) {
      lectures = <Lectures>[];
      json['lectures'].forEach((v) {
        lectures!.add(new Lectures.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['total_lectures'] = this.totalLectures;
    data['total_subjects'] = this.totalSubjects;
    data['producer_name'] = this.producerName;
    data['language'] = this.language;
    data['introduction'] = this.introduction;
    data['info_obj'] = this.infoObj;
    data['info_result'] = this.infoResult;
    data['day_from'] = this.dayFrom;
    data['day_to'] = this.dayTo;
    data['payment'] = this.payment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['rate_point'] = this.ratePoint;
    data['durian'] = this.durian;
    data['video_preview'] = this.videoPreview;
    data['course_mode'] = this.courseMode;
    data['grade_name'] = this.gradeName;
    data['category_id'] = this.categoryId;
    data['is_standard'] = this.isStandard;
    data['category_name'] = this.categoryName;
    data['type_name'] = this.typeName;
    data['is_active'] = this.isActive;
    if (this.lectures != null) {
      data['lectures'] = this.lectures!.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lectures {
  int? id;
  String? subName;
  String? lectureName;
  String? lectureLink;
  String? lectureMode;
  String? document;

  Lectures(
      {this.id,
        this.subName,
        this.lectureName,
        this.lectureLink,
        this.lectureMode,
        this.document
      });

  Lectures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subName = json['sub_name'];
    lectureName = json['lecture_name'];
    lectureLink = json['lecture_link'];
    lectureMode = json['lecture_mode'];
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_name'] = this.subName;
    data['lecture_name'] = this.lectureName;
    data['lecture_link'] = this.lectureLink;
    data['lecture_mode'] = this.lectureMode;
    data['document'] = this.document;
    return data;
  }
}

class Tags {
  int? id;
  String? name;

  Tags({this.id, this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
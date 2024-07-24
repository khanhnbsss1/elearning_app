
import 'package:webkit/base/services/base_request/models/page_model.dart';

class CourseResponseModel extends PageModel{
  List<CourseInfo>? content;

  CourseResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  CourseResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <CourseInfo>[];
      json['content'].forEach((v) {
        content!.add(new CourseInfo.fromJson(v));
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
class CourseInfo {
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
  String? accompanyCourse;

  CourseInfo(
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
        this.accompanyCourse,
      });

  CourseInfo.fromJson(Map<String, dynamic> json) {
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
    accompanyCourse = json['accompany_course'];
    tags = [];
/*    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags?.add(new Tags.fromJson(v));
      });
    }*/
    lectures=[];
    if (json['lectures'] != null) {
      lectures = <Lectures>[];
      json['lectures'].forEach((v) {
        lectures?.add(new Lectures.fromJson(v));
      });
    }
    // if (json['tags'] != null) {
    //   tags = <Tags>[];
    //   json['tags'].forEach((v) {
    //     tags!.add(new Tags.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['total_lectures'] = totalLectures;
    data['total_subjects'] = totalSubjects;
    data['producer_name'] = producerName;
    data['language'] = language;
    data['introduction'] = introduction;
    data['info_obj'] = infoObj;
    data['info_result'] = infoResult;
    data['day_from'] = dayFrom;
    data['day_to'] = dayTo;
    data['payment'] = payment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['rate_point'] = ratePoint;
    data['durian'] = durian;
    data['video_preview'] = videoPreview;
    data['course_mode'] = courseMode;
    data['grade_name'] = gradeName;
    data['category_id'] = categoryId;
    data['is_standard'] = isStandard;
    data['category_name'] = categoryName;
    data['type_name'] = typeName;
    data['is_active'] = isActive;
    data['accompany_course'] = accompanyCourse;
    //data['tags'] = tags;
    if (lectures != null) {
      data['lectures'] = (lectures??[]).map((v) => v.toJson()).toList();
    }
    if (tags != null) {
       data['tags'] = (tags??[]).map((v) => v.toJson()).toList();
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

class Tags {
  int? id;
  String? name;

  Tags({this.id, this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

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
  String? producerName;
  int? totalLectures;
  int? totalSubjects;
  String? language;
  int? payment;
  String? createdAt;
  String? mode;
  String? updatedAt;
  int? ratePoint;
  String? introduction;
  String? categoryName;
  String? gradeName;
  int? gradeId;
  int? categoryId;
  int? isStandard;
  List<String>? tags;

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
        this.mode,
        this.updatedAt,
        this.ratePoint,
        this.introduction,
        this.categoryName,
        this.gradeName,
        this.gradeId,
        this.categoryId,
        this.isStandard,
        this.tags});

  CourseInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    producerName = json['producer_name'];
    totalLectures = json['total_lectures'];
    totalSubjects = json['total_subjects'];
    language = json['language'];
    payment = json['payment'];
    createdAt = json['created_at'];
    mode = json['mode'];
    updatedAt = json['updated_at'];
    ratePoint = json['rate_point'];
    introduction = json['introduction'];
    categoryName = json['category_name'];
    gradeName = json['grade_name'];
    gradeId = json['grade_id'];
    categoryId = json['category_id'];
    isStandard = json['is_standard'];
    tags = json['tags'].cast<String>();
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
    data['mode'] = mode;
    data['updated_at'] = updatedAt;
    data['rate_point'] = ratePoint;
    data['introduction'] = introduction;
    data['category_name'] = categoryName;
    data['grade_name'] = gradeName;
    data['grade_id'] = gradeId;
    data['category_id'] = categoryId;
    data['is_standard'] = isStandard;
    data['tags'] = tags;
    return data;
  }
}

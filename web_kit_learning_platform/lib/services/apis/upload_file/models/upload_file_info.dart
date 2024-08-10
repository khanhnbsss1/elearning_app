
import 'package:dio/dio.dart';


enum SubjectType{
  courses,
  lectures,
  documents,
  question,
  answer,
  avatar,
  landingapge_review,
  landingapge_teacher,
  vocabulary,
  discount
}
Map<SubjectType, String> subjectTypeToStr={
  SubjectType.courses:"courses",
  SubjectType.lectures:"lectures",
  SubjectType.documents:"documents",
  SubjectType.question:"question",
  SubjectType.answer:"answer",
  SubjectType.avatar:"avatar",
  SubjectType.landingapge_review:"landingapge_review",
  SubjectType.landingapge_teacher:"landingapge_teacher",
  SubjectType.vocabulary:"vocabulary",
  SubjectType.discount:"discount",

};
class UploadFileInfo {
  SubjectType? data;
  MultipartFile? file;
  String? fileName;
  UploadFileInfo(
      {
        this.data,
        this.file,
        this.fileName
      });

  UploadFileInfo.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    file = json['file'];
    fileName = json['fileName'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data;
    data['file'] = file;
    data['fileName'] = fileName;

    return data;
  }
  String getDataType(){
    return subjectTypeToStr[data??SubjectType.courses]??'course';
  }
}
class UploadFileResponseInfo {
  int? id;
  String? link;
  String? fileType;
  String? category;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? fileSize;

  UploadFileResponseInfo(
      {this.id,
        this.link,
        this.fileType,
        this.category,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.fileSize});

  UploadFileResponseInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    fileType = json['file_type'];
    category = json['category'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    fileSize = json['file_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['link'] = link;
    data['file_type'] = fileType;
    data['category'] = category;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['file_size'] = fileSize;
    return data;
  }
}

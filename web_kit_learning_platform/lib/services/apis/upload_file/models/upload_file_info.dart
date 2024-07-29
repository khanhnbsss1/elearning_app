import 'dart:io';

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
  UploadFileInfo(
      {
        this.data,
        this.file,
      });

  UploadFileInfo.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data;
    data['file'] = file;
    return data;
  }
  String getDataType(){
    return subjectTypeToStr[data??SubjectType.courses]??'course';
  }
}
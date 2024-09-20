
import 'dart:convert';

import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class RequestRegisteredListResponseModel extends PageModel{
  List<RegisteredInfo>? content;

  RequestRegisteredListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  RequestRegisteredListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <RegisteredInfo>[];
      json['content'].forEach((v) {
        content!.add(new RegisteredInfo.fromJson(v));
      });
    }
  }
  RequestRegisteredListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <RegisteredInfo>[];
      json.forEach((v) {
        content!.add(new RegisteredInfo.fromJson(v));
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

class RegisteredInfo {
  int? id;
  int? userId;
  int? courseId;
  String? status;
  int? acceptorId;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;
  String? type;
  String? userName;
  String? fullname;
  String? acceptorName;
  String? courseName;
  int? total;
  int? totalNew;
  int? totalAccept;
  String? totalRegistrations;

  RegisteredInfo(
      {this.id,
        this.userId,
        this.courseId,
        this.status,
        this.acceptorId,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
        this.type,
        this.userName,
        this.fullname,
        this.acceptorName,
        this.courseName,
        this.total,
        this.totalNew,
        this.totalAccept,
        this.totalRegistrations});

  RegisteredInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    courseId = json['course_id'];
    status = json['status'];
    acceptorId = json['acceptor_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    type = json['type'];
    userName = json['user_name'];
    fullname = json['fullname'];
    acceptorName = json['acceptor_name'];
    courseName = json['course_name'];
    total = json['total'];
    totalNew = json['total_new'];
    totalAccept = json['total_accept'];
    totalRegistrations = json['total_registrations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['course_id'] = this.courseId;
    data['status'] = this.status;
    data['acceptor_id'] = this.acceptorId;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    data['user_name'] = this.userName;
    data['fullname'] = this.fullname;
    data['acceptor_name'] = this.acceptorName;
    data['course_name'] = this.courseName;
    data['total'] = this.total;
    data['total_new'] = this.totalNew;
    data['total_accept'] = this.totalAccept;
    data['total_registrations'] = this.totalRegistrations;
    return data;
  }
}

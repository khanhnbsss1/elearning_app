
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
  String? type;
  String? userName;
  String? acceptorName;
  String? courseName;
  int? total;

  RegisteredInfo(
      {this.id,
        this.userId,
        this.courseId,
        this.status,
        this.acceptorId,
        this.createdBy,
        this.createdAt,
        this.type,
        this.userName,
        this.acceptorName,
        this.courseName,
        this.total});

  RegisteredInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    courseId = json['course_id'];
    status = json['status'];
    acceptorId = json['acceptor_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    type = json['type'];
    userName = json['user_name'];
    acceptorName = json['acceptor_name'];
    courseName = json['course_name'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['course_id'] = courseId;
    data['status'] = status;
    data['acceptor_id'] = acceptorId;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['type'] = type;
    data['user_name'] = userName;
    data['acceptor_name'] = acceptorName;
    data['course_name'] = courseName;
    data['total'] = total;
    return data;
  }
}

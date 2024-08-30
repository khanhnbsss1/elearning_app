
import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class RegisterTimePeriodResponseModel extends PageModel{
  List<RegisterTimePeriodInfo>? content;

  RegisterTimePeriodResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  RegisterTimePeriodResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <RegisterTimePeriodInfo>[];
      json['content'].forEach((v) {
        content!.add(new RegisterTimePeriodInfo.fromJson(v));
      });
    }
  }
  RegisterTimePeriodResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <RegisterTimePeriodInfo>[];
      json.forEach((v) {
        content!.add(new RegisterTimePeriodInfo.fromJson(v));
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

class RegisterTimePeriodInfo {
  int? id;
  String? fullname;
  String? userName;
  String? createdAt;

  RegisterTimePeriodInfo(
      {this.id, this.fullname, this.userName, this.createdAt});

  RegisterTimePeriodInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    userName = json['user_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['user_name'] = this.userName;
    data['created_at'] = this.createdAt;
    return data;
  }
}




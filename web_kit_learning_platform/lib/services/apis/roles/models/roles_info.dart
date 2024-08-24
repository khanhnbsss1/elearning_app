
import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class RolesListResponseModel extends PageModel{
  List<RoleInfo>? content;

  RolesListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  RolesListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <RoleInfo>[];
      json['content'].forEach((v) {
        content!.add(new RoleInfo.fromJson(v));
      });
    }
  }
  RolesListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <RoleInfo>[];
      json.forEach((v) {
        content!.add(new RoleInfo.fromJson(v));
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

class RoleInfo {
  String? id;
  String? name;
  String? normalizedName;
  String? concurrencyStamp;

  RoleInfo({this.id, this.name, this.normalizedName, this.concurrencyStamp});

  RoleInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    normalizedName = json['normalizedName'];
    concurrencyStamp = json['concurrencyStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['normalizedName'] = normalizedName;
    data['concurrencyStamp'] = concurrencyStamp;
    return data;
  }
}



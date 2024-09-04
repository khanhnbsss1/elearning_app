
import 'package:webkit/base/author/user_helper.dart';
import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class PermissionListResponseModel extends PageModel{
  List<PermissionGroupInfo>? content;

  PermissionListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  PermissionListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <PermissionGroupInfo>[];
      json['content'].forEach((v) {
        content!.add(new PermissionGroupInfo.fromJson(v));
      });
    }
  }
  PermissionListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <PermissionGroupInfo>[];
      json.forEach((v) {
        content!.add(new PermissionGroupInfo.fromJson(v));
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

class PermissionGroupInfo {
  String? id;
  String? type;
  String? descriptionType;
  bool?isActivate;
  List<PermissionInfo>? permission;

  PermissionGroupInfo({this.id, this.type, this.descriptionType, this.permission, this.isActivate});

  PermissionGroupInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    descriptionType = json['description_type'];
    if (json['permission'] != null) {
      permission = <PermissionInfo>[];
      json['permission'].forEach((v) {
        PermissionInfo permissionInfo = new PermissionInfo.fromJson(v);
        permission!.add(new PermissionInfo.fromJson(v));
        if(!(permissionInfo.isActivate??false))
          {
            isActivate = false;
          }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['description_type'] = descriptionType;
    if (permission != null) {
      data['permission'] = permission!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  void setActiveAllPermission(bool isActiveInput){
    isActivate = isActiveInput;
    for(PermissionInfo permissionInfo in permission??[]){
      permissionInfo.isActivate = isActiveInput;
    }
  }
}

class PermissionInfo {
  String? descriptionValue;
  String? value;
  bool? isActivate;
  String? roleId;

  PermissionInfo({this.descriptionValue, this.value, this.isActivate, this.roleId});

  PermissionInfo.fromJson(Map<String, dynamic> json) {
    descriptionValue = json['description_value'];
    value = json['value'];
    isActivate = json['isActivate']?? (UserManager().userContainPermission(permissionList: [value??""]));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description_value'] = descriptionValue;
    data['value'] = value;
    data['isActivate'] = isActivate;
    data['roleId'] = roleId;
    return data;
  }
}


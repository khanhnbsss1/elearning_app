import 'package:webkit/base/services/base_request/models/page_model.dart';

class GradeInfo {
  int? id;
  String? name;

  GradeInfo({this.id, this.name});

  GradeInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['grade_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['grade_name'] = name;
    return data;
  }
}

class GradeListResponseModel extends PageModel{
  List<GradeInfo>? content;

  GradeListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  GradeListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <GradeInfo>[];
      json['content'].forEach((v) {
        content!.add(new GradeInfo.fromJson(v));
      });
    }
  }
  GradeListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <GradeInfo>[];
      json.forEach((v) {
        content!.add(new GradeInfo.fromJson(v));
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
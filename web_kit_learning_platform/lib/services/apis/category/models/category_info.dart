import 'package:webkit/base/services/base_request/models/page_model.dart';

class CategoryInfo {
  int? id;
  String? name;

  CategoryInfo({this.id, this.name});

  CategoryInfo.fromJson(Map<String, dynamic> json) {
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

class CategoryListResponseModel extends PageModel{
  List<CategoryInfo>? content;

  CategoryListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  CategoryListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <CategoryInfo>[];
      json['content'].forEach((v) {
        content!.add(new CategoryInfo.fromJson(v));
      });
    }
  }
  CategoryListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <CategoryInfo>[];
      json.forEach((v) {
        content!.add(new CategoryInfo.fromJson(v));
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
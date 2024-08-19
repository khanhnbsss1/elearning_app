import '../../../../base/base_request_elearning/models/page_model.dart';

class TagsInfo {
  int? id;
  String? name;

  TagsInfo({this.id, this.name});

  TagsInfo.fromJson(Map<String, dynamic> json) {
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

class TagListResponseModel extends PageModel{
  List<TagsInfo>? content;

  TagListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  TagListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <TagsInfo>[];
      json['content'].forEach((v) {
        content!.add(new TagsInfo.fromJson(v));
      });
    }
  }
  TagListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <TagsInfo>[];
      json.forEach((v) {
        content!.add(new TagsInfo.fromJson(v));
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

import 'package:webkit/base/services/base_request/models/page_model.dart';

class QuestionInfo {
  int? id;
  String? name;

  QuestionInfo({this.id, this.name});
  QuestionInfo.fromJson(Map<String, dynamic> json) {
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

class QuestionListResponseModel extends PageModel{
  List<QuestionInfo>? content;

  QuestionListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  QuestionListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <QuestionInfo>[];
      json['content'].forEach((v) {
        content!.add(new QuestionInfo.fromJson(v));
      });
    }
  }
  QuestionListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <QuestionInfo>[];
      json.forEach((v) {
        content!.add(new QuestionInfo.fromJson(v));
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
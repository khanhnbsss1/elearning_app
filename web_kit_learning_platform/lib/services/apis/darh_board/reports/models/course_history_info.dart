
import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class CourseHistoryListResponseModel extends PageModel{
  List<CourseHistoryInfo>? content;

  CourseHistoryListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  CourseHistoryListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <CourseHistoryInfo>[];
      json['content'].forEach((v) {
        content!.add(new CourseHistoryInfo.fromJson(v));
      });
    }
  }
  CourseHistoryListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <CourseHistoryInfo>[];
      json.forEach((v) {
        content!.add(new CourseHistoryInfo.fromJson(v));
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

class CourseHistoryInfo {
  int? id;
  String? name;
  String? timeValue;
  String? implementer;
  String? action;

  CourseHistoryInfo(
      {this.id, this.name, this.timeValue, this.implementer, this.action});

  CourseHistoryInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    timeValue = json['time_value'];
    implementer = json['implementer'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['time_value'] = this.timeValue;
    data['implementer'] = this.implementer;
    data['action'] = this.action;
    return data;
  }
}





import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class RevenueHistoryListResponseModel extends PageModel{
  List<RevenueHistoryInfo>? content;

  RevenueHistoryListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  RevenueHistoryListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <RevenueHistoryInfo>[];
      json['content'].forEach((v) {
        content!.add(new RevenueHistoryInfo.fromJson(v));
      });
    }
  }
  RevenueHistoryListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <RevenueHistoryInfo>[];
      json.forEach((v) {
        content!.add(new RevenueHistoryInfo.fromJson(v));
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

class RevenueHistoryInfo {
  int? courseId;
  String? courseName;
  int? categoryId;
  String? categoryName;
  int? gradeId;
  String? gradeName;
  int? userId;
  String? userName;
  int? amount;

  RevenueHistoryInfo(
      {this.courseId,
        this.courseName,
        this.categoryId,
        this.categoryName,
        this.gradeId,
        this.gradeName,
        this.userId,
        this.userName,
        this.amount});

  RevenueHistoryInfo.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    gradeId = json['grade_id'];
    gradeName = json['grade_name'];
    userId = json['user_id'];
    userName = json['user_name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['grade_id'] = this.gradeId;
    data['grade_name'] = this.gradeName;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['amount'] = this.amount;
    return data;
  }
}




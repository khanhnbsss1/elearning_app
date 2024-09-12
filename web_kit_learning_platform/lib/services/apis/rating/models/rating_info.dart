
import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class RatingListResponseModel extends PageModel{
  List<RatingInfo>? content;

  RatingListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  RatingListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <RatingInfo>[];
      json['content'].forEach((v) {
        content!.add(new RatingInfo.fromJson(v));
      });
    }
  }
  RatingListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <RatingInfo>[];
      json.forEach((v) {
        content!.add(new RatingInfo.fromJson(v));
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

class RatingInfo {
  int? id;
  double? ratePoint;
  int? courseId;
  int? producerId;
  String? fullname;
  String? review;
  int? isShow;
  String? createdAt;
  int? total;

  RatingInfo(
      {this.id,
        this.ratePoint,
        this.courseId,
        this.producerId,
        this.fullname,
        this.review,
        this.isShow,
        this.createdAt,
        this.total});

  RatingInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ratePoint = (json['rate_point']??0).toDouble();
    courseId = json['course_id'];
    producerId = json['producer_id'];
    fullname = json['fullname'];
    review = json['review'];
    isShow = json['is_show'];
    createdAt = json['created_at'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rate_point'] = ratePoint;
    data['course_id'] = courseId;
    data['producer_id'] = producerId;
    data['fullname'] = fullname;
    data['review'] = review;
    data['is_show'] = isShow;
    data['created_at'] = createdAt;
    data['total'] = total;
    return data;
  }
}




import '../../../../../base/base_request_elearning/models/page_model.dart';
import '../../course_detail/models/course_detail_model.dart';

class CourseResponseModel extends PageModel{
  List<CourseInfo>? content;

  CourseResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  CourseResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <CourseInfo>[];
      json['content'].forEach((v) {
        content!.add(CourseInfo.fromJson(v));
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

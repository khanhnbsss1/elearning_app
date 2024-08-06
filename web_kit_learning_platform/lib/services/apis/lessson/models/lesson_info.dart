
import 'package:webkit/base/services/base_request/models/page_model.dart';

class LessonListResponseModel extends PageModel{
  List<LessonInfo>? content;

  LessonListResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  LessonListResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <LessonInfo>[];
      json['content'].forEach((v) {
        content!.add(new LessonInfo.fromJson(v));
      });
    }
  }
  LessonListResponseModel.fromList( dynamic json) {
    if (json!= null) {
      content = <LessonInfo>[];
      json.forEach((v) {
        content!.add(new LessonInfo.fromJson(v));
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

class LessonInfo {
  int? id;
  String? subName;
  String? lectureName;
  String? link;
  int? docId;
  String? docName;
  String? mode;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? note;
  
  LessonInfo(
      {this.id,
        this.subName,
        this.lectureName,
        this.link,
        this.docId,
        this.docName,
        this.mode,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.note
      });

  LessonInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subName = json['sub_name'];
    lectureName = json['lecture_name']?? json['name'];
    link = json['lecture_link']??json['link'];
    docId = json['doc_id'];
    docName = json['docName'];
    mode = json['mode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sub_name'] = subName;
    data['lecture_name'] = lectureName;
    data['lecture_link'] = link;
    data['doc_id'] = docId;
    data['docName'] = docName;
    data['link'] = link;
    data['mode'] = mode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['note'] = note;
    return data;
  }
}

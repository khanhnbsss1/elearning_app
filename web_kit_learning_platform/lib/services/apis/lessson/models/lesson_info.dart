
import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

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
  String? docLink;
  String? link;
  int? docId;
  String? docName;
  String? mode;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? note;
  String? content;
  int? testId;
  int? gradeId;
  int? categoryId;
  String? testName;
  UploadFileResponseInfo? documentUploadInfo;
  List<VocabularyInfo>? vocabularies;
  int? videoDuration;// bien nay chi set khi play video tren web
  bool? isFinnish;
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
        this.note,
        this.documentUploadInfo,
        this.vocabularies,
        this.docLink,
        this.testId,
        this.testName,
        this.videoDuration,
        this.isFinnish,
        this.content,
        this.gradeId,
        this.categoryId
      });

  LessonInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subName = json['sub_name'];
    lectureName = json['lecture_name']?? json['name'];
    link = json['lecture_link']??json['link'];
    docId = json['doc_id'];
    docName = json['doc_name'];
    mode = json['mode']??json['lecture_mode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    if(json['note']!=null)
      {
        List<String> noteStr = (json['note'] as String).split("&&&&---&&&&");
        if(noteStr.isNotEmpty)
        {
          note = noteStr.first;
          content = noteStr.last;
        }
      }

    docLink = json['doc_link'];
    isFinnish = json['learning_status']== 'Completed'?true:false;
    testId = json['test_id'];
    categoryId = json['category_id'];
    gradeId = json['grade_id'];
    
    testName = json['test_name'];
    if (json['vocabularies'] != null) {
      vocabularies = <VocabularyInfo>[];
      json['vocabularies'].forEach((v) {
        vocabularies!.add(new VocabularyInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(id!=null) {
      data['id'] = id;
    }
    if(lectureName!=null&&lectureName!.isNotEmpty) {
      data['lecture_name'] = lectureName;
    }
    if(subName!=null&&subName!.isNotEmpty) {
      data['sub_name'] = subName;
    }
    if(docId!=null) {
      data['file_id'] = docId;
    }
/*    if(docName!=null&&docName!.isNotEmpty) {
      data['doc_name'] = docName;
    }*/
    if(link!=null) {
      data['link'] = link;
    }
/*    if(docLink!=null&&docLink!.isNotEmpty) {
      data['doc_link'] = docLink;
    }*/
    if(mode!=null) {
      data['mode'] = mode;
      data['lecture_mode'] = mode;

    }
    
    if(testId!=null) {
      data['test_id'] = testId;
    }
    data['grade_id'] = gradeId??1;
    data['category_id'] = categoryId??1;
    
    if(note!=null || content!=null ) {
      data['note'] = "$note&&&&---&&&&$content";
    }
    return data;
  }
}

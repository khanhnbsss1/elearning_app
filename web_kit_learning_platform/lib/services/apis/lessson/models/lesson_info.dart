
import 'dart:convert';

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
  String?gradeName;
  int? categoryId;
  String? categoryName;
  String? testName;
  UploadFileResponseInfo? documentUploadInfo;
  List<VocabularyInfo>? vocabularies;
  int? videoDuration;// bien nay chi set khi play video tren web
  bool? isFinnish;
  int? proccess;
  LinkInfo? videoInfos;
  VideoInfo? selectVideoInfo;
  LessonInfo(
      {this.id,
        this.subName,
        this.lectureName,
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
        this.categoryId,
        this.videoInfos,
        this.selectVideoInfo,
        this.proccess,
        this.categoryName,
        this.gradeName
      }){
    videoInfos??=LinkInfo(link: []);
  }

  LessonInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subName = (json['sub_name']??"").toString().trim();
    lectureName = (json['lecture_name']?? json['name']??"").toString().trim();
    isFinnish = json['learning_status']== 'Completed'?true:false;
    proccess = json['progress'];
    videoInfos = LinkInfo(link: []);
    
    if((json['lecture_link']??json['link']??'').isNotEmpty)
      {
        try{
          videoInfos = LinkInfo.fromJson(jsonDecode(json['lecture_link']??json['link']??''));
        }
        catch(e){
          videoInfos = LinkInfo(link: [VideoInfo(order: 0, videoTitle: "", videoLink:(json['lecture_link']??json['link']??'') )]);
        }
        int selectVideoIndex = ((proccess??0) /100 * ((videoInfos?.link??[]).length)).toInt();
        selectVideoInfo??= 
        (videoInfos?.link??[]).length> selectVideoIndex?
        (videoInfos?.link??[]).elementAt(selectVideoIndex): 
        VideoInfo(videoLink: "", order: 0, videoTitle: "");
      }
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
   
    testId = json['test_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    gradeId = json['grade_id'];
    gradeName = json['grade_name'];
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
    if(videoInfos!=null) {
      data['link'] = jsonEncode(videoInfos?.toJson());
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
    data['grade_id'] = gradeId;
    data['category_id'] = categoryId;
    
    if(note!=null || content!=null ) {
      data['note'] = "$note&&&&---&&&&$content";
    }
    return data;
  }
}


class LinkInfo {
  List<VideoInfo>? link;

  LinkInfo({this.link});

  LinkInfo.fromJson(Map<String, dynamic> json) {
    if (json['link'] != null) {
      link = <VideoInfo>[];
      json['link'].forEach((v) {
        link!.add(new VideoInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (link != null) {
      data['link'] = link!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class VideoInfo {
  int? order;
  String? videoTitle;
  String? videoLink;
  bool? isFinish;

  VideoInfo({this.order, this.videoTitle, this.videoLink, this.isFinish});

  VideoInfo.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    videoTitle = json['videoTitle'];
    videoLink = json['videoLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order'] = order;
    data['videoTitle'] = videoTitle;
    data['videoLink'] = videoLink;
    return data;
  }
  bool isValidate(){
    return (videoTitle??'').isNotEmpty && (videoLink??'').isNotEmpty;
  }
}


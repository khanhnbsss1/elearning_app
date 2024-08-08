import 'package:webkit/base/services/base_request/models/page_model.dart';
import 'package:webkit/services/apis/sentence/models/sentence_info.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';

class VocabularyResponseModel extends PageModel{
  List<VocabularyInfo>? content;

  VocabularyResponseModel({super.total, super.pageSize, super.pageNumber, this.content});
  VocabularyResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    if (json['content'] != null) {
      content = <VocabularyInfo>[];
      json['content'].forEach((v) {
        content!.add(new VocabularyInfo.fromJson(v));
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
class VocabularyInfo {
  int? id;
  String? simplified;
  String? traditional;
  String? pinyinTones;
  String? translationVn;
  int? gradeId;
  int? lectureId;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? audio;
  String? audioLink;
  int? audioId;
  String? imageLink;
  int? imageId;
  String? categoryWord;
  List<SentenceInfo>? sentenceInfos;

  UploadFileResponseInfo? audioFileInfo;
  UploadFileResponseInfo? imageFileInfo;
  VocabularyInfo(
      {this.id,
        this.simplified,
        this.traditional,
        this.pinyinTones,
        this.translationVn,
        this.lectureId,
        this.audio,
        this.categoryWord,
        this.gradeId,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.imageLink,
        this.imageId,
        this.audioId, 
        this.audioLink,
        this.audioFileInfo,
        this.sentenceInfos,
        this.imageFileInfo,
      }){
    sentenceInfos??=[];
    if((sentenceInfos??[]).isEmpty)
      {
        sentenceInfos?.add(SentenceInfo(id: 0));
      }
  }

  VocabularyInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    simplified = json['simplified'];
    traditional = json['traditional'];
    pinyinTones = json['pinyin_tones'];
    translationVn = json['translation_vn'];
    gradeId = json['grade_id'];
    lectureId = json['lecture_id'];
    audio = json['audio'];
    audioId = json['audio_id'];
    audioLink = json['audio_link'];
    imageLink = json['image_link'];
    imageId = json['image_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    if (json['example'] != null) {
      sentenceInfos = <SentenceInfo>[];
      json['example'].forEach((v) {
        sentenceInfos?.add(new SentenceInfo.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['simplified'] = simplified;
    data['traditional'] = traditional;
    data['pinyin_tones'] = pinyinTones;
    data['translation_vn'] = translationVn;
    data['grade_id'] = gradeId;
    data['lecture_id'] = lectureId;
    data['audio'] = audio;
    data['audio_id'] = audioId;
    data['audio_link'] = audioLink;
    data['image_id'] = imageId;
    data['image_link'] = imageLink;
    data['category_word'] = categoryWord;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    if (sentenceInfos != null) {
      data['example'] = sentenceInfos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
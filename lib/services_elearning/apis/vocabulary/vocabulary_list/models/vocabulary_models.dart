import '../../../../../base/base_request_elearning/models/page_model.dart';
import '../../../sentence/models/sentence_info.dart';
import '../../../upload_file/models/upload_file_info.dart';

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
    if (json['examples'] != null) {
      sentenceInfos = <SentenceInfo>[];
      json['examples'].forEach((v) {
        sentenceInfos?.add(new SentenceInfo.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(id!=null) {
      data['id'] = id;
    }
    data['simplified'] = simplified;
    data['traditional'] = traditional;
    data['pinyin_tones'] = pinyinTones;
    data['translation_vn'] = translationVn;
    if(gradeId!=null) {
      data['grade_id'] = gradeId;
    }
    if(lectureId!=null) {
      data['lecture_id'] = lectureId;
    }

    if(audio!=null&& audio!.isNotEmpty) {
      data['audio'] = audio;
    }

    if(audioId!=null) {
      data['audio_id'] = audioId;
    }
    if(audioLink!=null&& audioLink!.isNotEmpty) {
      data['audio_link'] = audioLink;
    }

    if(imageId!=null) {
      data['image_id'] = imageId;
    }
    if(imageLink!=null&& imageLink!.isNotEmpty) {
      data['image_link'] = imageLink;
    }

    if(categoryWord!=null && categoryWord!.isNotEmpty) {
      data['category_word'] = categoryWord;
    }

    if(createdAt!=null&& createdAt!.isNotEmpty) {
      data['created_at'] = createdAt;
    }
    if(updatedAt!=null&& updatedAt!.isNotEmpty) {
      data['updated_at'] = updatedAt;
    }
    if(createdBy!=null&& createdBy!.isNotEmpty) {
      data['created_by'] = createdBy;
    }
    if(updatedBy!=null&& updatedBy!.isNotEmpty) {
      data['updated_by'] = updatedBy;
    }
    if (sentenceInfos != null && sentenceInfos!.isNotEmpty) {
      if(!sentenceInfos!.last.isValidate()) {
        if((sentenceInfos?.length??0) >1)
          {
            sentenceInfos?.removeLast();
            data['examples'] = sentenceInfos!.map((v) => v.toJson()).toList();
          }
      }
      else
        {
          data['examples'] = sentenceInfos!.map((v) => v.toJson()).toList();
        }
    }
    return data;
  }
}
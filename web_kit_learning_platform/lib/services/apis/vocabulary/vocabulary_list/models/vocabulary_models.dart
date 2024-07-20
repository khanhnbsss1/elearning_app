import 'package:webkit/base/services/base_request/models/page_model.dart';

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
  String? pinyin;
  String? pinyinTones;
  String? translationEn;
  String? translationVn;
  int? lectureId;
  String? audio;
  String? categoryWord;
  int? gradeId;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  VocabularyInfo(
      {this.id,
        this.simplified,
        this.traditional,
        this.pinyin,
        this.pinyinTones,
        this.translationEn,
        this.translationVn,
        this.lectureId,
        this.audio,
        this.categoryWord,
        this.gradeId,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy});

  VocabularyInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    simplified = json['simplified'];
    traditional = json['traditional'];
    pinyin = json['pinyin'];
    pinyinTones = json['pinyin_tones'];
    translationEn = json['translation_en'];
    translationVn = json['translation_vn'];
    lectureId = json['lecture_id'];
    audio = json['audio'];
    categoryWord = json['category_word'];
    gradeId = json['grade_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['simplified'] = simplified;
    data['traditional'] = traditional;
    data['pinyin'] = pinyin;
    data['pinyin_tones'] = pinyinTones;
    data['translation_en'] = translationEn;
    data['translation_vn'] = translationVn;
    data['lecture_id'] = lectureId;
    data['audio'] = audio;
    data['category_word'] = categoryWord;
    data['grade_id'] = gradeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    return data;
  }
}
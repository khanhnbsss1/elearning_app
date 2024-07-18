import 'dart:io';

class Word {
  String? simplified;
  String? traditional;
  String? pinyinTones;
  String? translationVn;
  File? audio;
  String? created_by;

  Word(
      {this.simplified,
        this.traditional,
        this.pinyinTones,
        this.translationVn,
        this.audio,
        this.created_by,
      });

  Word.fromJson(Map<String, dynamic> json) {
    simplified = json['simplified'];
    traditional = json['traditional'];
    pinyinTones = json['pinyin_tones'];
    translationVn = json['translation_vn'];
    audio = json['audio'];
    created_by = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['simplified'] = this.simplified;
    data['traditional'] = this.traditional;
    data['pinyin_tones'] = this.pinyinTones;
    data['translation_vn'] = this.translationVn;
    data['audio'] = this.audio;
    data['created_by'] = this.created_by;
    return data;
  }
}
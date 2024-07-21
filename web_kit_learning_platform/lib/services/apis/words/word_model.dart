import 'dart:io';

import 'package:dio/dio.dart';

class WordInfo {
  String? simplified;
  String? traditional;
  String? pinyinTones;
  String? translationVn;
  MultipartFile? audio;
  String? createdBy;

  WordInfo(
      {this.simplified,
        this.traditional,
        this.pinyinTones,
        this.translationVn,
        this.audio,
        this.createdBy,
      });

  WordInfo.fromJson(Map<String, dynamic> json) {
    simplified = json['simplified'];
    traditional = json['traditional'];
    pinyinTones = json['pinyin_tones'];
    translationVn = json['translation_vn'];
    audio = json['audio'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['simplified'] = simplified;
    data['traditional'] = traditional;
    data['pinyin_tones'] = pinyinTones;
    data['translation_vn'] = translationVn;
    data['audio'] = audio;
    data['created_by'] = createdBy;
    return data;
  }
}
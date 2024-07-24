import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:webkit/helpers/widgets/my_form_validator.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/services/apis/words/add_words_api.dart';
import 'package:webkit/services/apis/words/word_model.dart';

import 'my_controller.dart';

class AddWordController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  MultipartFile? _audioFile;
  VocabularyInfo ? vocabularyInfo;
  AddWordController({this.vocabularyInfo});
  @override
  void onInit() {
    super.onInit();
    basicValidator.addField(
      'simplified',
      required: true,
      label: "Simplified",
      controller: TextEditingController(text: vocabularyInfo?.simplified??""),
    );
    basicValidator.addField(
      'traditional',
      required: true,
      label: "Traditional",
      controller: TextEditingController(text: vocabularyInfo?.traditional??""),
    );
    basicValidator.addField(
      'pinyin_tones',
      required: true,
      label: "Pinyin tones",
      controller: TextEditingController(text: vocabularyInfo?.pinyinTones??""),
    );
    basicValidator.addField(
      'translation_vn',
      required: true,
      label: "Translation VN",
      controller: TextEditingController(text: vocabularyInfo?.translationVn??""),
    );
    basicValidator.addField(
      'audio',
      required: true,
      label: 'Audio',
      controller: TextEditingController(text: vocabularyInfo?.audio??""),
    );
    basicValidator.addField(
      'created_by',
      label: 'created_by',
      required: true,
      controller: TextEditingController(text: vocabularyInfo?.createdBy ??""),
    );
  }


  void setAudioFile(MultipartFile file) {
    _audioFile = file;
  }
  void setVocabularyInfo(VocabularyInfo ?vocabularyInfoInput) {
    vocabularyInfo = vocabularyInfoInput;
  }
  Future<bool> onAddWord() async {

    WordInfo word = WordInfo(
      simplified: basicValidator.getController('simplified')?.text,
      traditional: basicValidator.getController('traditional')?.text,
      pinyinTones: basicValidator.getController('pinyin_tones')?.text,
      translationVn: basicValidator.getController('translation_vn')?.text,
      audio: _audioFile,
      createdBy: 'long1',
    );
    AddWordsApi addWordsApi = AddWordsApi(word: word);
    print('api called');
    print(basicValidator.getController('audio')?.text,);
    dynamic data = await addWordsApi.call();
    return true;
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/widgets/my_form_validator.dart';
import 'package:webkit/models/user.dart';
import 'package:webkit/services/apis/words/add_words_api.dart';
import 'package:webkit/services/apis/words/word_model.dart';
import 'package:webkit/views/course/course_list/add_words.dart';

import 'my_controller.dart';

class AddWordController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  @override
  void onInit() {
    super.onInit();
    basicValidator.addField(
      'simplified',
      required: true,
      label: "Simplified",
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'traditional',
      required: true,
      label: "Traditional",
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'pinyin_tones',
      required: true,
      label: "Pinyin tones",
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'translation_vn',
      required: true,
      label: "Translation VN",
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'audio',
      required: true,
      label: 'Audio',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'created_by',
      label: 'created_by',
      required: true,
    );
  }

  File? _audioFile;

  void setAudioFile(File file) {
    _audioFile = file;
  }

  Future<void> onAddWord() async {

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
  }
}

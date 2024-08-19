
import 'package:flutter/cupertino.dart';
import 'package:lms_app/helper_elearning/my_form_validator.dart';
import 'package:lms_app/services_elearning/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'my_controller.dart';

class AddWordController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  VocabularyInfo ? vocabularyInfo;
  AddWordController({this.vocabularyInfo}){
    onInit();
  }
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
      controller: TextEditingController(text: vocabularyInfo?.audioLink??""),
    );
    basicValidator.addField(
      'image',
      required: true,
      label: 'Image',
      controller: TextEditingController(text: vocabularyInfo?.imageLink??""),
    );
    basicValidator.addField(
      'created_by',
      label: 'created_by',
      required: true,
      controller: TextEditingController(text: vocabularyInfo?.createdBy ??""),
    );
  }
  
  void setVocabularyInfo(VocabularyInfo ?vocabularyInfoInput) {
    vocabularyInfo = vocabularyInfoInput;
  }
}

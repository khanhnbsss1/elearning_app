import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:webkit/helpers/widgets/my_form_validator.dart';
import 'package:webkit/services/apis/course/courrse_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/services/apis/words/add_words_api.dart';
import 'package:webkit/services/apis/words/word_model.dart';

import '../my_controller.dart';

class AddLectureController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  MultipartFile? _audioFile;
  LecturesInfo? lecturesInfo;
  AddLectureController({this.lecturesInfo});
  @override
  void onInit() {
    super.onInit();
    basicValidator.addField(
      'sub_name',
      required: true,
      label: "Subject name",
      controller: TextEditingController(text: lecturesInfo?.subName??""),
    );
    basicValidator.addField(
      'course_id',
      required: true,
      label: "Course name",
      controller: TextEditingController(text: lecturesInfo?.courseId.toString()??""),
    );
    basicValidator.addField(
      'lecture_name',
      required: true,
      label: "Lecture name",
      controller: TextEditingController(text: lecturesInfo?.lectureName??""),
    );
    basicValidator.addField(
      'link',
      required: true,
      label: "Lecture link",
      controller: TextEditingController(text: lecturesInfo?.link??""),
    );
    basicValidator.addField(
      'doc_link',
      required: true,
      label: 'Document link',
      controller: TextEditingController(text: lecturesInfo?.docLink??""),
    );
    basicValidator.addField(
      'mode',
      required: true,
      label: 'Payment',
      controller: TextEditingController(text: lecturesInfo?.mode??""),
    );
    basicValidator.addField(
      'note',
      required: true,
      label: 'Node',
      controller: TextEditingController(text: lecturesInfo?.note??""),
    );
    basicValidator.addField(
      'created_by',
      label: 'created_by',
      required: true,
      controller: TextEditingController(text: lecturesInfo?.createdBy ??""),
    );
  }


  Future<bool> onAddLecture() async {

    LecturesInfo lecture = LecturesInfo(
      subName: basicValidator.getController('sub_name')?.text??'',
      courseId: int.parse(basicValidator.getController('course_id')?.text??'0'),
      lectureName: basicValidator.getController('lecture_name')?.text??'',
      link: basicValidator.getController('link')?.text??'',
      docLink: basicValidator.getController('doc_link')?.text??'',
      mode: basicValidator.getController('mode')?.text??'',
      note: basicValidator.getController('note')?.text??'',
      createdBy: 'long1',
    );
    // AddWordsApi addWordsApi = AddWordsApi(word: word);
    // print('api called');
    // print(basicValidator.getController('audio')?.text,);
    // dynamic data = await addWordsApi.call();
    return true;
  }
}

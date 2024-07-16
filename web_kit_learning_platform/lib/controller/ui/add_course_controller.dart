import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/my_controller.dart';

import 'package:webkit/helpers/widgets/my_form_validator.dart';
import 'package:webkit/helpers/widgets/my_validators.dart';
import 'package:webkit/services/apis/auth/register/models/register_request.dart';
import 'package:webkit/services/apis/auth/register/register_with_phone_api.dart';
import 'package:webkit/services/apis/course/add_course_request.dart';

class AddCourseController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  bool showPassword = false, loading = false, isChecked = false;
  // List<TextEditingController> lectureControllers = [];

  @override
  void onInit() {
    super.onInit();
    basicValidator.addField(
      'id',
      label: "id",
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'name',
      required: true,
      label: "name",
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'image',
      label: 'Image',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'total_lectures',
      label: 'Total lectures',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'total_subjects',
      label: 'Total subjects',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'producer_name',
      label: 'Producer name',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'language',
      required: true,
      label: 'Language',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'introduction',
      label: 'Introduction',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'payment',
      label: 'Payment',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'rate_point',
      label: 'Rate point',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'durian',
      required: true,
      label: 'Duration',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'course_mode',
      label: 'Course mode',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'grade_name',
      label: 'Grade name',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'category_id',
      label: 'Category id',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'is_standard',
      required: true,
      label: 'Is standard',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'category_name',
      required: true,
      label: 'Category name',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'info_obj',
      label: 'Info object',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'info_result',
      label: 'Info result',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'video_preview',
      label: 'Video review',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'is_active',
      label: 'Is active',
      controller: TextEditingController(),
    );

    // basicValidator.addField(
    //   'sub_name',
    //   label: 'Subject name',
    //   controller: lectureControllers[0],
    // );
    // basicValidator.addField(
    //   'lecture_name',
    //   label: 'Lecture name',
    //   controller: lectureControllers[0],
    // );
    // basicValidator.addField(
    //   'lecture_link',
    //   label: 'Lecture link',
    //   controller: lectureControllers[0],
    // );
    // basicValidator.addField(
    //   'lecture_mode',
    //   label: 'Lecture mode',
    //   controller: lectureControllers[0],
    // );
  }

  void onChangeCheckBox(bool? value) {
    isChecked = value ?? isChecked;
    update();
  }

  void setCourseName(String value) {
    basicValidator.getController('name')!.text = value;
    update();
  }

  Future<void> onAddCourse() async {
    // List<Lectures> lectures = [];
    // for (int i = 0; i < lectureControllers.length; i++) {
    //   lectures.add(Lectures(
    //     subName: basicValidator.getController('lecture_name_$i')?.text,
    //     lectureName: basicValidator.getController('lecture_name_$i')?.text,
    //     lectureLink: basicValidator.getController('lecture_link_$i')?.text,
    //     lectureMode: basicValidator.getController('lecture_mode_$i')?.text,
    //   ));
    // }
    AddCourseRequest addCourseRequest = AddCourseRequest(
      id: basicValidator.getController('id')?.hashCode,
      name: basicValidator.getController('name')!.text,
      image: basicValidator.getController('image')?.text,
      totalLectures: int.parse(
          basicValidator.getController('total_lectures')?.text ?? '0'),
      totalSubjects: int.parse(
          basicValidator.getController('total_subjects')?.text ?? '0'),
      producerName: basicValidator.getController('producer_name')?.text,
      language: basicValidator.getController('language')!.text,
      introduction: basicValidator.getController('introduction')?.text,
      payment: int.parse(basicValidator.getController('payment')?.text ?? '0'),
      ratePoint:
          int.parse(basicValidator.getController('rate_point')?.text ?? '0'),
      durian: basicValidator.getController('durian')!.text,
      courseMode: basicValidator.getController('course_mode')!.text,
      gradeName: basicValidator.getController('grade_name')?.text,
      categoryId:
          int.parse(basicValidator.getController('category_id')?.text ?? '0'),
      isStandard:
          int.parse(basicValidator.getController('is_standard')!.text ?? '0'),
      categoryName: basicValidator.getController('category_name')?.text,
      videoPreview: basicValidator.getController('video_preview')?.text,
      infoObj: basicValidator.getController('info_obj')?.text,
      infoResult: basicValidator.getController('info_result')?.text,
      isActive: basicValidator.getController('is_active')?.hashCode,
      // lectures: lectures,
    );
  }
}

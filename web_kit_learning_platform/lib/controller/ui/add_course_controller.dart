import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/helpers/widgets/my_form_validator.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';

class AddCourseController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  bool showPassword = false, loading = false, isChecked = false;
  MultipartFile ?_imageFile;
  MultipartFile ?_previewVideo;
  
  Map<int,String> listOfCategoryName = {};
  Map<int,String> listOfProduceNames = {};
  Map<int,String> listOfGradeNames = {};
  Map<int,String> listOfAccompanyCourses = {};
  Map<int,String> listOfTags = {};
  Map<int,String> listOfDiscounts = {};
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
      'video_review',
      label: 'video_review',
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
      required: false,
      label: 'Is standard',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'is_show_course_in_landing_page',
      required: false,
      label: 'Is is_show_course_in_landing_page',
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
    basicValidator.addField(
      'tags',
      label: 'Tags',
      // required: true,
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'accompany_course',
      label: 'Accompany course',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'payment_mode',
      label: 'Payment',
      controller: TextEditingController(text: "FREE"),
    );
    basicValidator.addField(
      'payment_value',
      label: 'PaymentValue',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'payment_discount',
      label: 'PaymentDiscount',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'payment_discount',
      label: 'PaymentDiscount',
      controller: TextEditingController(),
    );
  }

  void onChangeCheckBox(bool? value) {
    isChecked = value ?? isChecked;
    update();
  }

  void setCourseName(String value) {
    basicValidator.getController('name')!.text = value;
    update();
  }
  void setImage(MultipartFile imageFile) {
    _imageFile= imageFile;
    update();
  }
  MultipartFile? getImage(MultipartFile imageFile) {
    return _imageFile;
  }
  
  void setVideoPreView(MultipartFile file) {
    _previewVideo= file;
    update();
  }
  MultipartFile? getVideoPreView(MultipartFile imageFile) {
    return _previewVideo;
  }
  int? getIdFromName(Map<int, String> map, String name) {
    try {
      return map.entries.firstWhere((entry) => entry.value == name).key;
    } catch (e) {
      return null;
    }
  }
  Future<CourseInfo?> getCourseInfoFromUI({required CourseInfo courseInfo}) async {
    basicValidator.getController('accompany_course')!.text = getIdFromName(listOfAccompanyCourses, basicValidator.getController('accompany_course')!.text??"").toString();
   // basicValidator.getController('category_id')!.text = getIdFromName(listOfCategoryName, basicValidator.getController('category_name')!.text??"").toString();
    List<String>? tags =basicValidator.getController('tags')!.text.split(',');
    List<TagsInfo> tagsList = [];
    int? gradleId = getIdFromName(listOfGradeNames, basicValidator.getController('grade_name')!.text??"");
    basicValidator.getController('grade_name')!.text = listOfGradeNames[getIdFromName(listOfGradeNames, basicValidator.getController('grade_name')!.text??"")]??"";
    UserProfile? userProfile = await UserManager().getUserProfile();
    for(int tagKey in listOfTags.keys)
      {
        if(tags.contains(listOfTags[tagKey]))
          {
            tagsList.add(TagsInfo(name: listOfTags[tagKey], id: tagKey));
          }
      }
    CourseInfo addCourseRequest = courseInfo.copyWith(
      id: int.tryParse(basicValidator.getController('id')?.text ?? '0'),
      name: basicValidator.getController('name')!.text,
      image: basicValidator.getController('image')?.text ?? "",
      totalLectures: int.tryParse(basicValidator.getController('total_lectures')?.text ?? '0'),
      totalSubjects: int.tryParse(basicValidator.getController('total_subjects')?.text ?? '0'),
      producerName: basicValidator.getController('producer_name')?.text,
      language: basicValidator.getController('language')!.text,
      introduction: basicValidator.getController('introduction')?.text,
      payment: (basicValidator.getController('payment_mode')?.text == 'FREE') ? 0 : int.tryParse(basicValidator.getController('payment_value')?.text ?? '0'),
      ratePoint: int.tryParse(basicValidator.getController('rate_point')?.text ?? '0'),
      durian: basicValidator.getController('durian')!.text,
      courseMode: basicValidator.getController('course_mode')!.text,
      gradeName: basicValidator.getController('grade_name')?.text,
      categoryId: int.tryParse(basicValidator.getController('category_id')?.text ?? '0'),
      isStandard: int.tryParse(basicValidator.getController('is_standard')!.text),
      categoryName: basicValidator.getController('category_name')?.text,
      videoPreview: basicValidator.getController('video_preview')?.text,
      infoObj: basicValidator.getController('info_obj')?.text,
      infoResult: basicValidator.getController('info_result')?.text,
      isActive: int.tryParse(basicValidator.getController('is_active')?.text ?? '0'),
      accompanyCourse: basicValidator.getController('accompany_course')?.text ?? '',
      
      tags: tagsList,
      createdBy: userProfile?.userName,
      updatedBy: userProfile?.userName,
      gradeId: gradleId,
      mode: basicValidator.getController('payment_mode')?.text??"FREE",
      //tags: basicValidator.getController('tags')?.text ?? '',
      // lectures: lectures,
    );
    return addCourseRequest;
  }
}

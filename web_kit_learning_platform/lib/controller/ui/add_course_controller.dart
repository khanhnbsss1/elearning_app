import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/helpers/widgets/my_form_validator.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
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
  List<TagsInfo> listOfTags = [];
  Map<int,String> listOfDiscounts = {};
  List<TextEditingController>controllerInfoObject=[];
  List<TextEditingController>controllerResultObject=[];
  AddCourseController(){
    onInit();
  }
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

  void setInfoObjectController(List<String>items){
    controllerInfoObject.clear();
    for(int index =0; index<items.length; index++){
      controllerInfoObject.add(TextEditingController(text: items.elementAt(index)));
    }
  }
  List<TextEditingController> getListInfoObjectController(){
      return controllerInfoObject;
  }
  TextEditingController getInfoObjectController(int index){
    return controllerInfoObject.elementAt(index);
  }
  void insertInfoObjectController({required TextEditingController textEditingController} ){
    controllerInfoObject.add(textEditingController);
  }
  void removeInfoObjectController({required TextEditingController textEditingController} ){
    controllerInfoObject.remove(textEditingController);
  }
  
  void setResultObjectController(List<String>items){
    controllerResultObject.clear();
    for(int index =0; index<items.length; index++){
      controllerResultObject.add(TextEditingController(text: items.elementAt(index)));
    }
  }
  List<TextEditingController> getListResultObjectController(){
    return controllerResultObject;
  }
  void insertResultObjectController({required TextEditingController textEditingController} ){
    controllerResultObject.add(textEditingController);
  }
  void removeResultObjectController({required TextEditingController textEditingController} ){
    controllerResultObject.remove(textEditingController);
  }
  TextEditingController getResultObjectController(int index){
    return controllerResultObject.elementAt(index);
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
    int? gradleId = getIdFromName(listOfGradeNames, basicValidator.getController('grade_name')!.text??"");
    basicValidator.getController('grade_name')!.text = listOfGradeNames[getIdFromName(listOfGradeNames, basicValidator.getController('grade_name')!.text??"")]??"";
    UserProfile? userProfile = await UserManager().getUserProfile();
    List<String> infoObject = [];
    List<String> resultObject = [];

    for(TextEditingController textEditingController in getListInfoObjectController())
      {
        if(textEditingController.text.isNotEmpty) {
          infoObject.add(textEditingController.text);
        }
      }
    for(TextEditingController textEditingController in getListResultObjectController())
    {
      if(textEditingController.text.isNotEmpty) {
        resultObject.add(textEditingController.text);
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
      infoObj: infoObject.join("&&&"),
      infoResult: resultObject.join("&&&"),
      isActive: int.tryParse(basicValidator.getController('is_active')?.text ?? '1'),
      accompanyCourse: (basicValidator.getController('accompany_course')?.text??"").isNotEmpty? basicValidator.getController('accompany_course')?.text:'',
      createdBy: userProfile?.userName,
      updatedBy: userProfile?.userName,
      gradeId: gradleId,
      mode: basicValidator.getController('payment_mode')?.text??"FREE",
    );
    return addCourseRequest;
  }
}

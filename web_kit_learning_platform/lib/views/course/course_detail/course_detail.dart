import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/expands/expand_widget.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
import 'package:webkit/views/course/course_list/components/lectures_detail.dart';
import 'package:webkit/views/course/course_list/components/course_mode.dart';
import 'package:webkit/views/course/course_list/components/tag_drop_down.dart';
import '../../../controller/ui/add_course_controller.dart';
import '../../../services/apis/course/add_course_request.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:file_picker/file_picker.dart';

class CourseDetail extends StatefulWidget {
  final List<CourseInfo>? courseInfo;
  const CourseDetail({super.key, required this.courseInfo});

  void show(BuildContext context) {
    showGeneralDialog(
        //barrierDismissible: true,
      context: context,
        pageBuilder: (context, animation, secondaryAnimation) => this,);
  }

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail>
    with SingleTickerProviderStateMixin, UIMixin {
  final MultiSelectController multiSelectController = MultiSelectController();
  late AddCourseController controller;
  late AnimationController animationController;
  late List<CourseInfo> coursesInfo;
  @override
  void initState() {
    super.initState();
    controller = Get.put(AddCourseController());
    animationController = AnimationController(vsync: this);
    coursesInfo = widget.courseInfo!;
    controller.basicValidator.getController('course_mode')?.text = 'FREE';
  }

  List<Lectures> lectures = [];
  bool isChecked = false;
  bool value = false;
  List<String> categoryNameList = [
  'Tiếng Trung',
  'Tiếng Việt',
  'Tiếng Anh',
  'Tiếng Nhật',
  ];

  List<String> tagList = [
  'HSK1',
  'China',
  'HSK2',
  'VietNam'
  'HSK3',
  'HSK4',
  'HSK5',
  'A1',
  'A2',
  'B1',
  'B2',
  'C1',
  'C2',
  ];

  List<String> accompanyCourse = [
    'Sơ cấp nói',
    'Trung cấp nói',
    'Cao cấp nói',
    'Sơ cấp nghe',
    'Trung cấp nghe',
    'Cao cấp nghe'
  ];

  List gradeNameList = ['HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5'];
  String? value1;
  String? value2;

  File? selectedImage;
  final ImagePicker imagePicker = ImagePicker();

  List<String> listOfProduceNames = [];
  List<String> listOfGradeNames = [];
  List<String> listOfAccompanyCourses = [];
  List<String> listOfTags = [];

  @override
  Widget build(BuildContext context) {
  for (CourseInfo courseInfo in coursesInfo) {
    if (!listOfProduceNames.contains(courseInfo.producerName) && courseInfo.producerName != "") {
      listOfProduceNames.add(courseInfo.producerName??"");
    }
    if (!listOfAccompanyCourses.contains(courseInfo.name) && courseInfo.name != "") {
      listOfAccompanyCourses.add(courseInfo.name??"");
    }
    if (!listOfGradeNames.contains(courseInfo.gradeName) && courseInfo.gradeName != "") {
      listOfGradeNames.add(courseInfo.gradeName??"");
    }
    for (String tag in courseInfo.tags??[]) {
          if (!listOfTags.contains(tag)  && tag != "") {
            listOfTags.add(tag ?? "");
          }
        }
    }
    return GetBuilder<AddCourseController>(
      init: controller,
      builder: (controller) {
        return Material(
          child: CustomDialog1(
            title: 'New course',
            titleAlignment: MainAxisAlignment.center,
            //radius: 20,
            width: MediaQuery.of(context).size.width,
            height:  MediaQuery.of(context).size.height-Dimens.size20,
            mainAxisSizeParent: MainAxisSize.max,
            enableCloseButton: true,
            bodyBackGroundColor: ColorConst.bgDialogColor,
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(255, 233, 233, 1.0),
                  border: Border(
                      top: BorderSide(
                        width: 1,
                        color: ColorConst.colorHintTextSearch,
                      )
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.all(Dimens.size16),
                    child: Form(
                      key: controller.basicValidator.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildCourseSummaryInfo(),
                          SizedBox(height: 16,),
                          addLectures(),
                          SizedBox(height: 16,),
                          Center(
                            child: TextButton(
                              child: Text('Submit',
                                style: TextStyleConstant.textStyleBlack16w400.copyWith(
                                  color: Colors.black,
                                ), ),
                              onPressed: () {
                                try {
                                  print('id: ${controller.basicValidator.getController('id')?.hashCode}');
                                } catch (e) {
                                  print('id error: $e');
                                }

                                try {
                                  print('name: ${controller.basicValidator.getController('name')!.text}');
                                } catch (e) {
                                  print('name error: $e');
                                }

                                try {
                                  print('image: ${controller.basicValidator.getController('image')?.text}');
                                } catch (e) {
                                  print('image error: $e');
                                }

                                try {
                                  print('totalLectures: ${int.parse(controller.basicValidator.getController('total_lectures')?.text ?? '0')}');
                                } catch (e) {
                                  print('totalLectures error: $e');
                                }

                                try {
                                  print('totalSubjects: ${int.parse(controller.basicValidator.getController('total_subjects')?.text ?? '0')}');
                                } catch (e) {
                                  print('totalSubjects error: $e');
                                }

                                try {
                                  print('producerName: ${controller.basicValidator.getController('producer_name')?.text}');
                                } catch (e) {
                                  print('producerName error: $e');
                                }

                                try {
                                  print('language: ${controller.basicValidator.getController('language')!.text}');
                                } catch (e) {
                                  print('language error: $e');
                                }

                                try {
                                  print('introduction: ${controller.basicValidator.getController('introduction')?.text}');
                                } catch (e) {
                                  print('introduction error: $e');
                                }

                                try {
                                  print('payment: ${int.parse(controller.basicValidator.getController('payment')?.text ?? '0')}');
                                } catch (e) {
                                  print('payment error: $e');
                                }

                                try {
                                  print('ratePoint: ${int.parse(controller.basicValidator.getController('rate_point')?.text ?? '0')}');
                                } catch (e) {
                                  print('ratePoint error: $e');
                                }

                                try {
                                  print('durian: ${controller.basicValidator.getController('durian')!.text}');
                                } catch (e) {
                                  print('durian error: $e');
                                }

                                try {
                                  print('courseMode: ${controller.basicValidator.getController('course_mode')!.text}');
                                } catch (e) {
                                  print('courseMode error: $e');
                                }

                                try {
                                  print('gradeName: ${controller.basicValidator.getController('grade_name')?.text}');
                                } catch (e) {
                                  print('gradeName error: $e');
                                }

                                try {
                                  print('categoryId: ${int.parse(controller.basicValidator.getController('category_id')?.text ?? '0')}');
                                } catch (e) {
                                  print('categoryId error: $e');
                                }

                                try {
                                  print('isStandard: ${int.parse(controller.basicValidator.getController('is_standard')!.text ?? '0')}');
                                } catch (e) {
                                  print('isStandard error: $e');
                                }

                                try {
                                  print('categoryName: ${controller.basicValidator.getController('category_name')?.text}');
                                } catch (e) {
                                  print('categoryName error: $e');
                                }

                                try {
                                  print('videoPreview: ${controller.basicValidator.getController('video_preview')?.text}');
                                } catch (e) {
                                  print('videoPreview error: $e');
                                }

                                try {
                                  print('infoObj: ${controller.basicValidator.getController('info_obj')?.text}');
                                } catch (e) {
                                  print('infoObj error: $e');
                                }

                                try {
                                  print('infoResult: ${controller.basicValidator.getController('info_result')?.text}');
                                } catch (e) {
                                  print('infoResult error: $e');
                                }

                                try {
                                  print('isActive: ${controller.basicValidator.getController('is_active')?.hashCode}');
                                } catch (e) {
                                  print('isActive error: $e');
                                }

                                try {
                                  print('accompanyCourse: ${controller.basicValidator.getController('accompany_course')?.text ?? ''}');
                                } catch (e) {
                                  print('accompanyCourse error: $e');
                                }

                                try {
                                  print('tags: ${controller.basicValidator.getController('tags')?.text ?? ''}');
                                } catch (e) {
                                  print('tags error: $e');
                                }
                                controller.onAddCourse();
                              },
                            ),
                            // MyButton.rounded(
                            //   onTap: controller.onAddCourse,
                            //   elevation: 0,
                            //   padding: MySpacing.xy(20, 16),
                            //   backgroundColor: ColorConst.whiteColor,
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       // controller.loading
                            //       //     ? SizedBox(
                            //       //   height: 14,
                            //       //   width: 14,
                            //       //   child: CircularProgressIndicator(
                            //       //     color: theme.colorScheme.onPrimary,
                            //       //     strokeWidth: 1.2,
                            //       //   ),
                            //       // )
                            //       //     : Container(),
                            //       // if (controller.loading) MySpacing.width(16),
                            //       // SizedBox(height: 12,),
                            //
                            //     ],
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

  }
  Widget buildCourseSummaryInfo(){
    return Card(
      child: ExpandWidget(
       // expandColor: Color.fromRGBO(255, 233, 233, 1.0),
        title: 'Course',
        titleStyle: TextStyle(
            fontSize: 18
        ),
        //titleGradient: const [Color.fromRGBO(169, 59, 58, 1.0), Color.fromRGBO(255, 131, 131, 1.0),],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium('Name: *'),
                        MySpacing.height(4),
                        Container(
                          color: ColorConst.whiteColor,
                          child: TextFormField(
                            validator: controller.basicValidator
                                .getValidation('name'),
                            controller: controller.basicValidator
                                .getController('name'),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle:
                              MyTextStyle.bodySmall(xMuted: true),
                              border: outlineInputBorder,
                              prefixIcon: Icon(
                                LucideIcons.user,
                                size: 20,
                                color: ColorConst.colorIconGrays,
                              ),
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MySpacing.width(20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium(
                          'Category: *',
                        ),
                        MySpacing.height(4),
                        Container(
                          color: ColorConst.whiteColor,
                          child: DropdownButtonFormField(
                            dropdownColor: theme.cardTheme.color,
                            decoration: InputDecoration(
                              labelText: value2 ?? 'Category',
                              labelStyle:
                              MyTextStyle.bodySmall(xMuted: true),
                              border: outlineInputBorder,
                              prefixIcon: Icon(
                                LucideIcons.phone,
                                size: 20,
                                color: ColorConst.colorIconGrays,
                              ),
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                            ),
                            items: categoryNameList.map((element) {
                              return DropdownMenuItem(
                                value: element,
                                child: Text(element),
                              );
                            }).toList(),
                            onChanged: (value) => setState(
                                    () => controller.basicValidator.getController('category_name')?.text = value!),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // MySpacing.height(20),
              MySpacing.height(20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium(
                          'Background image: ',
                        ),
                        MySpacing.height(4),
                        Container(
                          color: ColorConst.whiteColor,
                          child: TextFormField(
                            validator: controller.basicValidator
                                .getValidation('image'),
                            controller: controller.basicValidator
                                .getController('image'),
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(
                              labelText: 'Image',
                              labelStyle: MyTextStyle.bodySmall(xMuted: true),
                              border: outlineInputBorder,
                              prefixIcon: Icon(
                                LucideIcons.mail,
                                size: 20,
                                color: ColorConst.colorIconGrays,
                              ),
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.image),
                                onPressed: () async {
                                  final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
                                  setState(() {
                                    if (pickedFile != null) {
                                      selectedImage = File(pickedFile.path);
                                      // Update the text field with the selected image path
                                      controller.basicValidator
                                          .getController('image')
                                          ?.text = selectedImage!.path;
                                    } else {
                                      selectedImage = null;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MySpacing.width(20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium(
                          'Video preview: ',
                        ),

                        MySpacing.height(4),
                        Container(
                          color: ColorConst.whiteColor,
                          child: TextFormField(
                            validator: controller.basicValidator
                                .getValidation('video_review'),
                            controller: controller.basicValidator
                                .getController('video_review'),
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(
                              labelText: 'Youtube url',
                              labelStyle: MyTextStyle.bodySmall(xMuted: true),
                              border: outlineInputBorder,
                              prefixIcon: Icon(
                                LucideIcons.mail,
                                size: 20,
                                color: ColorConst.colorIconGrays,
                              ),
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.video_call),
                                onPressed: () async {
                                  final pickedFile = await imagePicker
                                      .pickVideo(source: ImageSource.gallery);
                                  setState(() {
                                    if (pickedFile != null) {
                                      selectedImage = File(pickedFile.path);
                                      // Update the text field with the selected image path
                                      controller.basicValidator
                                          .getController('image')
                                          ?.text = selectedImage!.path;
                                    } else {
                                      selectedImage = null;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MySpacing.height(20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium('Author:'),
                        MySpacing.height(4),
                        customDropDownSearchCustom(list: listOfProduceNames,hintText:'Author', controller: controller.basicValidator.getController('producer_name')),
                      ],
                    ),
                  ),
                  MySpacing.width(20),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium('Duration: *'),
                        MySpacing.height(4),
                        Container(
                          color: ColorConst.whiteColor,
                          child: TextFormField(
                            validator: controller.basicValidator
                                .getValidation('durian'),
                            controller: controller.basicValidator
                                .getController('durian'),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Course duration',
                              labelStyle:
                              MyTextStyle.bodySmall(xMuted: true),
                              border: outlineInputBorder,
                              prefixIcon: Icon(
                                LucideIcons.user,
                                size: 20,
                                color: ColorConst.colorIconGrays,
                              ),
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MySpacing.width(20),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium(
                          'Who is the course for ?',
                        ),
                        MySpacing.height(4),
                        Container(
                          color: ColorConst.whiteColor,
                          child: TextFormField(
                            validator: controller.basicValidator
                                .getValidation('info_obj'),
                            controller: controller.basicValidator
                                .getController('info_obj'),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Object',
                              labelStyle:
                              MyTextStyle.bodySmall(xMuted: true),
                              border: outlineInputBorder,
                              prefixIcon: Icon(
                                LucideIcons.user,
                                size: 20,
                                color: ColorConst.colorIconGrays,
                              ),
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MySpacing.width(20),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium(
                          'Grade: ',
                        ),
                        MySpacing.height(4),
                        customDropDownSearchCustom(list: listOfGradeNames, hintText: 'GradeName', controller: controller.basicValidator.getController('grade_name'))
                      ],
                    ),
                  ),
                ],
              ),
              MySpacing.height(20),
              MyText.labelMedium('Introduction: '),
              MySpacing.height(4),
              Container(
                color: ColorConst.whiteColor,
                child: TextFormField(
                  validator: controller.basicValidator
                      .getValidation('introduction'),
                  controller: controller.basicValidator
                      .getController('introduction'),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Introduction',
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      // prefixIcon: const Icon(
                      //   LucideIcons.lock,
                      //   size: 20,
                      // ),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior:
                      FloatingLabelBehavior.never),
                  minLines: 5,
                  maxLines: 10,
                ),
              ),
              MySpacing.height(20),
              MyText.labelMedium('What will you achieve after the course?'),
              MySpacing.height(4),
              Container(
                color: ColorConst.whiteColor,
                child: TextFormField(
                  validator: controller.basicValidator
                      .getValidation('info_result'),
                  controller: controller.basicValidator
                      .getController('info_result'),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Result after the course',
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      // prefixIcon: const Icon(
                      //   LucideIcons.lock,
                      //   size: 20,
                      // ),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior:
                      FloatingLabelBehavior.never),
                  minLines: 5,
                  maxLines: 10,
                ),
              ),
              MySpacing.height(20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyText.labelMedium(
                          'Stardard: *',
                        ),
                        MySpacing.height(15),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            color: ColorConst.whiteColor,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  value = !value;
                                  value == true ? controller.basicValidator.getController('is_standard')?.text = '1'
                                  : controller.basicValidator.getController('is_standard')?.text = '0';
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    border: Border.all(
                                      color: Colors.black87,
                                    ),
                                  ),
                                  width: 24,
                                  height: 24,
                                  child: value ? Icon(
                                    Icons.check,
                                    size: 18,
                                    color: ColorConst.colorIconGrays,
                                  ) : null
                              ),),
                          ),
                        ),
                        MySpacing.height(15),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: ModeOptionWidget(mode: 'FREE',
                        onModeChanged: (String? value) {
                          controller.basicValidator.getController('course_mode')?.text = value!;
                          setState(() {
                            setLectureModeToFree();
                          });
                          print(controller.basicValidator.getController('course_mode')?.text = value!);
                      },
                        onPaymentChanged: (int? value) {
                          controller.basicValidator.getController('payment')?.text = value!.toString();
                        },
                        disablePayment: false, disablePremiumMode: false,
                      )),
                  SizedBox(width: 20,),
                  Expanded(flex: 8 ,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText.labelMedium(
                        'Accompany course: ',
                      ),
                      MySpacing.height(4),
                      // Container(
                      //   color: ColorConst.whiteColor,
                      //   child: DropdownButtonFormField(
                      //     dropdownColor: theme.cardTheme.color,
                      //     decoration: InputDecoration(
                      //       labelText: value1 ?? 'Accompany course',
                      //       labelStyle:
                      //       MyTextStyle.bodySmall(xMuted: true),
                      //       border: outlineInputBorder,
                      //       prefixIcon: Icon(
                      //         LucideIcons.book,
                      //         size: 20,
                      //         color: ColorConst.colorIconGrays,
                      //       ),
                      //       contentPadding: MySpacing.all(16),
                      //       isCollapsed: true,
                      //       floatingLabelBehavior:
                      //       FloatingLabelBehavior.never,
                      //     ),
                      //     items: accompanyCourse.map((element) {
                      //       return DropdownMenuItem(
                      //         value: element,
                      //         child: Text(element),
                      //       );
                      //     }).toList(),
                      //     onChanged: (value) => setState(() {
                      //       print(controller.basicValidator.getController('course_mode'));
                      //     }),
                      //   ),
                      // ),
                      customDropDownSearchCustom(list: listOfAccompanyCourses, hintText: 'Accompany Course', controller: controller.basicValidator.getController('accompany_course')),
                    ],
                  ),),
                ],
              ),
              MyText.labelMedium(
                'Tags: *',
              ),
              MySpacing.height(4),
              TagDropDown(tags: listOfTags,
                onAddTags: (tags) {
                  controller.basicValidator.getController('tags')?.text = tags.join(', ');
                  print(controller.basicValidator.getController('tags')?.text);
                }, onRemoveTags: (tags ) {
                  final currentText = controller.basicValidator.getController('tags')?.text;
                  final removedTags = currentText?.split(', ').where((tag) => !tags.contains(tag)).toList();
                  final newTags = tags.where((tag) => !currentText!.split(', ').contains(tag)).toList();

                  controller.basicValidator.getController('tags')?.text = [...newTags, ...?currentText?.split(', ').where((tag) => !removedTags!.contains(tag))].join(', ');
                  print(controller.basicValidator.getController('tags')?.text);
                },),
              MySpacing.height(20),

            ],
          ),
        ),
      ),
    );
  }
  Widget addLectures(){
    return Card(
      child: ExpandWidget(
        // expandColor: Color.fromRGBO(255, 233, 233, 1.0),
        title: 'Lectures',
        titleStyle: TextStyle(
          fontSize: 18
        ),
        //titleGradient: [ColorConst.bgColor, Color.fromRGBO(255, 233, 233, 1.0),],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  color: Colors.black
                ),
                color: ColorConst.whiteColor
              ),
              constraints: BoxConstraints(
                minHeight: 100
              ),
              child: AddLectures(color: ColorConst.colorIconGrays, controller: controller, lectures: lectures,
                onChanged: (subjects, lectures) {
                  controller.basicValidator.getController('total_subjects')?.text = subjects.length.toString();
                  int totalLectures = 0;
                  for (int i = 0; i < subjects.length; i++) {
                    totalLectures += subjects[i].lectures.length;
                  }
                  controller.basicValidator.getController('total_lectures')?.text = totalLectures.toString();
                },),
            ),
          ],
        ),
      ),
    );
  }
  Widget listLecture(){
    return SizedBox();
  }

  Widget customDropDownSearchCustom({required List<String> list,required String hintText, required TextEditingController? controller}){
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        constraints: BoxConstraints(
          maxHeight: (65 + list.length * 50 < 210) ? 65 + list.length * 50 : 210,
        ),
        showSearchBox: true,
        searchDelay: Duration(seconds: 0),
        showSelectedItems: true,
      ),
      items: list,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText,
          hintStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.book,
            size: 20,
            color: ColorConst.colorIconGrays,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior:
          FloatingLabelBehavior.never,
        ),
      ),
      onChanged: (value) {
        controller?.text = value??"";
      },
    );
  }
}


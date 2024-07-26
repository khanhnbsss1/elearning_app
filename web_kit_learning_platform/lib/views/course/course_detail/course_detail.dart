// import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file/file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/expands/expand_widget.dart';
import 'package:webkit/controller/ui/add_lecture_controller.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/landing_page/components/colornotifier.dart';
import 'package:webkit/services/apis/course/courrse_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
import 'package:webkit/views/course/course_detail/bloc/add_course_directory_bloc.dart';
import 'package:webkit/views/course/course_detail/components/add_lectures.dart';
import '../../../controller/ui/add_course_controller.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import '../../lessson/vocabulary_detail/add_lesson.dart';
import 'components/course_mode.dart';
import 'components/lectures_detail.dart';
import 'components/tag_drop_down.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key});

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
  late List<CourseInfo> coursesInfo;
  late ColorNotifier notifier;
  @override
  void initState() {
    super.initState();
    controller = Get.put(AddCourseController());
    controller.basicValidator.getController('course_mode')?.text = 'FREE';
    controller.basicValidator.getController('is_standard')?.text = '0';
    controller.basicValidator.getController('id')?.text = '100';
    controller.basicValidator.getController('total_lectures')?.text = '0';
    controller.basicValidator.getController('total_subjects')?.text = '0';
    controller.basicValidator.getController('payment')?.text = '0';
    controller.basicValidator.getController('rate_point')?.text = '0';
    controller.basicValidator.getController('category_id')?.text = '0';
    controller.basicValidator.getController('is_active')?.text = '0';
    controller.basicValidator.getController('language')?.text = 'CN';
    _tabController = TabController(length: 4, vsync: this);
  }

  List<Lectures> lectures = [];
  bool value = false;
  bool value1 = false;
  String? value2;

  File? selectedImage;
  final ImagePicker imagePicker = ImagePicker();

  Map<int,String> listOfCategoryName = {};
  Map<int,String> listOfProduceNames = {};
  Map<int,String> listOfGradeNames = {};
  Map<int,String> listOfAccompanyCourses = {};
  Map<int,String> listOfTags = {};

  int? getIdFromName(Map<int, String> map, String name) {
    try {
      return map.entries
          .firstWhere((entry) => entry.value == name)
          .key;
    } catch (e) {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: BlocProvider(
        create: (context) {
          return AddCourseFilterBloc(AddCourseFilterState())..add(AddCourseFilterInitEvent());
        },
        child: BlocConsumer<AddCourseFilterBloc, AddCourseFilterState>(
          listener: (context, state) {
            switch (state.blocStatus) {
              case AddCourseFilterStatus.initial:
                break;
              default:
                break;
            }
          }, builder: (BuildContext context, state) {
            return LayoutBuilder(
                builder: (context, constraints) {
                  return buildAddCourse(constraints: constraints, state: state);
                },
            );
        },
        )
      ),
    );
  }

  late TabController _tabController;

  Widget buildAddCourse(
  {required BoxConstraints constraints,required AddCourseFilterState state}) {
    state.addCourseFilterModel?.data?.forEach((data) {
      switch (data.filterType) {
        case 'CATEGORY':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!listOfCategoryName.containsValue(e.name!)) {
              listOfCategoryName[e.id!] = e.name!;
            }
          });
          break;
        case 'AUTHOR':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!listOfProduceNames.containsValue(e.name!)) {
              listOfProduceNames[e.id!] = e.name!;
            }
          });
          break;
        case 'GRADE':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!listOfGradeNames.containsValue(e.name!)) {
              listOfGradeNames[e.id!] = e.name!;
            }
          });
          break;
        case 'ACCOMPANY':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!listOfAccompanyCourses.containsValue(e.name!)) {
              listOfAccompanyCourses[e.id!] = e.name!;
            }
          });
          break;
        case 'TAG':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!listOfTags.containsValue(e.name!)) {
              listOfTags[e.id!] = e.name!;
            }
          });
          break;
        default:
          break;
      }
    });

    return GetBuilder<AddCourseController>(
      init: controller,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    children: const [
                      Text('Create course', style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),),
                      // SizedBox(height: 8,),
                      // Text('Course / Course list / Create course', style: TextStyle(
                      //   fontSize: 16,
                      //   color: Colors.black.withOpacity(0.5),
                      // ),),
                    ],
                  ),
                  Spacer(),
                  TextButton(onPressed: (){}, child: Text('Save update', style: TextStyle(fontSize: 16,),),),
                  TextButton(onPressed: (){}, child: Text('Preview', style: TextStyle(fontSize: 16,),),),
                ],
              ),
            ),
            toolbarHeight: 70,
          ),
          body: Column(
            children: [
              Center(
                child: Card(
                  elevation: 5,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Introduction'),
                        Tab(text: 'Content'),
                        Tab(text: 'Quiz'),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    IntroductionTab(),
                    ContentTab(),
                    QuizTab(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget IntroductionTab() {
    return Expanded(
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
                child: Form(
                  key: controller.basicValidator.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCourseSummaryInfo(),
                      SizedBox(height: 16,),
                      // addLectures(),
                      // SizedBox(height: 16,),
                      Center(
                        child: TextButton(
                          child: Text('Submit',
                            style: TextStyleConstant.textStyleBlack16w400.copyWith(
                              color: Colors.black,
                            ), ),
                          onPressed: () {
                            controller.basicValidator.getController('accompany_course')!.text = getIdFromName(listOfAccompanyCourses, controller.basicValidator.getController('accompany_course')!.text).toString();
                            controller.basicValidator.getController('category_id')!.text = getIdFromName(listOfCategoryName, controller.basicValidator.getController('category_name')!.text).toString();
                            controller.basicValidator.getController('grade_name')!.text = getIdFromName(listOfGradeNames, controller.basicValidator.getController('grade_name')!.text).toString();
                            List<String> tags = controller.basicValidator.getController('tags')!.text.split(',');
                            List<int> tagIds = tags.map((tag) => getIdFromName(listOfTags, tag))
                                .where((id) => id != null)
                                .cast<int>()
                                .toList();
                            String tagIdsString = tagIds.join(',');
                            controller.basicValidator.getController('tags')?.text = tagIdsString;
                            printInfo();
                            controller.onAddCourse();
                          },
                        ),

                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ContentTab() {
    AddLectures addLectures = AddLectures();
    List<Widget> listOfLectures = [];
    // for (LecturesInfo lecturesInfo )
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        color: notifier.whitecolor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 50,
                    constraints: BoxConstraints(
                      minWidth: 400,
                    ),
                    child: customDropDownSearch(
                        list: listOfAccompanyCourses.values.toList(),
                        hintText: 'Add lectures from another course',
                        controller: null,
                        check: true,
                    ),
                  ),
                  SizedBox(width: 8,),
                  IconButton(onPressed: () {
                    addLectures.show(context);
                  }, icon: Icon(Icons.add_circle, color: notifier.redcolor,)),
                ],
              ),
              // ListView.builder(itemBuilder: (BuildContext context, int index) {  },)
            ],
          ),
        ),
      ),
    );
  }




  Widget QuizTab() {
    return Text('asd');
  }

  Widget buildCourseSummaryInfo(){
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
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
                            labelText: 'Course name...',
                            labelStyle:
                            MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            prefixIcon: Icon(
                              LucideIcons.user,
                              size: 20,
                              color: notifier.redcolor,
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
                            labelText: value2 ?? 'Category...',
                            labelStyle:
                            MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            prefixIcon: Icon(
                              LucideIcons.phone,
                              size: 20,
                              color: notifier.redcolor,
                            ),
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior:
                            FloatingLabelBehavior.never,
                          ),
                          items: listOfCategoryName.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.value,
                              child: Text(entry.value),
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
                            labelText: 'Upload image (.png, .jpg)...',
                            labelStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            prefixIcon: Icon(
                              LucideIcons.mail,
                              size: 20,
                              color: notifier.redcolor,
                            ),
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior:
                            FloatingLabelBehavior.never,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.image, color: notifier.redcolor,),
                              onPressed: () async {
                                // final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
                                // setState(() {
                                //   if (pickedFile != null) {
                                //     selectedImage = File(pickedFile.path);
                                //     // Update the text field with the selected image path
                                //     controller.basicValidator
                                //         .getController('image')
                                //         ?.text = selectedImage!.path;
                                //   } else {
                                //     selectedImage = null;
                                //   }
                                // });
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
                            labelText: 'Upload youtube url...',
                            labelStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            prefixIcon: Icon(
                              LucideIcons.mail,
                              size: 20,
                              color: notifier.redcolor,
                            ),
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior:
                            FloatingLabelBehavior.never,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.video_call, color: notifier.redcolor,),
                              onPressed: () async {
                                // uploadFile();
                                // final pickedFile = await imagePicker
                                //     .pickVideo(source: ImageSource.gallery);
                                // setState(() {
                                //   if (pickedFile != null) {
                                //     selectedImage = File(pickedFile.path);
                                //     // Update the text field with the selected image path
                                //     controller.basicValidator
                                //         .getController('image')
                                //         ?.text = selectedImage!.path;
                                //   } else {
                                //     selectedImage = null;
                                //   }
                                // });
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
                      customDropDownSearch(
                          list: listOfProduceNames.values.toList(),
                          hintText:'Author...',
                          controller: controller.basicValidator.getController('producer_name')),
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
                            labelText: 'How long does the course last?',
                            labelStyle:
                            MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            prefixIcon: Icon(
                              LucideIcons.user,
                              size: 20,
                              color: notifier.redcolor,
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
                            labelText: 'Who is this course for ? ',
                            labelStyle:
                            MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            prefixIcon: Icon(
                              LucideIcons.user,
                              size: 20,
                              color: notifier.redcolor,
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
                      customDropDownSearch(list: listOfGradeNames.values.toList(), hintText: 'Grade name...', controller: controller.basicValidator.getController('grade_name'))
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
                    labelText: 'Course introduction...',
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
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 1,
            //       child: Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           MyText.labelMedium(
            //             'Stardard: *',
            //           ),
            //           MySpacing.height(15),
            //           Padding(
            //             padding: EdgeInsets.only(left: 20),
            //             child: Container(
            //               color: ColorConst.whiteColor,
            //               child: InkWell(
            //                 onTap: () {
            //                   setState(() {
            //                     value = !value;
            //                     value == true ? controller.basicValidator.getController('is_standard')?.text = '1'
            //                     : controller.basicValidator.getController('is_standard')?.text = '0';
            //                   });
            //                 },
            //                 child: Container(
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(1),
            //                       border: Border.all(
            //                         color: Colors.black87,
            //                       ),
            //                     ),
            //                     width: 24,
            //                     height: 24,
            //                     child: value ? Icon(
            //                       Icons.check,
            //                       size: 18,
            //                       color: notifier.redcolor,
            //                     ) : null
            //                 ),),
            //             ),
            //           ),
            //           MySpacing.height(15),
            //         ],
            //       ),
            //     ),
            //     Expanded(
            //         flex: 5,
            //         child: ModeOptionWidget(mode: 'FREE',
            //           onModeChanged: (String? value) {
            //             controller.basicValidator.getController('course_mode')?.text = value!;
            //             setState(() {
            //               setLectureModeToFree();
            //             });
            //             print(controller.basicValidator.getController('course_mode')?.text = value!);
            //         },
            //           onPaymentChanged: (int? value) {
            //             controller.basicValidator.getController('payment')?.text = value!.toString();
            //           },
            //           disablePayment: false, disablePremiumMode: false,
            //         )),
            //     SizedBox(width: 20,),
            //     Expanded(flex: 8 ,child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         MyText.labelMedium(
            //           'Accompany course: ',
            //         ),
            //         MySpacing.height(4),
            //         // Container(
            //         //   color: ColorConst.whiteColor,
            //         //   child: DropdownButtonFormField(
            //         //     dropdownColor: theme.cardTheme.color,
            //         //     decoration: InputDecoration(
            //         //       labelText: value1 ?? 'Accompany course',
            //         //       labelStyle:
            //         //       MyTextStyle.bodySmall(xMuted: true),
            //         //       border: outlineInputBorder,
            //         //       prefixIcon: Icon(
            //         //         LucideIcons.book,
            //         //         size: 20,
            //         //         color: notifier.redcolor,
            //         //       ),
            //         //       contentPadding: MySpacing.all(16),
            //         //       isCollapsed: true,
            //         //       floatingLabelBehavior:
            //         //       FloatingLabelBehavior.never,
            //         //     ),
            //         //     items: accompanyCourse.map((element) {
            //         //       return DropdownMenuItem(
            //         //         value: element,
            //         //         child: Text(element),
            //         //       );
            //         //     }).toList(),
            //         //     onChanged: (value) => setState(() {
            //         //       print(controller.basicValidator.getController('course_mode'));
            //         //     }),
            //         //   ),
            //         // ),
            //         customDropDownSearch(list: listOfAccompanyCourses.values.toList(), hintText: 'Accompany Course', controller: controller.basicValidator.getController('accompany_course')),
            //       ],
            //     ),),
            //   ],
            // ),
            Row(
              children: [
                MyText.labelMedium(
                  'Settings: '
                ),
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: notifier.redcolor,
                        activeColor: notifier.redcolor,
                        fillColor: MaterialStateColor.resolveWith((states) => notifier.whitecolor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(width: 1.0, color: notifier.redcolor),
                        ),
                        value: value,
                        onChanged: (newValue) {
                          setState(() {
                            value = newValue!;
                            controller.basicValidator.getController('is_active')?.text = '1';
                          });
                        },
                      ),
                      MyText.bodyMedium(
                        'Show course in landing page'
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: notifier.redcolor,
                        activeColor: notifier.redcolor,
                        fillColor: MaterialStateColor.resolveWith((states) => notifier.whitecolor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(width: 1.0, color: notifier.redcolor),
                        ),
                        value: value1,
                        onChanged: (newValue) {
                          setState(() {
                            value1 = newValue!;
                          });
                        },
                      ),
                      MyText.bodyMedium(
                          'Standard'
                      ),
                      SizedBox( width: 8,),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Expanded(
                    child: customDropDownSearch(
                      check: value1,
                      list: listOfAccompanyCourses.values.toList(),
                      hintText: 'Accompany course',
                      controller: controller.basicValidator.getController('accompany_course'),
                    ),
                  ),
                )
              ],
            ),
            MySpacing.height(20),
            MyText.labelMedium(
              'Tags: *',
            ),
            MySpacing.height(4),
            TagDropDown(tags: listOfTags.values.toSet(),
              onAddTags: (tags) {
                controller.basicValidator.getController('tags')?.text = tags.join(',');
              }, onRemoveTags: (tags ) {
                final currentTags = controller.basicValidator.getController('tags')?.text.split(',').map((tag) => tag.trim()).toList();
                final removedTags = currentTags?.where((tag) => !tags.contains(tag)).toList();
                final newTags = tags.where((tag) => !currentTags!.contains(tag)).toList();

                controller.basicValidator.getController('tags')?.text = [...newTags, ...?currentTags?.where((tag) => !removedTags!.contains(tag))].join(',');
              },),
            MySpacing.height(20),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.labelMedium('Discount code:'),
                      MySpacing.height(4),
                      customDropDownSearch(
                          list: listOfProduceNames.values.toList(),
                          hintText:'Discount code...',
                          controller: controller.basicValidator.getController('producer_name')),
                          textLabelItem
                    ],
                  ),
                ),
                MySpacing.width(20),
                Expanded(
                  flex: 4,
                  child: SizedBox())
              ],
            ),

          ],
        ),
      ),
    );
  }
  // Widget addLectures(){
  //   return Card(
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(4)),
  //             border: Border.all(
  //               color: Colors.black
  //             ),
  //             color: ColorConst.whiteColor
  //           ),
  //           constraints: BoxConstraints(
  //             minHeight: 100
  //           ),
  //           child: AddLectures(color: notifier.redcolor, controller: controller, lectures: lectures,
  //             onChanged: (subjects, lectures) {
  //               controller.basicValidator.getController('total_subjects')?.text = subjects.length.toString();
  //               int totalLectures = 0;
  //               for (int i = 0; i < subjects.length; i++) {
  //                 totalLectures += subjects[i].lectures.length;
  //               }
  //               controller.basicValidator.getController('total_lectures')?.text = totalLectures.toString();
  //             },),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget listLecture(){
    return SizedBox();
  }

  Widget customDropDownSearch({
    required List<String?> list,
    required String hintText,
    required TextEditingController? controller,
    bool check = true,
  }) {
    return DropdownSearch<String>(
      enabled: check,
      popupProps: PopupProps.menu(
        itemBuilder: (context, e, check) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Discount name : $e - Discount code: $e - Start: $e - End: $e')
          );
        },
        constraints: BoxConstraints(
          maxHeight: (65 + list.length * 50 < 210) ? 65 + list.length * 50 : 210,
        ),
        showSearchBox: true,
        searchDelay: Duration(seconds: 0),
        showSelectedItems: true,
      ),
      items: list.map((e) => e ?? '').toList(),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText,
          hintStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.book,
            size: 20,
            color: notifier.redcolor,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
      onChanged: (value) {
        controller?.text = value ?? "";
      },
    );
  }

  void printInfo() {
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
  }
}


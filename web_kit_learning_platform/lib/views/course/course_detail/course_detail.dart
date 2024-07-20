// import 'dart:io';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/html.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/expands/expand_widget.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
import 'package:webkit/views/course/course_detail/bloc/add_course_directory_bloc.dart';
import '../../../controller/ui/add_course_controller.dart';
import '../../../services/apis/course/add_course_request.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
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
  late AnimationController animationController;
  late List<CourseInfo> coursesInfo;
  @override
  void initState() {
    super.initState();
    controller = Get.put(AddCourseController());
    animationController = AnimationController(vsync: this);
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
  }

  List<Lectures> lectures = [];
  bool value = false;

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
        return Material(
          child: CustomDialog1(
            title: 'New course',
            titleAlignment: MainAxisAlignment.center,
            //radius: 20,
            width: MediaQuery.of  (context).size.width,
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

  // Future<void> uploadFile() async {
  //   // Create an input element to select the file
  //   final FileUploadInputElement uploadInput = FileUploadInputElement();
  //   uploadInput.accept = 'image/*'; // Adjust file types if needed
  //   uploadInput.click();
  //
  //   uploadInput.onChange.listen((event) async {
  //     final files = uploadInput.files;
  //
  //     if (files!.length > 0) {
  //       final file = files[0];
  //
  //       // Debugging: Log file details
  //       print('File selected: ${file.name}, size: ${file.size} bytes');
  //
  //       // Create FormData
  //       // final formData = FormData();
  //       // formData.appendBlob('file', file, file.name);
  //       // dynamic text  = [
  //       //   {
  //       //     "id": 0,
  //       //     "name": "Khóa học luyện thi  tiếng Trung",
  //       //     "image": "http://navitrack.camdvr.org:9000/elearning/CN/courses/CourseTest_20240625.jpg?AWSAccessKeyId=LIgVcqy3d8rJzBM4&Expires=2034661189&Signature=MLh7bNigrR2hoiHh9TV589Qr23A%3D",
  //       //     "producer_name": "long1",
  //       //     "language": "CN",
  //       //     "introduction": "",
  //       //     "info_obj": "",
  //       //     "info_result": "",
  //       //     "day_from": "2024-01-01",
  //       //     "day_to": "2024-06-01",
  //       //     "payment": 50000,
  //       //     "update_by": "0348074377",
  //       //     "category": "CQ",
  //       //     "grade_id": 1,
  //       //     "is_active": 1,
  //       //     "video_preview": "",
  //       //     "durian": "8 hours",
  //       //     "mode": "public",
  //       //     "is_standard": 1
  //       //   }
  //       // ];
  //
  //       // Create FormData
  //       final formData = FormData.fromMap({
  //         'file': await MultipartFile.fromBytes(
  //           await file.arrayBuffer(),
  //           filename: file.name,
  //         ),
  //       });
  //
  //       // Initialize Dio
  //       final dio = Dio();
  //
  //       try {
  //         final response = await dio.post(
  //           'http://192.168.0.47:8989/upload-file',
  //           data: 'file',
  //           options: Options(
  //             headers: {
  //               'Content-Type': 'multipart/form-data',
  //             },
  //           ),
  //         );
  //
  //         if (response.statusCode == 200) {
  //           print('File uploaded successfully!');
  //         } else {
  //           print('File upload failed with status: ${response.statusCode}');
  //         }
  //       } catch (e) {
  //         print('Error uploading file: $e');
  //       }
  //     }});
  //
  //   //     formData.appendBlob('data',text);
  //   //     formData.appendBlob('tags',"1,2" as Blob);
  //   //     // Create and send the request
  //   //     final request = HttpRequest();
  //   //     request
  //   //       ..open('POST', 'http://192.168.0.47:8989/api/Course/create-course')
  //   //       ..setRequestHeader('Content-Type', 'multipart/form-data',)
  //   //       ..setRequestHeader('Device-Type', 'Web')
  //   //       ..setRequestHeader('Authorization', 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiMDM0ODA3NDM3NyIsImp0aSI6ImZhYmM3YjI3LTU2ZDgtNGRhZC05MmNmLWRmMTc4ZWI5NDMwNyIsImV4cCI6MTcyMTQ3MTQzNn0.NrSGIfm9BwEEfDm11KzwCmCiWG6YypoTX733ExBA8fs')
  //   //       ..onLoadEnd.listen((e) {
  //   //         if (request.status == 200) {
  //   //           print('File uploaded successfully!');
  //   //         } else {
  //   //           print('File upload failed with status: ${request.status}');
  //   //         }
  //   //       })
  //   //       ..send(formData);
  //   //   } else {
  //   //     print('No files found in the input');
  //   //   }
  //   // });
  // }


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
                              suffixIcon: ElevatedButton(
                                child: Icon(Icons.video_call),
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
                            hintText:'Author',
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
                        customDropDownSearch(list: listOfGradeNames.values.toList(), hintText: 'GradeName', controller: controller.basicValidator.getController('grade_name'))
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
                      customDropDownSearch(list: listOfAccompanyCourses.values.toList(), hintText: 'Accompany Course', controller: controller.basicValidator.getController('accompany_course')),
                    ],
                  ),),
                ],
              ),
              MyText.labelMedium(
                'Tags: *',
              ),
              MySpacing.height(4),
              TagDropDown(tags: listOfTags.values.toList(),
                onAddTags: (tags) {
                  controller.basicValidator.getController('tags')?.text = tags.join(',');
                }, onRemoveTags: (tags ) {
                  final currentTags = controller.basicValidator.getController('tags')?.text.split(',').map((tag) => tag.trim()).toList();
                  final removedTags = currentTags?.where((tag) => !tags.contains(tag)).toList();
                  final newTags = tags.where((tag) => !currentTags!.contains(tag)).toList();

                  controller.basicValidator.getController('tags')?.text = [...newTags, ...?currentTags?.where((tag) => !removedTags!.contains(tag))].join(',');
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

  Widget customDropDownSearch({required List<String?> list,required String hintText, required TextEditingController? controller}){
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
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


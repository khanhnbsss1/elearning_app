import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/views/course/course_list/add_lectures.dart';
import 'package:webkit/views/course/course_list/course_mode.dart';
import '../../../controller/ui/add_course_controller.dart';
import '../../../services/apis/course/add_course_request.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/enum/app_enums.dart';
import 'package:multi_dropdown/models/chip_config.dart';
import 'package:multi_dropdown/models/network_config.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multi_dropdown/widgets/hint_text.dart';
import 'package:multi_dropdown/widgets/selection_chip.dart';
import 'package:multi_dropdown/widgets/single_selected_item.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  void show(BuildContext context) {
    showDialog(
        barrierDismissible: true, context: context, builder: (context) => this);
  }

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse>
    with SingleTickerProviderStateMixin, UIMixin {

  final MultiSelectController multiSelectController = MultiSelectController();
  late AddCourseController controller;
  late AnimationController animationController;

  Color color = Color.fromRGBO(163, 20, 19, 1.0);
  @override
  void initState() {
    super.initState();
    controller = Get.put(AddCourseController());
    animationController = AnimationController(vsync: this);
  }

  List<Lectures> lectures = [];
  bool isChecked = false;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    print('Building AnimatedList');
    List categoryNameList = [
      'Tiếng Trung',
      'Tiếng Việt',
      'Tiếng Anh',
      'Tiếng Nhật',
    ];

    List tagList = [
      'HSK1',
      'China',
      'HSK2',
      'VietNam'
    ];

    List<bool> tagListCheckBox = List<bool>.filled(tagList.length, false);


    List gradeNameList = ['HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5'];
    String? value1;
    String? value2;

    File? selectedImage;
    final ImagePicker imagePicker = ImagePicker();


    // void addItem() {
    //   setState(() {
    //     _items.add('New Item');
    //   });
    // }
    //
    // void removeItem(int index) {
    //   setState(() {
    //     _items.removeAt(index);
    //   });
    // }

    return Material(
        color: theme.cardTheme.color,
        child: GetBuilder<AddCourseController>(
          init: controller,
          builder: (controller) {
            return Padding(
              padding: MySpacing.all(36),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.close,
                      color: color,),
                    ),
                  ),
                  Center(
                      child: MyText.titleLarge(
                    'Add course',
                    fontWeight: 700,
                  )),
                  Padding(
                    padding: MySpacing.y(20),
                    child: Form(
                      key: controller.basicValidator.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MySpacing.height(20),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.labelMedium('Course name *'),
                                    MySpacing.height(4),
                                    TextFormField(
                                      validator: controller.basicValidator
                                          .getValidation('name'),
                                      controller: controller.basicValidator
                                          .getController('name'),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'name',
                                        labelStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        prefixIcon: Icon(
                                          LucideIcons.user,
                                          size: 20,
                                          color: color,
                                        ),
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
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
                                      'Category *',
                                    ),
                                    MySpacing.height(4),
                                    DropdownButtonFormField(
                                      dropdownColor: theme.cardTheme.color,
                                      decoration: InputDecoration(
                                        labelText: value2 ?? 'Category',
                                        labelStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        prefixIcon: Icon(
                                          LucideIcons.phone,
                                          size: 20,
                                          color: color,
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
                                              () => value2 = value as String?),
                                    )
                                  ],
                                ),
                              ),
                              // Expanded(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       MyText.labelMedium(
                              //         'Category',
                              //       ),
                              //       MySpacing.height(4),
                              //       TextFormField(
                              //         validator: controller.basicValidator
                              //             .getValidation('category_name'),
                              //         controller: controller.basicValidator
                              //             .getController('category_name'),
                              //         keyboardType: TextInputType.number,
                              //         decoration: InputDecoration(
                              //           labelText: 'Category name',
                              //           labelStyle:
                              //               MyTextStyle.bodySmall(xMuted: true),
                              //           border: outlineInputBorder,
                              //           prefixIcon: const Icon(
                              //             LucideIcons.user,
                              //             size: 20,
                              //           ),
                              //           contentPadding: MySpacing.all(16),
                              //           isCollapsed: true,
                              //           floatingLabelBehavior:
                              //               FloatingLabelBehavior.never,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                          MySpacing.height(20),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.labelMedium(
                                      'Image',
                                    ),
                                    MySpacing.height(4),
                                    TextFormField(
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
                                          color: color,
                                        ),
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.image),
                                          onPressed: () async {
                                            final pickedFile = await imagePicker
                                                .pickImage(source: ImageSource.gallery);
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
                                  ],
                                ),
                              ),
                              MySpacing.width(20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.labelMedium(
                                      'Video review',
                                    ),

                                    MySpacing.height(4),
                                    TextFormField(
                                      validator: controller.basicValidator
                                          .getValidation('video_review'),
                                      controller: controller.basicValidator
                                          .getController('Video_review'),
                                      keyboardType: TextInputType.url,
                                      decoration: InputDecoration(
                                        labelText: 'Youtube url',
                                        labelStyle: MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        prefixIcon: Icon(
                                          LucideIcons.mail,
                                          size: 20,
                                          color: color,
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
                                    MyText.labelMedium(
                                      'Grade',
                                    ),
                                    MySpacing.height(4),
                                    DropdownButtonFormField(
                                      dropdownColor: theme.cardTheme.color,
                                      decoration: InputDecoration(
                                        labelText: value1 ?? 'Grade name',
                                        labelStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        prefixIcon: Icon(
                                          LucideIcons.phone,
                                          size: 20,
                                          color: color,
                                        ),
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                      ),
                                      items: gradeNameList.map((element) {
                                        return DropdownMenuItem(
                                          value: element,
                                          child: Text(element),
                                        );
                                      }).toList(),
                                      onChanged: (value) => setState(
                                              () => value1 = value as String?),
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
                                      'Tags',
                                    ),
                                    MySpacing.height(4),
                                    DropdownButtonFormField(
                                      dropdownColor: theme.cardTheme.color,
                                      decoration: InputDecoration(
                                        labelText: value1 ?? 'Tags',
                                        labelStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        prefixIcon: Icon(
                                          LucideIcons.phone,
                                          size: 20,
                                          color: color,
                                        ),
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                      ),
                                      items: tagList.map((element) {
                                        return DropdownMenuItem(
                                          value: element,
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    // tagListCheckBox = !tagListCheckBox;
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
                                                      color: color,
                                                    ) : null
                                                ),),
                                              MySpacing.width(20),
                                              Text(element),
                                            ],
                                          )
                                        );
                                      }).toList(),
                                      onChanged: (value) => setState(
                                              () => value1 = value as String?),
                                    ),
                                  ],
                                ),
                              ),

                              MySpacing.width(20),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText.labelMedium(
                                      'Stardard *',
                                    ),
                                    MySpacing.height(15),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          value = !value;
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
                                            color: color,
                                          ) : null
                                      ),),
                                    MySpacing.height(15),
                                  ],
                                ),
                              ),
                              // MySpacing.width(20),
                              Expanded(
                                  flex: 3,
                                  child: ModeOptionWidget()),
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
                                    MyText.labelMedium('Proceduce name'),
                                    MySpacing.height(4),
                                    TextFormField(
                                      validator: controller.basicValidator
                                          .getValidation('producer_name'),
                                      controller: controller.basicValidator
                                          .getController('producer_name'),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'Proceduce name',
                                        labelStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        prefixIcon: Icon(
                                          LucideIcons.user,
                                          size: 20,
                                          color: color,
                                        ),
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
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
                                    MyText.labelMedium('Course duration *'),
                                    MySpacing.height(4),
                                    TextFormField(
                                      validator: controller.basicValidator
                                          .getValidation('durian'),
                                      controller: controller.basicValidator
                                          .getController('durian'),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'Course duration',
                                        labelStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        prefixIcon: Icon(
                                          LucideIcons.user,
                                          size: 20,
                                          color: color,
                                        ),
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              MySpacing.width(20),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.labelMedium(
                                      'Who is the course for ?',
                                    ),
                                    MySpacing.height(4),
                                    TextFormField(
                                      validator: controller.basicValidator
                                          .getValidation('info_obj'),
                                      controller: controller.basicValidator
                                          .getController('info_obj'),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Info object',
                                        labelStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        prefixIcon: Icon(
                                          LucideIcons.user,
                                          size: 20,
                                          color: color,
                                        ),
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          MySpacing.height(20),
                          MyText.labelMedium('Course introduction'),
                          TextFormField(
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
                          MySpacing.height(20),
                          MyText.labelMedium('What will you achieve after the course?'),
                          MySpacing.height(4),
                          TextFormField(
                            validator: controller.basicValidator
                                .getValidation('info_result'),
                            controller: controller.basicValidator
                                .getController('info_result'),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: 'Info result',
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
                          MySpacing.height(20),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MyText.labelMedium('Lecture'),
                              Spacer(),
                              // SizedBox(width: 100,),
                              // IconButton(
                              //   icon: Icon(Icons.add, size: 18),
                              //   onPressed: () {
                              //     addItem();
                              //   },
                              // ),
                              // IconButton(
                              //   icon: Icon(Icons.delete, size: 18, color: Colors.red),
                              //   onPressed: () {
                              //     removeItem(_items.length - 1);
                              //   },
                              // ),
                            ],
                          ),
                          MySpacing.height(4),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                  width: 1,
                                  strokeAlign: 0,
                                  color: Colors.black),
                            ),
                            height: 1000,
                            width: double.infinity,
                            child: AddLectures(color: color, controller: controller, lectures: lectures,),
                          ),
                          Center(
                            child: MyButton.rounded(
                              onTap: controller.onAddCourse,
                              elevation: 0,
                              padding: MySpacing.xy(20, 16),
                              backgroundColor: contentTheme.primary,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  controller.loading
                                      ? SizedBox(
                                    height: 14,
                                    width: 14,
                                    child: CircularProgressIndicator(
                                      color: theme.colorScheme.onPrimary,
                                      strokeWidth: 1.2,
                                    ),
                                  )
                                      : Container(),
                                  if (controller.loading) MySpacing.width(16),
                                  MyText.bodySmall(
                                    'Add Course',
                                    color: contentTheme.onPrimary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            );
          },
        ));

  }

}

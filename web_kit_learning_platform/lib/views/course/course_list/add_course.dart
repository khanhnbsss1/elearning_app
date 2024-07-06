import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/auth/register_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/images.dart';
import 'package:webkit/landing_page/mediaquery/mq.dart';
import 'package:webkit/plugins/screenshot/lib/screenshot.dart';
import 'package:webkit/views/course/course_list/course_mode.dart';
import 'package:webkit/views/layouts/auth_layout.dart';

import '../../../controller/ui/add_course_controller.dart';
import '../../../services/apis/course/add_course_request.dart';

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

  late AddCourseController controller;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    controller = Get.put(AddCourseController());
    animationController = AnimationController(vsync: this);
  }

  List<String> _items = [];
  List<Lectures> lectures = [];

  @override
  Widget build(BuildContext context) {
    print('Building AnimatedList');
    List categoryNameList = [
      'Tiếng Trung',
      'Tiếng Việt',
      'Tiếng Anh',
      'Tiếng Nhật',
    ];
    List categoryIdList = [
      '1',
      '2',
      '3',
      '4',
    ];
    List gradeNameList = ['HSK1', 'HSK2', 'HSK3', 'HSK4', 'HSK5'];
    String? value1;
    String? value2;
    String? value3;

    File? _selectedImage;
    final ImagePicker _imagePicker = ImagePicker();

    final GlobalKey<AnimatedListState> _listKey = GlobalKey();

    void _addItem() {
      setState(() {
        _items.add('New Item');
        _listKey.currentState?.insertItem(0);
        print('_items: $_items');
      });
    }

    void _removeItem(int index) {
      setState(() {
        _items.removeAt(index);
        _listKey.currentState?.removeItem(index, (context, animation) {
          return FadeTransition(
            opacity: animation,
            child: ListTile(
              title: Text(_items[index]),
            ),
          );
        });
        print('_items: $_items');

      });
    }

    // void _addItem() {
    //   setState(() {
    //     lectures.add(Lectures(
    //       id: lectures.length + 1,
    //       subName: '',
    //       lectureName: '',
    //       lectureLink: '',
    //       lectureMode: '',
    //     ));
    //     _listKey.currentState?.insertItem(lectures.length - 1);
    //     print('_items: $_items');
    //   });
    // }
    //
    // void _removeItem(int index) {
    //   setState(() {
    //     lectures.removeAt(index);
    //     _listKey.currentState?.removeItem(index, (context, animation) {
    //       return FadeTransition(
    //         opacity: animation,
    //         child: ListTile(
    //           title: SizedBox(),
    //         ),
    //       );
    //     });
    //   });
    // }
    String? _selectedOption = 'Free';
    bool _isPremium = false;
    final _paymentController = TextEditingController();

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
                      child: Icon(Icons.close),
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
                                    MyText.labelMedium('Name'),
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
                                        prefixIcon: const Icon(
                                          LucideIcons.user,
                                          size: 20,
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
                                      'Category',
                                    ),
                                    MySpacing.height(4),
                                    TextFormField(
                                      validator: controller.basicValidator
                                          .getValidation('categoryId'),
                                      controller: controller.basicValidator
                                          .getController('categoryId'),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Category Id',
                                        labelStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        prefixIcon: const Icon(
                                          LucideIcons.user,
                                          size: 20,
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
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.labelMedium(
                                      'Info object',
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
                                        prefixIcon: const Icon(
                                          LucideIcons.user,
                                          size: 20,
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
                                    MyText.labelMedium('Duration'),
                                    MySpacing.height(4),
                                    TextFormField(
                                      validator: controller.basicValidator
                                          .getValidation('durian'),
                                      controller: controller.basicValidator
                                          .getController('durian'),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'durian',
                                        labelStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        prefixIcon: const Icon(
                                          LucideIcons.user,
                                          size: 20,
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
                              // Expanded(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       MyText.labelMedium(
                              //         'Payment',
                              //       ),
                              //       MySpacing.height(4),
                              //       TextFormField(
                              //         validator: controller.basicValidator
                              //             .getValidation('payment'),
                              //         controller: controller.basicValidator
                              //             .getController('payment'),
                              //         keyboardType: TextInputType.number,
                              //         decoration: InputDecoration(
                              //           labelText: 'Payment',
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
                              Expanded(child: ModeOptionWidget()),
                            ],
                          ),
                          MySpacing.height(20),
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
                              labelText: 'image',
                              labelStyle: MyTextStyle.bodySmall(xMuted: true),
                              border: outlineInputBorder,
                              prefixIcon: const Icon(
                                LucideIcons.mail,
                                size: 20,
                              ),
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.image),
                                onPressed: () async {
                                  final pickedFile = await _imagePicker
                                      .pickImage(source: ImageSource.gallery);
                                  setState(() {
                                    if (pickedFile != null) {
                                      _selectedImage = File(pickedFile.path);
                                      // Update the text field with the selected image path
                                      controller.basicValidator
                                          .getController('image')
                                          ?.text = _selectedImage!.path;
                                    } else {
                                      _selectedImage = null;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          MySpacing.height(20),
                          MyText.labelMedium(
                            'Video review',
                          ),
                          MySpacing.height(4),
                          TextFormField(
                            validator: controller.basicValidator
                                .getValidation('image'),
                            controller: controller.basicValidator
                                .getController('image'),
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(
                              labelText: 'image',
                              labelStyle: MyTextStyle.bodySmall(xMuted: true),
                              border: outlineInputBorder,
                              prefixIcon: const Icon(
                                LucideIcons.mail,
                                size: 20,
                              ),
                              contentPadding: MySpacing.all(16),
                              isCollapsed: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.video_call),
                                onPressed: () async {
                                  final pickedFile = await _imagePicker
                                      .pickVideo(source: ImageSource.gallery);
                                  setState(() {
                                    if (pickedFile != null) {
                                      _selectedImage = File(pickedFile.path);
                                      // Update the text field with the selected image path
                                      controller.basicValidator
                                          .getController('image')
                                          ?.text = _selectedImage!.path;
                                    } else {
                                      _selectedImage = null;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          MySpacing.height(20),
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.labelMedium(
                                      'Category name',
                                    ),
                                    MySpacing.height(4),
                                    DropdownButtonFormField(
                                      dropdownColor: theme.cardTheme.color,
                                      decoration: InputDecoration(
                                        labelText: value2 ?? 'Category name',
                                        labelStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        prefixIcon: const Icon(
                                          LucideIcons.phone,
                                          size: 20,
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
                              MySpacing.width(20),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.labelMedium(
                                      'Grade name',
                                    ),
                                    MySpacing.height(4),
                                    DropdownButtonFormField(
                                      dropdownColor: theme.cardTheme.color,
                                      decoration: InputDecoration(
                                        labelText: value1 ?? 'Grade name',
                                        labelStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        prefixIcon: const Icon(
                                          LucideIcons.phone,
                                          size: 20,
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
                                    )
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
                                      'Category Id',
                                    ),
                                    MySpacing.height(4),
                                    DropdownButtonFormField(
                                      dropdownColor: theme.cardTheme.color,
                                      decoration: InputDecoration(
                                        labelText: value3 ?? 'Category Id',
                                        labelStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        prefixIcon: const Icon(
                                          LucideIcons.phone,
                                          size: 20,
                                        ),
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                      ),
                                      items: categoryIdList.map((element) {
                                        return DropdownMenuItem(
                                          value: element,
                                          child: Text(element),
                                        );
                                      }).toList(),
                                      onChanged: (value) => setState(
                                          () => value3 = value as String?),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          MySpacing.height(20),
                          MyText.labelMedium('Introduction'),
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
                          MyText.labelMedium('Info result'),
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
                              IconButton(
                                icon: Icon(Icons.add, size: 18),
                                onPressed: () {
                                  _addItem();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, size: 18, color: Colors.red),
                                onPressed: () {
                                  _removeItem(_items.length - 1);
                                },
                              ),
                            ],
                          ),
                          MySpacing.height(4),
                          Container(
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.all(Radius.circular(4)),
                            //     border: Border.all(
                            //           width: 1,
                            //           strokeAlign: 0,
                            //           color: Colors.black),
                            // ),
                            height: 500,
                            width: double.infinity,
                            child: AnimatedList(
                              key: _listKey,
                              initialItemCount: _items.length + 1,
                              itemBuilder: (context, index, animation) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset(1, 0),
                                    end: Offset(0, 0),
                                  ).animate(animation),
                                  child: ListTile(
                                    title: Card(
                                      elevation: 10,
                                      child: Container(
                                        margin: EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      MyText.labelMedium(
                                                        'Sub name',
                                                      ),
                                                      MySpacing.height(4),
                                                      TextFormField(
                                                        validator: controller.basicValidator
                                                            .getValidation('sub_name'),
                                                        controller: controller.basicValidator
                                                            .getController('sub_name'),
                                                        keyboardType: TextInputType.number,
                                                        decoration: InputDecoration(
                                                          labelText: 'Subject name',
                                                          labelStyle:
                                                          MyTextStyle.bodySmall(xMuted: true),
                                                          border: outlineInputBorder,
                                                          prefixIcon: const Icon(
                                                            LucideIcons.user,
                                                            size: 20,
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
                                                      MyText.labelMedium('Lecturn name'),
                                                      MySpacing.height(4),
                                                      TextFormField(
                                                        validator: controller.basicValidator
                                                            .getValidation('lecture_name'),
                                                        controller: controller.basicValidator
                                                            .getController('lecture_name'),
                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          labelText: 'Lecture name',
                                                          labelStyle:
                                                          MyTextStyle.bodySmall(xMuted: true),
                                                          border: outlineInputBorder,
                                                          prefixIcon: const Icon(
                                                            LucideIcons.user,
                                                            size: 20,
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
                                                        'Lecture mode',
                                                      ),
                                                      MySpacing.height(4),
                                                      TextFormField(
                                                        validator: controller.basicValidator
                                                            .getValidation('lecture_mode'),
                                                        controller: controller.basicValidator
                                                            .getController('lecture_mode'),
                                                        keyboardType: TextInputType.number,
                                                        decoration: InputDecoration(
                                                          labelText: 'Lecture name',
                                                          labelStyle:
                                                          MyTextStyle.bodySmall(xMuted: true),
                                                          border: outlineInputBorder,
                                                          prefixIcon: const Icon(
                                                            LucideIcons.user,
                                                            size: 20,
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
                                            MyText.labelMedium(
                                              'Lecture link',
                                            ),
                                            MySpacing.height(4),
                                            TextFormField(
                                              validator: controller.basicValidator
                                                  .getValidation('lecture_link'),
                                              controller: controller.basicValidator
                                                  .getController('lecture_link'),
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText: 'Lecture link',
                                                labelStyle:
                                                MyTextStyle.bodySmall(xMuted: true),
                                                border: outlineInputBorder,
                                                prefixIcon: const Icon(
                                                  LucideIcons.user,
                                                  size: 20,
                                                ),
                                                contentPadding: MySpacing.all(16),
                                                isCollapsed: true,
                                                floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                              ),
                                            ),
                                            MySpacing.height(20),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),),
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

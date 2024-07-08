import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../controller/ui/add_course_controller.dart';
import '../../../helpers/utils/ui_mixins.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../../services/apis/course/add_course_request.dart';

class AddLectures extends StatefulWidget {
  final Color color;
  final AddCourseController controller;
  final List<Lectures> lectures;
  const AddLectures({super.key, required this.color, required this.controller, required this.lectures,});

  @override
  State<AddLectures> createState() => _AddLecturesState();
}

class _AddLecturesState extends State<AddLectures> with SingleTickerProviderStateMixin, UIMixin {

  late TextEditingController lectureController;
  late AddCourseController controller;
  late Color color;
  List<Lectures> lectures = [];

  void initState() {
    super.initState();
    controller = widget.controller;
    color = widget.color;
    lectures = widget.lectures;
  }

  void addItem() {
    setState(() {
      lectures.add(Lectures(
        id: lectures.length,
        subName: '',
        lectureName: '',
        lectureLink: '',
        lectureMode: '',
      ));
      print(lectures);
    });
  }

  List<Widget> listOfLectures = List.empty(growable: true);

  void removeItem(int index) {
    setState(() {
      lectures.removeAt(0);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8,),
        Center(
          child: SizedBox(
            width: 150,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // background color
                  side: BorderSide(width: 1, color: Colors.black), // border
                ),
                onPressed: () { addItem(); },
                child: Row(
                  children: [
                    Icon(Icons.add, color: color,),
                    Text('Add Lecture',style: TextStyle(color: color),),
              ],
            )),
          ),
        ),
        
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 800),
          child: SizedBox(
            width: double.infinity,
            child: ListView.builder(itemCount: lectures.length,
                itemBuilder:  (context, index) {
                  return Card(
                    elevation: 10,
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.delete, size: 18, color: Colors.red),
                              onPressed: () {
                                removeItem(index + 1);
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.labelMedium(
                                      'Subject',
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MyText.labelMedium(
                              'Lecture link',
                            ),
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
                          MySpacing.height(20),
                        ],
                      ),
                    ),
                  );
                },),
          ),
        )
        // Card(
        //   elevation: 10,
        //   child: Container(
        //     margin: EdgeInsets.all(16),
        //     child: Column(
        //       children: [
        //         Align(
        //           alignment: Alignment.topRight,
        //           child: IconButton(
        //             icon: Icon(Icons.delete, size: 18, color: Colors.red),
        //             onPressed: () {
        //               removeItem(lectures.length - 1);
        //             },
        //           ),
        //         ),
        //         Row(
        //           children: [
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   MyText.labelMedium(
        //                     'Subject',
        //                   ),
        //                   MySpacing.height(4),
        //                   TextFormField(
        //                     validator: controller.basicValidator
        //                         .getValidation('sub_name'),
        //                     controller: controller.basicValidator
        //                         .getController('sub_name'),
        //                     keyboardType: TextInputType.number,
        //                     decoration: InputDecoration(
        //                       labelText: 'Subject name',
        //                       labelStyle:
        //                       MyTextStyle.bodySmall(xMuted: true),
        //                       border: outlineInputBorder,
        //                       prefixIcon: Icon(
        //                         LucideIcons.user,
        //                         size: 20,
        //                         color: color,
        //                       ),
        //                       contentPadding: MySpacing.all(16),
        //                       isCollapsed: true,
        //                       floatingLabelBehavior:
        //                       FloatingLabelBehavior.never,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             MySpacing.width(20),
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   MyText.labelMedium('Lecturn name'),
        //                   MySpacing.height(4),
        //                   TextFormField(
        //                     validator: controller.basicValidator
        //                         .getValidation('lecture_name'),
        //                     controller: controller.basicValidator
        //                         .getController('lecture_name'),
        //                     keyboardType: TextInputType.text,
        //                     decoration: InputDecoration(
        //                       labelText: 'Lecture name',
        //                       labelStyle:
        //                       MyTextStyle.bodySmall(xMuted: true),
        //                       border: outlineInputBorder,
        //                       prefixIcon: Icon(
        //                         LucideIcons.user,
        //                         size: 20,
        //                         color: color,
        //                       ),
        //                       contentPadding: MySpacing.all(16),
        //                       isCollapsed: true,
        //                       floatingLabelBehavior:
        //                       FloatingLabelBehavior.never,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             MySpacing.width(20),
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   MyText.labelMedium(
        //                     'Lecture mode',
        //                   ),
        //                   MySpacing.height(4),
        //                   TextFormField(
        //                     validator: controller.basicValidator
        //                         .getValidation('lecture_mode'),
        //                     controller: controller.basicValidator
        //                         .getController('lecture_mode'),
        //                     keyboardType: TextInputType.number,
        //                     decoration: InputDecoration(
        //                       labelText: 'Lecture name',
        //                       labelStyle:
        //                       MyTextStyle.bodySmall(xMuted: true),
        //                       border: outlineInputBorder,
        //                       prefixIcon: Icon(
        //                         LucideIcons.user,
        //                         size: 20,
        //                         color: color,
        //                       ),
        //                       contentPadding: MySpacing.all(16),
        //                       isCollapsed: true,
        //                       floatingLabelBehavior:
        //                       FloatingLabelBehavior.never,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //         MySpacing.height(20),
        //         Align(
        //           alignment: Alignment.centerLeft,
        //           child: MyText.labelMedium(
        //             'Lecture link',
        //           ),
        //         ),
        //         MySpacing.height(4),
        //         TextFormField(
        //           validator: controller.basicValidator
        //               .getValidation('lecture_link'),
        //           controller: controller.basicValidator
        //               .getController('lecture_link'),
        //           keyboardType: TextInputType.number,
        //           decoration: InputDecoration(
        //             labelText: 'Lecture link',
        //             labelStyle:
        //             MyTextStyle.bodySmall(xMuted: true),
        //             border: outlineInputBorder,
        //             prefixIcon: Icon(
        //               LucideIcons.user,
        //               size: 20,
        //               color: color,
        //             ),
        //             contentPadding: MySpacing.all(16),
        //             isCollapsed: true,
        //             floatingLabelBehavior:
        //             FloatingLabelBehavior.never,
        //           ),
        //         ),
        //         MySpacing.height(20),
        //       ],
        //     ),
        //   ),
        // ),

      ],
    );
  }
}

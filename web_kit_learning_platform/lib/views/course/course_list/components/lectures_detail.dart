import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:universal_html/html.dart';
import 'package:webkit/base/theme/colors_app.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../controller/ui/add_course_controller.dart';
import '../../../../helpers/theme/app_theme.dart';
import '../../../../helpers/utils/ui_mixins.dart';
import '../../../../helpers/widgets/my_spacing.dart';
import '../../../../helpers/widgets/my_text.dart';
import '../../../../helpers/widgets/my_text_style.dart';
import '../../../../services/apis/course/add_course_request.dart';
import 'course_mode.dart';

class AddLectures extends StatefulWidget {
  final Color color;
  final AddCourseController controller;
  final List<Lectures> lectures;

  const AddLectures({
    super.key,
    required this.color,
    required this.controller,
    required this.lectures,
  });

  @override
  State<AddLectures> createState() => _AddLecturesState();
}

class _AddLecturesState extends State<AddLectures>
    with SingleTickerProviderStateMixin, UIMixin {
  late TextEditingController lectureController;
  late AddCourseController controller;
  late Color color;
  List<Subject> subjects = [];
  List<Lectures> lectures = [];

  void initState() {
    super.initState();
    controller = widget.controller;
    color = widget.color;
    lectures = widget.lectures;
  }

  void addLecture(
      {required int subjectIndex,
      required String lectureName,
      required String lectureLink,
      required String lectureMode}) {
    setState(() {
      subjects[subjectIndex].lectures.add(Lectures(
            id: lectures.length + 1,
            subName: '',
            lectureName: lectureName,
            lectureLink: lectureLink,
            lectureMode: lectureMode,
          ));
    });
  }

  void removeLecture({required int lectureIndex, required int subjectIndex}) {
    setState(() {
      subjects[subjectIndex].lectures.removeAt(lectureIndex);
    });
  }

  void addSubject() {
    setState(() {
      Subject newSubject = Subject(subName: '', lectures: lectures);
      subjects.add(newSubject);
      lectures = []; // reset the lectures list for the next subject
    });
  }

  void removeSubject(int index) {
    setState(() {
      subjects.removeAt(index);
    });
  }

  // String? _filePath;

  // FilePickerResult? result = await FilePicker.platform.pickFiles();
  //
  // void _pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );
  //
  //   if (result != null) {
  //     setState(() {
  //       _filePath = result.files.single.path;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // background color
                    side: BorderSide(width: 1, color: Colors.black), // border
                  ),
                  onPressed: () {
                    addSubject();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: color,
                      ),
                      Text(
                        'Add subject',
                        style: TextStyle(color: color),
                      ),
                    ],
                  )),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 800),
          child: SizedBox(
            width: double.infinity,
            child: ListView.builder(
              itemCount: subjects.length,
              shrinkWrap: true,
              itemBuilder: (context, subjectIndex) {
                return Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorConst.blackColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
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
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: Icon(Icons.delete,
                                          size: 18, color: Colors.red),
                                      onPressed: () {
                                        removeSubject(subjectIndex);
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: SizedBox(
                                      width: 150,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            // background color
                                            side: BorderSide(
                                                width: 1,
                                                color: Colors.black), // border
                                          ),
                                          onPressed: () {
                                            _addLectureDialog(
                                                subjectIndex: subjectIndex);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color: color,
                                              ),
                                              Text(
                                                'Add lecture',
                                                style: TextStyle(color: color),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      MySpacing.height(10),
                      // lectures.add(Lectures(id: 1, lectureName: '',lectureLink: '', lectureMode: '')),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            // Align(
                            //   alignment: Alignment.topRight,
                            //   child: SizedBox(
                            //     width: 150,
                            //     child: ElevatedButton(
                            //         style: ElevatedButton.styleFrom(
                            //           backgroundColor: Colors.white,
                            //           // background color
                            //           side: BorderSide(
                            //               width: 1,
                            //               color: Colors.black), // border
                            //         ),
                            //         onPressed: () {
                            //           _addLectureDialog(
                            //               subjectIndex: subjectIndex);
                            //         },
                            //         child: Row(
                            //           children: [
                            //             Icon(
                            //               Icons.add,
                            //               color: color,
                            //             ),
                            //             Text(
                            //               'Add lecture',
                            //               style: TextStyle(color: color),
                            //             ),
                            //           ],
                            //         )),
                            //   ),
                            // ),
                            ListView.builder(
                              itemCount: subjects[subjectIndex].lectures.length,
                              shrinkWrap: true,
                              itemBuilder: (context, lectureIndex) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                                '${lectureIndex + 1}. Lecture Name: ${subjects[subjectIndex].lectures[lectureIndex].lectureName}'),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                                'Lecture Link: ${subjects[subjectIndex].lectures[lectureIndex].lectureLink}'),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                                'Lecture Mode: ${subjects[subjectIndex].lectures[lectureIndex].lectureMode}'),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    removeLecture(
                                                        lectureIndex:
                                                            lectureIndex,
                                                        subjectIndex:
                                                            subjectIndex);
                                                  },
                                                  child: Icon(Icons.remove)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  void _addLectureDialog({
    required int subjectIndex,
  }) {
    FilePickerResult? result;
    final formKey = GlobalKey<FormState>();
    final lectureNameController = TextEditingController();
    final lectureLinkController = TextEditingController();
    final documentLinkController = TextEditingController();
    String mode = 'FREE';

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add Lecture'),
        content: Form(
          key: formKey,
          child: SizedBox(
            width: 800,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText.labelMedium('Lecture name'),
                SizedBox(height: 4,),
                TextFormField(
                  controller: lectureNameController,
                  decoration: InputDecoration(
                      labelText: 'Lecture name: ',
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter lecture name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                MyText.labelMedium('Lecture link: '),
                SizedBox(height: 4,),
                TextFormField(
                  controller: lectureLinkController,
                  decoration: InputDecoration(
                      labelText: 'Lecture link',
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter lecture link';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                // DropdownButtonFormField(
                //   dropdownColor: theme.cardTheme.color,
                //   decoration: InputDecoration(
                //     labelText: mode,
                //     labelStyle: MyTextStyle.bodySmall(xMuted: true),
                //     border: outlineInputBorder,
                //     prefixIcon: Icon(
                //       LucideIcons.check,
                //       size: 20,
                //       color: color,
                //     ),
                //     contentPadding: MySpacing.all(16),
                //     isCollapsed: true,
                //     floatingLabelBehavior: FloatingLabelBehavior.never,
                //   ),
                //   items: const [
                //     DropdownMenuItem<String>(
                //       value: 'FREE',
                //       child: Text('Free'),
                //     ),
                //     DropdownMenuItem<String>(
                //       value: 'PREMIUM',
                //       child: Text('Premium'),
                //     )
                //   ],
                //   onChanged: (newValue) {
                //     setState(() {
                //       mode = newValue!;
                //     });
                //   },
                // ),
                MyText.labelMedium('Document: '),
                SizedBox(height: 4,),
                TextFormField(
                  controller: documentLinkController,
                  decoration: InputDecoration(
                      labelText: 'Youtube url, pdf',
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.image),
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                        );
                        setState(() {
                          if (result != null) {
                            documentLinkController.text = result.names[0]!;
                          } else {
                          }
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Row(children: [
                  Expanded(flex: 7, child: ModeOptionWidget(mode: DropdownMode.FREE,)),
                  Expanded(flex: 3, child: SizedBox()),
                ],),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: color),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text(
                'Add Lecture',
                style: TextStyle(color: color),
              ),
              onPressed: () {
                setState(() {
                  if (formKey.currentState!.validate()) {
                    addLecture(
                        subjectIndex: subjectIndex,
                        lectureName: lectureNameController.text,
                        lectureLink: lectureLinkController.text,
                        lectureMode: mode);
                    Navigator.of(context).pop();
                  }
                });
              }),
        ],
      ),
    );
  }
}

class Subject {
  String subName;
  List<Lectures> lectures;

  Subject({required this.subName, required this.lectures});
}

class Vocabulary {
  String word;
  String definition;
  String pronunciation;

  Vocabulary({required this.word,required this.definition, required this.pronunciation});
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import '../../../../controller/ui/add_course_controller.dart';
import '../../../../helpers/utils/ui_mixins.dart';
import '../../../../helpers/widgets/my_spacing.dart';
import '../../../../helpers/widgets/my_text.dart';
import '../../../../helpers/widgets/my_text_style.dart';
import 'course_mode.dart';

class AddLectures extends StatefulWidget {
  final Color color;
  final AddCourseController controller;
  final List<LessonInfo> lectures;
  final void Function(List<Subject>,List<LessonInfo>) onChanged;

  const AddLectures({
    super.key,
    required this.color,
    required this.controller,
    required this.lectures,
    required this.onChanged,
  });

  @override
  State<AddLectures> createState() => _AddLecturesState();
}

List<Subject> subjects = [];
List<LessonInfo> lectures = [];

class _AddLecturesState extends State<AddLectures>
    with SingleTickerProviderStateMixin, UIMixin {
  late TextEditingController lectureController;
  late AddCourseController controller;
  late Color color;


  @override
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
      required int? docId,
      required String? lectureMode,
      }) {
    setState(() {
      subjects[subjectIndex].lectures.add(LessonInfo(
            id: lectures.length + 1,
            subName: '',
            lectureName: lectureName,
            link: lectureLink,
            docId: docId,
            mode: lectureMode,
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
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                  margin: EdgeInsets.only(right: 12, left: 12, bottom: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: MyText.labelMedium(
                              'Subject',
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.delete,
                                size: 18, color: Colors.red),
                            onPressed: () {
                              removeSubject(subjectIndex);
                            },
                          ),
                        ],
                      ),
                      MySpacing.height(4),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: TextFormField(
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
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Align(
                                alignment: Alignment.centerRight,
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
                            ),
                          ),
                        ],
                      ),
                      // lectures.add(Lectures(id: 1, lectureName: '',lectureLink: '', lectureMode: '')),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
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
                                              Border.all(color: Colors.black38)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child:Text('${lectureIndex + 1}.')
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: Text(
                                                  'Name: ${subjects[subjectIndex].lectures[lectureIndex].lectureName}',
                                                overflow: TextOverflow.ellipsis,),
                                            ),
                                            SizedBox(width: 8,),
                                            Expanded(
                                              flex: 8,
                                              child: Text(
                                                  'Link: ${subjects[subjectIndex].lectures[lectureIndex].link}',
                                              overflow: TextOverflow.ellipsis,),
                                            ),
                                            SizedBox(width: 8,),
                                            Expanded(
                                              flex: 8,
                                              child: Text(
                                                  'Document: ${subjects[subjectIndex].lectures[lectureIndex].docName}',
                                                overflow: TextOverflow.ellipsis,),
                                            ),
                                            SizedBox(width: 8,),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  'Mode: ${subjects[subjectIndex].lectures[lectureIndex].mode}',
                                                overflow: TextOverflow.ellipsis,),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 2,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        removeLecture(
                                                            lectureIndex:
                                                                lectureIndex,
                                                            subjectIndex:
                                                                subjectIndex);
                                                      },
                                                      icon: Icon(Icons.delete)),
                                                ],
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
    final formKey = GlobalKey<FormState>();
    final lectureNameController = TextEditingController();
    final lectureLinkController = TextEditingController();
    final lectureModeController = TextEditingController();
    final documentLinkController = TextEditingController();
    final String? mode = controller.basicValidator.getController('course_mode')?.text;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add Lecture'),
        content: Form(
          key: formKey,
          child: SizedBox(
            width: 500,
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
                            documentLinkController.text = "No document";
                          }
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Row(children: [
                  Expanded(flex: 7, child: ModeOptionWidget(mode: controller.basicValidator.getController('course_mode')?.text,
                    onModeChanged: (value) {
                    lectureModeController.text = value!;
                  },
                    onPaymentChanged: (int? value) {
                    },
                    disablePayment: true,
                    disablePremiumMode: controller.basicValidator.getController('course_mode')?.text == 'FREE' ? true : false,
                  )),
                  // Expanded(flex: 3, child: SizedBox()),
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
                        docId: 0,
                        lectureMode: (lectureModeController.text == '') ? mode : lectureModeController.text);
                    widget.onChanged(subjects, lectures);
                    Navigator.of(context).pop();
                  }
                });
              }),
        ],
      ),
    );
  }
}

void setLectureModeToFree() {
  for (var subject in subjects) {
    for (var lecture in subject.lectures) {
      lecture.mode = 'FREE';
    }
  }
}
class Subject {
  String subName;
  List<LessonInfo> lectures;

  Subject({required this.subName, required this.lectures});
}
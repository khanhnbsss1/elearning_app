import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/theme/colors_app.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webkit/controller/ui/add_lecture_controller.dart';
import 'package:webkit/controller/ui/add_word_controller.dart';
import 'package:webkit/helpers/widgets/my.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/services/apis/course/courrse_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/views/course/course_detail/components/course_mode.dart';
import 'package:webkit/views/course/course_detail/components/tag_drop_down.dart';
import '../../../../helpers/utils/ui_mixins.dart';
import '../../../../helpers/widgets/my_spacing.dart';
import '../../../../helpers/widgets/my_text_style.dart';
import '../../../../landing_page/components/colornotifier.dart';
import 'custom_text_form_field.dart';

class AddLectures extends StatefulWidget {
  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              width: 550,

              child: Expanded(
                  child: this
              ),
            ),
          );
        });
  }
  AddLectures({this.lecturesInfo});
  LecturesInfo ?lecturesInfo;
  @override
  State<AddLectures> createState() => _AddWordsState();
}

class _AddWordsState extends State<AddLectures>
    with SingleTickerProviderStateMixin, UIMixin {

  @override
  void initState() {
    super.initState();
  }

  List<LecturesInfo> lectures = [];

  void addLectureInfo({
    required String subName,
    required int courseId,
    required String lectureName,
    required String link,
    required String docLink,
    required String mode,
    required String note,
  }) {
    setState(() {
      lectures.add(LecturesInfo(
          subName: '',
          courseId: 0,
          lectureName: '',
          link: '',
          docLink: '',
          mode: '',
          note: '',
    ));
  });
  }

  AddLectureController addLectureController = new AddLectureController();

  void removeExample({required int exampleIndex}) {
    setState(() {

    });
  }

  List<LecturesInfo> listLecture = [];

  late ColorNotifier notifier;

  bool _validateExampleFields(int exampleIndex) {
    final textFormFields = [

    ];

    for (var textField in textFormFields) {
      if (textField.value.text.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alert'),
            content: Text('Please fill in all missing fields'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context,);
                  },
                  child: Text('Ok'))
            ],
          ),
        );
        return false;
      }
    }
    return true;
  }


  bool value = false;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('New word'),
        titleTextStyle: TextStyleConstant.textStyleBlack20w700,
        centerTitle: true,
      ),
      body: MyResponsive(builder: (context, constraints, myScreenMediaType) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4,),
                    MyText.labelMedium(
                      'Lecture name'
                    ),
                    SizedBox(height: 4,),
                    CustomTextFormField(controller: 'lecture_name', label: 'Lecture name...', addLectureController: addLectureController,),
                    SizedBox(
                      height: 16,
                    ),
                    MyText.labelMedium(
                        'Subject name'
                    ),
                    SizedBox(height: 4,),
                    CustomTextFormField(controller: 'subject_name', label: 'Subject name...', addLectureController: addLectureController,),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        MyText.labelMedium(
                            'Lecture link'
                        ),
                        Spacer(),
                        Row(
                          children: [
                            MyText.bodyMedium(
                                'Attach link'
                            ),
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
                                });
                              },
                            ),

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 4,),
                    CustomTextFormField(controller: 'link', label: 'Lecture link (or youtube link)',attachFile: true, attachLink: value, addLectureController: addLectureController,),
                    SizedBox(
                      height: 16,
                    ),
                    MyText.labelMedium(
                        'Documents: '
                    ),
                    SizedBox(height: 4,),
                    CustomTextFormField(controller: 'doc_link', label: 'Upload documents',attachFile: true, attachLink: true, addLectureController: addLectureController,),
                    SizedBox(height: 16,),
                    ModeOptionWidget(mode: 'FREE', onModeChanged: (String? value) {  }, onPaymentChanged: (int? value) {  }, ),
                    SizedBox(height: 16,),
                    MyText.labelMedium(
                      'Words: '
                    ),
                    TagDropDown(tags: const {'1','2','3','4','5','6','7','8','9','10','11','12','13'}, onAddTags: (List<String> _) {  }, onRemoveTags: (List<String> _) {  },),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: notifier.redcolor,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        addLectureController.onAddLecture();
                      },
                      child: Text('Submit', style: TextStyleConstant.textStyleBlack16w400.copyWith(color: Colors.white)),
                    )),
              ),
            ],
          ),
        );
      }),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/views/course/create_edit_course/components/course_mode.dart';
import 'package:webkit/views/lessson/components/search_word_drop_down.dart';
import '../../../base/widgets/widget_common/widget_with_title_common.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';

import 'lesson_detail_bloc/lesson_detail_bloc.dart';

enum LessonActionType{
  view, 
  edit,
  create
}
class CreateEditLesson extends StatefulWidget {
   LessonInfo? lessonInfo;
   LessonActionType? lessonActionType;
   CreateEditLesson({super.key, this.lessonInfo, this.lessonActionType}){
     lessonActionType??= LessonActionType.create;
   }

  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * (ResponsiveInfo.isTablet() ? 0.4 : 0.9),
                height: MediaQuery.of(context).size.height * (ResponsiveInfo.isTablet() ? 0.8 : 0.9),
                child: this
            ),
          );
        });
  }

  @override
  State<CreateEditLesson> createState() => _CreateEditLesson();
}

class _CreateEditLesson extends State<CreateEditLesson>
    with TickerProviderStateMixin, UIMixin {
  TextEditingController editingControllerLectureName = TextEditingController();
  TextEditingController editingControllerLectureDescription = TextEditingController();
  TextEditingController editingControllerLectureVideoLink = TextEditingController();
  TextEditingController editingControllerLectureDocuments = TextEditingController();

  String mode = 'FREE';
  int price = 0;

  late bool enableEdit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.lessonInfo?.id!=null)
      {
        editingControllerLectureName.text = widget.lessonInfo?.lectureName??"";
        editingControllerLectureDescription.text = widget.lessonInfo?.note??"";
        editingControllerLectureVideoLink.text = widget.lessonInfo?.link??"";
        editingControllerLectureDocuments.text = widget.lessonInfo?.docName??"";
      }
    enableEdit = widget.lessonActionType!=LessonActionType.view;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.size20))
      ),
      clipBehavior: Clip.antiAlias,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConst.mainColor,
          iconTheme: IconThemeData(
            color: ColorConst.whiteColor, //change your color here
          ),
          title: Text(L10nX.getStr.create_lesson_str, style: TextStyleConstant.textStyleBlack20w700.copyWith(color: ColorConst.whiteColor),),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: ColorConst.dividerColor, width: 1)),
            color: ColorConst.whiteColor
          ), 
            child: lectureDetail()),
      ),
    );
  }

  MultipartFile? selectedImage;
  final ImagePicker imagePicker = ImagePicker();

  Widget lectureDetail() {
    return BlocProvider(
      create: (context) {
        return LessonDetailBloc(LessonDetailState(lessonInfo: widget.lessonInfo,))
          ..add(LessonDetailInitEvent());
      },
      child: BlocConsumer<LessonDetailBloc, LessonDetailState>(
        listener: (context, state) {
          switch (state.blocStatus) {
            case LessonDetailStatus.initial:
              break;
            default:
              break;
          }
          state.blocStatus = LessonDetailStatus.unKnown;
        },
        builder: (BuildContext context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            buildLectureName(context: context),
                            MySpacing.height(16),
                            buildLectureDescription(context: context),
                            MySpacing.height(16),
                            buildLectureVideoLink(context: context),
                            MySpacing.height(16),
                            buildLectureDocuments(context: context),
                            MySpacing.height(16),
                            buildLectureMode(context: context),
                            MySpacing.height(16),
                            Visibility(
                              visible: state.lessonInfo?.id!=null,
                                child: buildLectureWords(context: context, state: state)),
                            MySpacing.height(16),
                          ],
                        ),
                      ),
                    ),
                    Divider(color: ColorConst.dividerColor.withOpacity(0.3),),
                    ActionButton1(
                      text: widget.lessonActionType == LessonActionType.create?L10nX.getStr.create_lesson_str:L10nX.getStr.str_update,
                      width: Dimens.size150,
                      onTap: () {
                        state.lessonInfo??= LessonInfo();
                        state.lessonInfo?.lectureName = editingControllerLectureName.text;
                        state.lessonInfo?.note = editingControllerLectureDescription.text;
                        state.lessonInfo?.link = editingControllerLectureVideoLink.text;
                        state.lessonInfo?.docName = editingControllerLectureName.text;
                        state.lessonInfo?.mode = mode;
                        switch(widget.lessonActionType){
                          
                          case LessonActionType.view:
                            // TODO: Handle this case.
                            break;
                          case LessonActionType.edit:
                            // TODO: Handle this case.
                              {
                                BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailUpdateLessonEvent(lessonInfo: state.lessonInfo!));
                              }
                            break;
                          case LessonActionType.create:
                            // TODO: Handle this case.
                          {
                            BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailCreateLessonEvent(lessonInfo: state.lessonInfo!));
                          }
                            break;
                          default: 
                            break;
                        }
                        },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildLectureName({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: L10nX.getStr.lecture_name_str,
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: editingControllerLectureName,
        enabled: enableEdit,
        decoration: InputDecoration(
          labelText: L10nX.getStr.lecture_name_str,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.user,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }

  Widget buildLectureDescription({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: L10nX.getStr.description,
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        // validator: state.controller?.basicValidator.getValidation('name'),
        // controller: state.controller?.basicValidator.getController('name'),
        keyboardType: TextInputType.text,
        enabled: enableEdit,
        controller: editingControllerLectureDescription,
        decoration: InputDecoration(
          labelText: L10nX.getStr.description,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.user,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }

  bool enableLectureLink = false;
  Widget buildLectureVideoLink({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: L10nX.getStr.youtube_link,
      isRequirement: true,
      enableAttachFile: false,
      enable: enableEdit,
      onCheckChanged: (bool value){
        setState(() {
          enableLectureLink = value;
        });
      },
      // titleStyle: ,
      child: TextFormField(
        // validator: state.controller?.basicValidator.getValidation('name'),
        // controller: state.controller?.basicValidator.getController('name'),
        keyboardType: TextInputType.text,
        controller: editingControllerLectureVideoLink,
        enabled: enableEdit,
        decoration: InputDecoration(
          labelText: 'Link or youtube',
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.user,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: Visibility(
            visible: enableLectureLink,
            child: IconButton(
              icon: Icon(Icons.upload_file),
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg']);
                MultipartFile file = MultipartFile.fromBytes(
                    result!.files.first.bytes!.toList(growable: true),
                    filename: result.names[0]);
                setState(() {
                  // state.controller?.basicValidator.getController('image')?.text = result.files.first.name ?? "";
                });
                // BlocProvider.of<LessonDetailBloc>(context).add(AddCourseUploadImageEvent(uploadFileInfo: UploadFileInfo(data: SubjectType.courses, file: file)));
              },
            ),
          ),
        ),
      ),
    );
  }

  bool enableDocumentsLink = false;
  Widget buildLectureDocuments({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: L10nX.getStr.document_str,
      isRequirement: true,
      enableAttachFile: true,
      onCheckChanged: (bool value) {
        setState(() {
          enableDocumentsLink = value;
        });
      },
      // titleStyle: ,
      child: TextFormField(
        // validator: state.controller?.basicValidator.getValidation('name'),
        // controller: state.controller?.basicValidator.getController('name'),
        keyboardType: TextInputType.text,
        enabled: enableEdit,
        controller: editingControllerLectureDocuments,
        decoration: InputDecoration(
          labelText: L10nX.getStr.document_str,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.user,
            size: 20,
            color: ColorConst.colorIconRed,
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: Visibility(
            visible: enableDocumentsLink,
            child: IconButton(
              icon: Icon(Icons.cloud_upload_rounded, color: ColorConst.mainColor,),
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: [
                      'pdf', 'word', 'pptx', 'pptm', 'pdf', 'xps', 'potx', 'potm', 'xml','xlsx','xlsx', 'xlsb', 'xls', 'xls', 'xlt' ]);
                if(result!=null)
                  {
                    MultipartFile file = MultipartFile.fromBytes(result.files.first.bytes!.toList(growable: true), filename: result.names[0]);
                    editingControllerLectureDocuments.text = file.filename??"";
                    BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailUploadDocumentEvent(
                        docInfo: UploadFileInfo(data: SubjectType.lectures, file: file)));
                  }

              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLectureMode({required BuildContext context}) {
    return ModeOptionWidget(mode: '',
      onModeChanged: (String? value)
      {
        mode = value??"FREE";
      },
      onPaymentChanged: (int? price)
      {
        price = price;
      },
    );
  }
  Widget buildLectureWords({required BuildContext context, required LessonDetailState state}) {
    return WidgetWithColumnTitleCommon(
      title: L10nX.getStr.vocabulary_str,
      isRequirement: true,
      child: SearchWordDropDown(
        exitsWords: state.listOfWord??[],
        allWords: [],
        onAddWords: (tags) {
          state.listOfWord!.add(tags);
           BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailUpdateWordsEvent(listOfWord: state.listOfWord??[]));
        },
        onRemoveWords: (tags) {
           (state.listOfWord??[]).removeWhere((element) => element.id == tags.id,);
           BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailUpdateWordsEvent(listOfWord: state.listOfWord??[]));
        },
      ),
    );
  }

}

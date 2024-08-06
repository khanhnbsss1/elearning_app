import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker/src/file_picker_result.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/views/course/create_edit_course/bloc/add_course_bloc.dart';
import 'package:webkit/views/course/create_edit_course/components/course_mode.dart';
import 'package:webkit/views/course/create_edit_course/components/tag_drop_down.dart';
import '../../../../base/theme/colors_app.dart';
import '../../../../base/widgets/common/responsive_info.dart';
import '../../../../base/widgets/widget_common/widget_with_title_common.dart';
import '../../../../helpers/widgets/my_spacing.dart';
import '../../../../helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';

class CreateEditLesson extends StatefulWidget {
  final CourseInfo? courseInfo;

  const CreateEditLesson({super.key, required this.courseInfo});

  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * (ResponsiveInfo.isTablet() ? 0.4 : 0.9),
                height: MediaQuery
                    .of(context)
                    .size
                    .height * (ResponsiveInfo.isTablet() ? 0.8 : 0.9),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
        centerTitle: true,
      ),
      body: lectureDetail(),
    );
  }

  MultipartFile? selectedImage;
  final ImagePicker imagePicker = ImagePicker();

  Widget lectureDetail() {
    return BlocProvider(
      create: (context) {
        return AddCourseBloc(AddCourseState(courseInfo: widget.courseInfo,))
          ..add(AddCourseInitEvent());
      },
      child: BlocConsumer<AddCourseBloc, AddCourseState>(
        listener: (context, state) {
          switch (state.blocStatus) {
            case AddCourseStatus.initial:
              break;
            default:
              break;
          }
          state.blocStatus = AddCourseStatus.unKnown;
        },
        builder: (BuildContext context, state) {
          return Material(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildLectureName(context: context),
                        MySpacing.height(16),
                        buildLectureLink(context: context),
                        MySpacing.height(16),
                        buildLecture(context: context),
                        MySpacing.height(16),
                        buildLectureDocuments(context: context),
                        MySpacing.height(16),
                        buildLectureMode(context: context),
                        MySpacing.height(16),
                        buildLectureWords(context: context),
                        MySpacing.height(16),
                        ActionButton1(
                          text: 'submit',
                        ),
                        MySpacing.height(16),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildLectureName({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: 'Lecture name',
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        // validator: state.controller?.basicValidator.getValidation('name'),
        // controller: state.controller?.basicValidator.getController('name'),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Lecture name',
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

  Widget buildLectureLink({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: 'Subject',
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        // validator: state.controller?.basicValidator.getValidation('name'),
        // controller: state.controller?.basicValidator.getController('name'),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Subject',
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
  Widget buildLecture({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: 'Lecture',
      isRequirement: true,
      enableAttachFile: true,
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
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['png', 'jpg']);
                MultipartFile file = MultipartFile.fromBytes(
                    result!.files.first.bytes!.toList(growable: true),
                    filename: result.names[0]);
                setState(() {
                  // state.controller?.basicValidator.getController('image')?.text = result.files.first.name ?? "";
                });
                // BlocProvider.of<AddCourseBloc>(context).add(AddCourseUploadImageEvent(uploadFileInfo: UploadFileInfo(data: SubjectType.courses, file: file)));
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
      title: 'Documents',
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
        decoration: InputDecoration(
          labelText: 'Name',
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
              icon: Icon(Icons.upload_file),
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['png', 'jpg']);
                MultipartFile file = MultipartFile.fromBytes(
                    result!.files.first.bytes!.toList(growable: true),
                    filename: result.names[0]);
                setState(() {
                  // state.controller?.basicValidator.getController('image')?.text = result.files.first.name ?? "";
                });
                // BlocProvider.of<AddCourseBloc>(context).add(AddCourseUploadImageEvent(uploadFileInfo: UploadFileInfo(data: SubjectType.courses, file: file)));
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
      },
      onPaymentChanged: (int? price)
      {

      },
    );
  }
  List<TagsInfo>listOfTags = [TagsInfo(id: 1,name: '1'
  ),];
  Widget buildLectureWords({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: 'Lecture name',
      isRequirement: true,
      child: TagDropDown(
        // allTags: state.controller!.listOfTags,
        allTags: listOfTags,
        onAddTags: (tags) {
          // (state.courseInfo?.tags??[]).add(tags);
          listOfTags.add(TagsInfo(id: 2, name: '2'));
          // BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateControllerEvent(addCourseController: state.controller!));
        },
        // exitsTags: state.courseInfo?.tags,
        onRemoveTags: (tags) {
          // (state.courseInfo?.tags??[]).removeWhere((element) => element.name == tags,);
          // BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateCourseInfoEvent(courseInfo: state.courseInfo!));
        },
      ),
    );
  }
}

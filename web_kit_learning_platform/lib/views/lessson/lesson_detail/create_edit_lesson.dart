import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker/src/file_picker_result.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/views/course/create_edit_course/bloc/add_course_bloc.dart';
import 'package:webkit/views/course/create_edit_course/components/course_mode.dart';
import 'package:webkit/views/course/create_edit_course/components/tag_drop_down.dart';
import '../../../base/theme/colors_app.dart';
import '../../../base/widgets/common/responsive_info.dart';
import '../../../base/widgets/widget_common/widget_with_title_common.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';

import 'lesson_detail_bloc/lesson_detail_bloc.dart';

class CreateEditLesson extends StatefulWidget {

   LessonInfo? lessonInfo;
   CreateEditLesson({super.key, this.lessonInfo});

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
  final TextEditingController _wordDropdownSearchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.size20))
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Scaffold(
            appBar: AppBar(
              title: Text(L10nX.getStr.create_lesson_str, style: TextStyleConstant.textStyleBlack20w700,),
              centerTitle: true,
            ),
            body: Container(
              
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: ColorConst.dividerColor, width: 1)),
                color: ColorConst.whiteColor
              ), 
                child: lectureDetail()),
          ),
        ),
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
                            buildLecture(context: context),
                            MySpacing.height(16),
                            buildLectureLink(context: context),
                            MySpacing.height(16),
                            buildLectureDocuments(context: context),
                            MySpacing.height(16),
                            buildLectureMode(context: context),
                            MySpacing.height(16),
                            buildLectureWords(context: context),
                            MySpacing.height(16),
                          ],
                        ),
                      ),
                    ),
                    ActionButton1(
                      text: L10nX.getStr.create_lesson_str,
                      width: Dimens.size150,
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

  Widget buildLecture({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: L10nX.getStr.description,
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        // validator: state.controller?.basicValidator.getValidation('name'),
        // controller: state.controller?.basicValidator.getController('name'),
        keyboardType: TextInputType.text,
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
  Widget buildLectureLink({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: L10nX.getStr.lecture_link_str,
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
  List<TagsInfo>listOfTags = [
    TagsInfo(id: 1,name: '1'
  ),];
  Widget buildLectureWords({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: L10nX.getStr.lecture_name_str,
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
  Widget wordsDropDownSearch({Function(LessonInfo)? onSelectLesson, required AddCourseState state, required BuildContext context}) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: Dimens.size300,
            child: StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
                return DropDownSearchFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
                    controller: _wordDropdownSearchFieldController,
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontStyle: FontStyle.italic
                    ),

                    decoration: InputDecoration(
                      labelText: L10nX.getStr.search_lesson_str,
                      hintTextDirection: AppTheme.textDirection,
                      labelStyle: TextStyleConstant.textStyleBlack14w400,
                      hintStyle: TextStyleConstant.textStyleBlack14w400,
                      border: outlineInputBorder,
                      prefixIcon: Icon(
                        Icons.edit_document,
                        size: 20,
                        color: ColorConst.colorIconRed,
                      ),
                      suffixIcon: Icon(
                        LucideIcons.search,
                        size: 20,
                        color: ColorConst.colorIconRed,
                      ),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),

                  suggestionsCallback: (pattern) async {
                    return await getLessonFilterList(pattern);
                  },

                  itemBuilder: (context, suggestion) {
                    return OnHoverWidget(
                      builder: (bool isHovered) {
                        return  Container(
                          decoration: BoxDecoration(
                              color: isHovered?ColorConst.mainColor.withOpacity(0.05):ColorConst.whiteColor,
                              border: Border(
                                  bottom: BorderSide(color: ColorConst.dividerColor)
                              )
                          ),
                          child: ListTile(
                            leading: Icon(Icons.edit_document),
                            title: Text(suggestion.lectureName??""),
                          ),
                        );
                      },
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    if((BlocProvider.of<AddCourseBloc>(context).state.currentSubject??'').isEmpty)
                    {
                      ToastUtils.showToastError(L10nX.getStr.please_choose_a_subject);
                      return;
                    }
                    if(onSelectLesson!=null)
                    {
                      _wordDropdownSearchFieldController.text = suggestion.lectureName??"";
                      onSelectLesson(suggestion);
                    }
                    else
                    {
                      ToastUtils.showToastError(L10nX.getStr.unknown_str);
                    }
                    print("object");
                  },
                  transitionBuilder: (context, child, controller) {
                    return Container(
                      constraints: BoxConstraints(
                          maxHeight: Dimens.size300
                      ),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: ColorConst.whiteColor,
                          borderRadius: BorderRadius.circular(Dimens.size10)
                      ),
                      padding: EdgeInsets.all(Dimens.size8),
                      child: child,
                    );
                  },
                  displayAllSuggestionWhenTap: false,
                  hideSuggestionsOnKeyboardHide: true,
                );
              },
            ),
          ),
          Gap(Dimens.size16),
          InkWell(
            onTap: () {
              CreateEditLesson().show(context);
            },
            child: Icon(Icons.add_circle, color: ColorConst.mainColor,size: Dimens.size50,),
          )
        ]
    );
  }
  Future<List<LessonInfo>>getLessonFilterList(String keyWord) async{
    if(keyWord.isEmpty) {
      return [];
    }
    GetLessonListFilterApi getLessonListApi= GetLessonListFilterApi(searchCommonRequest: SearchCommonRequest(keyword: keyWord));
    LessonListResponseModel data = await getLessonListApi.call();
    return data.content??[];
  }
}

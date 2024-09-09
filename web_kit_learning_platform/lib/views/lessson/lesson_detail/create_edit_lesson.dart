import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/instance_mananger/filter_manager.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/views/course/create_edit_course/components/course_mode.dart';
import 'package:webkit/views/lessson/components/search_test_drop_down.dart';
import 'package:webkit/views/lessson/components/search_word_drop_down.dart';
import '../../../base/widgets/widget_common/widget_with_title_common.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';

import 'lesson_detail_bloc/lesson_detail_bloc.dart';

class CreateEditLesson extends StatefulWidget {
   LessonInfo? lessonInfo;
   ActionType? lessonActionType;
   CreateEditLesson({super.key, this.lessonInfo, this.lessonActionType}){
     lessonActionType??= ActionType.create;
   }

  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          double width = MediaQuery.of(context).size.width * (ResponsiveInfo.isTablet() ? 0.6 : 0.9);
          if(width<500) {
            width = 500;
          }
          return Dialog(
            child: SizedBox(
                width: width,
                height: MediaQuery.of(context).size.height * (ResponsiveInfo.isTablet() ? 0.8 : 0.9),
                key: UniqueKey(),
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
 

  String mode = 'FREE';
  int price = 0;
  late LessonDetailState _state;
  late bool enableEdit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enableEdit = widget.lessonActionType!=ActionType.view;
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
          title: Text( widget.lessonInfo?.id!=null?L10nX.getStr.edit_lesson_str:L10nX.getStr.create_lesson_str, style: TextStyleConstant.textStyleBlack20w700.copyWith(color: ColorConst.whiteColor),),
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
        return LessonDetailBloc(LessonDetailState(lessonInfo: widget.lessonInfo, lessonActionType: widget.lessonActionType))
          ..add(LessonDetailInitEvent());
      },
      child: BlocConsumer<LessonDetailBloc, LessonDetailState>(
        listener: (context, state) {
          switch (state.blocStatus) {
            case LessonDetailStatus.initial:
              break;
            case LessonDetailStatus.onCreateLesson:
              Navigator.of(context).pop();
              break;
            default:
              break;
          }
          state.blocStatus = LessonDetailStatus.unKnown;
        },
        builder: (BuildContext context, state) {
          _state= state;
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
                            buildLectureContent(context: context),
                            MySpacing.height(16),
                            buildLectureVideoLink(context: context, state: state),
                            MySpacing.height(16),
                            buildLectureDocuments(context: context),
                            MySpacing.height(16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: buildLectureMode(context: context, state: state)),
                              ],
                            ),
                            MySpacing.height(16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildCategory(context: context, state: state),
                                Gap(Dimens.size20),
                                buildGrade(context: context, state: state),
                              ],
                            ),
                            MySpacing.height(16),
                            buildLectureWords(context: context, state: state),
                            MySpacing.height(16),
                            buildLectureTest(context: context, state: state),
                            MySpacing.height(50),
                          ],
                        ),
                      ),
                    ),
                    Divider(color: ColorConst.dividerColor.withOpacity(0.3),),
                    Visibility(
                      visible: widget.lessonActionType == ActionType.create || widget.lessonActionType == ActionType.edit,
                      child: ActionButton1(
                        text: widget.lessonActionType == ActionType.create?L10nX.getStr.create_lesson_str:L10nX.getStr.str_update,
                        width: Dimens.size150,
                        onTap: () {
                          state.lessonInfo??= LessonInfo();
                          state.lessonInfo?.lectureName = state.editingControllerLectureName?.text;
                          state.lessonInfo?.note = state.editingControllerLectureDescription?.text;
                          state.lessonInfo?.content = state.editingControllerLectureContent?.text;
                         // state.lessonInfo?.link = state.editingControllerLectureVideoLink?.text;
                          state.lessonInfo?.docName = state.editingControllerLectureName?.text;
                          state.lessonInfo?.mode = mode;
                          switch(widget.lessonActionType){
                            case ActionType.view:
                              // TODO: Handle this case.
                              break;
                            case ActionType.edit:
                              // TODO: Handle this case.
                                {
                                  BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailUpdateLessonEvent(lessonInfo: state.lessonInfo!));
                                }
                              break;
                            case ActionType.create:
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
                    ),
                    Visibility(
                      visible: widget.lessonActionType == ActionType.view ,
                      child: ActionButton1(
                        text: L10nX.getStr.close,
                        width: Dimens.size150,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
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
        controller: _state.editingControllerLectureName,
        enabled: enableEdit,
        decoration: InputDecoration(
          labelText: L10nX.getStr.lecture_name_str,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            Icons.title,
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
        controller: _state.editingControllerLectureDescription,
        decoration: InputDecoration(
          labelText: L10nX.getStr.description,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            Icons.note_alt_outlined,
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

  bool enableLectureContent = false;
  Widget buildLectureContent({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: L10nX.getStr.content_str,
      isRequirement: true,
      // titleStyle: ,
      enableAttachFile: true,
      onCheckChanged: (bool value) {
        setState(() {
          enableLectureContent = value;
        });
      },
      child: TextFormField(
        keyboardType: TextInputType.url,
        enabled: enableEdit,
        controller: _state.editingControllerLectureContent,
        minLines: 1,
        maxLines: 1,
        readOnly: true,
        decoration: InputDecoration(
          labelText: L10nX.getStr.content_str,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          alignLabelWithHint: true,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: Visibility(
            visible: enableLectureContent,
            child: IconButton(
              icon: Icon(Icons.cloud_upload_rounded, color: ColorConst.mainColor,),
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['pdf']);
                if(result!=null)
                {
                  MultipartFile file = MultipartFile.fromBytes(result.files.first.bytes!.toList(growable: true), filename: result.names[0]);
                  _state.editingControllerLectureContent?.text = file.filename??"";
                  BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailUploadContentDocEvent(
                      docInfo: UploadFileInfo(data: SubjectType.documents, file: file)));
                }

              },
            ),
          ),
        ),
      ),
    );
  }

  bool enableLectureLink = false;
  Widget buildLectureVideoLink({required BuildContext context, required LessonDetailState state}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      titleWidget: Row(
        children: [
          Text(L10nX.getStr.youtube_link,style: TextStyleConstant.textStyleBlack14w600,),
          Gap(Dimens.size8),
          Center(
            child: InkWell(
              onTap: () {
                BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailOnAddVideoInfoEvent());
              },
              child: Icon(Icons.add_circle, color: ColorConst.mainColor,size: Dimens.size20,),
            ),
          )
        ],
      ),
      isRequirement: true,
      enableAttachFile: false,
      enable: enableEdit,
      onCheckChanged: (bool value){
        setState(() {
          enableLectureLink = value;
        });
      },
      // titleStyle: ,
      child: buildVideoList(state: state , context: context),
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
        controller: _state.editingControllerLectureDocuments,
        decoration: InputDecoration(
          labelText: L10nX.getStr.document_str,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          prefixIcon: Icon(
            LucideIcons.link,
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
                    _state.editingControllerLectureDocuments?.text = file.filename??"";
                    BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailUploadDocumentEvent(
                        docInfo: UploadFileInfo(data: SubjectType.documents, file: file)));
                  }

              },
            ),
          ),
        ),
      ),
    );
  }
  Widget buildLectureMode({required BuildContext context, required LessonDetailState state}) {
    return ModeOptionWidget(mode: '',
      onModeChanged: (String? value)
      {
        state.lessonInfo?.mode = value??"FREE";
        BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailChangeLessonEvent(lessonInfo: state.lessonInfo!));
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
        enableEdit: state.lessonActionType != ActionType.view,
        exitsWords: state.listOfWord??[],
        allWords: const [],
        onAddWords: (tags) {
          state.listOfWordAdd!.add(tags);
          state.listOfWord!.add(tags);
          if((state.listOfWordRemove??[]).where((element) => element.id == tags.id).isNotEmpty)
            {
              (state.listOfWordRemove??[]).removeWhere((element) => element.id == tags.id,);
            }
           BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailUpdateWordsEvent(
               listOfWord: state.listOfWord??[], 
               listOfWordAdd: state.listOfWordAdd,
             listOfWordRemove: state.listOfWordRemove
           ));
        },
        onRemoveWords: (tags) {
           (state.listOfWord??[]).removeWhere((element) => element.id == tags.id,);
           (state.listOfWordRemove??[]).add(tags);
           if((state.listOfWordAdd??[]).where((element) => element.id == tags.id).isNotEmpty)
           {
             (state.listOfWordAdd??[]).removeWhere((element) => element.id == tags.id,);
           }
           BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailUpdateWordsEvent(
               listOfWord: state.listOfWord??[],
               listOfWordAdd: state.listOfWordAdd,
               listOfWordRemove: state.listOfWordRemove
           ));
        },
      ),
    );
  }
  Widget buildLectureTest({required BuildContext context, required LessonDetailState state}) {
    return WidgetWithColumnTitleCommon(
      title: L10nX.getStr.test_str,
      isRequirement: true,
      child: SearchTestDropDown(
        enableEdit: state.lessonActionType != ActionType.view,
        testInfo: state.testInfo,
        onSelectTest: (testInfo) {
          BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailUpdateTestInfoEvent(testInfo: testInfo));
        },
      ),
    );
  }
  Widget buildCategory({required BuildContext context, required LessonDetailState state}){
    return FilterManager().buildCategory(
        context: context,
      enable: state.lessonActionType != ActionType.view,
      onChanged: (p0) {
        state.lessonInfo?.categoryId = p0?.id;
        //state.valueListenable?.value = value;
        BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailChangeLessonEvent(lessonInfo: state.lessonInfo!));
      },
      inputCategoryId: state.lessonInfo?.categoryId,
    );
  }
  Widget buildGrade({required BuildContext context, required LessonDetailState state}){
    return FilterManager().buildGrade(
        context: context,
      onChanged: (p0) {
        state.lessonInfo?.gradeId = p0?.id;
        BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailChangeLessonEvent(lessonInfo: state.lessonInfo!));

      },
      enable: state.lessonActionType != ActionType.view,
      inputGradeId: state.lessonInfo?.gradeId
    );
  }
  
  Widget buildVideoList({required BuildContext context, required LessonDetailState state}){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.size16),
        border: Border.all(color: ColorConst.colorIconGrays, width: 0.2)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: (state.lessonInfo?.videoInfos?.link??[]).length,
            itemBuilder: (context, index) {
              VideoInfo videoInfo = (state.lessonInfo?.videoInfos?.link??[]).elementAt(index);
              return LessonVideoItem(
                videoInfo: videoInfo, 
                onchangeVideoInfo: (p0) {
                  BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailOnUpdateVideoInfoEvent(videoInfo: p0));
                },
                enableEdit: state.lessonActionType != ActionType.view,
                onRemove: (p0) {
                  BlocProvider.of<LessonDetailBloc>(context).add(LessonDetailOnRemoveVideoInfoEvent(videoInfo: p0));
                },
              );
            },),
        ],
      )
    );
  }
}

class LessonVideoItem extends StatefulWidget{
  VideoInfo videoInfo;
  Function(VideoInfo)? onchangeVideoInfo, onRemove;
  bool? enableEdit;
  LessonVideoItem({required this.videoInfo, this.onchangeVideoInfo, this.enableEdit, this.onRemove});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LessonVideoItemState();
  }

  
}
class LessonVideoItemState extends State<LessonVideoItem> with UIMixin{
  FocusNode focusNodeTitle = FocusNode();
  FocusNode focusNodeLink = FocusNode();
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerLink = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerTitle.text = widget.videoInfo.videoTitle??"";
    controllerLink.text = widget.videoInfo.videoLink??"";

    focusNodeTitle.addListener(() {
      if(focusNodeTitle.hasFocus)
        {
          if(widget.onchangeVideoInfo!=null)
          {
            widget.onchangeVideoInfo!(widget.videoInfo);
          }
        }
    },);
    focusNodeLink.addListener(() {
      if(focusNodeLink.hasFocus)
      {
        if(widget.onchangeVideoInfo!=null)
        {
          widget.onchangeVideoInfo!(widget.videoInfo);
        }
      }
    },);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    controllerTitle.text = widget.videoInfo.videoTitle??"";
    controllerLink.text = widget.videoInfo.videoLink??"";
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.text,
              focusNode: focusNodeTitle,
              enabled:widget.enableEdit,
              controller: controllerTitle,
              onChanged: (value) {
                widget.videoInfo.videoTitle = value;
                if(widget.onchangeVideoInfo!=null)
                {
                  widget.onchangeVideoInfo!(widget.videoInfo);
                }
              },
              decoration: InputDecoration(
                labelText: L10nX.getStr.title_str,
                labelStyle: MyTextStyle.bodySmall(xMuted: true),
                border: outlineInputBorder,
                prefixIcon: Icon(
                  Icons.tag,
                  size: Dimens.size15,
                  color: ColorConst.colorIconRed,
                ),
                contentPadding: MySpacing.all(16),
                isCollapsed: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),),
          Gap(Dimens.size20),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.url,
              focusNode: focusNodeLink,
              controller: controllerLink,
              enabled: widget.enableEdit,
              onChanged: (value) {
                widget.videoInfo.videoLink = value;
                if(widget.onchangeVideoInfo!=null)
                {
                  widget.onchangeVideoInfo!(widget.videoInfo);
                }
              },
              decoration: InputDecoration(
                labelText: L10nX.getStr.video_link,
                labelStyle: MyTextStyle.bodySmall(xMuted: true),
                border: outlineInputBorder,
                prefixIcon: Icon(
                  LucideIcons.link,
                  size: Dimens.size15,
                  color: ColorConst.colorIconRed,
                ),
                contentPadding: MySpacing.all(16),
                isCollapsed: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),),
          IconButton(onPressed: () {
            if(widget.onRemove!=null)
              {
                widget.onRemove!(widget.videoInfo);
              }
          }, icon: Icon(
            Icons.delete_forever,
            color: ColorConst.mainColor,))
        ],
      ),
    );
  }
}
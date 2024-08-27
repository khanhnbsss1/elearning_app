import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webkit/base/instance_mananger/filter_manager.dart';
import 'package:webkit/base/widgets/audio/audio_speaker.dart';
import 'package:webkit/base/widgets/widget_common/widget_with_title_common.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/sentence/models/sentence_info.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/views/course/create_edit_course/bloc/add_course_bloc.dart';
import 'package:webkit/views/vocabulary/components/example_form.dart';
import '../../../helpers/utils/ui_mixins.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../../landing_page/components/colornotifier.dart';
import 'bloc/create_edit_word_bloc.dart';

enum WordsPageActionType {
  view,
  edit,
  create,
}

class CreateEditWordsPage extends StatefulWidget {
  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            key: UniqueKey(),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * (ResponsiveInfo.isTablet() ? 0.6 : 0.9), 
                height: MediaQuery.of(context).size.height * (ResponsiveInfo.isTablet() ? 0.7 : 0.8),
                child: this),
          );
        });
  }

  CreateEditWordsPage({super.key,this.vocabularyInfo, this.wordsPageActionType, this.onCreated}) {
    wordsPageActionType ??= WordsPageActionType.create;
  }
  VocabularyInfo? vocabularyInfo;
  WordsPageActionType? wordsPageActionType;
  Function()?onCreated;
  @override
  State<CreateEditWordsPage> createState() => _CreateEditWordsPageState();
}

class _CreateEditWordsPageState extends State<CreateEditWordsPage> with SingleTickerProviderStateMixin, UIMixin {
  @override
  void initState() {
    super.initState();
  }
  
  late CreateEditWordState _state;
  late ColorNotifier notifier;
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return BlocProvider(
        create: (context) {
          return CreateEditWordBloc(CreateEditWordState(
            vocabularyInfo: widget.vocabularyInfo,
            wordsPageActionType: widget.wordsPageActionType
          ))..add(CreateEditWordInitEvent());
        },
        child: BlocConsumer<CreateEditWordBloc, CreateEditWordState>(listener: (context, state) {
          switch (state.blocStatus) {
            case CreateEditWordStatus.initial:
              break;
            case CreateEditWordStatus.onUploadAudio:
              // TODO: Handle this case.
              break;
            case CreateEditWordStatus.onUploadImage:
              // TODO: Handle this case.
            break;
            case CreateEditWordStatus.onSubmit:
              // TODO: Handle this case.
            if(widget.onCreated!=null)
              {
                widget.onCreated!();
              }
              Navigator.of(context).pop(true);
              break;
            case CreateEditWordStatus.onLoading:
              // TODO: Handle this case.
              break;
            case CreateEditWordStatus.onError:
              // TODO: Handle this case.
              break;
            case CreateEditWordStatus.onSaveSentence:
              // TODO: Handle this case.
              break;
            default:
              break;
          }
        }, 
            builder: (BuildContext context, state) {
          _state = state;
          bool enable = widget.wordsPageActionType != WordsPageActionType.view;
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimens.size20)),
            clipBehavior: Clip.hardEdge,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  L10nX.getStr.new_word_str,
                  style: TextStyleConstant.textStyleBlack20w700.copyWith(color: ColorConst.whiteColor),
                ),
                backgroundColor: ColorConst.mainColor,
                iconTheme: IconThemeData(color: ColorConst.whiteColor),
                titleTextStyle: TextStyleConstant.textStyleBlack20w700,
                centerTitle: true,
              ),
              body: MyResponsive(builder: (context, constraints, myScreenMediaType) {
                double maxWidthItem = 250;
                double heightOfItem = myScreenMediaType.isMobile? 60:100;
                int numberRow = (constraints.maxWidth / maxWidthItem).toInt();
                double widthItem = (constraints.maxWidth - (50 * numberRow)) / numberRow;
                return Padding(
                  padding: EdgeInsets.all(Dimens.size24),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          controller: controller,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GridView.count(
                                crossAxisCount: numberRow,
                                crossAxisSpacing: 24,
                                childAspectRatio: (widthItem) / (heightOfItem) - 0.05,
                                mainAxisSpacing: 24,
                                shrinkWrap: true,
                                children: [
                                  customTextFormField1(
                                      controller: 'traditional',
                                      enable: enable,
                                      myScreenMediaType: myScreenMediaType,
                                      label: L10nX.getStr.vocabulary_str,
                                      constraints: constraints),
                                  customTextFormField1(
                                      controller: 'simplified',
                                      enable: enable,
                                      myScreenMediaType: myScreenMediaType, 
                                      label: L10nX.getStr.simplified_str, 
                                      constraints: constraints),
                                  customTextFormField1(
                                      controller: 'translation_vn',
                                      enable: enable,
                                      myScreenMediaType: myScreenMediaType, 
                                      label: L10nX.getStr.meaning_str, 
                                      constraints: constraints),
                                  customTextFormField1(
                                      controller: 'pinyin_tones',
                                      enable: enable,
                                      myScreenMediaType: myScreenMediaType,
                                      label: L10nX.getStr.pinyin_tone_str,
                                      constraints: constraints),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: customTextFormField1(
                                      controller: 'audio',
                                      constraints: constraints,
                                      myScreenMediaType: myScreenMediaType,
                                      enable: enable,
                                      label: L10nX.getStr.sound_str,
                                      isLink: true,
                                      onUpload: () async {
                                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['wav', 'mp3'],
                                        );
                                        dio.MultipartFile file = dio.MultipartFile.fromBytes(result!.files.first.bytes!.toList(growable: true), filename: result.names[0]);
                                        BlocProvider.of<CreateEditWordBloc>(context)
                                            .add(CreateEditWordUploadAudioEvent(data: UploadFileInfo(data: SubjectType.vocabulary, fileName: result.files.first.name, file: file)));
                                      },
                                    ),
                                  ),
                                  Gap(Dimens.size12),
                                  FilterManager().buildGrade(
                                      context: context,
                                    inputGradeId: state.vocabularyInfo?.gradeId,
                                    enable: true,
                                    onChanged: (p0) {
                                      state.vocabularyInfo!.gradeId = p0?.id;
                                      BlocProvider.of<CreateEditWordBloc>(context).add(CreateEditWordOnUpdateVocabularyInfoEvent(vocabularyInfo: state.vocabularyInfo!));
                                    },
                                    
                                  )
                                ],
                              ),
                              Gap(Dimens.size16),
                              Row(
                                children: [
                                  Expanded(
                                    child: customTextFormField1(
                                      controller: 'image',
                                      constraints: constraints,
                                      enable: enable,
                                      myScreenMediaType: myScreenMediaType,
                                      label: L10nX.getStr.image_str,
                                      isLink: true,
                                      onUpload: () async {
                                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['png', 'jpg'],
                                        );
                                        dio.MultipartFile file = dio.MultipartFile.fromBytes(result!.files.first.bytes!.toList(growable: true), filename: result.names[0]);
                                        BlocProvider.of<CreateEditWordBloc>(context)
                                            .add(CreateEditWordUploadImageEvent(data: UploadFileInfo(data: SubjectType.vocabulary, fileName: result.files.first.name, file: file)));
                                      },
                                    ),
                                  ),
                                  Gap(Dimens.size12),
                                  SizedBox(
                                    width: Dimens.size200,
                                    child: customTextFormField1(
                                      controller: 'category',
                                      constraints: constraints,
                                      enable: enable,
                                      myScreenMediaType: myScreenMediaType,
                                      label: L10nX.getStr.category_word,
                                      isLink: false,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(Dimens.size16),
                              // box thêm ví dụ mới
                              buildExamplesListForEdit(myScreenMediaType: myScreenMediaType, context: context, state: state),
                              buildExamplesListForView(myScreenMediaType: myScreenMediaType, context: context, state: state),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                            child: Stack(
                              children:[
                                Visibility(
                                  visible: widget.wordsPageActionType != WordsPageActionType.view,
                                  child: ActionButton1(
                                    text:(widget.wordsPageActionType ==
                                        WordsPageActionType.edit && state.vocabularyInfo?.id!=null)?L10nX.getStr.str_update: 
                                    L10nX.getStr.create_str,
                                    width: Dimens.size120,
                                    onTap: () {
                                      switch(widget.wordsPageActionType){
                                        
                                        case null:
                                          // TODO: Handle this case.
                                        case WordsPageActionType.view:
                                          // TODO: Handle this case.
                                          break;
                                        case WordsPageActionType.edit:
                                          // TODO: Handle this case.
                                          BlocProvider.of<CreateEditWordBloc>(context).add(CreateEditWordUpdateWordEvent(state: _state));

                                          break;
                                        case WordsPageActionType.create:
                                          // TODO: Handle this case.
                                          BlocProvider.of<CreateEditWordBloc>(context).add(CreateEditWordCreateWordEvent(state: _state));
                                          break;
                                      }
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: widget.wordsPageActionType == WordsPageActionType.view,
                                  child: ActionButton1(
                                    text:L10nX.getStr.close,
                                    width: Dimens.size120,
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ] 
                            )),
                      ),
                    ],
                  ),
                );
              }),
            ),
          );
        }));
  }

  Widget buildExamplesListForEdit({required MyScreenMediaType myScreenMediaType, required BuildContext context, required CreateEditWordState state}) {
    return Visibility(
      visible: widget.wordsPageActionType == WordsPageActionType.create || widget.wordsPageActionType== WordsPageActionType.edit,
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all(color: ColorConst.blackColor, width: 0.5), borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: controller,
                child: Column(
                  children: [
                    Center(
                      child: Text(L10nX.getStr.add_examples_str),
                    ),
                    ListView.builder(
                      itemCount:(_state.vocabularyInfo?.sentenceInfos??[]).length,
                      shrinkWrap: true,
                      controller: controller,
                      itemBuilder: (context, exampleIndex) {
                        return ExampleFrom(
                          index: exampleIndex,
                          controller: controller,
                          sentenceInfo:_state.vocabularyInfo?.sentenceInfos?.elementAt(exampleIndex),
                          onRemoveSentenceInfo: (p0) {
                            BlocProvider.of<CreateEditWordBloc>(context).add(CreateEditWordOnRemoveSentenceEvent(sentenceInfo: p0));
                          },
                          onSaveSentenceInfo: (p0) {
                            BlocProvider.of<CreateEditWordBloc>(context).add(CreateEditWordOnSaveSentenceEvent(sentenceInfo: p0));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              // nút thêm ví dụ mới
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<CreateEditWordBloc>(context).add(CreateEditWordOnAddNewSentenceEvent());
                    },
                    child: Icon(
                      Icons.add_circle_outline,
                      color: ColorConst.mainColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildExamplesListForView({required MyScreenMediaType myScreenMediaType, required BuildContext context, required CreateEditWordState state}) {
    return Visibility(
      visible: widget.wordsPageActionType == WordsPageActionType.view,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetWithColumnTitleCommon(
                    title: L10nX.getStr.examples_str,
                    child: (_state.vocabularyInfo?.sentenceInfos??[]).isNotEmpty?ListView.builder(
                      itemCount:(_state.vocabularyInfo?.sentenceInfos??[]).length,
                      shrinkWrap: true,
                      itemBuilder: (context, exampleIndex) {
                        SentenceInfo sentenceInfo = (_state.vocabularyInfo?.sentenceInfos??[]).elementAt(exampleIndex);
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                           // Text('${sentenceInfo.chineseSentence??''}(${sentenceInfo.pinyionSentence??''})'),
                            Text('没有例子 (${'"没有例子"'})'),
                            AudioSpeaker(url: sentenceInfo.audioLink??'')
                          ],);
                      },
                    ):Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(L10nX.getStr.has_not_example, style: TextStyleConstant.textStyleBlack13w300,)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget customTextFormField1(
      {required String controller,
      required String label,
      double? width,
      bool isLink = false, 
      bool? enable,
      Function()? onUpload,
      required BoxConstraints constraints,
      required MyScreenMediaType myScreenMediaType}) {
    return myScreenMediaType.isMobile
        ? Row(
          children: [
            Expanded(
                child: TextFormField(
                validator: _state.addWordController?.basicValidator.getValidation(controller),
                controller: _state.addWordController?.basicValidator.getController(controller),
                readOnly: !(enable??true),
                decoration: InputDecoration(
                  enabledBorder: isLink ? InputBorder.none : null,
                  focusedBorder: isLink ? InputBorder.none : null,
                  labelText: label,
                  labelStyle: MyTextStyle.bodySmall(xMuted: true),
                  border: outlineInputBorder.copyWith(
                    borderRadius: BorderRadius.circular(Dimens.size16),
                  ),
                  contentPadding: MySpacing.all(16),
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon:  Visibility(
                      visible: (enable??true) && isLink,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          style: TextButton.styleFrom(backgroundColor: notifier.whitecolor, foregroundColor: Colors.white),
                          onPressed: () async {
                            if (onUpload != null) {
                              onUpload();
                            }
                          },
                          icon: Icon(
                            Icons.cloud_upload_rounded,
                            size: 14,
                            color: ColorConst.mainColor,
                          ),
                        ),
                      ),
                    ),
                  suffixIcon: Visibility(
                    visible: (enable??true) &&  (_state.addWordController?.basicValidator.getController(controller)?.text != ""),
                    child: IconButton(
                            onPressed: () {
                              setState(() {
                                _state.addWordController?.basicValidator.getController(controller)?.text = "";
                              });
                            },
                            icon: Icon(
                              Icons.close_sharp,
                              color: Colors.red,
                            ),
                          ),
                      )
                ),
              )),
          ],
        )
        : Container(
            constraints: BoxConstraints(minWidth: Dimens.size150),
            width: (width ?? constraints.maxWidth - (16 * 2 - 20 * 3)) / 5,
            child: WidgetWithColumnTitleCommon(
              title: label,
              isRequirement: true,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: _state.addWordController?.basicValidator.getValidation(controller),
                      controller: _state.addWordController?.basicValidator.getController(controller),
                      readOnly: !(enable??true),
                      decoration: InputDecoration(
                        labelText: label,
                        labelStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: outlineInputBorder.copyWith(
                          borderRadius: BorderRadius.circular(Dimens.size16),
                        ),
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        constraints: constraints,
                        prefixIcon:  Visibility(
                          visible: (enable??true) && isLink,
                          child: Padding(
                                  padding:  EdgeInsets.all(Dimens.size4),
                                  child: IconButton(
                                    style: TextButton.styleFrom(backgroundColor: notifier.whitecolor, foregroundColor: Colors.white),
                                    onPressed: () async {
                                      if (onUpload != null) {
                                        onUpload();
                                      }
                                    },
                                    icon: Icon(
                                      Icons.cloud_upload_rounded,
                                      size: Dimens.size12,
                                      color: ColorConst.mainColor,
                                    ),
                                  ),
                                ),
                        ),
                          
                        suffixIcon:
                            Visibility(
                              visible: (enable??true) &&  (_state.addWordController?.basicValidator.getController(controller)?.text != ""),
                              child: Padding(
                                  padding:  EdgeInsets.all(Dimens.size4),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _state.addWordController?.basicValidator.getController(controller)?.text = "";
                                      });
                                    },
                                    icon: Icon(
                                      Icons.close_sharp,
                                      size:Dimens.size12,
                                      color: ColorConst.colorIconGrays,
                                    ),
                                  ),
                                ),
                            )
    
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

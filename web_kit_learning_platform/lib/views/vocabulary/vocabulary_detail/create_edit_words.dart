import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webkit/base/widgets/widget_common/widget_with_title_common.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
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
            child: SizedBox(
                width: MediaQuery.of(context).size.width * (ResponsiveInfo.isTablet() ? 0.6 : 0.9), height: MediaQuery.of(context).size.height * (ResponsiveInfo.isTablet() ? 0.7 : 0.8), child: this),
          );
        });
  }

  CreateEditWordsPage({this.vocabularyInfo, this.wordsPageActionType}) {
    wordsPageActionType ??= WordsPageActionType.create;
  }
  VocabularyInfo? vocabularyInfo;
  WordsPageActionType? wordsPageActionType;
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

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return BlocProvider(
        create: (context) {
          return CreateEditWordBloc(CreateEditWordState(vocabularyInfo: widget.vocabularyInfo, ))..add(CreateEditWordInitEvent());
        },
        child: BlocConsumer<CreateEditWordBloc, CreateEditWordState>(listener: (context, state) {
          switch (state.blocStatus) {
            case CreateEditWordStatus.initial:
              break;
            default:
              break;
          }
        }, builder: (BuildContext context, state) {
          _state = state;
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
                double heightOfItem = 100;
                int numberRow = (constraints.maxWidth / maxWidthItem).toInt();
                double widthItem = (constraints.maxWidth - (50 * numberRow)) / numberRow;
                return Padding(
                  padding: EdgeInsets.all(Dimens.size24),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
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
                                  customTextFormField1(controller: 'traditional', myScreenMediaType: myScreenMediaType, label: L10nX.getStr.vocabulary_str, constraints: constraints),
                                  customTextFormField1(controller: 'simplified', myScreenMediaType: myScreenMediaType, label: L10nX.getStr.simplified_str, constraints: constraints),
                                  customTextFormField1(controller: 'translation_vn', myScreenMediaType: myScreenMediaType, label: L10nX.getStr.meaning_str, constraints: constraints),
                                  customTextFormField1(controller: 'pinyin_tones', myScreenMediaType: myScreenMediaType, label: L10nX.getStr.pinyin_tone_str, constraints: constraints),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: customTextFormField1(
                                      controller: 'audio',
                                      constraints: constraints,
                                      myScreenMediaType: myScreenMediaType,
                                      label: L10nX.getStr.upload_sound_file_str,
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
                                ],
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: customTextFormField1(
                                      controller: 'image',
                                      constraints: constraints,
                                      myScreenMediaType: myScreenMediaType,
                                      label: L10nX.getStr.upload_image_str,
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
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              // box thêm ví dụ mới
                              buildExamplesList(myScreenMediaType: myScreenMediaType, context: context),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                            child: ActionButton1(
                          text: L10nX.getStr.create_str,
                          width: Dimens.size120,
                          onTap: () {
                            BlocProvider.of<CreateEditWordBloc>(context).add(CreateEditWordCreateWordEvent(state: _state));
                          },
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

  Widget buildExamplesList({required MyScreenMediaType myScreenMediaType, required BuildContext context}) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: ColorConst.blackColor), borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Center(
                    child: Text(L10nX.getStr.add_examples_str),
                  ),
                  ListView.builder(
                    itemCount:(_state.vocabularyInfo?.sentenceInfos??[]).length,
                    shrinkWrap: true,
                    itemBuilder: (context, exampleIndex) {
                      return ExampleFrom(
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
    );
  }

  Widget customTextFormField1(
      {required String controller,
      required String label,
      double? width,
      bool isLink = false,
      Function()? onUpload,
      required BoxConstraints constraints,
      required MyScreenMediaType myScreenMediaType}) {
    return myScreenMediaType.isMobile
        ? Expanded(
            child: TextFormField(
            validator: _state.addWordController?.basicValidator.getValidation(controller),
            controller: _state.addWordController?.basicValidator.getController(controller),
            decoration: InputDecoration(
              enabledBorder: isLink ? InputBorder.none : null,
              focusedBorder: isLink ? InputBorder.none : null,
              labelText: label,
              labelStyle: MyTextStyle.bodySmall(xMuted: true),
              border: outlineInputBorder.copyWith(
                borderRadius: BorderRadius.circular(25),
              ),
              contentPadding: MySpacing.all(16),
              isCollapsed: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              suffixIcon: (_state.addWordController?.basicValidator.getController(controller)?.text != "" && isLink)
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _state.addWordController?.basicValidator.getController(controller)?.text = "";
                        });
                      },
                      icon: Icon(
                        Icons.close_sharp,
                        color: Colors.red,
                      ),
                    )
                  : null,
            ),
          ))
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
                      decoration: InputDecoration(
                        //enabledBorder: isLink ? InputBorder.none : null,
                        // focusedBorder: isLink ? InputBorder.none : null,
                        labelText: label,
                        labelStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: outlineInputBorder.copyWith(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: (isLink)
                            ? Padding(
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
                              )
                            : null, 
                        suffixIcon: (_state.addWordController?.basicValidator.getController(controller)?.text != "")
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _state.addWordController?.basicValidator.getController(controller)?.text = "";
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close_sharp,
                                    color: ColorConst.colorIconGrays,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

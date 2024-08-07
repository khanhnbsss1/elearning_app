import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import '../../../helpers/utils/ui_mixins.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../../landing_page/components/colornotifier.dart';
import 'bloc/create_edit_word_bloc.dart';
enum WordsPageActionType{
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
              width: MediaQuery.of(context).size.width*(ResponsiveInfo.isTablet()?0.6:0.9),
              height: MediaQuery.of(context).size.height*(ResponsiveInfo.isTablet()?0.7:0.8),
              child: this
            ),
            );
        });
  }
  CreateEditWordsPage({this.vocabularyInfo, this.wordsPageActionType}){
    wordsPageActionType??= WordsPageActionType.create;
  }
  VocabularyInfo ?vocabularyInfo;
  WordsPageActionType? wordsPageActionType;
  @override
  State<CreateEditWordsPage> createState() => _CreateEditWordsPageState();
}

class _CreateEditWordsPageState extends State<CreateEditWordsPage>
    with SingleTickerProviderStateMixin, UIMixin {

  @override
  void initState() {
    super.initState();

    savedExample.add(false);
  }

  List<ExampleForm> examples = [];

  void addExample({
    required String example,
    required String meaning,
    required String simplified,
    required String soundFile,
  }) {
    setState(() {
      examples.add(ExampleForm(
          example: example,
          meaning: meaning,
          simplified: simplified,
          soundFile: soundFile));
    });
  }

  void removeExample({required int exampleIndex}) {
    setState(() {
      examples.removeAt(exampleIndex);
      _state.exampleTextControllers?.removeAt(exampleIndex);
      _state.exampleMeaningControllers?.removeAt(exampleIndex);
      _state.exampleSimplifiedControllers?.removeAt(exampleIndex);
      _state.exampleSoundControllers?.removeAt(exampleIndex);
      savedExample.removeAt(exampleIndex);
    });
  }
  List<bool> savedExample = [];

  late CreateEditWordState _state;
  late ColorNotifier notifier;

  bool _validateExampleFields(int exampleIndex) {
    final textFormFields = [
      _state.exampleTextControllers![exampleIndex],
      _state.exampleMeaningControllers![exampleIndex],
      _state.exampleSimplifiedControllers![exampleIndex],
      _state.exampleSoundControllers![exampleIndex],
    ];

    for (var textField in textFormFields) {
      if (textField.value.text.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(L10nX.getStr.string_notify),
            content: Text(L10nX.getStr.please_fill_in_all_missing_fields_str),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context,);
                  },
                  child: Text(L10nX.getStr.ok))
            ],
          ),
        );
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return BlocProvider(
        create: (context) {
          return CreateEditWordBloc(CreateEditWordState())
            ..add(CreateEditWordInitEvent());
        },
        child: BlocConsumer<CreateEditWordBloc, CreateEditWordState>(
            listener: (context, state) {
              switch (state.blocStatus) {
                case CreateEditWordStatus.initial:
                  break;
                default:
                  break;
              }
            },
            builder: (BuildContext context, state) {
              _state = state;
              return Scaffold(
                appBar: AppBar(
                  title: Text(L10nX.getStr.new_word_str),
                  titleTextStyle: TextStyleConstant.textStyleBlack20w700,
                  centerTitle: true,
                ),
                body: MyResponsive(builder: (context, constraints, myScreenMediaType) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        // thêm từ mới
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runAlignment: WrapAlignment.center,
                            spacing: Dimens.size20,
                            runSpacing: Dimens.size20,
                            children: [
                              customTextFormField1(
                                  controller: 'traditional',
                                  label: L10nX.getStr.vocabulary_str,
                                  constraints: constraints,
                                  myScreenMediaType: myScreenMediaType
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              customTextFormField1(controller: 'simplified',myScreenMediaType: myScreenMediaType, label: L10nX.getStr.simplified_str, constraints: constraints),
                              SizedBox(
                                width: 16,
                              ),
                              customTextFormField1(controller: 'translation_vn', myScreenMediaType: myScreenMediaType,label: L10nX.getStr.meaning_str, constraints: constraints),
                              SizedBox(
                                width: 16,
                              ),
                              customTextFormField1(controller: 'pinyin_tones', myScreenMediaType: myScreenMediaType,label: L10nX.getStr.pinyin_tone_str, constraints: constraints),
                              SizedBox(
                                width: 16,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: notifier.redcolor,
                                        foregroundColor: Colors.white),
                                    onPressed: () async {
                                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['.wav','.mp3'],
                                      );
                                      dio.MultipartFile file = dio.MultipartFile.fromBytes(result!.files.first.bytes!.toList(growable: true),filename: result.names[0]);
                                      BlocProvider.of<CreateEditWordBloc>(context).add(CreateEditWordUploadAudioEvent(data: UploadFileInfo(
                                          data: SubjectType.vocabulary,
                                          fileName: result.files.first.name,
                                          file: file
                                      )));
                                    },
                                    icon: Icon(Icons.audio_file, size: 14),
                                  ),
                                  Expanded(
                                    child: customTextFormField1(
                                        controller: 'audio',constraints: constraints,
                                        myScreenMediaType: myScreenMediaType,
                                        label: L10nX.getStr.upload_sound_file_str, audio: true),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: notifier.redcolor,
                                        foregroundColor: Colors.white),
                                    onPressed: () async {
                                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['.png','.jpg'],
                                      );
                                      dio.MultipartFile file = dio.MultipartFile.fromBytes(result!.files.first.bytes!.toList(growable: true),filename: result.names[0]);
                                      BlocProvider.of<CreateEditWordBloc>(context).add(CreateEditWordUploadImageEvent(data: UploadFileInfo(
                                          data: SubjectType.vocabulary,
                                          fileName: result.files.first.name,
                                          file: file
                                      )));
                                    },
                                    icon: Icon(Icons.image, size: 14),
                                  ),
                                  Expanded(
                                    child: customTextFormField1(
                                        controller: 'image',constraints: constraints,
                                        myScreenMediaType: myScreenMediaType,
                                        label: L10nX.getStr.upload_image_str, audio: true),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        // box thêm ví dụ mới

                        buildExamplesList(myScreenMediaType: myScreenMediaType),
                        Center(
                            child: ActionButton1(
                              text: L10nX.getStr.create_str,
                              width: Dimens.size120,
                              onTap: () {
                                _state.addWordController?.onAddWord();
                              },
                            )),
                        SizedBox(height: 12,),
                      ],
                    ),
                  );
                }),
              );
            }));
  }
  
  
  Widget buildExamplesList({required MyScreenMediaType myScreenMediaType}){
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: ColorConst.blackColor),
            borderRadius: BorderRadius.circular(10)),
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
                    itemCount: _state.exampleTextControllers?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, exampleIndex) {
                      return Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                              Border.all(color: Colors.black38)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 12,
                                left: 12,
                                bottom: 12,
                                top: 0),
                            child: (myScreenMediaType.isTablet ||
                                myScreenMediaType.isMobile )
                                ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          '${exampleIndex + 1}.'),
                                      Spacer(),
                                      Opacity(
                                        opacity: !savedExample[exampleIndex] ? 1.0 : 0.1,
                                        child: IgnorePointer(
                                          ignoring: savedExample[exampleIndex],
                                          child: InkWell(
                                            onTap: () {
                                              if (_validateExampleFields(exampleIndex)) {
                                                setState(() {
                                                  savedExample[exampleIndex] = true;
                                                  addExample(
                                                    example: _state.exampleTextControllers![exampleIndex].text,
                                                    meaning: _state.exampleMeaningControllers![exampleIndex].text,
                                                    simplified: _state.exampleSimplifiedControllers![exampleIndex].text,
                                                    soundFile: _state.exampleSoundControllers![exampleIndex].text,
                                                  );
                                                });
                                              }
                                            },
                                            child: Icon(Icons.save_as_outlined,
                                              size: myScreenMediaType.isTablet ? 12 : 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Opacity(
                                        opacity: savedExample[exampleIndex] ? 1.0 : 0.1,
                                        child: IgnorePointer(
                                          ignoring: !savedExample[exampleIndex],
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  savedExample[exampleIndex] = false;
                                                });
                                              },
                                              child: Icon(Icons.edit,)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Opacity(
                                        opacity: savedExample[exampleIndex] ? 1.0 : 0.1,
                                        child: IgnorePointer(
                                          ignoring: !savedExample[
                                          exampleIndex],
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                removeExample(exampleIndex: exampleIndex);
                                              });
                                            },
                                            child: Icon(
                                              Icons.close_sharp,
                                              color: !savedExample[
                                              exampleIndex]
                                                  ? Colors.grey
                                                  : Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  // text fields
                                  customTextFormField2(
                                    controller: _state.exampleTextControllers!,
                                    index: exampleIndex,
                                    value: L10nX.getStr.examples_str,
                                    enabled: savedExample,
                                    getFile: "",
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  customTextFormField2(
                                    controller:
                                    _state.exampleMeaningControllers!,
                                    index: exampleIndex,
                                    value: L10nX.getStr.meaning_str,
                                    enabled: savedExample,
                                    getFile: "",
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  customTextFormField2(
                                    controller:
                                    _state.exampleSimplifiedControllers!,
                                    index: exampleIndex,
                                    value: L10nX.getStr.simplified_str,
                                    enabled: savedExample,
                                    getFile: "",
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  customTextFormField2(
                                    controller:
                                    _state.exampleSoundControllers!,
                                    index: exampleIndex,
                                    value:L10nX.getStr.sound_str,
                                    enabled: savedExample,
                                    getFile: "wav",
                                  ),
                                ])
                                : Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  top: 8,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      Opacity(
                                        opacity: !savedExample[
                                        exampleIndex]
                                            ? 1.0
                                            : 0.1,
                                        child: IgnorePointer(
                                          ignoring:
                                          savedExample[
                                          exampleIndex],
                                          child: InkWell(
                                            onTap: () {
                                              if (_validateExampleFields(
                                                  exampleIndex)) {
                                                setState(() {
                                                  savedExample[
                                                  exampleIndex] =
                                                  true;
                                                  addExample(
                                                    example: _state.exampleTextControllers![
                                                    exampleIndex]
                                                        .text,
                                                    meaning: _state.exampleMeaningControllers![
                                                    exampleIndex]
                                                        .text,
                                                    simplified:
                                                    _state.exampleSimplifiedControllers![exampleIndex]
                                                        .text,
                                                    soundFile:
                                                    _state.exampleSoundControllers![exampleIndex]
                                                        .text,
                                                  );
                                                });
                                              }
                                            },
                                            child: Icon(
                                              Icons
                                                  .save_as_outlined,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Opacity(
                                        opacity: savedExample[
                                        exampleIndex]
                                            ? 1.0
                                            : 0.1,
                                        child: IgnorePointer(
                                          ignoring:
                                          !savedExample[
                                          exampleIndex],
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  savedExample[
                                                  exampleIndex] =
                                                  false;
                                                });
                                              },
                                              child: Icon(
                                                Icons.edit,
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Opacity(
                                        opacity: savedExample[
                                        exampleIndex]
                                            ? 1.0
                                            : 0.1,
                                        child: IgnorePointer(
                                          ignoring:
                                          !savedExample[
                                          exampleIndex],
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                removeExample(
                                                    exampleIndex:
                                                    exampleIndex);
                                              });
                                            },
                                            child: Icon(
                                              Icons.close_sharp,
                                              color: !savedExample[
                                              exampleIndex]
                                                  ? Colors.black
                                                  : Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    // text fields
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Text(
                                                    '${exampleIndex + 1}.'))),
                                        Expanded(
                                          flex: 10,
                                          child:
                                          customTextFormField2(
                                            controller:
                                            _state.exampleTextControllers!,
                                            index: exampleIndex,
                                            value: L10nX.getStr.examples_str,
                                            enabled:
                                            savedExample,
                                            getFile: "",
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Expanded(
                                          flex: 10,
                                          child:
                                          customTextFormField2(
                                            controller:
                                            _state.exampleMeaningControllers!,
                                            index: exampleIndex,
                                            value: L10nX.getStr.meaning_str,
                                            enabled:
                                            savedExample,
                                            getFile: "",
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child:
                                          customTextFormField2(
                                            controller:
                                            _state.exampleSimplifiedControllers!,
                                            index: exampleIndex,
                                            value: L10nX.getStr.simplified_str,
                                            enabled:
                                            savedExample,
                                            getFile: "",
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Expanded(
                                            flex: 10,
                                            child:
                                            customTextFormField2(
                                              controller:
                                              _state.exampleSoundControllers!,
                                              index:
                                              exampleIndex,
                                              value: L10nX.getStr.sound_str,
                                              enabled:
                                              savedExample,
                                              getFile: "wav",
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: SizedBox()),
                                      ],
                                    ),
                                  ],
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
            SizedBox(height: 8,),
            // nút thêm ví dụ mới
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    // nếu không có ví dụ nào thì sẽ thêm mới
                    if ((_state.exampleTextControllers??[]).isEmpty) {
                      setState(() {
                        _state.exampleTextControllers?.add(new TextEditingController());
                        _state.exampleMeaningControllers?.add(new TextEditingController());
                        _state.exampleSimplifiedControllers?.add(new TextEditingController());
                        _state.exampleSoundControllers?.add(new TextEditingController());
                        savedExample.add(false);
                      });
                    } else {
                      // nếu tất cả ví dụ đã có được lưu thì mới được thêm mới
                      bool allExamplesSaved = true;
                      for (int index = 0;
                      index < (_state.exampleTextControllers??[]).length;
                      index++) {
                        if (savedExample[index] == false) {
                          allExamplesSaved = false;
                          break;
                        }
                      }
                      if (!allExamplesSaved) {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please save all examples before adding new examples'), duration: Duration(seconds: 1),),);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(L10nX.getStr.string_notify),
                            content: Text(
                                'Please save all examples before adding new examples'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                    );
                                  },
                                  child: Text(L10nX.getStr.ok))
                            ],
                          ),
                        );
                      } else {
                        setState(() {
                          _state.exampleTextControllers?.add(new TextEditingController());
                          _state.exampleMeaningControllers?.add(new TextEditingController());
                          _state.exampleSimplifiedControllers?.add(new TextEditingController());
                          _state.exampleSoundControllers?.add(new TextEditingController());
                          savedExample.add(false);
                        });
                      }
                    }
                  },
                  child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget customTextFormField1({
    required String controller,
    required String label,
    double? width,
    bool audio = false,
    required BoxConstraints constraints,
    required MyScreenMediaType myScreenMediaType
  }){
    return myScreenMediaType.isMobile?
    Expanded(child: TextFormField(
          validator: _state.addWordController?.basicValidator.getValidation(controller),
          controller: _state.addWordController?.basicValidator.getController(controller),
          decoration: InputDecoration(
            enabledBorder: audio ? InputBorder.none : null,
            focusedBorder: audio ? InputBorder.none : null,
            labelText: label,
            labelStyle: MyTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder.copyWith(
              borderRadius: BorderRadius.circular(25),
            ),
            contentPadding: MySpacing.all(16),
            isCollapsed: true,
            floatingLabelBehavior:
            FloatingLabelBehavior.never,
            suffixIcon: (_state.addWordController?.basicValidator.getController(controller)?.text != "" && audio)
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
        )):
      Container(
      constraints: BoxConstraints(
        minWidth: Dimens.size200
      ),
      width: (width??constraints.maxWidth-(16*2-20*3))/4,
      child: TextFormField(
        validator: _state.addWordController?.basicValidator.getValidation(controller),
        controller: _state.addWordController?.basicValidator.getController(controller),
        decoration: InputDecoration(
          enabledBorder: audio ? InputBorder.none : null,
          focusedBorder: audio ? InputBorder.none : null,
          labelText: label,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder.copyWith(
            borderRadius: BorderRadius.circular(25),
          ),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior:
          FloatingLabelBehavior.never,
          suffixIcon: (_state.addWordController?.basicValidator.getController(controller)?.text != "" && audio)
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
      ),
    );
  }


  Widget customTextFormField2(
      {required List<TextEditingController> controller,
        required int index,
        required String value,
        required List<bool> enabled,
        String? getFile}) {
    return TextFormField(
      enabled: !enabled[index],
      controller: controller[index],
      decoration: InputDecoration(
        labelText: (getFile == "") ? value : 'Upload $value file (.$getFile)',
        labelStyle: MyTextStyle.bodySmall(xMuted: true),
        border: outlineInputBorder.copyWith(
          borderRadius: BorderRadius.circular(25),
        ),
        contentPadding: MySpacing.all(16),
        isCollapsed: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: (getFile == "")
            ? SizedBox()
            : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (controller[index].text == "")
                ? SizedBox()
                : IconButton(
                onPressed: () {
                  setState(() {
                    controller[index].text = "";
                  });
                },
                icon: (!enabled[index]) ? Icon(
                  Icons.close_sharp,
                  color: Colors.red,
                ) : SizedBox()),
            IconButton(
              onPressed: () async {
                FilePickerResult? result =
                await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['$getFile'],
                );
                setState(() {
                  if (result != null) {
                    controller[index].text = result.names[0]!;
                  } else {}
                });
              },
              icon: Icon(Icons.upload_file),
            ),
          ],
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $value';
        }
        return null;
      },
    );
  }
  
}

class ExampleForm {
  String example;
  String meaning;
  String simplified;
  String soundFile;

  ExampleForm(
      {required this.example,
        required this.meaning,
        required this.simplified,
        required this.soundFile});
}

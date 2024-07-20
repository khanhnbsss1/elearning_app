import 'dart:io' as io;
import 'dart:typed_data';
// import 'dart:html';
import 'package:file/file.dart';
import 'package:file/memory.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/theme/colors_app.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webkit/controller/add_word_controller.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/my_screen_media_type.dart';
import 'package:webkit/services/apis/words/word_model.dart';
import 'package:webkit/views/layouts/layout.dart';
import '../../../base/theme/text_stype_constant.dart';
import '../../../helpers/utils/ui_mixins.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../../landing_page/components/colornotifier.dart';
import 'package:universal_io/io.dart';


class AddWords extends StatefulWidget {
  void show(BuildContext context) {
    // showGeneralDialog(
    //   //barrierDismissible: true,
    //   context: context,
    //   pageBuilder: (context, animation, _) => Container(
    //     child: this,
    //   ),
    // );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SizedBox(
              width: 1100,
              height: 1000,
              child: this,
            ),
          );
        });
  }

  @override
  State<AddWords> createState() => _AddWordsState();
}

class _AddWordsState extends State<AddWords>
    with SingleTickerProviderStateMixin, UIMixin {

  @override
  void initState() {
    super.initState();
    exampleTextControllers
        .add(new TextEditingController());
    exampleMeaningControllers
        .add(new TextEditingController());
    exampleSimplifiedControllers
        .add(new TextEditingController());
    exampleSoundControllers
        .add(new TextEditingController());
    savedExample.add(false);
    addWordController = Get.put(AddWordController());
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
      exampleTextControllers.removeAt(exampleIndex);
      exampleMeaningControllers.removeAt(exampleIndex);
      exampleSimplifiedControllers.removeAt(exampleIndex);
      exampleSoundControllers.removeAt(exampleIndex);
      savedExample.removeAt(exampleIndex);
    });
  }

  late AddWordController addWordController;

  final List<TextEditingController> exampleTextControllers = [];
  final List<TextEditingController> exampleMeaningControllers = [];
  final List<TextEditingController> exampleSimplifiedControllers = [];
  final List<TextEditingController> exampleSoundControllers = [];

  List<bool> savedExample = [];

  late ColorNotifier notifier;

  bool _validateExampleFields(int exampleIndex) {
    final textFormFields = [
      exampleTextControllers[exampleIndex],
      exampleMeaningControllers[exampleIndex],
      exampleSimplifiedControllers[exampleIndex],
      exampleSoundControllers[exampleIndex],
    ];

    for (var textField in textFormFields) {
      if (textField.value.text.isEmpty) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Please fill in all fields'), duration: Duration(seconds: 1),),
        // );
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alert'),
            content: Text('Please fill in all missing fields'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
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

  File createFileFromBytes(String fileName, String fileType, Uint8List fileContent) {
    final fileSystem = MemoryFileSystem();

    final file = fileSystem.file(fileName);

    file.writeAsBytesSync(fileContent);

    return file;
  }

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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: const [
              //     Text('Thêm/Chỉnh từ vựng'),
              //   ],
              // ),
              SizedBox(
                height: 12,
              ),

              // thêm từ mới
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: (myScreenMediaType.isTablet ||
                    myScreenMediaType.isMobile ||
                    myScreenMediaType.isLaptop)
                    ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: customTextFormField1(controller: 'traditional', label: 'Word'),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 3,
                          child: customTextFormField1(controller: 'simplified', label: 'Simplified'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: customTextFormField1(controller: 'translation_vn', label: 'Meaning'),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 3,
                          child: customTextFormField1(controller: 'pinyin_tones', label: 'Pinyin tones'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: IconButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: notifier.redcolor,
                                  foregroundColor: Colors.white),
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['wav'],
                                );

                                String? fileName = result?.names[0];
                                String fileType = 'wav';
                                Uint8List? fileContent = result?.files.first.bytes;

                                File file = createFileFromBytes(fileName!, fileType, fileContent!);

                                setState(() {
                                  if (result != null) {
                                    addWordController.basicValidator.getController('audio')?.text = result.names[0]!;
                                    addWordController.setAudioFile(file);
                                  } else {}
                                });
                              },
                              icon: Icon(Icons.upload_file, size: 14),
                            )),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          flex: 12,
                          child: customTextFormField1(controller: 'audio', label: 'Upload sound file(.WAV)', audio: true),
                        ),
                        Expanded(flex: 2, child: SizedBox()),
                      ],
                    ),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 2, child: SizedBox()),
                    Expanded(
                      flex: 3,
                      child: customTextFormField1(controller: 'traditional', label: 'Word'),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 3,
                      child: customTextFormField1(controller: 'simplified', label: 'Simplified'),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 3,
                      child:  customTextFormField1(controller: 'translation_vn', label: 'Meaning'),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 3,
                      child:  customTextFormField1(controller: 'pinyin_tones', label: 'Pinyin tones'),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          style: TextButton.styleFrom(
                              backgroundColor: notifier.redcolor,
                              foregroundColor: Colors.white),
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['wav'],
                            );
                            

                            String? fileName = result?.names[0];
                            String fileType = 'wav';
                            Uint8List? fileContent = result?.files.first.bytes;

                            File file = createFileFromBytes(fileName!, fileType, fileContent!);
                            print(file.readAsBytesSync());
                            setState(() {
                              if (result != null) {
                                addWordController.basicValidator.getController('audio')?.text = result.names[0]!;
                                addWordController.setAudioFile(file);
                              } else {}
                            });
                          },
                          icon: Icon(Icons.upload_file, size: 14),
                        )),
                    Expanded(
                      flex: 6,
                      child:  customTextFormField1(controller: 'audio', label: 'Upload sound file(.WAV)', audio: true),
                    ),
                    Expanded(flex: 2, child: SizedBox()),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // box thêm ví dụ mới
              SizedBox(
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
                              child: Text('Add examples'),
                            ),
                            ListView.builder(
                              itemCount: exampleTextControllers.length,
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
                                                              example: exampleTextControllers[exampleIndex].text,
                                                              meaning: exampleMeaningControllers[exampleIndex].text,
                                                              simplified: exampleSimplifiedControllers[exampleIndex].text,
                                                              soundFile: exampleSoundControllers[exampleIndex].text,
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
                                              controller:
                                              exampleTextControllers,
                                              index: exampleIndex,
                                              value: 'Example',
                                              enabled: savedExample,
                                              getFile: "",
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            customTextFormField2(
                                              controller:
                                              exampleMeaningControllers,
                                              index: exampleIndex,
                                              value: 'Meaning',
                                              enabled: savedExample,
                                              getFile: "",
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            customTextFormField2(
                                              controller:
                                              exampleSimplifiedControllers,
                                              index: exampleIndex,
                                              value: 'Simplified',
                                              enabled: savedExample,
                                              getFile: "",
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            customTextFormField2(
                                              controller:
                                              exampleSoundControllers,
                                              index: exampleIndex,
                                              value: 'Sound',
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
                                                              example: exampleTextControllers[
                                                              exampleIndex]
                                                                  .text,
                                                              meaning: exampleMeaningControllers[
                                                              exampleIndex]
                                                                  .text,
                                                              simplified:
                                                              exampleSimplifiedControllers[exampleIndex]
                                                                  .text,
                                                              soundFile:
                                                              exampleSoundControllers[exampleIndex]
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
                                                      exampleTextControllers,
                                                      index: exampleIndex,
                                                      value: 'Example',
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
                                                      exampleMeaningControllers,
                                                      index: exampleIndex,
                                                      value: 'Meaning',
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
                                                      exampleSimplifiedControllers,
                                                      index: exampleIndex,
                                                      value: 'Simplified',
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
                                                        exampleSoundControllers,
                                                        index:
                                                        exampleIndex,
                                                        value: 'Sound',
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
                          TextButton(
                            onPressed: () {
                              // nếu không có ví dụ nào thì sẽ thêm mới
                              if (exampleTextControllers.isEmpty) {
                                setState(() {
                                  exampleTextControllers
                                      .add(new TextEditingController());
                                  exampleMeaningControllers
                                      .add(new TextEditingController());
                                  exampleSimplifiedControllers
                                      .add(new TextEditingController());
                                  exampleSoundControllers
                                      .add(new TextEditingController());
                                  savedExample.add(false);
                                });
                              } else {
                                // nếu tất cả ví dụ đã có được lưu thì mới được thêm mới
                                bool allExamplesSaved = true;
                                for (int index = 0;
                                index < exampleTextControllers.length;
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
                                      title: Text('Alert'),
                                      content: Text(
                                          'Please save all examples before adding new examples'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                context,
                                              );
                                            },
                                            child: Text('Ok'))
                                      ],
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    exampleTextControllers
                                        .add(new TextEditingController());
                                    exampleMeaningControllers
                                        .add(new TextEditingController());
                                    exampleSimplifiedControllers
                                        .add(new TextEditingController());
                                    exampleSoundControllers
                                        .add(new TextEditingController());
                                    savedExample.add(false);
                                  });
                                }
                              }
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: notifier.redcolor,
                                foregroundColor: Colors.white),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.add),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: notifier.redcolor,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      addWordController.onAddWord();
                    },
                    child: Text('Submit', style: TextStyleConstant.textStyleBlack16w400.copyWith(color: Colors.white)),
                  )),
              SizedBox(height: 12,),
            ],
          ),
        );
      }),
    );
  }

  Widget customTextFormField1({
    required String controller,
    required String label,
    bool audio = false,
  }){
    return TextFormField(
      validator: addWordController.basicValidator.getValidation(controller),
      controller: addWordController.basicValidator.getController(controller),
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
        suffixIcon: (addWordController.basicValidator.getController(controller)?.text != "" && audio)
            ? IconButton(
          onPressed: () {
            setState(() {
              addWordController.basicValidator.getController(controller)?.text = "";
            });
          },
          icon: Icon(
            Icons.close_sharp,
            color: Colors.red,
          ),
        )
            : null,
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

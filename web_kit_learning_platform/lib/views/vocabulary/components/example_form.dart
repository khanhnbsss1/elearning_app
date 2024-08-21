import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/sentence/models/sentence_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/upload_file/upload_file_api.dart';

class ExampleFrom extends StatefulWidget {
  SentenceInfo? sentenceInfo;
  Function(SentenceInfo)? onSaveSentenceInfo;
  Function(SentenceInfo)? onRemoveSentenceInfo;
  ScrollController? controller;
  ExampleFrom({this.sentenceInfo, this.onRemoveSentenceInfo, this.onSaveSentenceInfo, this.controller});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExampleFromState();
  }
}

class ExampleFromState extends State<ExampleFrom> with UIMixin {
  bool enaAbleSaveSentenceInfo = false;
  TextEditingController chineseSentenceController = TextEditingController();
  TextEditingController translationVNSentenceController = TextEditingController();
  TextEditingController pinyionSentenceController = TextEditingController();
  TextEditingController audioSentenceController = TextEditingController();
  List<String> oldText = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oldText.add(widget.sentenceInfo?.chineseSentence ?? '');
    oldText.add(widget.sentenceInfo?.translationVn ?? '');
    oldText.add(widget.sentenceInfo?.pinyionSentence ?? '');
    oldText.add(widget.sentenceInfo?.audioLink ?? '');
    chineseSentenceController.text = oldText.elementAt(0);
    translationVNSentenceController.text = oldText.elementAt(1);
    pinyionSentenceController.text = oldText.elementAt(2);
    audioSentenceController.text = oldText.elementAt(3);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    enaAbleSaveSentenceInfo = (chineseSentenceController.text ?? "").isNotEmpty &&
        (translationVNSentenceController.text ?? "").isNotEmpty &&
        (pinyionSentenceController.text ?? "").isNotEmpty &&
        (audioSentenceController.text ?? "").isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black38)),
        child: Padding(
          padding:  EdgeInsets.all(ResponsiveInfo.isPhone()?Dimens.size8:Dimens.size12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double maxWidthItem = 600;
                        double heightOfItem = ResponsiveInfo.isPhone() ? 40 : 90;
                        int numberRow = ((constraints.maxWidth / maxWidthItem) / 2).toInt() * 2;
                        if (numberRow < 1) {
                          numberRow = 1;
                        }
                        double widthItem = (constraints.maxWidth - (50 * numberRow)) / numberRow;
                        return GridView.count(
                          crossAxisCount: ResponsiveInfo.isPhone() ? 1 : 2,
                          controller: widget.controller,
                          shrinkWrap: true,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          padding: EdgeInsets.zero,
                          childAspectRatio: (widthItem) / (heightOfItem),
                          children: [
                            TextFormField(
                              controller: chineseSentenceController,
                              decoration: InputDecoration(
                                labelText: L10nX.getStr.simplified_str,
                                labelStyle: MyTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder.copyWith(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                contentPadding: MySpacing.all(16),
                                isCollapsed: true,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    (chineseSentenceController.text == "")
                                        ? SizedBox()
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                chineseSentenceController.text = "";
                                              });
                                            },
                                            icon: (chineseSentenceController.text.isNotEmpty)
                                                ? Icon(
                                                    Icons.close_sharp,
                                                    color: ColorConst.colorIconGrays,
                                                  )
                                                : SizedBox()),
                                  ],
                                ),
                              ),
                              onChanged: (value) {
                                updateDataToSentenceInfo();
                                if (value.isNotEmpty && oldText.elementAt(0).isEmpty || value.isEmpty && oldText.elementAt(0).isNotEmpty) {
                                  setState(() {});
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter $value';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: translationVNSentenceController,
                              decoration: InputDecoration(
                                labelText: L10nX.getStr.meaning_str,
                                labelStyle: MyTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder.copyWith(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                contentPadding: MySpacing.all(16),
                                isCollapsed: true,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                suffixIcon: (widget.sentenceInfo?.audioFileInfo?.link ?? "").isNotEmpty
                                    ? SizedBox()
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          (translationVNSentenceController.text == "")
                                              ? SizedBox()
                                              : IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      translationVNSentenceController.text = "";
                                                    });
                                                  },
                                                  icon: (translationVNSentenceController.text.isNotEmpty)
                                                      ? Icon(
                                                          Icons.close_sharp,
                                                          color: ColorConst.colorIconGrays,
                                                        )
                                                      : SizedBox()),
                                        ],
                                      ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter $value';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                updateDataToSentenceInfo();
                                  
                                if (value.isNotEmpty && oldText.elementAt(1).isEmpty || value.isEmpty && oldText.elementAt(1).isNotEmpty) {
                                  setState(() {});
                                }
                              },
                            ),
                            TextFormField(
                              controller: pinyionSentenceController,
                              decoration: InputDecoration(
                                labelText: L10nX.getStr.pinyin_tone_str,
                                labelStyle: MyTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder.copyWith(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                contentPadding: MySpacing.all(16),
                                isCollapsed: true,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                suffixIcon: (widget.sentenceInfo?.audioFileInfo?.link ?? "").isNotEmpty
                                    ? SizedBox()
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          (pinyionSentenceController.text == "")
                                              ? SizedBox()
                                              : IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      pinyionSentenceController.text = "";
                                                    });
                                                  },
                                                  icon: (pinyionSentenceController.text.isNotEmpty)
                                                      ? Icon(
                                                          Icons.close_sharp,
                                                          color: ColorConst.colorIconGrays,
                                                        )
                                                      : SizedBox()),
                                        ],
                                      ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter $value';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                updateDataToSentenceInfo();
                                  
                                if (value.isNotEmpty && oldText.elementAt(2).isEmpty || value.isEmpty && oldText.elementAt(2).isNotEmpty) {
                                  setState(() {});
                                }
                              },
                            ),
                            TextFormField(
                              controller: audioSentenceController,
                              decoration: InputDecoration(
                                labelText: (widget.sentenceInfo?.audioFileInfo?.link ?? "").isNotEmpty ? (widget.sentenceInfo?.audioFileInfo?.link ?? "") : 'Upload audio file...',
                                labelStyle: MyTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder.copyWith(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                contentPadding: MySpacing.all(16),
                                isCollapsed: true,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                suffixIcon: (widget.sentenceInfo?.audioFileInfo?.link ?? "").isNotEmpty
                                    ? SizedBox()
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          (audioSentenceController.text == "")
                                              ? SizedBox()
                                              : IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      audioSentenceController.text = "";
                                                    });
                                                  },
                                                  icon: (audioSentenceController.text.isNotEmpty)
                                                      ? Icon(
                                                          Icons.close_sharp,
                                                          color: Colors.red,
                                                        )
                                                      : SizedBox()),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                            child: IconButton(
                                              style: TextButton.styleFrom(backgroundColor: ColorConst.whiteColor, foregroundColor: Colors.white),
                                              onPressed: () async {
                                                FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                  type: FileType.custom,
                                                  allowedExtensions: ['wav', 'mp3'],
                                                );
                                                if (result == null) {
                                                  return;
                                                }
                                                MultipartFile file = MultipartFile.fromBytes(result.files.first.bytes!.toList(growable: true), filename: result.names[0]);
                                                UploadFileApi uploadFileApi = UploadFileApi(fileInfo: UploadFileInfo(data: SubjectType.vocabulary, fileName: result.files.first.name, file: file));
                                                UploadFileResponseInfo? resultUpload = await uploadFileApi.call();
                                                if (resultUpload != null) {
                                                  setState(() {
                                                    widget.sentenceInfo?.audioFileInfo = resultUpload;
                                                    widget.sentenceInfo?.audioId = resultUpload.id;
                                                    widget.sentenceInfo?.audioLink = resultUpload.link;
                                                    audioSentenceController.text = result.names[0]!;
                                                  });
                                                }
                                              },
                                              icon: Icon(
                                                Icons.cloud_upload_rounded,
                                                color: ColorConst.mainColor,
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              validator: (value) {
                                updateDataToSentenceInfo();
                                  
                                if (value == null || value.isEmpty) {
                                  return 'Please enter $value';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty && oldText.elementAt(3).isEmpty || value.isEmpty && oldText.elementAt(3).isNotEmpty) {
                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: !ResponsiveInfo.isPhone(),
                      child: Row(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      buildSaveDeleteWidget(),
                    ],
                  )),
                ],
              ),
              Visibility(
                  visible: ResponsiveInfo.isPhone(),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      buildSaveDeleteWidget(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSaveDeleteWidget() {
    return Stack(
      children: [
        Visibility(
            visible: !ResponsiveInfo.isPhone(),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Opacity(
              opacity: enaAbleSaveSentenceInfo ? 1.0 : 0.1,
              child: IgnorePointer(
                ignoring: !enaAbleSaveSentenceInfo,
                child: InkWell(
                  onTap: () {
                    if (widget.onSaveSentenceInfo != null) {
                      widget.sentenceInfo?.chineseSentence = chineseSentenceController.text;
                      widget.sentenceInfo?.translationVn = translationVNSentenceController.text;
                      widget.sentenceInfo?.pinyionSentence = pinyionSentenceController.text;
                      widget.sentenceInfo?.audioLink = audioSentenceController.text;
                      widget.onSaveSentenceInfo!(widget.sentenceInfo!);
                    }
                  },
                  child: Icon(
                    Icons.save_as_outlined,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Opacity(
              opacity: enaAbleSaveSentenceInfo ? 1.0 : 0.1,
              child: IgnorePointer(
                child: InkWell(
                  onTap: () {
                    if (widget.onRemoveSentenceInfo != null) {
                      widget.onRemoveSentenceInfo!(widget.sentenceInfo!);
                    }
                  },
                  child: Icon(
                    Icons.close_sharp,
                    color: !enaAbleSaveSentenceInfo ? Colors.black : Colors.red,
                  ),
                ),
              ),
            ),
          ],
        )),
        Visibility(
            visible: ResponsiveInfo.isPhone(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Opacity(
                  opacity: enaAbleSaveSentenceInfo ? 1.0 : 0.1,
                  child: IgnorePointer(
                    ignoring: !enaAbleSaveSentenceInfo,
                    child: InkWell(
                      onTap: () {
                        if (widget.onSaveSentenceInfo != null) {
                          widget.sentenceInfo?.chineseSentence = chineseSentenceController.text;
                          widget.sentenceInfo?.translationVn = translationVNSentenceController.text;
                          widget.sentenceInfo?.pinyionSentence = pinyionSentenceController.text;
                          widget.sentenceInfo?.audioLink = audioSentenceController.text;
                          widget.onSaveSentenceInfo!(widget.sentenceInfo!);
                        }
                      },
                      child: Icon(
                        Icons.save_as_outlined,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Opacity(
                  opacity: enaAbleSaveSentenceInfo ? 1.0 : 0.1,
                  child: IgnorePointer(
                    child: InkWell(
                      onTap: () {
                        if (widget.onRemoveSentenceInfo != null) {
                          widget.onRemoveSentenceInfo!(widget.sentenceInfo!);
                        }
                      },
                      child: Icon(
                        Icons.close_sharp,
                        color: !enaAbleSaveSentenceInfo ? Colors.black : Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  void updateDataToSentenceInfo() {
    widget.sentenceInfo?.chineseSentence = chineseSentenceController.text;
    widget.sentenceInfo?.translationVn = translationVNSentenceController.text;
    widget.sentenceInfo?.pinyionSentence = pinyionSentenceController.text;
    widget.sentenceInfo?.audioLink = audioSentenceController.text;
  }
}

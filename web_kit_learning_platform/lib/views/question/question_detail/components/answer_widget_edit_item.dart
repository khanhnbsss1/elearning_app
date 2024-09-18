import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/audio/audio_speaker.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/upload_file/upload_file_api.dart';

class AnswerWidgetEditItem extends StatefulWidget{

  AnswerInfo answerUploadInfo;
  AnswerType? answerType;

  Function(AnswerInfo)? onChange;
  Function(AnswerInfo)? onCheckRightAnswer;
  Function(AnswerInfo)? onRemove;
  
  AnswerWidgetEditItem({required this.answerUploadInfo, this.onChange, this.onCheckRightAnswer, this.answerType, this.onRemove});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AnswerWidgetEditItemState();
  }
  
}
class AnswerWidgetEditItemState extends State<AnswerWidgetEditItem> with UIMixin{
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      controller.text = widget.answerUploadInfo.name??"";
  
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Visibility(
            visible: widget.answerType == AnswerType.image && (widget.answerUploadInfo.answer??"").isNotEmpty,
            child: SizedBox(
              width: Dimens.size150,
              height: Dimens.size120,
              child: ImageManager().getImageByUrl(
                  widget.answerUploadInfo.answer??"",
                  boxFit: BoxFit.contain,
              ),
            ),
          ),
          Visibility(
            visible: widget.answerType == AnswerType.audio && (widget.answerUploadInfo.answer??"").isNotEmpty,
            child: AudioSpeaker(
              url: widget.answerUploadInfo.answer??"",
            ),
          ),
          Gap(Dimens.size8),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              controller: controller,
              readOnly: widget.answerType!= AnswerType.text,
              onTapOutside: (event) {
                if(widget.onChange!=null && widget.answerType == AnswerType.text)
                  {
                    widget.answerUploadInfo.name = controller.text;
                    widget.onChange!(widget.answerUploadInfo);
                  }
              },
              onChanged: (value) {
                if(widget.onChange!=null && widget.answerType == AnswerType.text)
                {
                  widget.answerUploadInfo.name = controller.text;
                  widget.onChange!(widget.answerUploadInfo);
                }
              },
              decoration: InputDecoration(
                labelText: "${L10nX.getStr.answer_str_1}...",
                labelStyle: MyTextStyle.bodySmall(xMuted: true),
                constraints: BoxConstraints(
                  maxHeight: Dimens.size70
                ),
                border: outlineInputBorder,
                suffixIcon: Visibility(
                  visible: widget.answerType !=AnswerType.text,
                  child: InkWell(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions:widget.answerType == AnswerType.audio? ['wav', 'mp3']:['png', 'jpg'],
                      );
                      if(result==null) {
                        return;
                      }
                      MultipartFile file = MultipartFile.fromBytes(result.files.first.bytes!.toList(growable: true), filename: result.names[0]);
                  
                      UploadFileInfo uploadFileInfo = UploadFileInfo(
                          data: SubjectType.vocabulary,
                          fileName: result.files.first.name,
                          file: file
                      );
                      UploadFileApi uploadFileApi= UploadFileApi(fileInfo:uploadFileInfo);
                      UploadFileResponseInfo? resultUpload = await uploadFileApi.call();
                      if(resultUpload!=null)
                        {
                          setState(() {
                            controller.text = uploadFileInfo.fileName??"";
                            widget.answerUploadInfo.uploadInfo = resultUpload;
                            widget.answerUploadInfo.fileId = resultUpload.id;
                            widget.answerUploadInfo.answer = resultUpload.link;
                            if(widget.onChange!=null)
                              {
                                widget.onChange!(widget.answerUploadInfo);
                              }
                          });
                        }
                    },
                    child: Icon(
                      Icons.cloud_upload_rounded,
                      size: 20,
                      color: ColorConst.colorIconRed,
                    ),
                  ),
                ),
                contentPadding: MySpacing.all(Dimens.size16),
                isCollapsed: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          Gap(Dimens.size16),
          InkWell(
            onTap: () {
              if(widget.onRemove!=null)
              {
                widget.onRemove!(widget.answerUploadInfo!);
              }
            },
            child: Icon(Icons.delete_forever_outlined, color: ColorConst.colorIconRed,),
          ),
          Gap(Dimens.size16),
          Checkbox(
              value: widget.answerUploadInfo.rightAnswer ==1?true:false, 
              fillColor: WidgetStateProperty.resolveWith((states) {
                return ColorConst.whiteColor;
              },), 
            side: WidgetStateBorderSide.resolveWith(
                  (states) => BorderSide(width: 1.0, color: ColorConst.blackColor,),
            ),
            checkColor: ColorConst.colorIconRed,
            
            onChanged: (value) {
                widget.answerUploadInfo.rightAnswer = value==false?0:1;
                if(widget.onCheckRightAnswer!=null)
                  {
                    widget.onCheckRightAnswer!(widget.answerUploadInfo!);
                  }
              },
          ),
      
        ],
      ),
    );
  }

}
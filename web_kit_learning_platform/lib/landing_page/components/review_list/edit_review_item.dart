import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/widget_common/widget_with_title_common.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/landing_page/review/models/landing_page_review_list_response_model.dart';
import 'package:webkit/services/apis/landing_page/review/review_detail/add_review_item_api.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/upload_file/upload_file_api.dart';

import '../../../services/apis/landing_page/review/review_detail/update_review_item_api.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class EditReviewItemPage extends StatefulWidget{
  ActionType? actionType;
  UserTypeName? userTypeName;
  EditReviewItemPage({this.info, this.actionType, this.userTypeName}){
    info??=ReviewLandingPageInfo();
    actionType??=ActionType.create;
    userTypeName??=UserTypeName.user;
    
  }
  ReviewLandingPageInfo?info;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditReviewItemPageState();
  }
  
  
  void show(BuildContext context, {Function(dynamic)? callBack}) {
    showDialog(
      context: context,
       builder: (context) => this,
    ).then((value) {
      if(callBack!=null && value !=null)
        {
          callBack(value);
        }
    },);
  }}
class EditReviewItemPageState extends State<EditReviewItemPage>with UIMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController fileController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.info?.id!=null)
      {
        nameController.text = widget.info?.name??"";
        positionController.text = widget.info?.position??"";
        reviewController.text = widget.info?.review??"";
        fileController.text = widget.info?.avatar??"";
      }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text(widget.actionType ==ActionType.create? (
      widget.userTypeName == UserTypeName.user?L10nX.getStr.add_review_user: L10nX.getStr.add_review_teacher
      ): (widget.userTypeName == UserTypeName.user?L10nX.getStr.edit_review_user: L10nX.getStr.edit_review_tacher)),
      content: Container(
        width: MediaQuery.of(context).size.width/3,
       // height: MediaQuery.of(context).size.height*2/3,
        constraints: BoxConstraints(
          maxWidth: Dimens.size600,
          maxHeight: Dimens.size600,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetWithColumnTitleCommon(
              title: L10nX.getStr.full_name,
              isRequirement: true,
              child: TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  widget.info?.name = value;
                },
                enabled: widget.actionType != ActionType.view,
                decoration: InputDecoration(
                    labelText: L10nX.getStr.full_name,
                    labelStyle: MyTextStyle.bodySmall(xMuted: true),
                    border: outlineInputBorder,
                    contentPadding: EdgeInsets.all(16),
                    isCollapsed: true,
                    floatingLabelBehavior:
                    FloatingLabelBehavior.never),
              ),
            ),
            Gap(Dimens.size16),
        
            WidgetWithColumnTitleCommon(
              title: L10nX.getStr.positions,
              isRequirement: true,
              child: TextFormField(
                controller: positionController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  widget.info?.position = value;
                },
                enabled: widget.actionType != ActionType.view,
                decoration: InputDecoration(
                    labelText: L10nX.getStr.positions,
                    labelStyle: MyTextStyle.bodySmall(xMuted: true),
                    border: outlineInputBorder,
                    contentPadding: EdgeInsets.all(16),
                    isCollapsed: true,
                    floatingLabelBehavior:
                    FloatingLabelBehavior.never),
              ),
            ),
            Gap(Dimens.size16),
            WidgetWithColumnTitleCommon(
              title: L10nX.getStr.review_str,
              isRequirement: true,
              child: TextFormField(
                controller: reviewController,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  widget.info?.position = value;
                },
                minLines: 3,
                maxLines: 7,
                enabled: widget.actionType != ActionType.view,
                decoration: InputDecoration(
                    labelText: L10nX.getStr.review_str,
                    labelStyle: MyTextStyle.bodySmall(xMuted: true),
                    border: outlineInputBorder,
                    contentPadding: EdgeInsets.all(16),
                    isCollapsed: true,
                    floatingLabelBehavior:
                    FloatingLabelBehavior.never),
              ),
            ),
            Gap(Dimens.size16),
        
            WidgetWithColumnTitleCommon(
              title: L10nX.getStr.background_image_str,
              isRequirement: true,
              child: TextFormField(
                controller: fileController,
                keyboardType: TextInputType.url,
                readOnly: true,
                onChanged: (value) {
                },
                enabled: widget.actionType != ActionType.view,
                decoration: InputDecoration(
                    labelText: L10nX.getStr.review_str,
                    labelStyle: MyTextStyle.bodySmall(xMuted: true),
                    border: outlineInputBorder,
                    contentPadding: EdgeInsets.all(16),
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: Icon(
                    CupertinoIcons.profile_circled,
                    size: Dimens.size20,
                    color: ColorConst.mainColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cloud_upload, color: ColorConst.mainColor,),
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg'],
                      );
                      if (result == null) {
                        return;
                      }
                      MultipartFile file = MultipartFile.fromBytes(result.files.first.bytes!.toList(growable: true), filename: result.names[0]);
                      UploadFileApi uploadFileApi = UploadFileApi(fileInfo: UploadFileInfo(data: SubjectType.landingapge_review, fileName: result.files.first.name, file: file));
                      UploadFileResponseInfo? resultUpload = await uploadFileApi.call();
                      if (resultUpload != null) {
                        setState(() {
                          fileController.text = result.files.first.name ?? "";
                          widget.info?.fileId = resultUpload.id  ;
                          widget.info?.avatar = resultUpload.link  ;

                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            Gap(Dimens.size16),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.actionType== ActionType.edit || widget.actionType== ActionType.create,
              child: ActionButton1(
                text: widget.actionType== ActionType.edit?L10nX.getStr.edit_str:L10nX.getStr.create_str,
                width: Dimens.size120,
                onTap: () async {
                  dynamic tagApi;
                  widget.info?.name = nameController.text;
                  widget.info?.position = positionController.text;
                  widget.info?.review = reviewController.text;
                  widget.info?.typeName = widget.userTypeName== UserTypeName.user?"User": "Teacher";
                  widget.info?.isShow = 1;
                  if(widget.info?.id==null){ /// th edit tag
                    tagApi = AddReviewApi(info: widget.info!);
                  }
                  else
                  {
                    tagApi = UpdateReviewApi(info: widget.info!);
                  }
                  MonitorLoading().showLoading("");
                  dynamic data = await tagApi.call();
                  MonitorLoading().dismiss();
                  if(data.runtimeType == String && (data as String).isEmpty)
                    {
                      Navigator.of(context).pop(true);
                    }
                },
              ),
            ),
            Gap(Dimens.size20),
            ActionButton1(
              text: L10nX.getStr.close,
              enableBgColor: ColorConst.whiteColor,
              textStype: TextStyleConstant.textStyleBlack14w600,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
  
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/widget_common/widget_with_title_common.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/landing_page/components/course_list/edit_course_landingpage/search_course_drop_down.dart';
import 'package:webkit/services/apis/landing_page/course/course_list/course_list_api.dart';
import 'package:webkit/services/apis/landing_page/course/models/course_list_landing_page_response_model.dart';
import 'package:webkit/services/apis/landing_page/review/models/landing_page_review_list_response_model.dart';
import 'package:webkit/services/apis/landing_page/review/review_detail/add_review_item_api.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/upload_file/upload_file_api.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../services/apis/landing_page/course/course_detail/add_course_item_api.dart';
import '../../../../services/apis/landing_page/course/course_detail/update_course_item_api.dart';

class EditCourseItemPage extends StatefulWidget {
  ActionType? actionType;
  EditCourseItemPage({this.info, this.actionType,e}) {
    info ??= CourseLandingPageInfo();
    actionType ??= ActionType.create;
  }
  CourseLandingPageInfo? info;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditCourseItemPageState();
  }

  void show(BuildContext context, {Function(dynamic)? callBack}) {
    showDialog(
      context: context,
      builder: (context) => this,
    ).then(
      (value) {
        if (callBack != null && value != null) {
          callBack(value);
        }
      },
    );
  }
}

class EditCourseItemPageState extends State<EditCourseItemPage> with UIMixin {
  TextEditingController introductionController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController fileController = TextEditingController();
  CourseListResponseModel courseListLandingPageResponseModel = CourseListResponseModel(data: []);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.info?.id != null) {
      introductionController.text = widget.info?.introduction ?? "";
      ratingController.text = (widget.info?.ratePoint ?? 0).toString();
      fileController.text = widget.info?.image ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text(widget.actionType == ActionType.create
          ? L10nX.getStr.course_create
          : (L10nX.getStr.course_edit)),
      content: Container(
        width: MediaQuery.of(context).size.width / 3,
        // height: MediaQuery.of(context).size.height*2/3,
        constraints: BoxConstraints(
          maxWidth: Dimens.size600,
          maxHeight: Dimens.size600,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchCourseDropDown(
                    allWords: [],
                    courseName: widget.info?.courseName,
                    onSelectCourse: (p0) {
                      setState(() {
                        widget.info?.courseId = p0.id;
                        widget.info?.name = p0.name;
                        widget.info?.ratePoint = p0.rating;
                        //widget.info?.fileId = p0.imageId;
                       // widget.info?.image = p0.image;
                        widget.info?.courseName = p0.name;

                      });
                    },
                    actionType: ActionType.create,
                  ),
                ),
              ],
            ),
            WidgetWithColumnTitleCommon(
              title: L10nX.getStr.introduction_str,
              isRequirement: true,
              child: TextFormField(
                controller: introductionController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  widget.info?.introduction = value;
                },
                minLines: 3,
                maxLines: 7,
                enabled: widget.actionType != ActionType.view,
                decoration: InputDecoration(
                    labelText: L10nX.getStr.introduction_str,
                    labelStyle: MyTextStyle.bodySmall(xMuted: true),
                    border: outlineInputBorder,
                    contentPadding: EdgeInsets.all(16),
                    isCollapsed: true,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    alignLabelWithHint: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never),
              ),
            ),
            Gap(Dimens.size16),
            WidgetWithColumnTitleCommon(
              title: L10nX.getStr.rating,
              isRequirement: true,
              child: TextFormField(
                controller: ratingController,
                keyboardType: TextInputType.multiline,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  FilteringTextInputFormatter.deny(
                    RegExp(r'^0+'),
                  ),
                ],
                onChanged: (value) {
                  widget.info?.ratePoint = double.tryParse(value);
                },

                enabled: widget.actionType != ActionType.view,
                decoration: InputDecoration(
                    labelText: L10nX.getStr.rating,
                    labelStyle: MyTextStyle.bodySmall(xMuted: true),
                    border: outlineInputBorder,
                    contentPadding: EdgeInsets.all(16),
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never),
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
                onChanged: (value) {},
                enabled: widget.actionType != ActionType.view,
                decoration: InputDecoration(
                  labelText: L10nX.getStr.background_image_str,
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
                    icon: Icon(
                      Icons.cloud_upload,
                      color: ColorConst.mainColor,
                    ),
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg'],
                      );
                      if (result == null) {
                        return;
                      }
                      MultipartFile file = MultipartFile.fromBytes(result.files.first.bytes!.toList(growable: true), filename: result.names[0]);
                      UploadFileApi uploadFileApi = UploadFileApi(fileInfo: UploadFileInfo(data: SubjectType.courses, fileName: result.files.first.name, file: file));
                      UploadFileResponseInfo? resultUpload = await uploadFileApi.call();
                      if (resultUpload != null) {
                        setState(() {
                          fileController.text = result.files.first.name ?? "";
                          widget.info?.fileId = resultUpload.id;
                          widget.info?.image = resultUpload.link;
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
              visible: widget.actionType == ActionType.edit || widget.actionType == ActionType.create,
              child: ActionButton1(
                text: widget.actionType == ActionType.edit ? L10nX.getStr.edit_str : L10nX.getStr.create_str,
                width: Dimens.size120,
                onTap: () async {
                  dynamic tagApi;
                  widget.info?.introduction = introductionController.text;
                  widget.info?.ratePoint = double.tryParse((ratingController.text).isNotEmpty ? ratingController.text : "0");
                  widget.info?.isShow = 1;
                  if (widget.info?.id == null) {
                    /// th edit tag
                    tagApi = AddCourseLandingPageApi(info: widget.info!);
                  } else {
                    tagApi = UpdateCourseLandingPageApi(info: widget.info!);
                  }
                  MonitorLoading().showLoading("");
                  dynamic data = await tagApi.call();
                  MonitorLoading().dismiss();
                  if (data.runtimeType == String && (data as String).isEmpty) {
                    Navigator.of(context).pop(true);
                  }
                },
              ),
            ),
            Gap(Dimens.size20),
            ActionButton1(
              text: L10nX.getStr.close,
              enableBgColor: ColorConst.whiteColor,
              textStype: TextStyleConstant.textStyleBlack16w600,
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

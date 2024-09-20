import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/category/add_category_api.dart';
import 'package:webkit/services/apis/category/models/category_info.dart';
import 'package:webkit/services/apis/category/update_category_api.dart';
import 'package:webkit/services/apis/grade/add_grade_api.dart';
import 'package:webkit/services/apis/grade/models/grade_info.dart';
import 'package:webkit/services/apis/grade/update_grade_api.dart';
import 'package:webkit/services/apis/tags/add_tag_api.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/services/apis/tags/update_tag_api.dart';
enum GradePageAction{
  view,
  edit,
  create
}

class AddCategoryPage extends StatefulWidget{
  GradePageAction? tagPageAction;
  AddCategoryPage({this.info, this.tagPageAction}){
    info??=CategoryInfo();
    tagPageAction??=GradePageAction.create;
  }
  CategoryInfo?info;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddCategoryPageState();
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
class AddCategoryPageState extends State<AddCategoryPage>with UIMixin {
  TextEditingController tagController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.info?.id!=null)
      {
        tagController.text = widget.info?.name??"";
      }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text(widget.tagPageAction ==GradePageAction.create? L10nX.getStr.category_add_str: L10nX.getStr.category_update_str),
      content: TextFormField(
        controller: tagController,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          widget.info?.name = value;
        },
        enabled: widget.tagPageAction != GradePageAction.view,
        decoration: InputDecoration(
            labelText: L10nX.getStr.category_add_str,
            labelStyle: MyTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder,
            contentPadding: EdgeInsets.all(16),
            isCollapsed: true,
            floatingLabelBehavior:
            FloatingLabelBehavior.never),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.tagPageAction== GradePageAction.edit || widget.tagPageAction== GradePageAction.create,
              child: ActionButton1(
                text: widget.tagPageAction== GradePageAction.edit?L10nX.getStr.edit_str:L10nX.getStr.create_str,
                width: Dimens.size120,
                onTap: () async {
                  dynamic tagApi;
                  if(widget.info?.id!=null){ /// th edit tag
                    tagApi = UpdateCategoryApi(info: widget.info!);
                  }
                  else
                  {
                    tagApi = AddCategoryApi(info: widget.info!);
              
                  }
                  MonitorLoading().showLoading("");
                  dynamic data = await tagApi.call();
                  MonitorLoading().dismiss();
                  if(data.runtimeType == String && (data as String).isEmpty)
                    {
                      Navigator.of(context).pop();
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
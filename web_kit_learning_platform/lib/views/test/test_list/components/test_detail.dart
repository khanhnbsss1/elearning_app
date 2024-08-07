import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/tags/add_tag_api.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/services/apis/tags/update_tag_api.dart';
import 'package:webkit/services/apis/test/add_test_api.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import 'package:webkit/services/apis/test/update_test_api.dart';
enum TestPageAction{
  view,
  edit,
  create
}

class TestDetailPage extends StatefulWidget{
  TestPageAction? tagPageAction;
  TestDetailPage({this.tagsInfo, this.tagPageAction}){
    tagsInfo??=TestInfo();
    tagPageAction??=TestPageAction.create;
  }
  TestInfo?tagsInfo;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestDetailPageState();
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
class TestDetailPageState extends State<TestDetailPage>with UIMixin {
  TextEditingController tagController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.tagsInfo?.id!=null)
      {
        tagController.text = widget.tagsInfo?.name??"";
      }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text(L10nX.getStr.add_tags),
      content: TextFormField(
        controller: tagController,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          widget.tagsInfo?.name = value;
        },
        enabled: widget.tagPageAction != TestPageAction.view,
        decoration: InputDecoration(
            labelText: L10nX.getStr.add_tags,
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
              visible: widget.tagPageAction== TestPageAction.edit || widget.tagPageAction== TestPageAction.create,
              child: ActionButton1(
                text: widget.tagPageAction== TestPageAction.edit?L10nX.getStr.edit_str:L10nX.getStr.create_str,
                width: Dimens.size120,
                onTap: () async {
                  var tagApi;
                  if(widget.tagsInfo?.id!=null){ /// th edit tag
                    tagApi = UpdateTestApi(info: widget.tagsInfo!);
                  }
                  else
                  {
                    tagApi = AddTestApi(info: widget.tagsInfo!);
              
                  }
                  MonitorLoading().showLoading("");
                  dynamic data = await tagApi.call();
                  MonitorLoading().dismiss();
                  if(data.runtimeType == String && (data as String).isEmpty)
                    {
                      Navigator.of(context).pop(widget.tagsInfo);
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
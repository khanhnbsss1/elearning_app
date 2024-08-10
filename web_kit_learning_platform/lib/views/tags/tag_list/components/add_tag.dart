import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/tags/add_tag_api.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/services/apis/tags/update_tag_api.dart';
enum TagPageAction{
  view,
  edit,
  create
}

class AddTagPage extends StatefulWidget{
  TagPageAction? tagPageAction;
  AddTagPage({this.tagsInfo, this.tagPageAction}){
    tagsInfo??=TagsInfo();
    tagPageAction??=TagPageAction.create;
  }
  TagsInfo?tagsInfo;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddTagPageState();
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
class AddTagPageState extends State<AddTagPage>with UIMixin {
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
        enabled: widget.tagPageAction != TagPageAction.view,
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
              visible: widget.tagPageAction== TagPageAction.edit || widget.tagPageAction== TagPageAction.create,
              child: ActionButton1(
                text: widget.tagPageAction== TagPageAction.edit?L10nX.getStr.edit_str:L10nX.getStr.create_str,
                width: Dimens.size120,
                onTap: () async {
                  dynamic tagApi;
                  if(widget.tagsInfo?.id!=null){ /// th edit tag
                    tagApi = UpdateTagApi(tagInfo: widget.tagsInfo!);
                  }
                  else
                  {
                    tagApi = AddTagApi(tagInfo: widget.tagsInfo!);
              
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
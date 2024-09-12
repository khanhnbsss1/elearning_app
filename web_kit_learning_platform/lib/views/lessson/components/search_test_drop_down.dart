import 'package:async_searchable_dropdown/async_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/instance_mananger/filter_manager.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/services/apis/test/get_test_list_api.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import 'package:webkit/views/test/test_detail/create_edit_test.dart';

class SearchTestDropDown extends StatefulWidget {
  final Function(TestInfo) onSelectTest;
  final Function()? onDeleteTest;

  TestInfo  ?testInfo;
  bool? enableEdit;
  SearchTestDropDown({super.key, required this.onSelectTest, this.testInfo, this.enableEdit, this.onDeleteTest}){
    enableEdit??=true;
  }

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<SearchTestDropDown> with SingleTickerProviderStateMixin, UIMixin {
  Color color = Color.fromRGBO(163, 20, 19, 1.0);
  final TextEditingController _wordDropdownSearchFieldController = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wordDropdownSearchFieldController.text = widget.testInfo?.name??"";
  }
  @override
  void didUpdateWidget(covariant SearchTestDropDown oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    
    _wordDropdownSearchFieldController.text = widget.testInfo?.name??"";

  }
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: testDropDownSearch(
                      context: context, 
                      onSelectWord: (p0) {
                          setState(() {
                            _wordDropdownSearchFieldController.text = p0.name??"";
                             widget.onSelectTest(p0);
                          });
                },)),
              ]),
          SizedBox(height: 20,),
          Visibility(
            visible: _wordDropdownSearchFieldController.text.isNotEmpty,
            child: Chip(
              key: UniqueKey(),
              deleteIconColor: color,
              label: Text(_wordDropdownSearchFieldController.text),
              //deleteIcon: SizedBox(),
              onDeleted: () {
                widget.onDeleteTest;
              },
            ),
          ),
        ]
    );
  }
  Widget testDropDownSearch({Function(TestInfo)? onSelectWord,required BuildContext context}) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SizedBox(
              width: Dimens.size300,
              height: Dimens.size60,
              child: StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return SearchableDropdown<TestInfo>(
                    isEnabled: widget.enableEdit??true,
                    inputDecoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: Dimens.size45),
                      hintTextDirection: AppTheme.textDirection,
                      labelStyle: TextStyleConstant.textStyleBlack14w400,
                      hintStyle: TextStyleConstant.textStyleBlack14w400,
                      border: outlineInputBorder,
                      labelText: L10nX.getStr.test_str,
                      prefixIcon: Icon(
                        Icons.quiz,
                        color: ColorConst.colorIconRed,
                      ),
                    ),
                    remoteItems: (search) async {
                      return await getTestFilterList(search??"");
                    },
                    itemLabelFormatter: (value) {
                      return value.name??"";
                    },
                    onChanged: (TestInfo? value) {
                      if(onSelectWord!=null)
                      {
                        _wordDropdownSearchFieldController.text = value?.name??"";
                        widget.testInfo = value;
                        onSelectWord(value!);
                      }
                      else
                      {
                        ToastUtils.showToastError(L10nX.getStr.unknown_str);
                      }
                      print("object");
                    },
                    value: null,
                  );
                },
              ),
            ),
          ),
          Gap(Dimens.size16),
          InkWell(
            onTap: () {
              if(widget.enableEdit??true) {
                CreateEditTest().show(context);
              }
            },
            child: Icon(Icons.add_circle, color: ColorConst.mainColor,size: Dimens.size40,),
          )
        ]
    );
  }
  Future<List<TestInfo>>getTestFilterList(String keyWord) async{
    if(keyWord.isEmpty) {
      return [];
    }
    TestListResponseModel data = await FilterManager().getTestListAll(keyWord);
    List<TestInfo>? content=[];
    if((data.content??[]).isNotEmpty)
    {
      content = [...(data.content??[]).where((element) {
        String name = TiengViet.parse((element.name??'').toLowerCase());
        String keyWordfinal = TiengViet.parse(keyWord.toLowerCase());
        return name.contains(keyWordfinal);
      },)];
    }
    return content;
  }
  
}


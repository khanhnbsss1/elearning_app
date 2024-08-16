import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/services/apis/test/get_test_list_api.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/vocabulary_list_api.dart';
import 'package:webkit/views/test/test_detail/create_edit_test.dart';
import 'package:webkit/views/vocabulary/vocabulary_detail/create_edit_words.dart';

class SearchTestDropDown extends StatefulWidget {
  final Function(TestInfo) onSelectTest;
  TestInfo  ?testInfo;
  SearchTestDropDown({required this.onSelectTest, this.testInfo});

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
    if(widget.testInfo!=null)
      {
        _wordDropdownSearchFieldController.text = widget.testInfo?.name??"";
      }
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
                             widget.onSelectTest(p0);
                          });
                },)),
              ]),
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
              child: StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return DropDownSearchFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      controller: _wordDropdownSearchFieldController,
                      style: DefaultTextStyle.of(context).style.copyWith(
                          fontStyle: FontStyle.italic
                      ),
                      decoration: InputDecoration(
                        labelText: L10nX.getStr.vocabulary_str,
                        hintTextDirection: AppTheme.textDirection,
                        labelStyle: TextStyleConstant.textStyleBlack14w400,
                        hintStyle: TextStyleConstant.textStyleBlack14w400,
                        border: outlineInputBorder,
                        prefixIcon: Icon(
                          Icons.edit_document,
                          size: 20,
                          color: ColorConst.colorIconRed,
                        ),
                        suffixIcon: Icon(
                          LucideIcons.search,
                          size: 20,
                          color: ColorConst.colorIconRed,
                        ),
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
            
                    suggestionsCallback: (pattern) async {
                      return await getTestFilterList(pattern);
                    },
            
                    itemBuilder: (context, suggestion) {
                      return OnHoverWidget(
                        builder: (bool isHovered) {
                          return  Container(
                            decoration: BoxDecoration(
                                color: isHovered?ColorConst.mainColor.withOpacity(0.05):ColorConst.whiteColor,
                                border: Border(
                                    bottom: BorderSide(color: ColorConst.dividerColor)
                                )
                            ),
                            child: ListTile(
                              leading: Icon(Icons.book),
                              title: Text(suggestion.name??""),
                            ),
                          );
                        },
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      if(onSelectWord!=null)
                      {
                        //_wordDropdownSearchFieldController.text = suggestion.simplified??"";
                        onSelectWord(suggestion);
                      }
                      else
                      {
                        ToastUtils.showToastError(L10nX.getStr.unknown_str);
                      }
                      print("object");
                    },
                    transitionBuilder: (context, child, controller) {
                      return Container(
                        constraints: BoxConstraints(
                            maxHeight: Dimens.size300
                        ),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: ColorConst.whiteColor,
                            borderRadius: BorderRadius.circular(Dimens.size10)
                        ),
                        padding: EdgeInsets.all(Dimens.size8),
                        child: child,
                      );
                    },
                    displayAllSuggestionWhenTap: false,
                    hideSuggestionsOnKeyboardHide: true,
                  );
                },
              ),
            ),
          ),
          Gap(Dimens.size16),
          InkWell(
            onTap: () {
              CreateEditTest().show(context);
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
    GetTestListApi getLessonListApi= GetTestListApi(searchCommonRequest: SearchCommonRequest(keyword: keyWord, pageSize: 100, pageNumber: 0));
    TestListResponseModel data = await getLessonListApi.call();
    return data.content??[];
  }
  
}


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
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/vocabulary_list_api.dart';
import 'package:webkit/views/vocabulary/vocabulary_detail/create_edit_words.dart';

class SearchWordDropDown extends StatefulWidget {
  final List<VocabularyInfo> allWords;
  final List<VocabularyInfo>? exitsWords;
  final Function(VocabularyInfo) onAddWords;
  final Function(VocabularyInfo) onRemoveWords;

  SearchWordDropDown({required this.allWords, required this.onAddWords, required this.onRemoveWords, this.exitsWords});

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<SearchWordDropDown> with SingleTickerProviderStateMixin, UIMixin {
  Color color = Color.fromRGBO(163, 20, 19, 1.0);
  final TextEditingController _wordDropdownSearchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: wordsDropDownSearch(
                      context: context, onSelectWord: (p0) {
                        if([...(widget.exitsWords??[]).where((element) {return element.id == p0.id;},)].isEmpty) 
                        {
                          setState(() {
                             widget.onAddWords(p0);
                          });
                  }
                },)),
              ]),
          SizedBox(height: 20,),
          Wrap(
            children: (widget.exitsWords??[]).map((tag) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Chip(
                deleteIconColor: color,
                label: Text(tag.simplified??''),
                onDeleted: () {
                  setState(() {
                    widget.onRemoveWords(tag);
                  });
                },
              ),
            )).toList(),
          ),
        ]
    );
  }
  Widget wordsDropDownSearch({Function(VocabularyInfo)? onSelectWord,required BuildContext context}) {
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
                      return await getWordFilterList(pattern);
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
                              title: Text(suggestion.simplified??""),
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
              CreateEditWordsPage().show(context);
            },
            child: Icon(Icons.add_circle, color: ColorConst.mainColor,size: Dimens.size40,),
          )
        ]
    );
  }
  Future<List<VocabularyInfo>>getWordFilterList(String keyWord) async{
    if(keyWord.isEmpty) {
      return [];
    }
    GetListVocabularyApi getLessonListApi= GetListVocabularyApi(searchCommonRequest: SearchCommonRequest(keyword: keyWord, pageSize: 100, pageNumber: 0));
    VocabularyResponseModel data = await getLessonListApi.call();
    return data.content??[];
  }
  
}


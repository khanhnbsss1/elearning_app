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
import 'package:webkit/services/apis/question/get_quiz_list_api.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';
import 'package:webkit/views/test/test_detail/create_edit_test.dart';
import 'package:webkit/views/vocabulary/vocabulary_detail/create_edit_words.dart';

class SearchQuizDropDown extends StatefulWidget {
  final List<QuestionInfo> allWords;
  final List<QuestionInfo>? exitsQuestion;
  final Function(QuestionInfo) onAddWords;
  final Function(QuestionInfo) onRemoveWords;
  ActionType? actionType;
  SearchQuizDropDown({required this.allWords, required this.onAddWords, required this.onRemoveWords, this.exitsQuestion, this.actionType}){
    actionType??=ActionType.view;
  }

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<SearchQuizDropDown> with SingleTickerProviderStateMixin, UIMixin {
  Color color = Color.fromRGBO(163, 20, 19, 1.0);
  final TextEditingController _wordDropdownSearchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int count =0;

    for(QuestionInfo quest in (widget.exitsQuestion??[]))
    {
      count +=quest.weightage??0;
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.actionType != ActionType.view,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: questDropDownSearch(
                        context: context, onSelectWord: (p0) {
                          if([...(widget.exitsQuestion??[]).where((element) {return element.id == p0.id;},)].isEmpty) 
                          {
                            setState(() {
                               widget.onAddWords(p0);
                            });
                    }
                  },)),
                ]),
          ),
          SizedBox(height: 20,),
          Text("${(widget.exitsQuestion??[]).length} ${L10nX.getStr.question_str} - ${L10nX.getStr.maximum_point}: $count", 
            style: TextStyleConstant.textStyleBlack15w400,),
          Gap(Dimens.size16),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: (widget.exitsQuestion??[]).length,
              itemBuilder: (context, index) {
                QuestionInfo questionInfo = (widget.exitsQuestion??[]).elementAt(index);
                return Container(
                  decoration: BoxDecoration(
                    color: ColorConst.whiteColor,
                    border: Border.all(color: ColorConst.dividerColor, width: 0.2)
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${index+1}. ${questionInfo.questionName} "),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("${questionInfo.weightage??0} đ    ${L10nX().getStringByKey('${mapQuestionTypeToStrKey[questionInfo.questionType]}_type_str'.toLowerCase())}"),
                            Gap(Dimens.size8),
                            Visibility(
                              visible: widget.actionType != ActionType.view,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.onRemoveWords(questionInfo);
                                  });
                                },
                                child: Icon(Icons.delete_forever_outlined, color: ColorConst.colorIconRed,size: Dimens.size20,),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
                },),
          ),
        ]
    );
  }
  Widget questDropDownSearch({Function(QuestionInfo)? onSelectWord,required BuildContext context}) {
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
                        labelText: L10nX.getStr.search_lesson_str,
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
                      return await getQuestionFilterList(pattern);
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
                              title: Text(suggestion.questionName??""),
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
              //CreateEditWordsPage().show(context);
            },
            child: Icon(Icons.add_circle, color: ColorConst.mainColor,size: Dimens.size40,),
          )
        ]
    );
  }
  Future<List<QuestionInfo>>getQuestionFilterList(String keyWord) async{
    if(keyWord.isEmpty) {
      return [];
    }
    GetQuizListApi getLessonListApi= GetQuizListApi(searchCommonRequest: SearchCommonRequest(keyword: keyWord, pageSize: 100, pageNumber: 0));
    QuestionListResponseModel data = await getLessonListApi.call();
    return data.content??[];
  }
  
}


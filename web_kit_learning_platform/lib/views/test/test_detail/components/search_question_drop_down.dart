import 'package:async_searchable_dropdown/async_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/services/apis/question/get_quiz_list_api.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';

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
                  return SearchableDropdown<QuestionInfo>(
                    inputDecoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: Dimens.size45),
                      hintTextDirection: AppTheme.textDirection,
                      labelStyle: TextStyleConstant.textStyleBlack14w400,
                      hintStyle: TextStyleConstant.textStyleBlack14w400,
                      border: outlineInputBorder,
                      labelText: L10nX.getStr.search_lesson_str,
                      prefixIcon: Icon(
                        Icons.edit_document,
                        color: ColorConst.colorIconRed,
                      ),
                    ),
                    remoteItems: (search) async {
                      return await getQuestionFilterList(search??"");
                    },
                    itemLabelFormatter: (value) {
                      return value.questionName??"";
                    },
                    onChanged: (QuestionInfo? value) {
                      if(onSelectWord!=null)
                      {
                        //_wordDropdownSearchFieldController.text = suggestion.simplified??"";
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


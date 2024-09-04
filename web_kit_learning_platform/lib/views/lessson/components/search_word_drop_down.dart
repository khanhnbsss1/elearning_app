import 'package:async_searchable_dropdown/async_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/vocabulary_list_api.dart';
import 'package:webkit/views/vocabulary/create_edit_vocabullary/create_edit_words.dart';

class SearchWordDropDown extends StatefulWidget {
  final List<VocabularyInfo> allWords;
  final List<VocabularyInfo>? exitsWords;
  final Function(VocabularyInfo) onAddWords;
  final Function(VocabularyInfo) onRemoveWords;
  bool ? enableEdit;
  SearchWordDropDown({required this.allWords, required this.onAddWords, required this.onRemoveWords, this.exitsWords, this.enableEdit}){
    enableEdit??=true;
  }

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
            spacing: Dimens.size4,
            runSpacing: Dimens.size4,
            children: (widget.exitsWords??[]).map((tag) => Chip(
              deleteIconColor: color,
              label: Text(tag.simplified??''),
              onDeleted: () {
                if(widget.enableEdit??true)
                  {
                    setState(() {
                      widget.onRemoveWords(tag);
                    });
                  }
            
              },
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
                 return SearchableDropdown<VocabularyInfo>(
                   isEnabled: widget.enableEdit??true,
                    inputDecoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: Dimens.size45),
                      hintTextDirection: AppTheme.textDirection,
                      labelStyle: TextStyleConstant.textStyleBlack14w400,
                      hintStyle: TextStyleConstant.textStyleBlack14w400,
                      border: outlineInputBorder,
                      labelText: L10nX.getStr.vocabulary_str,
                      prefixIcon: Icon(
                        Icons.edit_document,
                        color: ColorConst.colorIconRed,
                      ),
                    ),
                    remoteItems: (search) async {
                      return getWordFilterList(search??"");
                    },
                    itemLabelFormatter: (value) {
                      return value.simplified??"";
                    },
                    onChanged: (VocabularyInfo? value) {
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
              if(widget.enableEdit??true)
                {
                  CreateEditWordsPage().show(context);
                }
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


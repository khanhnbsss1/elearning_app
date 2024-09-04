import 'package:async_searchable_dropdown/async_searchable_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/instance_mananger/filter_manager.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/plugins/screenshot/lib/screenshot.dart';
import 'package:webkit/services/apis/grade/models/grade_info.dart';
import 'package:webkit/services/apis/question/get_quiz_list_api.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';
import 'package:webkit/views/question/question_detail/question_detail.dart';
import 'package:webkit/views/question/question_detail/question_work/question_work_item.dart';
import 'package:webkit/widgets/item_edit_view_delete/item_edit_view_delete.dart';

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
            child: buildQuestionList()
          ),
        ]
    );
  }
  Widget buildQuestionList(){
    QuestionDataSource employeeDataSource = QuestionDataSource(
      data: widget.exitsQuestion??[],
      starIndex: 0,
      enableDelete: widget.actionType != ActionType.view,
      onDelete: (p0) {
        setState(() {
          widget.onRemoveWords(p0);
        });
      },
      onEdit: (p0) {
        QuestionCreateEditDetailPage(actionType: ActionType.edit,info: p0,).show(context);
      },
      onViewDetail: (p0) {
        QuestionWorkItem(
          questionInfo: p0,
          enableCloseButton: true,
        ).show(context);
      },
    );
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SfDataGridTheme(
          data: SfDataGridThemeData(
            headerColor: ColorConst.mainColor.withOpacity(0.1),
          ),
          child: SfDataGrid(
            source: employeeDataSource,
            columnWidthMode: ColumnWidthMode.fill,
            isScrollbarAlwaysShown: false,
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            headerRowHeight: Dimens.size60,
            showHorizontalScrollbar: true,
            columns: <GridColumn>[
              GridColumn(
                  columnName: 'id',
                  maximumWidth: Dimens.size50,
                  label: Container(
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: Text(
                        'ID',
                      ))),
              GridColumn(
                  columnName: L10nX.getStr.question_str,
                  //minimumWidth: Dimens.size250,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(
                        L10nX.getStr.question_str,
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: L10nX.getStr.type,
                  maximumWidth: Dimens.size120,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(L10nX.getStr.type))),
              GridColumn(
                  columnName: L10nX.getStr.grade_str,
                  maximumWidth: Dimens.size120,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(L10nX.getStr.grade_str))),
              GridColumn(
                  columnName: L10nX.getStr.score_str,
                  maximumWidth: Dimens.size80,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(L10nX.getStr.score_str))),
              
              GridColumn(
                  columnName: L10nX.getStr.action_str,
                  maximumWidth: Dimens.size180,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(L10nX.getStr.action_str))),
        
            ],
          ),
        );
      },
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
                    key: UniqueKey(),
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
    QuestionListResponseModel questionListResponseModel =  await FilterManager().getQuestionListAll(keyWord);
    List<QuestionInfo>? content=[];
    if((questionListResponseModel.content??[]).isNotEmpty)
    {
      content = [...(questionListResponseModel.content??[]).where((element) {
        String name = TiengViet.parse((element.questionName??'').toLowerCase());
        String keyWordfinal = TiengViet.parse(keyWord.toLowerCase());
        return name.contains(keyWordfinal);
      },)];
    }
    return content;
  }
  
}

class QuestionDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  Function(QuestionInfo) onViewDetail, onEdit, onDelete;
  int? starIndex;
  List<QuestionInfo> data;
  bool enableDelete;
  QuestionDataSource({
    required this.data,
    this.starIndex,
    required this.enableDelete,
    required this.onDelete,
    required this.onEdit,
    required this.onViewDetail
  }) {

    _lessonData = data.map<DataGridRow>((e) {
      starIndex = (starIndex ??0)+1;
      
      Widget gradeWidget = FutureBuilder(future: FilterManager().getGradesInfo(), builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return SizedBox();
        }
        List<GradeInfo>? content = snapshot.data?.content??[];
        GradeInfo? gradeInfo;
        if(content.where((element) => element.id == e.gradeId,).isNotEmpty)
        {
          gradeInfo = content.firstWhere((element) => element.id == e.gradeId,);
        }
        else
        {
          gradeInfo = content.first;
        }
        return Text(gradeInfo.name??"", style: TextStyleConstant.textStyleBlack14w400,);
      },);
      return  DataGridRow(
          cells: [
            DataGridCell<Widget>(columnName: 'id', value: Text("$starIndex", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.question_str, value:
            Row(
              children: [
                Expanded(
                    child: Text(
                      e.questionName??"", 
                      textAlign: TextAlign.start,
                      style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            ) ),
            DataGridCell<Widget>(columnName: L10nX.getStr.type, value: Text(L10nX().getStringByKey("${mapQuestionTypeToStrKey[e.questionType]??""}_type_str".toLowerCase()), style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.grade_str, value: gradeWidget),
            DataGridCell<Widget>(columnName: L10nX.getStr.score_str, value: Text(e.weightage.toString(), style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.action_str,
                value: ItemViewEditDelete(
                  itemInfo: e,
                  enableEdit: UserManager().userContainPermission(permissionList: ["quizs.put.update_question"]),
                  enableEditDelete: enableDelete,
                  onViewDetail: (p0) {
                    onViewDetail(p0);
                  },
                  onEdit: (p0) {
                    onEdit(p0);
                  },
                  onDelete: (p0) {
                    onDelete(p0);
                  },
                )),
          ]);
    },).toList();
  }

  List<DataGridRow> _lessonData = [];

  @override
  List<DataGridRow> get rows => _lessonData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(Dimens.size8),
          child: e.value,
                        );
        }).toList());
  }
}



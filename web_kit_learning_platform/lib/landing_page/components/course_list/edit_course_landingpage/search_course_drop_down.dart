import 'package:async_searchable_dropdown/async_searchable_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/instance_mananger/filter_manager.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/course/course_list/course_api.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
import 'package:webkit/services/apis/grade/models/grade_info.dart';
import 'package:webkit/views/course/course_detail/course_preview.dart';
import 'package:webkit/widgets/item_edit_view_delete/item_edit_view_delete.dart';

class SearchCourseDropDown extends StatefulWidget {
  final List<CourseInfo> allWords;
  final List<CourseInfo>? exitsQuestion;
  final Function(CourseInfo) onAddWords;
  final Function(CourseInfo) onRemoveWords;
  ActionType? actionType;
  SearchCourseDropDown({required this.allWords, required this.onAddWords, required this.onRemoveWords, this.exitsQuestion, this.actionType}){
    actionType??=ActionType.view;
  }

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<SearchCourseDropDown> with SingleTickerProviderStateMixin, UIMixin {
  Color color = Color.fromRGBO(163, 20, 19, 1.0);
  final TextEditingController _wordDropdownSearchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.actionType != ActionType.view,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: courseDropDownSearch(
                        context: context, onSelectWord: (p0) {
                          if([...(widget.exitsQuestion??[]).where((element) {return element.id == p0.id;},)].isEmpty) 
                          {
                            setState(() {
                               //widget.exitsQuestion?.add(p0);
                               widget.onAddWords(p0);

                            });
                    }
                  },)),
                ]),
          ),
          Gap(Dimens.size16),
          Expanded(
            child: buildCourseList()
          ),
        ]
    );
  }
  Widget buildCourseList(){
    CourseDataSource employeeDataSource = CourseDataSource(
      data: widget.exitsQuestion??[],
      starIndex: 0,
      enableDelete: true,
      onEdit: (p0) {
      },
      onDelete: (p0) {
        setState(() {
          widget.onRemoveWords(p0);
        });
      },
      onViewDetail: (p0) {
        CoursePreview(
          courseInfo: p0,
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
            headerRowHeight: Dimens.size80,
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
                  columnName: L10nX.getStr.course_name,
                  //minimumWidth: Dimens.size250,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(
                        L10nX.getStr.course_name,
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: L10nX.getStr.author_str,
                  maximumWidth: Dimens.size120,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(L10nX.getStr.author_str))),
              GridColumn(
                  columnName: L10nX.getStr.grade_str,
                  maximumWidth: Dimens.size120,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(L10nX.getStr.grade_str))),
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
  Widget courseDropDownSearch({Function(CourseInfo)? onSelectWord,required BuildContext context}) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Dimens.size350,
            child: StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
                return SearchableDropdown<CourseInfo>(
                  key: UniqueKey(),
                  inputDecoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: Dimens.size45),
                    hintTextDirection: AppTheme.textDirection,
                    labelStyle: TextStyleConstant.textStyleBlack14w400,
                    hintStyle: TextStyleConstant.textStyleBlack14w400,
                    border: outlineInputBorder,
                    labelText: L10nX.getStr.course_name,
                    prefixIcon: Icon(
                      Icons.edit_document,
                      color: ColorConst.colorIconRed,
                    ),
                  ),
                  remoteItems: (search) async {
                    return await getCourseFilterList(search??"");
                  },
                  itemLabelFormatter: (value) {
                    return value.name??"";
                  },
                  onChanged: (CourseInfo? value) {
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
        ]
    );
  }
  Future<List<CourseInfo>>getCourseFilterList(String keyWord) async{
    if(keyWord.isEmpty) {
      return [];
    }
    GetCourseListApi courseApi = GetCourseListApi(searchCommonRequest: SearchCommonRequest(
        filterType: "ALL", pageNumber: 0, 
        pageSize: 100, keyword: keyWord, 
        isActive: true));
    CourseResponseModel courseResponseModel = await courseApi.call();
    return courseResponseModel.content??[];
  }
  
}

class CourseDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  Function(CourseInfo) onViewDetail, onEdit, onDelete;
  int? starIndex;
  List<CourseInfo> data;
  bool enableDelete;
  CourseDataSource({
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
            DataGridCell<Widget>(columnName: L10nX.getStr.course_name, value:
            Row(
              children: [
                Expanded(
                    child: Text(
                      e.name??"", 
                      textAlign: TextAlign.start,
                      style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            ) ),
            DataGridCell<Widget>(columnName: L10nX.getStr.author_str, value: Text(e.producerName??"", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.grade_str, value: gradeWidget),
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



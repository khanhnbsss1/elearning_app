
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../base.export.dart';
import '../scroll/custom_single_child_scroll_view.dart';
import 'animation/onhover_widget.dart';
import 'bloc/table_common_bloc.dart';
class ListWidgetTableBodyModel{
  Widget? bodyTitle;
  List<Map<String,Widget>> listWidgetTableBody = List.empty(growable: true);
  ListWidgetTableBodyModel(
      {
        required this.listWidgetTableBody,
        this.bodyTitle
  });
}
abstract class TableCommon extends StatelessWidget {
  BuildContext? buildContext;
  TableCommonState? _state;
  List<ListWidgetTableBodyModel> listOfListWidgetTableBodyModel = List.empty(growable: true);
  List<Widget> listWidgetTableHeader = List.empty(growable: true);
  double? widthOfTable;
  Map<String, int> initColumnInfo = {
    "stt": 1,
    "username": 3,
    "full_name": 4,
    "role": 8,
    "email": 4,
    "phone_number": 3,
    "birth_year": 2,
    "action": 4,
  };
  TableCommon({super.key, this.widthOfTable, } ){
    setColumnInfo();
  }

  void setColumnInfo();

  void buildDataForTableBody();
  void initPixelValueForColumnInfo(TableCommonState state){
    state.tableColumnInfo!.totalColumnWithStep = 0;
    for(String key in initColumnInfo.keys)
    {
      state.tableColumnInfo!.totalColumnWithStep =state.tableColumnInfo!.totalColumnWithStep! + initColumnInfo[key]!;
    }

    for(String key in initColumnInfo.keys) // tinh toan do rong theo ti le cua cot ra pixel
        {
      initColumnInfo[key] = state.widthOftable! * initColumnInfo[key]!~/state.tableColumnInfo!.totalColumnWithStep!;
      if(initColumnInfo[key]!<Dimens.size40) {
        initColumnInfo[key] = Dimens.size40.toInt();
      }
    }
    state.tableColumnInfo!.columnInfo = initColumnInfo;
    _state = state;
  }

  void setPixelOffsetForColumnByIndex(int index, int offset)
  {
    initColumnInfo = _state!.tableColumnInfo!.columnInfo!;
    _state!.widthOftable = _state!.widthOftable! - initColumnInfo[ initColumnInfo.keys.elementAt(index)]!;
    initColumnInfo[ initColumnInfo.keys.elementAt(index)] = initColumnInfo[initColumnInfo.keys.elementAt(index)]! + offset;
    if(initColumnInfo[ initColumnInfo.keys.elementAt(index)]! < Dimens.size40) {
      initColumnInfo[ initColumnInfo.keys.elementAt(index)] = Dimens.size40.toInt();
    }
    _state!.widthOftable = _state!.widthOftable! + initColumnInfo[ initColumnInfo.keys.elementAt(index)]!;
    _state!.tableColumnInfo!.columnInfo = initColumnInfo;

  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return BlocProvider(
        create: (context) {
          TableCommonState tableCommonState = TableCommonState(tableCommonStatus: TableCommonStatus.initial);
          if(widthOfTable!=null)
            {
              tableCommonState.widthOftable = widthOfTable;
            }
          return TableCommonBloc(tableCommonState)..add(const TableCommonInitEvent());
        },
        child: BlocConsumer<TableCommonBloc, TableCommonState>(
            listener: (context, state) {
              _state = state;
              switch(state.tableCommonStatus)
                  {

                case TableCommonStatus.initial:
                  
                  break;
                case TableCommonStatus.unknown:
                  
                  break;
                case TableCommonStatus.updateColumnSize:
                  setPixelOffsetForColumnByIndex(state.tableColumnInfo!.index, state.tableColumnInfo!.offsetColumnSize.toInt());
                  state.tableCommonStatus = TableCommonStatus.unknown;
                  
                  break;
                case TableCommonStatus.onRefreshTable:
                  state.tableCommonStatus = TableCommonStatus.unknown;
                  
                  break;
              }

            },
            builder: (BuildContext context, state) {
              buildContext = context;
              if(state.tableCommonStatus == TableCommonStatus.initial)
                {
                  return LayoutBuilder(
                      builder: (buildContext , boxConstraints ) {
                        final box = context.findRenderObject() as RenderBox;
                        BoxConstraints contraints = box.constraints;
                        state.widthOftable = widthOfTable??contraints.maxWidth;
                        state.tableColumnInfo = TableColumnInfo(index: 0, offsetColumnSize: 0);
                        _state = state;
                        initPixelValueForColumnInfo(state);
                        state.tableColumnInfo!.columnInfo = initColumnInfo;
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorConst.gray01ColorOnBackgroundColor),
                              borderRadius:  BorderRadius.all(Radius.circular(Dimens.size8)),
                        ),
                          child: CustomSingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: state.widthOftable,
                              child: Padding(
                                padding:   EdgeInsets.only(bottom: Dimens.size10),
                                child: _buildLayout(),
                              ),
                            ),
                          ),
                        );
                      }, );
                }
              else
                {
                  _state = state;
                  return LayoutBuilder(
                    builder: (buildContext , boxConstraints ) {
                      return
                        CustomSingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: state.widthOftable,
                            child: Padding(
                              padding:  EdgeInsets.only(bottom: Dimens.size10),
                              child: _buildLayout(),
                            ),
                          ),
                        );
                    },
                  );
                }

            }),);

  }
  Widget _buildLayout()
  {
    initColumnInfo = _state!.tableColumnInfo!.columnInfo!;
    _buildDataForHeader();
    buildDataForTableBody();
    List<Widget> bodyList = List.empty(growable: true);
    for(ListWidgetTableBodyModel listWidgetTableBodyModel in listOfListWidgetTableBodyModel)
      {
        List<Map<String, Widget>> listWidgetTableBody = listWidgetTableBodyModel.listWidgetTableBody;
        if(listWidgetTableBodyModel.bodyTitle!=null)
          {
            bodyList.add(listWidgetTableBodyModel.bodyTitle!,);
          }
        bodyList.add(contentTable(buildContext!, listWidgetTableBody: listWidgetTableBody, ));
      }
    return Container(
        constraints: BoxConstraints(
        maxHeight:  MediaQuery.of(buildContext!).size.height,
       // minHeight:  MediaQuery.of(buildContext!).size.height/4,
      ),
      child: Column(
        children: [
          tableHeader(buildContext!),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(buildContext!).size.height - 60,
              child: CustomSingleChildScrollView(
                thumbVisibility: false,
                controller: ScrollController(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: bodyList,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _buildDataForHeader()
  {
    listWidgetTableHeader.clear();
    int columnIndex = 0;
    for(String key in initColumnInfo.keys)
      {

        String columnName =  L10nX().getStringByKey(key);
        if(columnName =='Transalate missing key')
          {
            columnName = key;
          }

        listWidgetTableHeader.add(
            Expanded(
              flex: (initColumnInfo[key]!.toDouble() ).toInt(),
              child: Center(
                  child: Text(
                    columnName,
                    textAlign: TextAlign.center,
                    style: TextStyleConstant.textStyleBlack14w400,
                  )),
            ));
        if(columnIndex < initColumnInfo.keys.length)
        {
          listWidgetTableHeader.add(_lineVertical(columnIndex),);
        }
        columnIndex++;
      }
  }

  Widget tableHeader(BuildContext context) {
    return LayoutBuilder(
      builder: (buildContext , boxConstraints ) {
       return Container(
         width: boxConstraints.maxWidth,
         constraints:  BoxConstraints(
             minHeight: Dimens.size20,maxHeight: Dimens.size50),
          decoration: BoxDecoration(
              color: ColorConst.mainColor.withOpacity(0.15),
              borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.size8))),
          child: Row(
            children: listWidgetTableHeader,
          ),
        );
      },
    );
  }

  Widget _lineVertical(int columnIndex) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeLeftRight,
      child: GestureDetector(
          onPanUpdate: (details) {
            BlocProvider.of<TableCommonBloc>(buildContext!).
            add(TableCommonUpdateColumnSizeEvent(
                tableColumnInfo: _state!.tableColumnInfo!.copyWith(
                    index: columnIndex, offsetColumnSize: details.delta.dx)));
          },
          child: Row(
            children: [
              Container(
                height: Dimens.size20,
                width: Dimens.size5,
                color: Colors.transparent,
              ),
              Container(
                height: Dimens.size20,
                width: Dimens.size2,
                color: ColorConst.greyColor1,
              ),
              Container(
                height: Dimens.size20,
                width: Dimens.size5,
                color: Colors.transparent,
              ),
            ],
          )),
    );
  }

  Widget contentTable(BuildContext context, {required List<Map<String, Widget>> listWidgetTableBody}) {
    return listWidgetTableBody.isNotEmpty?
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight:  MediaQuery.of(context).size.height,
          ),
          child: ListView.builder(
            controller: ScrollController(),
              itemCount: listWidgetTableBody.length,//listEmployee.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return tableRow(context, index, listWidgetTableRow: listWidgetTableBody.elementAt(index));
              }),
        ),
      ],
    ):NoData();
  }
  Widget tableRow(BuildContext context, int index, {required Map<String, Widget> listWidgetTableRow}) {

    List<Widget> itemsColumns = List.empty(growable: true);
    for(int columnIndex = 0; columnIndex<listWidgetTableRow.keys.length; columnIndex++)
      {
        itemsColumns.add(
            Expanded(
              flex: (initColumnInfo[listWidgetTableRow.keys.elementAt(columnIndex)]!.toDouble()).toInt(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: listWidgetTableRow.values.elementAt(columnIndex),
              ),
            ));
        itemsColumns.add( Gap(Dimens.size22));
      }
    return OnHoverWidget(
        builder: (isHover) {
          return Column(
            children: [
              Container(
                color: (isHover) ? ColorConst.mainColor.withOpacity(0.4) : ColorConst.whiteColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: itemsColumns,
                ),
              ),
              Container(
                height: Dimens.size1,
                color: ColorConst.greyColor1.withOpacity(0.03),
              )
            ],
          );
        }
    );
  }
}

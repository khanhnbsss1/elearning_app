import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/page_common/permission_page.dart';
import 'package:webkit/base/widgets/pagination/pagination_custom.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/test/delete_test_api.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import 'package:webkit/views/test/test_detail/create_edit_test.dart';
import 'package:webkit/views/test/test_detail_work/test_work_page.dart';
import 'package:webkit/widgets/item_edit_view_delete/item_edit_view_delete.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import 'bloc/test_list_bloc.dart';

class TestListPage extends StatefulWidget {
  TestListType testListType;
  TestListPage({super.key, required this.testListType});
  @override
  State<TestListPage> createState() => _TestListPageState();
}

class _TestListPageState extends State<TestListPage> with SingleTickerProviderStateMixin, UIMixin {
  late MemberListController controller;
 TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState>? formKey = GlobalKey();
  ScrollController scrollController=ScrollController();
  @override
  void initState() {
    super.initState();
    controller = Get.put(MemberListController());
  }

  int? page = 1;
  final int pageItemCount = 16;
  late int pageCount;
  bool isOnVolume=  false;
  List<String>permission =[
    "tests.get.get_tests"
  ];
  @override
  Widget build(BuildContext context) {
    return PermissionPage(
      permissionList: permission,
      child: BlocProvider(
        create: (context) {
          return TestListBloc(TestListState(testListType:  widget.testListType))..add(TestListInitEvent());
        },
        child: BlocConsumer<TestListBloc, TestListState>(
          listener: (context, state) {
            switch (state.blocStatus) {
              case TestListStatus.initial:
                break;
              default:
                break;
                // TODO: Handle this case.
            }
          },
          builder: (BuildContext context, state) {
            return MyResponsive(
              builder: (context , boxConstraints , myScreenMediaType ) {
                if(!myScreenMediaType.isMobile)
                  {
                    return Layout(
                        isScroll: false,
                        title: Center(
                          child: Text(L10nX.getStr.test_list,
                            style: TextStyleConstant.textStyleBlack18w600,),),
                        padding: EdgeInsets.only(top: Dimens.size60),
                        child: buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType));
                  }
                else
                  {
                    return Layout(
                      isScroll: false,
                        title: Center(
                          child: Text(L10nX.getStr.test_list,
                            style: TextStyleConstant.textStyleBlack18w600,),),
                        child: buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType)
                    );
                  }
              },);
            
          },
        ),
      ),
    );
  }
  Widget buildLeftPage(
  {
    required MyScreenMediaType myScreenMediaType,
    required BoxConstraints boxConstraints,
    required BuildContext context,
    required TestListState state
  }
      ){
    return Container(
      color: ColorConst.whiteColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildListFilter(context: context, state: state, myScreenMediaType: myScreenMediaType, boxConstraints: boxConstraints),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: buildTestTableList(state: state, context: context),
          )),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PaginationCustom(
                key: GlobalKey(debugLabel: (state.listResponseModel?.total??0).toString()),
                currentPage: state.listResponseModel!.getCurrentPage(),
                limitPerPage: state.listResponseModel!.pageSize??10,
                totalDataCount: state.listResponseModel!.getTotalElement(),
                onPreviousPage: (p0) {
                  BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                },
                onBackToFirstPage: (p0) {
                  BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                },
                onNextPage: (p0) {
                  BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                },
                onGoToLastPage: (p0) {
                  BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                },
                backgroundColor: ColorConst.whiteColor,
                textStyle: TextStyleConstant.textStyleBlack14w700.copyWith(color: ColorConst.mainColor),
                previousPageIcon: Icons.keyboard_arrow_left,
                backToFirstPageIcon: Icons.first_page,
                nextPageIcon: Icons.keyboard_arrow_right,
                goToLastPageIcon: Icons.last_page,
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget buildListFilter(  {
    required MyScreenMediaType myScreenMediaType,
    required BoxConstraints boxConstraints,
    required BuildContext context,
    required TestListState state
  }){
   return LayoutBuilder(builder: (context, constraints) {
     return Container(
       decoration: BoxDecoration(
           border: Border(
               bottom: BorderSide(color: ColorConst.dividerColor, width: 0.2)
           )
       ),
       padding: EdgeInsets.symmetric(vertical: Dimens.size8, horizontal: 16),
       child: SizedBox(
         height:Dimens.size40,
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Row(
               mainAxisSize: MainAxisSize.min,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Container(
                   //height: Dimens.size40,
                   constraints: BoxConstraints(
                       maxWidth:  constraints.maxWidth> Dimens.size600?Dimens.size400:Dimens.size250
                   ),
                   child: Form(
                     key: formKey,
                     child: Row(
                       children: [
                         Expanded(
                           child: TextFormField(
                             maxLines: 1,
                             controller: textEditingController,
                             onChanged: (value) {
                           
                             },
                             onFieldSubmitted: (value) {
                               BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value, pageNumber: 0)));
                             },
                             onTapOutside: (event) {
                             },
                             style: TextStyleConstant.textStyleBlack14w400,
                             
                             decoration: InputDecoration(
                                 hintText: L10nX.getStr.search,
                                 fillColor: ColorConst.whiteColor,
                                 filled: true,
                                 hintStyle: TextStyleConstant.textStyleBlack13w400,
                                 border: outlineInputBorder.copyWith(borderRadius: BorderRadius.circular(Dimens.size16)),
                                 
                                 enabledBorder: outlineInputBorder.copyWith(borderRadius: BorderRadius.circular(Dimens.size16)),
                                 focusedBorder: focusedInputBorder.copyWith(borderRadius: BorderRadius.circular(Dimens.size16)),                                
                                 prefixIcon: Align(
                                     alignment: Alignment.center,
                                     child: Icon(
                                       LucideIcons.search,
                                       size: Dimens.size15,
                                     )),
                                 prefixIconConstraints:  BoxConstraints(
                                   minWidth: Dimens.size40,
                                   maxWidth: Dimens.size40,
                                   minHeight: Dimens.size40,
                                   maxHeight: Dimens.size40,),
                                 contentPadding: MySpacing.xy(Dimens.size16, Dimens.size12),
                                 //isCollapsed: true,
                                 floatingLabelBehavior: FloatingLabelBehavior.always),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
                 Gap(Dimens.size16),
                 Visibility(
                   visible: constraints.maxWidth> 600,
                   child: ActionButton1(
                     text: L10nX.getStr.search,
                     onTap: () {
                       BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text, pageNumber: 0)));
                     },
                   ),
                 ),
                 Visibility(
                   visible: constraints.maxWidth< 600,
                   child: InkWell(
                       onTap: () {
                         BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text, pageNumber: 0)));
                       },
                       child: Icon(Icons.search, color: ColorConst.mainColor,size: Dimens.size40,)),
                 ),
               ],
             ),
             Visibility(
               visible: UserManager().userContainPermission(permissionList: [
                 "tests.post.create_create_test"
               ]),
               child: Row(
                 children: [
                   Gap(Dimens.size10),
                   Visibility(
                     visible: constraints.maxWidth< 600,
                     child: InkWell(
                         onTap: () {
                           CreateEditTest(testActionType: ActionType.create, callBack: () {
                             BlocProvider.of<TestListBloc>(context).add(TestListInitEvent());
                           },).show(context);
                         },
                         child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
                   ),
                   Visibility(
                     visible: constraints.maxWidth >600,
                     child: ActionButton1(
                       preIcon: Icon(Icons.add_circle_outline, color: ColorConst.whiteColor,size: Dimens.size15,),
                       text: L10nX.getStr.add_new_str,
                       onTap: () {
                         CreateEditTest(testActionType: ActionType.create, callBack: () {
                           BlocProvider.of<TestListBloc>(context).add(TestListInitEvent());
                         },).show(context);
                       },
                     ),
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
     );
   },);
  }
  Widget buildTestTableList({required TestListState state, required BuildContext context}){
    return Padding(
        padding:  EdgeInsets.all(Dimens.size8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            switch (state.blocStatus) {
              case null:
              // TODO: Handle this case.
              case TestListStatus.initial:
              // TODO: Handle this case.
              case TestListStatus.onLoading:
              // TODO: Handle this case.           // TODO: Handle this case.
              case TestListStatus.onSearchByParams:
              // TODO: Handle this case.
                return Center(child: CircularProgressIndicator());
              case TestListStatus.onLoadEnd:
              // TODO: Handle this case.
                TestDataSource employeeDataSource = TestDataSource(
                  lessonData: state.listResponseModel?.content??[],
                  testListType: state.testListType!,
                  starIndex: (state.searchCommonRequest?.pageNumber??0)* (state.searchCommonRequest?.pageSize??0),
                  onDelete: (p0)  {
                    ConfirmPopupPage(
                      title: "${L10nX.getStr.delete_str} ${L10nX.getStr.test_str.toLowerCase()}",
                      content: L10nX.getStr.you_want_remove,
                      onAccept: () async {
                        MonitorLoading().showLoading("");
                        DeleteTestApi api = DeleteTestApi(info: p0);
                        dynamic data = await api.call();
                        MonitorLoading().dismiss();
                        BlocProvider.of<TestListBloc>(context).add(TestListInitEvent());
                      },
                    ).show(context);
                  
                  },
                  onEdit: (p0) {
                    CreateEditTest(
                      testActionType: ActionType.edit,
                      testInfo: p0,
                      callBack: () {
                        BlocProvider.of<TestListBloc>(context).add(TestListInitEvent());
                      },).show(context,);
                  },
                  onViewDetail: (p0) {
                    TestWorkPage(
                      testInfo: p0,
                      enableCloseButton: true,
                      enableShowResult: true,
                    ).show(context);
                  },
                  onStartTest: (p0) {
                    TestWorkPage(
                      testInfo: TestInfo(
                          id: p0.id, 
                          name:p0.name ?? ''),
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
                        rowHeight: Dimens.size60,
                        showHorizontalScrollbar: true,
                        columns: <GridColumn>[
                          GridColumn(
                              columnName: 'id',
                              maximumWidth: Dimens.size80,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'ID',
                                    style: TextStyleConstant.textStyleBlack14w500,
                                  ))),
                          GridColumn(
                              columnName: L10nX.getStr.test_name,
                              minimumWidth: Dimens.size200,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    L10nX.getStr.test_name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyleConstant.textStyleBlack14w500,
                                  ))),
                          GridColumn(
                              columnName: L10nX.getStr.type,
                              maximumWidth: Dimens.size250,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(
                                      L10nX.getStr.type,
                                    style: TextStyleConstant.textStyleBlack14w500,
                                  ))),
                          GridColumn(
                              columnName: L10nX.getStr.duration_str,
                              maximumWidth: Dimens.size150,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${L10nX.getStr.duration_str} (${L10nX.getStr.time_in_minute_str})" ,
                                    style: TextStyleConstant.textStyleBlack14w500,))),
                          GridColumn(
                              columnName: L10nX.getStr.action_str,
                              minimumWidth: Dimens.size180,
                              maximumWidth: Dimens.size200,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.action_str,style: TextStyleConstant.textStyleBlack14w500,))),

                        ],
                      ),
                    );
                  },
                );

            }
          },
        ));
  }
  
}
class TestDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  TestListType testListType;
  Function(TestInfo) onViewDetail, onEdit, onDelete, onStartTest;
  int? starIndex;
  TestDataSource({
    required List<TestInfo> lessonData, 
    required this.testListType,
    this.starIndex,
    required this.onDelete, 
    required this.onEdit, 
    required this.onStartTest,
    required this.onViewDetail}) {
    
    _lessonData = lessonData.map<DataGridRow>((e) {
      starIndex = (starIndex ??0)+1;
      return  DataGridRow(
          cells: [
            DataGridCell<Widget>(columnName: 'id', value: Text("$starIndex", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.test_name, value:Row(
              children: [
                Expanded(child: Text(e.name??"", style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            ) ),
            DataGridCell<Widget>(columnName: L10nX.getStr.type, value: Text(L10nX().getStringByKey("${mapTestLevelToStrKey[e.testType?? TestType.OUTPUT]}_test_str".toLowerCase()), style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.duration_str, value: Text("${(e.durian??0)}", style: TextStyleConstant.textStyleBlack14w400,)),
            //DataGridCell<Widget>(columnName: L10nX.getStr.doing_time_str, value: Text("${(e.}", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.action_str, 
                value: 
                    testListType==TestListType.editList?
                ItemViewEditDelete(
                  itemInfo: e,
                  enableEditDelete: UserManager().userContainPermission(permissionList: ["tests.delete.delete_test"]),
                  enableEdit: UserManager().userContainPermission(permissionList: ["tests.delete.delete_test"]),
                  enableView: UserManager().userContainPermission(permissionList: ["tests.delete.delete_test"]),
                
                  onViewDetail: (p0) {
                    onViewDetail(p0);
                  },
                  onEdit: (p0) {
                    onEdit(p0);
                  },
                  onDelete: (p0) {
                    onDelete(p0);
                  },
                ): 
                    ActionButton1(
                      text: L10nX.getStr.begin_start_test,
                      onTap: () {
                        onStartTest(e);
                      },
                    )
            ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/page_common/permission_page.dart';
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
  TestListPage({super.key});
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
          return TestListBloc(TestListState())..add(TestListInitEvent());
        },
        child: BlocConsumer<TestListBloc, TestListState>(
          listener: (context, state) {
            switch (state.blocStatus) {
              case TestListStatus.initial:
                break;
                // TODO: Handle this case.
              case TestListStatus.onSelectTag:
                {
                }
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
                        padding: EdgeInsets.only(top: 35 + 16, bottom: 0),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                FlutterCustomPagination(
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
                     maxWidth:  constraints.maxWidth> 600?400:250
                 ),
                 child: Form(
                   key: formKey,
                   child: Row(
                     children: [
                       Expanded(
                         child: SizedBox(
                           height:Dimens.size45,
                           child: TextFormField(
                             maxLines: 1,
                             controller: textEditingController,
                             onChanged: (value) {
                           
                             },
                             onFieldSubmitted: (value) {
                               BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
                             },
                             onTapOutside: (event) {
                             },
                             style: MyTextStyle.bodyMedium(),
                             decoration: InputDecoration(
                                 hintText: L10nX.getStr.search,
                                 fillColor: ColorConst.whiteColor,
                                 filled: true,
                                 hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                 border: outlineInputBorder.copyWith(borderRadius: BorderRadius.circular(16)),
                                 enabledBorder: outlineInputBorder.copyWith(borderRadius: BorderRadius.circular(16)),
                                 focusedBorder: focusedInputBorder.copyWith(borderRadius: BorderRadius.circular(16)),
                                 prefixIcon: const Align(
                                     alignment: Alignment.center,
                                     child: Icon(
                                       LucideIcons.search,
                                       size: 14,
                                     )),
                                 prefixIconConstraints: const BoxConstraints(
                                     minWidth: 36,
                                     maxWidth: 36,
                                     minHeight: 32,
                                     maxHeight: 32),
                                 contentPadding: MySpacing.xy(16, 12),
                                 //isCollapsed: true,
                                 floatingLabelBehavior: FloatingLabelBehavior.auto),
                           ),
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
                   radius: 16,
                   onTap: () {
                     BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                   },
                 ),
               ),
               Visibility(
                 visible: constraints.maxWidth< 600,
                 child: InkWell(
                     onTap: () {
                       BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
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
                     preIcon: Icon(Icons.add_circle_outline, color: ColorConst.whiteColor,),
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
     );
   },);
  }
  Widget buildTestTableList({required TestListState state, required BuildContext context}){
    TestDataSource employeeDataSource = TestDataSource(
      lessonData: state.listResponseModel?.content??[],
      onDelete: (p0) async {
        MonitorLoading().showLoading("");
        DeleteTestApi api = DeleteTestApi(info: p0);
        dynamic data = await api.call();
        MonitorLoading().dismiss();

        BlocProvider.of<TestListBloc>(context).add(TestListInitEvent());
      },
      onEdit: (p0) {
        CreateEditTest(
          testActionType: ActionType.edit, 
          testInfo: p0,
          callBack: () {
          BlocProvider.of<TestListBloc>(context).add(TestListInitEvent());
        },).show(context);
      },
      onViewDetail: (p0) {
        TestWorkPage(
          testInfo: p0,
          enableCloseButton: true,
          enableShowResult: true,
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
            rowHeight: Dimens.size80,
/*            onQueryRowHeight: (details) {
              return details.getIntrinsicRowHeight(details.rowIndex);
            },*/
            //defaultColumnWidth: 200,
            showHorizontalScrollbar: true,
            columns: <GridColumn>[
              GridColumn(
                  columnName: 'id',
                  maximumWidth: Dimens.size60,
                  label: Container(
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: Text(
                        'ID',
                      ))),
              GridColumn(
                  columnName: L10nX.getStr.test_name,
                  minimumWidth: Dimens.size200,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(
                        L10nX.getStr.test_name,
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: L10nX.getStr.course_str,
                  minimumWidth: Dimens.size200,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(L10nX.getStr.course_str))),
              GridColumn(
                  columnName: L10nX.getStr.subject_str,
                  minimumWidth: Dimens.size120,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(L10nX.getStr.subject_str))),
              GridColumn(
                  columnName: L10nX.getStr.type,
                  minimumWidth: Dimens.size120,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(L10nX.getStr.type))),
              GridColumn(
                  columnName: L10nX.getStr.question_number,
                  maximumWidth: Dimens.size120,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(L10nX.getStr.question_number))),
        
        /*              GridColumn(
                  columnName: L10nX.getStr.doing_time_str,
                  minimumWidth: Dimens.size120,
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(L10nX.getStr.doing_time_str))),*/
              GridColumn(
                  columnName: L10nX.getStr.action_str,
                  minimumWidth: Dimens.size180,
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
  
}
class TestDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  Function(TestInfo) onViewDetail, onEdit, onDelete;
  int? starIndex;
  TestDataSource({
    required List<TestInfo> lessonData, 
    this.starIndex,
    required this.onDelete, 
    required this.onEdit, 
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
            DataGridCell<Widget>(columnName: L10nX.getStr.course_str, value: Row(
              children: [
                Expanded(child: Text(e.courseName??"", style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            )),
            DataGridCell<Widget>(columnName: L10nX.getStr.subject_str, value: Text(e.subName??"", style: TextStyleConstant.textStyleBlack14w400,)),

            DataGridCell<Widget>(columnName: L10nX.getStr.type, value: Text(L10nX().getStringByKey("${mapTestLevelToStrKey[e.testType?? TestType.OUTPUT]}_test_str".toLowerCase()), style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.question_number, value: Text("${(e.quizDTOs??[]).length}", style: TextStyleConstant.textStyleBlack14w400,)),
            //DataGridCell<Widget>(columnName: L10nX.getStr.doing_time_str, value: Text("${(e.}", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.action_str, 
                value: ItemViewEditDelete(
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

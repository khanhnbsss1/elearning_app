import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import 'package:webkit/views/test/test_detail/create_edit_test.dart';
import 'package:webkit/widgets/item_edit_view_delete/item_edit_view_delete.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import 'bloc/test_list_bloc.dart';
import 'components/test_detail.dart';
import 'components/test_item_view.dart';
import 'package:syncfusion_flutter_core/theme.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
                    BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onBackToFirstPage: (p0) {
                    BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onNextPage: (p0) {
                    BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onGoToLastPage: (p0) {
                    BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
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
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: ColorConst.dividerColor, width: 0.2)
          )
      ),
      padding: EdgeInsets.symmetric(vertical: Dimens.size8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimens.size40,
                width: Dimens.size250,
                child: Form(
                  key: formKey,
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
              Gap(Dimens.size10),
              InkWell(
                  onTap: () {
                    BlocProvider.of<TestListBloc>(context).add(TestListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                  },
                  child: Icon(Icons.search_rounded, color: ColorConst.mainColor,size: Dimens.size40,)),
            ],
          ),
         
          Row(
            children: [
              Gap(Dimens.size10),
              InkWell(
                  onTap: () {
                    CreateEditTest(testActionType: ActionType.create, callBack: () {
                      BlocProvider.of<TestListBloc>(context).add(TestListInitEvent());
                    },).show(context);
                  },
                  child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
            ],
          ),
        ],
      ),
    );
  }
  Widget buildTestList({required TestListState state, required BuildContext context}){
    List<Widget> listOfLesson = List.empty(growable: true);

    for (TestInfo lessonInfo in state.listResponseModel?.content ?? []) {
      listOfLesson.add(
        InkWell(
          onTap: () {
            BlocProvider.of<TestListBloc>(context).add(TestListOnSelectTestEvent(selectInfo: lessonInfo));
          },
          child: TestItemView(
            info: lessonInfo,
            onViewDetail: (p0) {
              TestDetailPage(tagPageAction: TestPageAction.view,).show(context);
            },
            onEdit: (p0) {
              TestDetailPage(tagsInfo: p0,tagPageAction: TestPageAction.edit,).show(context, callBack: (p0) {
                BlocProvider.of<TestListBloc>(context).add(TestListInitEvent());
              },);
            },
            onDelete: (p0) {
              ConfirmPopupPage(
                title: L10nX.getStr.remove_tags,
                content: L10nX.getStr.you_want_remove,
                onAccept: () {
                  BlocProvider.of<TestListBloc>(context).add(TestListOnDeleteTagEvent(selectInfo: p0));
                },
              ).show(context);
            },
          ),
        )
      );
    }
    switch (state.blocStatus){
      case null:
        // TODO: Handle this case.
      case TestListStatus.initial:
        // TODO: Handle this case.
      case TestListStatus.onLoading:
        // TODO: Handle this case.
      case TestListStatus.onSearchByParams:
        // TODO: Handle this case.
        return Center(child: CircularProgressIndicator());
      case TestListStatus.onSelectTag:
      case TestListStatus.onLoadEnd:
        // TODO: Handle this case.
        return  (listOfLesson.isEmpty) ?
        Center(child:NoData()) :
        Scrollbar(
          controller: scrollController,
          thickness: Dimens.size10,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: scrollController,
            child: Column(
              mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listOfLesson,
            ),
          ),
        );
    }
  }
  Widget buildTestTableList({required TestListState state, required BuildContext context}){
    TestDataSource employeeDataSource = TestDataSource(
      lessonData: state.listResponseModel?.content??[],
      onDelete: (p0) {
        
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
        CreateEditTest(testActionType: ActionType.view,
          testInfo: p0,
          callBack: () {
          BlocProvider.of<TestListBloc>(context).add(TestListInitEvent());
        },).show(context);
      },
    );
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        headerColor: ColorConst.mainColor.withOpacity(0.1),
      ),
      child: SfDataGrid(
        source: employeeDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        isScrollbarAlwaysShown: false,
        gridLinesVisibility: GridLinesVisibility.both,
        rowHeight: Dimens.size80,
        showHorizontalScrollbar: true,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'id',
              maximumWidth: Dimens.size100,
              label: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'ID',
                  ))),
          GridColumn(
              columnName: L10nX.getStr.test_str,
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    L10nX.getStr.test_str,
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: L10nX.getStr.course_str,
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(L10nX.getStr.course_str))),
          GridColumn(
              columnName: L10nX.getStr.subject_str,
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(L10nX.getStr.subject_str))),
          GridColumn(
              columnName: L10nX.getStr.action_str,
              maximumWidth: Dimens.size150,
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(L10nX.getStr.action_str))),

        ],
      ),
    );
  }
  
}
class TestDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  Function(TestInfo) onViewDetail, onEdit, onDelete;
  TestDataSource({required List<TestInfo> lessonData, required this.onDelete, required this.onEdit, required this.onViewDetail}) {
    _lessonData = lessonData.map<DataGridRow>((e) {
      List<Widget> wordList = [];
      for(int index =0; index <10; index++){
        wordList.add(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: ColorConst.whiteColor,
                      borderRadius: BorderRadius.circular(Dimens.size20),
                      border: Border.all(color: ColorConst.blackColor, width: 1)
                  ),
                  padding: EdgeInsets.symmetric(vertical: Dimens.size8, horizontal: Dimens.size16),
                  child: Text("data", style: TextStyleConstant.textStyleBlack14w400,)),
            ));
      }

      return  DataGridRow(
          cells: [
            DataGridCell<Widget>(columnName: 'id', value: Text(e.id.toString(), style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.test_str, value:Text(e.name??"", style: TextStyleConstant.textStyleBlack14w400,) ),
            DataGridCell<Widget>(columnName: L10nX.getStr.course_str, value: Text(e.courseName??"", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.subject_str, value: Text(e.subName??"", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.action_str, 
                value: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ItemViewEditDelete(
                      itemInfo: e,
                      onViewDetail: (p0) {
                        onViewDetail(p0);
                      },
                      onEdit: (p0) {
                        onEdit(p0);
                      },
                      onDelete: (p0) {
                        onDelete(p0);
                      },
                    ),
                  ],
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
            padding: EdgeInsets.all(8.0),
            child: e.value,
          );
        }).toList());
  }
}

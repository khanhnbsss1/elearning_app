import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/page_common/permission_page.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/lessson/lesson_detail/delete_lesson_api.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/views/lessson/lesson_detail/create_edit_lesson.dart';
import 'package:webkit/widgets/item_edit_view_delete/item_edit_view_delete.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import 'bloc/lesson_list_bloc.dart';

class LessonListPage extends StatefulWidget {
  LessonListPage({super.key});
  @override
  State<LessonListPage> createState() => _LessonListPageState();
}

class _LessonListPageState extends State<LessonListPage> with SingleTickerProviderStateMixin, UIMixin {
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
    "lectures.post.get_list",
  ];
  @override
  Widget build(BuildContext context) {
    return PermissionPage(
      permissionList: permission,
      child: BlocProvider(
        create: (context) {
          return LessonListBloc(LessonListState())..add(LessonListInitEvent());
        },
        child: BlocConsumer<LessonListBloc, LessonListState>(
          listener: (context, state) {
            switch (state.blocStatus) {
              case LessonListStatus.initial:
                break;
            // TODO: Handle this case.
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
                        child: Text(L10nX.getStr.lesson_list,
                          style: TextStyleConstant.textStyleBlack18w600,),),
                      padding: EdgeInsets.only(top: Dimens.size60),
                      child: buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType));
                }
                else
                {
                  return Layout(
                      isScroll: false,
                      title: Center(child: Text(
                        L10nX.getStr.lesson_list,
                        style: TextStyleConstant.textStyleBlack18w600,
                      ),),
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
    required LessonListState state
  }
      ){
    return Container(
      color: ColorConst.whiteColor,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: Dimens.size0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildListFilter(context: context, state: state, myScreenMediaType: myScreenMediaType, boxConstraints: boxConstraints),
            Expanded(child: buildLessonList(state: state, context: context)),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterCustomPagination(
                  key: GlobalKey(debugLabel: (state.lessonListResponseModel?.total??0).toString()),
                  currentPage: state.lessonListResponseModel!.getCurrentPage(),
                  limitPerPage: state.lessonListResponseModel!.pageSize??10,
                  totalDataCount: state.lessonListResponseModel!.getTotalElement(),
                  onPreviousPage: (p0) {
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onBackToFirstPage: (p0) {
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onNextPage: (p0) {
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onGoToLastPage: (p0) {
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
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
    required LessonListState state
  }){
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: ColorConst.dividerColor, width: 0.2)
            )
        ),
        padding: EdgeInsets.symmetric(vertical: Dimens.size8, horizontal: Dimens.size16),
        child: SizedBox(
          height: Dimens.size45,
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
                        maxWidth:  constraints.maxWidth> Dimens.size800?Dimens.size400:Dimens.size250
                    ),
                    child: Form(
                      key: formKey,
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height:Dimens.size40,
                              child: TextFormField(
                                maxLines: 1,
                                controller: textEditingController,
                                onChanged: (value) {
                              
                                },
                                onFieldSubmitted: (value) {
                                  BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
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
                    visible: constraints.maxWidth> 800,
                    child: ActionButton1(
                      text: L10nX.getStr.search,
                      onTap: () {
                        BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                      },
                    ),
                  ),
                  Visibility(
                    visible: constraints.maxWidth< 800,
                    child: InkWell(
                        onTap: () {
                          BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                        },
                        child: Icon(Icons.search, color: ColorConst.mainColor,size: Dimens.size40,)),
                  ),
                ],
              ),
              Visibility(
                visible: UserManager().userContainPermission(permissionList: [
                  "lectures.post.create_lecture",
                ]),
                child: Row(
                  children: [
                    Gap(Dimens.size10),
                    Visibility(
                      visible: constraints.maxWidth< 800,
                      child: InkWell(
                          onTap: () {
                            CreateEditLesson(lessonActionType: ActionType.create,).show(context);
                
                          },
                          child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
                    ),
                    Visibility(
                      visible: constraints.maxWidth >800,
                      child: ActionButton1(
                        preIcon: Icon(Icons.add_circle_outline, color: ColorConst.whiteColor, size: Dimens.size15,),
                        text: L10nX.getStr.add_new_str,
                        onTap: () {
                          CreateEditLesson(lessonActionType: ActionType.create,).show(context);
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
  Widget buildLessonList({required LessonListState state, required BuildContext context}){
    return Padding(
      padding:  EdgeInsets.all(Dimens.size8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          switch (state.blocStatus) {
            case null:
            // TODO: Handle this case.
            case LessonListStatus.initial:
            // TODO: Handle this case.
            case LessonListStatus.onLoading:
            // TODO: Handle this case.           // TODO: Handle this case.
            case LessonListStatus.onSearchByParams:
            // TODO: Handle this case.
              return Center(child: CircularProgressIndicator());
            case LessonListStatus.onLoadEnd:
            // TODO: Handle this case.
              LessonDataSource employeeDataSource = LessonDataSource(
                lessonData: state.lessonListResponseModel?.content??[],
                starIndex: (state.searchCommonRequest?.pageNumber??0)* (state.searchCommonRequest?.pageSize??0),
                onDelete: (p0) {
                  ConfirmPopupPage(
                    content: L10nX.getStr.you_want_remove,
                    onAccept: () async {
                      MonitorLoading().showLoading("");
                      DeleteLessonApi api = DeleteLessonApi(lessonInfo: p0);
                      dynamic data = await api.call();
                      MonitorLoading().dismiss();

                      BlocProvider.of<LessonListBloc>(context).add(LessonListInitEvent());
                    },

                  ).show(context);
                },
                onEdit: (p0) {
                  CreateEditLesson(lessonActionType: ActionType.edit,lessonInfo: p0,).show(context);
                },
                onViewDetail: (p0) {
                  CreateEditLesson(lessonActionType: ActionType.view, lessonInfo: p0,).show(context);
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
/*            onQueryRowHeight: (details) {
              return details.getIntrinsicRowHeight(details.rowIndex);
            },*/
                      headerRowHeight: Dimens.size60,
                      rowHeight: Dimens.size70,
                      //defaultColumnWidth: 200,
                      showHorizontalScrollbar: true,
                      columns: <GridColumn>[
                        GridColumn(
                            columnName: 'id',
                            maximumWidth: Dimens.size60,
                            label: Container(
                                padding: EdgeInsets.all(Dimens.size8),
                                alignment: Alignment.center,
                                child: Text(
                                  'ID', style: TextStyleConstant.textStyleBlack14w500,
                                ))),
                        GridColumn(
                            columnName: L10nX.getStr.lecture_name_str,
                            minimumWidth: Dimens.size250,
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(
                                  L10nX.getStr.lecture_name_str,
                                  overflow: TextOverflow.ellipsis, style: TextStyleConstant.textStyleBlack14w500,
                                ))),
                        GridColumn(
                            columnName: L10nX.getStr.subject_name_str,
                            minimumWidth: Dimens.size200,
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(L10nX.getStr.subject_name_str, style: TextStyleConstant.textStyleBlack14w500,))),
                        GridColumn(
                            columnName: L10nX.getStr.document_str,
                            minimumWidth: Dimens.size120,
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(L10nX.getStr.document_str, style: TextStyleConstant.textStyleBlack14w500,))),
                        GridColumn(
                            columnName: L10nX.getStr.test_name,
                            minimumWidth: Dimens.size200,
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(L10nX.getStr.test_name, style: TextStyleConstant.textStyleBlack14w500,))),
                        GridColumn(
                            columnName: L10nX.getStr.payment_str,
                            maximumWidth: Dimens.size150,
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(L10nX.getStr.payment_str, style: TextStyleConstant.textStyleBlack14w500,))),
                        GridColumn(
                            columnName: L10nX.getStr.vocabulary_str,
                            minimumWidth: Dimens.size200,
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(L10nX.getStr.vocabulary_str, style: TextStyleConstant.textStyleBlack14w500,))),
                        GridColumn(
                            columnName: L10nX.getStr.action_str,
                            minimumWidth: Dimens.size180,
                            maximumWidth: Dimens.size200,
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(L10nX.getStr.action_str, style: TextStyleConstant.textStyleBlack14w500,))),

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

class LessonDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  Function(LessonInfo) onViewDetail, onEdit, onDelete;
  int? starIndex;
  LessonDataSource({
    required List<LessonInfo> lessonData,
    this.starIndex,
    required this.onDelete,
    required this.onEdit,
    required this.onViewDetail}) {

    _lessonData = lessonData.map<DataGridRow>((e) {
      starIndex = (starIndex ??0)+1;
      List<Widget> listWord = [];
      for(VocabularyInfo vocabularyInfo in e.vocabularies??[])
        {
          listWord.add(Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.size16),
              border: Border.all(color: ColorConst.blackColor, width: 0.2),
              color: ColorConst.whiteColor
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(vocabularyInfo.simplified??"", style: TextStyleConstant.textStyleBlack13w400,),
          ),
            
          );
        }
      return  DataGridRow(
          cells: [
            DataGridCell<Widget>(columnName: 'id', value: Text("$starIndex", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.lecture_name_str, value:Row(
              children: [
                Expanded(child: Text(e.lectureName??"", style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            ) ),
            DataGridCell<Widget>(columnName: L10nX.getStr.subject_name_str, value: Row(
              children: [
                Expanded(child: Text(e.subName??"", style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            )),
            DataGridCell<Widget>(columnName: L10nX.getStr.document_str, value: Row(
              children: [
                Expanded(child: Text(e.docName??"", style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            )),

            DataGridCell<Widget>(columnName: L10nX.getStr.test_name, value: Row(
              children: [
                Expanded(child: Text(e.testName??"", style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            )),
            DataGridCell<Widget>(columnName: L10nX.getStr.payment_str, value: Text(e.mode??"", style: TextStyleConstant.textStyleBlack14w400,)),

            DataGridCell<Widget>(columnName: L10nX.getStr.vocabulary_str, 
                value: SingleChildScrollView(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listWord,),
            )),
            //DataGridCell<Widget>(columnName: L10nX.getStr.doing_time_str, value: Text("${(e.}", style: TextStyleConstant.textStyleBlack14w400,)),

            DataGridCell<Widget>(columnName: L10nX.getStr.action_str,
                value: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ItemViewEditDelete(
                      itemInfo: e,
                      enableEditDelete: UserManager().userContainPermission(permissionList: ["lectures.delete.delete_lecture"]),
                      enableEdit: UserManager().userContainPermission(permissionList: ["lectures.put.edit_lecture"]),
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
            padding: EdgeInsets.all(Dimens.size8),
            child: e.value,
          );
        }).toList());
  }
}


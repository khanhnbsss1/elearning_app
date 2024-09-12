import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/instance_mananger/filter_manager.dart';
import 'package:webkit/base/page_common/permission_page.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/grade/models/grade_info.dart';
import 'package:webkit/services/apis/question/delete_quiz_api.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';
import 'package:webkit/views/question/question_detail/question_work/question_work_item.dart';
import 'package:webkit/widgets/item_edit_view_delete/item_edit_view_delete.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import 'bloc/quiz_list_bloc.dart';
import '../question_detail/question_detail.dart';
import 'components/quiz_item_view.dart';

class QuestionListPage extends StatefulWidget {
  QuestionListPage({super.key});
  @override
  State<QuestionListPage> createState() => _QuestionListPageState();
}

class _QuestionListPageState extends State<QuestionListPage> with SingleTickerProviderStateMixin, UIMixin {
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
    "quizs.get.get_courses",
  ];
  @override
  Widget build(BuildContext context) {
    return PermissionPage(
      permissionList: permission,
      child: BlocProvider(
        create: (context) {
          return QuizListBloc(QuizListState())..add(QuizListInitEvent());
        },
        child: BlocConsumer<QuizListBloc, QuizListState>(
          listener: (context, state) {
            switch (state.blocStatus) {
              case QuizListStatus.initial:
                break;
            // TODO: Handle this case.
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
                      title: Text(
                         L10nX.getStr.quiz_list,
                        style: TextStyleConstant.textStyleBlack18w600,
                      ),
                      padding: EdgeInsets.only(top: 35 + 16, bottom: 0),
                      child: buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType));
                }
                else
                {
                  return Layout(
                      isScroll: false,
                      title: Text(
                        L10nX.getStr.quiz_str,
                        style: TextStyleConstant.textStyleBlack18w600,
                      ),
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
        required QuizListState state
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
                    BlocProvider.of<QuizListBloc>(context).add(QuizListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onBackToFirstPage: (p0) {
                    BlocProvider.of<QuizListBloc>(context).add(QuizListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onNextPage: (p0) {
                    BlocProvider.of<QuizListBloc>(context).add(QuizListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onGoToLastPage: (p0) {
                    BlocProvider.of<QuizListBloc>(context).add(QuizListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
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
    required QuizListState state
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
                        maxWidth:  constraints.maxWidth> 800?400:250
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
                                BlocProvider.of<QuizListBloc>(context).add(QuizListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
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
                                  contentPadding: MySpacing.xy(16, 12),
                                  //isCollapsed: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.auto),
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
                        BlocProvider.of<QuizListBloc>(context).add(QuizListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                      },
                    ),
                  ),
                  Visibility(
                    visible: constraints.maxWidth< 800,
                    child: InkWell(
                        onTap: () {
                          BlocProvider.of<QuizListBloc>(context).add(QuizListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                        },
                        child: Icon(Icons.search, color: ColorConst.mainColor,size: Dimens.size40,)),
                  ),
                ],
              ),
              Visibility(
                visible: UserManager().userContainPermission(permissionList: [
                  "quizs.post.create_question"
                ]),
                child: Row(
                  children: [
                    Gap(Dimens.size10),
                    Visibility(
                      visible: constraints.maxWidth< 800,
                      child: InkWell(
                          onTap: () {
                            QuestionCreateEditDetailPage(
                              actionType: ActionType.create,
                                callBack: () {
                                  BlocProvider.of<QuizListBloc>(context).add(QuizListInitEvent());
                
                                },
                            ).show(context,);
                          },
                          child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
                    ),
                    Visibility(
                      visible: constraints.maxWidth >800,
                      child: ActionButton1(
                        preIcon: Icon(Icons.add_circle_outline, color: ColorConst.whiteColor,size: Dimens.size15,),
                        text: L10nX.getStr.add_new_str,
                        onTap: () {
                          QuestionCreateEditDetailPage(
                            actionType: ActionType.create,
                              callBack: () {
                                BlocProvider.of<QuizListBloc>(context).add(QuizListInitEvent());
                              }
                          ).show(context,);
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

  
  Widget buildTestTableList({required QuizListState state, required BuildContext context}){
    return Padding(
        padding:  EdgeInsets.all(Dimens.size8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            switch (state.blocStatus) {
              case null:
              // TODO: Handle this case.
              case QuizListStatus.initial:
              // TODO: Handle this case.
              case QuizListStatus.onLoading:
              // TODO: Handle this case.           // TODO: Handle this case.
              case QuizListStatus.onSearchByParams:
              // TODO: Handle this case.
                return Center(child: CircularProgressIndicator());
              case QuizListStatus.onLoadEnd:
              // TODO: Handle this case.
                QuestionDataSource employeeDataSource = QuestionDataSource(
                  lessonData: state.listResponseModel?.content??[],
                  onDelete: (p0) async {
                    ConfirmPopupPage(
                      content: L10nX.getStr.you_want_remove,
                      onAccept: () async {
                        MonitorLoading().showLoading("");
                        DeleteQuizApi api = DeleteQuizApi(info: p0);
                        dynamic data = await api.call();
                        MonitorLoading().dismiss();
                        BlocProvider.of<QuizListBloc>(context).add(QuizListInitEvent());
                      },

                    ).show(context);

                  },
                  onEdit: (p0) {
                    QuestionCreateEditDetailPage(
                      actionType: ActionType.edit,
                      info: p0,
                      callBack: () {
                        BlocProvider.of<QuizListBloc>(context).add(QuizListInitEvent());
                      },).show(context);
                  },
                  onViewDetail: (p0) {
                    QuestionWorkItem(
                      questionInfo: p0,
                      enableCloseButton: true,
                      enableShowResultAnswer: true,
                      onChangeAnswer: (p0) {

                      },
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
                        //defaultColumnWidth: 200,
                        showHorizontalScrollbar: true,
                        columns: <GridColumn>[
                          GridColumn(
                              columnName: 'id',
                              maximumWidth: Dimens.size100,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'ID',
                                    style: TextStyleConstant.textStyleBlack14w500,
                                  ))),
                          GridColumn(
                              columnName: L10nX.getStr.question_str,
                              minimumWidth: Dimens.size150,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    L10nX.getStr.question_str,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyleConstant.textStyleBlack14w500,
                                  ))),
                          GridColumn(
                              columnName: L10nX.getStr.question_type,
                              minimumWidth: Dimens.size80,
                              maximumWidth: Dimens.size150,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.question_type, style: TextStyleConstant.textStyleBlack14w500,))),
                          GridColumn(
                              columnName: L10nX.getStr.grade_str,
                              maximumWidth: Dimens.size120,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.grade_str, style: TextStyleConstant.textStyleBlack14w500,))),
                          GridColumn(
                              columnName: L10nX.getStr.score_str,
                              minimumWidth: Dimens.size80,
                              maximumWidth: Dimens.size120,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.score_str, style: TextStyleConstant.textStyleBlack14w500,))),
                          GridColumn(
                              columnName: L10nX.getStr.action_str,
                              minimumWidth: Dimens.size180,
                              maximumWidth: Dimens.size180,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
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

class QuestionDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  Function(QuestionInfo) onViewDetail, onEdit, onDelete;
  int? starIndex;
  QuestionDataSource({
    required List<QuestionInfo> lessonData,
    this.starIndex,
    required this.onDelete,
    required this.onEdit,
    required this.onViewDetail}) {

    _lessonData = lessonData.map<DataGridRow>((e) {
      starIndex = (starIndex ??0)+1;
      Widget gradeWidget = FutureBuilder(
        future: FilterManager().getGradesInfo(), 
        builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return SizedBox();
        }
        
        List<GradeInfo>? content = snapshot.data?.content??[];
        print("gradeid ${e.gradeId}");
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
            DataGridCell<Widget>(columnName: L10nX.getStr.question_str, value:Row(
              children: [
                Expanded(
                  child: Text(
                    e.questionName??"",
                    textAlign: TextAlign.start,
                    style: TextStyleConstant.textStyleBlack14w400,),
                ),
              ],
            ) ),
            DataGridCell<Widget>(columnName: L10nX.getStr.question_type, value: Text(L10nX().getStringByKey("${mapQuestionTypeToStrKey[e.questionType]??""}_type_str".toLowerCase()), style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.grade_str, value: gradeWidget),

            DataGridCell<Widget>(columnName: L10nX.getStr.score_str, value: Text((e.weightage??0).toString(), style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.action_str,
                value: ItemViewEditDelete(
                  itemInfo: e,
                  enableEditDelete: UserManager().userContainPermission(permissionList: ["quizs.delete.delete_question"]),
                  enableEdit: UserManager().userContainPermission(permissionList: ["quizs.put.update_question"]),
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

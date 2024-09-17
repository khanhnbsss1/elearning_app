import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/date_time/period_of_time_setting.dart';
import 'package:webkit/base/helper/date_time/date_time_helper.dart';
import 'package:webkit/base/page_common/permission_page.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/darh_board/reports/models/course_history_info.dart';
import 'package:webkit/services/apis/darh_board/reports/models/course_registed_history_info.dart';
import '../../layouts/layout.dart';
import 'bloc/course_registration_history_bloc.dart';

class CourseRegistrationHistoryListPage extends StatefulWidget {
  CourseRegistrationHistoryListPage({super.key});
  @override
  State<CourseRegistrationHistoryListPage> createState() => _CourseRegistrationHistoryListPageState();
}

class _CourseRegistrationHistoryListPageState extends State<CourseRegistrationHistoryListPage> with SingleTickerProviderStateMixin, UIMixin {
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
    "dashboard.get.get_course_registration_history"
  ];
  @override
  Widget build(BuildContext context) {
    return PermissionPage(
      permissionList: permission,
      child: BlocProvider(
        create: (context) {
          return CourseRegistrationHistoryListBloc(CourseRegistrationHistoryListState())..add(CourseRegistrationHistoryListInitEvent());
        },
        child: BlocConsumer<CourseRegistrationHistoryListBloc, CourseRegistrationHistoryListState>(
          listener: (context, state) {
            switch (state.blocStatus) {
              case CourseRegistrationHistoryListStatus.initial:
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
                        child: Text(L10nX.getStr.report_history_register_course,
                          style: TextStyleConstant.textStyleBlack18w600,),),
                      padding: EdgeInsets.only(top: Dimens.size60),
                      child: buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType));
                }
                else
                {
                  return Layout(
                      isScroll: false,
                      title: Center(child: Text(
                        L10nX.getStr.report_history_register_course,
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
    required CourseRegistrationHistoryListState state
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
            child: buildLessonList(state: state, context: context),
          )),
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
                  BlocProvider.of<CourseRegistrationHistoryListBloc>(context).add(CourseRegistrationHistoryListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                },
                onBackToFirstPage: (p0) {
                  BlocProvider.of<CourseRegistrationHistoryListBloc>(context).add(CourseRegistrationHistoryListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                },
                onNextPage: (p0) {
                  BlocProvider.of<CourseRegistrationHistoryListBloc>(context).add(CourseRegistrationHistoryListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                },
                onGoToLastPage: (p0) {
                  BlocProvider.of<CourseRegistrationHistoryListBloc>(context).add(CourseRegistrationHistoryListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
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
    required CourseRegistrationHistoryListState state
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
          height: Dimens.size50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PeriodOfTime(
                    initStartDate: DateTime.parse(state.searchCommonRequest?.startDate??""),
                    initEndTime:  DateTime.parse(state.searchCommonRequest?.endDate??""),
                    onChangeTime: (startTime, endTime) {
                      state.searchCommonRequest?.startDate = DateTimeHelper.dateFormat(date: startTime, dateType: DateTimeHelper.yyyyMMDD);
                      state.searchCommonRequest?.endDate = DateTimeHelper.dateFormat(date: endTime, dateType: DateTimeHelper.yyyyMMDD);
                      BlocProvider.of<CourseRegistrationHistoryListBloc>(context).add(CourseRegistrationHistoryListOnSearchByFilterEvent(
                          searchCommonRequest: state.searchCommonRequest!));
                    },
                  ),
                  Gap(Dimens.size16),
                  Visibility(
                    visible: constraints.maxWidth> 800,
                    child: ActionButton1(
                      text: L10nX.getStr.search,
                      onTap: () {
                        BlocProvider.of<CourseRegistrationHistoryListBloc>(context).add(CourseRegistrationHistoryListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text, pageNumber: 0)));
                      },
                    ),
                  ),
                  Visibility(
                    visible: constraints.maxWidth< 800,
                    child: InkWell(
                        onTap: () {
                          BlocProvider.of<CourseRegistrationHistoryListBloc>(context).add(CourseRegistrationHistoryListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text, pageNumber: 0)));
                        },
                        child: Icon(Icons.search, color: ColorConst.mainColor,size: Dimens.size40,)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },);
  }
  Widget buildLessonList({required CourseRegistrationHistoryListState state, required BuildContext context}){
    return Padding(
      padding:  EdgeInsets.all(Dimens.size8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          switch (state.blocStatus) {
            case null:
            // TODO: Handle this case.
            case CourseRegistrationHistoryListStatus.initial:
            // TODO: Handle this case.
            case CourseRegistrationHistoryListStatus.onLoading:
            // TODO: Handle this case.           // TODO: Handle this case.
            case CourseRegistrationHistoryListStatus.onSearchByParams:
            // TODO: Handle this case.
              return Center(child: CircularProgressIndicator());
            case CourseRegistrationHistoryListStatus.onLoadEnd:
            // TODO: Handle this case.
              CourseRegisteredHistoryInfoDataSource employeeDataSource = CourseRegisteredHistoryInfoDataSource(
                lessonData: state.lessonListResponseModel?.content??[],
                starIndex: (state.searchCommonRequest?.pageNumber??0)* (state.searchCommonRequest?.pageSize??0),
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
                                  'ID', style: TextStyleConstant.textStyleBlack14w500,
                                ))),
                        GridColumn(
                            columnName: L10nX.getStr.course_name,
                            minimumWidth: Dimens.size250,
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(
                                  L10nX.getStr.course_name,
                                  overflow: TextOverflow.ellipsis, style: TextStyleConstant.textStyleBlack14w500,
                                ))),
                        GridColumn(
                            columnName: L10nX.getStr.user_str,
                            maximumWidth: Dimens.size180,
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(L10nX.getStr.user_str, style: TextStyleConstant.textStyleBlack14w500,))),
                        GridColumn(
                            columnName: L10nX.getStr.time_str,
                            minimumWidth: Dimens.size100,
                            maximumWidth: Dimens.size200,

                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(L10nX.getStr.time_str, style: TextStyleConstant.textStyleBlack14w500,))),
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

class CourseRegisteredHistoryInfoDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  Function(CourseRegisteredHistoryInfo)? onViewDetail, onEdit, onDelete;
  int? starIndex;
  CourseRegisteredHistoryInfoDataSource({
    required List<CourseRegisteredHistoryInfo> lessonData,
    this.starIndex,
    this.onDelete,
    this.onEdit,
    this.onViewDetail}) {

    _lessonData = lessonData.map<DataGridRow>((e) {
      starIndex = (starIndex ??0)+1;
      return  DataGridRow(
          cells: [
            DataGridCell<Widget>(columnName: 'id', value: Text("$starIndex", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.course_name, value:Row(
              children: [
                Expanded(child: Text(e.courseName??"", style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            ) ),
            DataGridCell<Widget>(columnName: L10nX.getStr.user_str, value: Row(
              children: [
                Expanded(child: Text(e.userName??"", textAlign: TextAlign.center, style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            )),

            DataGridCell<Widget>(columnName: L10nX.getStr.time_str, value: Row(
              children: [
                Expanded(child: Text(e.timeCreated??"", style: TextStyleConstant.textStyleBlack14w400,)),
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


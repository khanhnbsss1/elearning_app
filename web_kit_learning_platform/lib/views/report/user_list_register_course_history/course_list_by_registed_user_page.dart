import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/date_time/period_of_time_setting.dart';
import 'package:webkit/base/helper/date_time/date_time_helper.dart';
import 'package:webkit/base/instance_mananger/filter_manager.dart';
import 'package:webkit/base/page_common/permission_page.dart';
import 'package:webkit/base/widgets/pagination/pagination_custom.dart';
import 'package:webkit/base/widgets/text/text_link.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/darh_board/reports/models/course_registed_history_info.dart';
import '../../layouts/layout.dart';
import '../../users_manager/users/user_list.dart';
import 'bloc/course_list_by_registed_user_bloc.dart';

class CourseListByRegistedUserPage extends StatefulWidget {
  CourseListByRegistedUserPage({super.key});
  @override
  State<CourseListByRegistedUserPage> createState() => _CourseListByRegistedUserPageState();
}

class _CourseListByRegistedUserPageState extends State<CourseListByRegistedUserPage> with SingleTickerProviderStateMixin, UIMixin {
  late MemberListController controller;
 TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState>? formKey = GlobalKey();
  ScrollController scrollController=ScrollController();
  TextEditingController editingController = TextEditingController();

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
    //"dashboard.get.get_registered_courses"
  ];
  @override
  Widget build(BuildContext context) {
    return PermissionPage(
      permissionList: permission,
      child: BlocProvider(
        create: (context) {
          return CourseListByRegistedUserBloc(CourseListByRegistedUserState())..add(CourseListByRegistedUserInitEvent());
        },
        child: BlocConsumer<CourseListByRegistedUserBloc, CourseListByRegistedUserState>(
          listener: (context, state) {
            switch (state.blocStatus) {
              case CourseListByRegistedUserStatus.initial:
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
                        child: Text(L10nX.getStr.user_by_course,
                          style: TextStyleConstant.textStyleBlack18w600,),),
                      padding: EdgeInsets.only(top: Dimens.size60),
                      child: buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType));
                }
                else
                {
                  return Layout(
                      isScroll: false,
                      title: Center(
                        child: Text(
                          L10nX.getStr.user_by_course, 
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
    required CourseListByRegistedUserState state
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
              PaginationCustom(
                key: GlobalKey(debugLabel: (state.courseResponseModel?.total??0).toString()),
                currentPage: state.courseResponseModel!.getCurrentPage(),
                limitPerPage: state.courseResponseModel!.pageSize??10,
                totalDataCount: state.courseResponseModel!.getTotalElement(),
                onPreviousPage: (p0) {
                  BlocProvider.of<CourseListByRegistedUserBloc>(context).add(CourseListByRegistedUserOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                },
                onBackToFirstPage: (p0) {
                  BlocProvider.of<CourseListByRegistedUserBloc>(context).add(CourseListByRegistedUserOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                },
                onNextPage: (p0) {
                  BlocProvider.of<CourseListByRegistedUserBloc>(context).add(CourseListByRegistedUserOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                },
                onGoToLastPage: (p0) {
                  BlocProvider.of<CourseListByRegistedUserBloc>(context).add(CourseListByRegistedUserOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
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
    required CourseListByRegistedUserState state
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
          height: Dimens.size50,
          child: Form(
            key: formKey,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: Dimens.size250,
                                height: Dimens.size40,
                                child: TextFormField(
                                  maxLines: 1,
                                  controller: editingController,
                                  onChanged: (value) {

                                  },
                                  onFieldSubmitted: (value) {
                                    BlocProvider.of<CourseListByRegistedUserBloc>(context)
                                        .add(CourseListByRegistedUserOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value, pageNumber: 0)));
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
                                          minWidth: Dimens.size36,
                                          maxWidth: Dimens.size36,
                                          minHeight: Dimens.size40,
                                          maxHeight: Dimens.size40),
                                      contentPadding: MySpacing.xy(Dimens.size16, Dimens.size12),
                                      //isCollapsed: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                                ),
                              ),
                              Gap(Dimens.size12),
                              FilterManager().buildGrade(
                                context: context,
                                title: "",
                                enableInit: false,
                                onChanged: (p0) {
                                  BlocProvider.of<CourseListByRegistedUserBloc>(context).add(CourseListByRegistedUserOnSearchByFilterEvent(
                                      searchCommonRequest: state.searchCommonRequest!.copyWith(
                                          gradeId: p0?.id,
                                          pageNumber: 0
                                      )));
                                },),
                              Gap(Dimens.size12),
                              FilterManager().buildCategory(
                                context: context,
                                title: "",
                                enableInit: false,
                                onChanged: (p0) {
                                  BlocProvider.of<CourseListByRegistedUserBloc>(context).add(CourseListByRegistedUserOnSearchByFilterEvent(
                                      searchCommonRequest: state.searchCommonRequest!.copyWith(
                                          categoryId: p0?.id,
                                          pageNumber: 0
                                      )));
                                },),
                              Gap(Dimens.size12),
                              FilterManager().buildAuthor(
                                context: context,
                                title: "",
                                onChanged: (p0) {
                                  BlocProvider.of<CourseListByRegistedUserBloc>(context).add(CourseListByRegistedUserOnSearchByFilterEvent(
                                      searchCommonRequest: state.searchCommonRequest!.copyWith(
                                          producerName: p0.value,
                                          pageNumber: 0
                                      )));
                                },),
                              Gap(Dimens.size12),
                              FilterManager().buildMode(
                                context: context,
                                title: "",
                                enableInit: false,
                                onChanged: (p0) {
                                  BlocProvider.of<CourseListByRegistedUserBloc>(context).add(CourseListByRegistedUserOnSearchByFilterEvent(
                                      searchCommonRequest: state.searchCommonRequest!.copyWith(
                                          mode : p0,
                                          pageNumber: 0
                                      )));
                                },),
                              Gap(Dimens.size12),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Visibility(
                                    visible: constraints.maxWidth< Dimens.size800,
                                    child: InkWell(
                                        onTap: () {
                                          BlocProvider.of<CourseListByRegistedUserBloc>(context)
                                              .add(CourseListByRegistedUserOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: editingController.text)));                                           },
                                        child: Icon(Icons.search, color: ColorConst.mainColor,size: Dimens.size40,)),
                                  ),
                                  Visibility(
                                    visible: constraints.maxWidth> Dimens.size800,
                                    child: ActionButton1(
                                      text: L10nX.getStr.search,
                                      radius: Dimens.size16,
                                      onTap: () {
                                        BlocProvider.of<CourseListByRegistedUserBloc>(context)
                                            .add(CourseListByRegistedUserOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: editingController.text)));                                         },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(Dimens.size16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },);
  }
  Widget buildLessonList({required CourseListByRegistedUserState state, required BuildContext context}){
    return Padding(
      padding:  EdgeInsets.all(Dimens.size8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          switch (state.blocStatus) {
            case null:
            // TODO: Handle this case.
            case CourseListByRegistedUserStatus.initial:
            // TODO: Handle this case.
            case CourseListByRegistedUserStatus.onLoading:
            // TODO: Handle this case.           // TODO: Handle this case.
            case CourseListByRegistedUserStatus.onSearchByParams:
            // TODO: Handle this case.
              return Center(child: CircularProgressIndicator());
            case CourseListByRegistedUserStatus.onLoadEnd:
            // TODO: Handle this case.
              CourseListByRegistedUserDataSource employeeDataSource = CourseListByRegistedUserDataSource(
                lessonData: state.courseResponseModel?.content??[],
                starIndex: (state.searchCommonRequest?.pageNumber??0)* (state.searchCommonRequest?.pageSize??0),
                onViewUser: (p0) {
                  UserListPage(
                    courseId: p0.id,
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
                      //defaultColumnWidth: 200,
                      showHorizontalScrollbar: true,
                      columns: <GridColumn>[
                        GridColumn(
                            columnName: 'id',
                            maximumWidth: Dimens.size60,
                            label: Container(
                                padding: EdgeInsets.all(Dimens.size16),
                                alignment: Alignment.center,
                                child: Text(
                                  'ID', style: TextStyleConstant.textStyleBlack14w500,
                                ))),
                        GridColumn(
                            columnName: L10nX.getStr.course_name,
                            minimumWidth: Dimens.size500,
                            label: Container(
                                padding: EdgeInsets.all(Dimens.size8),
                                alignment: Alignment.center,
                                child: Text(
                                  L10nX.getStr.course_name,
                                  overflow: TextOverflow.ellipsis, style: TextStyleConstant.textStyleBlack14w500,
                                ))),
                        GridColumn(
                            columnName: L10nX.getStr.category_str,
                            maximumWidth: Dimens.size250,
                            minimumWidth: Dimens.size200,
                            label: Container(
                                padding: EdgeInsets.all(Dimens.size8),
                                alignment: Alignment.center,
                                child: Text(L10nX.getStr.category_str, style: TextStyleConstant.textStyleBlack14w500,))),
                        GridColumn(
                            columnName: L10nX.getStr.grade_str,
                            maximumWidth: Dimens.size200,
                            minimumWidth: Dimens.size200,
                            label: Container(
                                padding: EdgeInsets.all(Dimens.size8),
                                alignment: Alignment.center,
                                child: Text(L10nX.getStr.grade_str, style: TextStyleConstant.textStyleBlack14w500, textAlign: TextAlign.center,))),
                        GridColumn(
                            columnName: L10nX.getStr.author_str,
                            maximumWidth: Dimens.size150,
                            minimumWidth: Dimens.size150,
                            label: Container(
                                padding: EdgeInsets.all(Dimens.size8),
                                alignment: Alignment.center,
                                child: Text(L10nX.getStr.author_str, style: TextStyleConstant.textStyleBlack14w500,))),
                        GridColumn(
                            columnName: L10nX.getStr.type,
                            maximumWidth: Dimens.size150,
                            minimumWidth: Dimens.size150,
                            label: Container(
                                padding: EdgeInsets.all(Dimens.size8),
                                alignment: Alignment.center,
                                child: Text(L10nX.getStr.type, style: TextStyleConstant.textStyleBlack14w500,))),
                        GridColumn(
                            columnName: L10nX.getStr.number_registered_user,
                            minimumWidth: Dimens.size100,
                            maximumWidth: Dimens.size150,
                            label: Container(
                                padding: EdgeInsets.all(Dimens.size8),
                                alignment: Alignment.center,
                                child: Text(L10nX.getStr.number_registered_user, textAlign: TextAlign.center,style: TextStyleConstant.textStyleBlack14w500,))),
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

class CourseListByRegistedUserDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  Function(CourseInfo)? onViewUser; 
  int? starIndex;
  CourseListByRegistedUserDataSource({
    required List<CourseInfo> lessonData,
    this.starIndex,
    this.onViewUser}) {

    _lessonData = lessonData.map<DataGridRow>((e) {
      starIndex = (starIndex ??0)+1;
      return  DataGridRow(
          cells: [
            DataGridCell<Widget>(columnName: 'id', value: Text("$starIndex", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.course_name, value:Row(
              children: [
                Expanded(child: Text(e.name??"", style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            ) ),
            DataGridCell<Widget>(columnName: L10nX.getStr.category_str, value: Row(
              children: [
                Expanded(child: Text(e.categoryName??"", textAlign: TextAlign.center, style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            )),
            DataGridCell<Widget>(columnName: L10nX.getStr.grade_str, value: Row(
              children: [
                Expanded(child: Text(e.gradeName??"", textAlign: TextAlign.center, style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            )),
            DataGridCell<Widget>(columnName: L10nX.getStr.product_name, value: Row(
              children: [
                Expanded(child: Text(e.producerName??"", textAlign: TextAlign.center, style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            )),
            DataGridCell<Widget>(columnName: L10nX.getStr.type, value: Row(
              children: [
                Expanded(child: Text(e.mode??"", textAlign: TextAlign.center, style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            )),
            DataGridCell<Widget>(columnName: L10nX.getStr.number_registered_user, 
                value: Row(
                  mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${e.totalStudent??0}", style: TextStyleConstant.textStyleBlack14w400,),
                Gap(Dimens.size16),
                TextLink(
                  text: L10nX.getStr.view_str,
                  onTap: () {
                    if(onViewUser!=null)
                      {
                        onViewUser!(e);
                      }
                  },
                )
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


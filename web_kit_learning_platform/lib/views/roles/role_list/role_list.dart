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
import 'package:webkit/services/apis/roles/delete_role_api.dart';
import 'package:webkit/services/apis/roles/models/roles_info.dart';
import 'package:webkit/views/roles/role_detail/create_edit_role.dart';
import 'package:webkit/widgets/item_edit_view_delete/item_edit_view_delete.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import 'bloc/role_list_bloc.dart';

class RoleListPage extends StatefulWidget {
  RoleListPage({super.key});
  @override
  State<RoleListPage> createState() => _RoleListPageState();
}

class _RoleListPageState extends State<RoleListPage> with SingleTickerProviderStateMixin, UIMixin {
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
    "claim.post.get_claims",
  ];
  @override
  Widget build(BuildContext context) {
    return PermissionPage(
      permissionList: permission,
      child: BlocProvider(
        create: (context) {
          return RoleListBloc(RoleListState())..add(RoleListInitEvent());
        },
        child: BlocConsumer<RoleListBloc, RoleListState>(
          listener: (context, state) {
            switch (state.blocStatus) {
              case LessonListStatus.initial:
                break;
            // TODO: Handle this case.
              case LessonListStatus.onSelectLesson:
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
                        child: Text(L10nX.getStr.role__list_str,
                          style: TextStyleConstant.textStyleBlack18w600,),),
                      padding: EdgeInsets.only(top: Dimens.size60),
                      child: buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType));
                }
                else
                {
                  return Layout(
                      isScroll: false,
                      title: Center(child: Text(
                        L10nX.getStr.role__list_str,
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
    required RoleListState state
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
            child: buildRoleList(state: state, context: context),
          )),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterCustomPagination(
                key: GlobalKey(debugLabel: (state.roleListResponseModel?.total??0).toString()),
                currentPage: state.roleListResponseModel!.getCurrentPage(),
                limitPerPage: state.roleListResponseModel!.pageSize??10,
                totalDataCount: state.roleListResponseModel!.getTotalElement(),
                onPreviousPage: (p0) {
                  BlocProvider.of<RoleListBloc>(context).add(RoleListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                },
                onBackToFirstPage: (p0) {
                  BlocProvider.of<RoleListBloc>(context).add(RoleListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                },
                onNextPage: (p0) {
                  BlocProvider.of<RoleListBloc>(context).add(RoleListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                },
                onGoToLastPage: (p0) {
                  BlocProvider.of<RoleListBloc>(context).add(RoleListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
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
    required RoleListState state
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
                                BlocProvider.of<RoleListBloc>(context).add(RoleListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
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
                        BlocProvider.of<RoleListBloc>(context).add(RoleListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                      },
                    ),
                  ),
                  Visibility(
                    visible: constraints.maxWidth< 800,
                    child: InkWell(
                        onTap: () {
                          BlocProvider.of<RoleListBloc>(context).add(RoleListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                        },
                        child: Icon(Icons.search, color: ColorConst.mainColor,size: Dimens.size40,)),
                  ),
                ],
              ),
              Visibility(
                visible: UserManager().userContainPermission(permissionList: [
                  "account.post.create_role",
                ]),
                child: Row(
                  children: [
                    Gap(Dimens.size10),
                    Visibility(
                      visible: constraints.maxWidth< 800,
                      child: InkWell(
                          onTap: () {
                            CreateEditRole(
                              actionType: ActionType.create,
                              callBack: () {
                                BlocProvider.of<RoleListBloc>(context).add(RoleListInitEvent());
                              },
                            ).show(context);              
                          },
                          child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
                    ),
                    Visibility(
                      visible: constraints.maxWidth >800,
                      child: ActionButton1(
                        preIcon: Icon(Icons.add_circle_outline, color: ColorConst.whiteColor,size: Dimens.size15,),
                        text: L10nX.getStr.add_new_str,
                        onTap: () {
                          CreateEditRole(
                            actionType: ActionType.create,
                          ).show(context);
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
  Widget buildRoleList({required RoleListState state, required BuildContext context}){
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
              // TODO: Handle this case.           
            // TODO: Handle this case.

              case LessonListStatus.onSelectLesson:
              // TODO: Handle this case.
              case LessonListStatus.onSearchByParams:
              // TODO: Handle this case.
                return Center(child: CircularProgressIndicator());
              case LessonListStatus.onLoadEnd:
              // TODO: Handle this case.
                RoleDataSource employeeDataSource = RoleDataSource(
                  lessonData: state.contentView??[],
                  starIndex: (state.searchCommonRequest?.pageNumber??0)* (state.searchCommonRequest?.pageSize??0),
                  onDelete: (p0) {
                    ConfirmPopupPage(
                      content: L10nX.getStr.you_want_remove,
                      onAccept: () async {
                        MonitorLoading().showLoading("");
                        DeleteRoleApi api = DeleteRoleApi(info: p0);
                        dynamic data = await api.call();
                        MonitorLoading().dismiss();

                        BlocProvider.of<RoleListBloc>(context).add(RoleListInitEvent());
                      },

                    ).show(context);
                  },
                  onEdit: (p0) {
                    CreateEditRole(
                      actionType: ActionType.edit,
                      roleInfo: p0,
                    ).show(context);
                  },
                  onViewDetail: (p0) {
                    CreateEditRole(
                      actionType: ActionType.view,
                      roleInfo: p0,
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
/*            onQueryRowHeight: (details) {
              return details.getIntrinsicRowHeight(details.rowIndex);
            },*/
                        headerRowHeight: Dimens.size60,
                        rowHeight: Dimens.size90,
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
                              columnName: L10nX.getStr.role_str,
                              minimumWidth: Dimens.size250,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    L10nX.getStr.role_str,
                                    overflow: TextOverflow.ellipsis, style: TextStyleConstant.textStyleBlack14w500,
                                  ))),
                          GridColumn(
                              columnName: L10nX.getStr.role_str,
                              minimumWidth: Dimens.size120,
                              maximumWidth: Dimens.size150,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.role_str, style: TextStyleConstant.textStyleBlack14w500,))),
                          GridColumn(
                              columnName: L10nX.getStr.action_str,
                              minimumWidth: Dimens.size150,
                              maximumWidth: Dimens.size200,
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

class RoleDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  Function(RoleInfo) onViewDetail, onEdit, onDelete;
  int? starIndex;
  RoleDataSource({
    required List<RoleInfo> lessonData,
    this.starIndex,
    required this.onDelete,
    required this.onEdit,
    required this.onViewDetail}) {
    
    _lessonData = lessonData.map<DataGridRow>((e) {
      starIndex = (starIndex ??0)+1;
      List<Widget> listWord = [];
      return  DataGridRow(
          cells: [
            DataGridCell<Widget>(columnName: 'id', value: Text("$starIndex", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.role_str, value:Row(
              children: [
                Expanded(child: Text(e.name??"", style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            ) ),
            DataGridCell<Widget>(columnName: L10nX.getStr.role_str, value: Text(e.normalizedName??"", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.action_str,
                value: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ItemViewEditDelete(
                      itemInfo: e,
                      enableEditDelete: UserManager().userContainPermission(permissionList: ["account.delete.delete_role"]),
                      enableEdit: UserManager().userContainPermission(permissionList: ["account.put.edit_role"]),
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


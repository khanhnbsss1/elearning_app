import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'package:webkit/services/apis/payment/models/request_registered_info.dart';
import 'package:webkit/services/apis/payment/unlock_course_api.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import 'bloc/request_register_list_bloc.dart';

class RequestRegisterListPage extends StatefulWidget {
  RequestRegisterListPage({super.key});
  @override
  State<RequestRegisterListPage> createState() => _RequestRegisterListPageState();
}

class _RequestRegisterListPageState extends State<RequestRegisterListPage> with SingleTickerProviderStateMixin, UIMixin {
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
          return RequestRegisterListBloc(RequestRegisterListState())..add(RequestRegisterListInitEvent());
        },
        child: BlocConsumer<RequestRegisterListBloc, RequestRegisterListState>(
          listener: (context, state) {
            switch (state.blocStatus) {
              case RequestRegisterListStatus.initial:
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
                          child: Text(L10nX.getStr.list_waiting_register,
                            style: TextStyleConstant.textStyleBlack18w600,),),
                        padding: EdgeInsets.only(top: Dimens.size60),
                        child: buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType));
                  }
                else
                  {
                    return Layout(
                      isScroll: false,
                        title: Center(
                          child: Text(L10nX.getStr.list_waiting_register,
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
    required RequestRegisterListState state
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
                PaginationCustom(
                  key: GlobalKey(debugLabel: (state.listResponseModel?.total??0).toString()),
                  currentPage: state.listResponseModel!.getCurrentPage(),
                  limitPerPage: state.listResponseModel!.pageSize??10,
                  totalDataCount: state.listResponseModel!.getTotalElement(),
                  onPreviousPage: (p0) {
                    BlocProvider.of<RequestRegisterListBloc>(context).add(RequestRegisterListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onBackToFirstPage: (p0) {
                    BlocProvider.of<RequestRegisterListBloc>(context).add(RequestRegisterListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onNextPage: (p0) {
                    BlocProvider.of<RequestRegisterListBloc>(context).add(RequestRegisterListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onGoToLastPage: (p0) {
                    BlocProvider.of<RequestRegisterListBloc>(context).add(RequestRegisterListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
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
    required RequestRegisterListState state
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
                   constraints: BoxConstraints(
                       maxWidth:  constraints.maxWidth> Dimens.size600?Dimens.size400:Dimens.size250
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
                                 BlocProvider.of<RequestRegisterListBloc>(context).add(
                                     RequestRegisterListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value, pageNumber: 0)));
                               },
                               onTapOutside: (event) {
                               },
                               style: TextStyleConstant.textStyleBlack14w400,
                               decoration: InputDecoration(
                                   hintText: "${L10nX.getStr.name} ${L10nX.getStr.user_str.toLowerCase()}",
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
              /*   Gap(Dimens.size16),
                 SizedBox(
                   //height: Dimens.size35,
                   width: Dimens.size150,
                   child: DropdownButtonFormField2<ActionStatus>(
                     isExpanded: true,
                     valueListenable: ValueNotifier<ActionStatus?>(state.status),
                     decoration: InputDecoration(
                       contentPadding:  EdgeInsets.symmetric(vertical: Dimens.size8),
                       border: outlineInputBorder,
                       // Add more decoration..
                     ),
                     hint:  Text(
                       L10nX.getStr.status,
                       style: TextStyleConstant.textStyleBlack13w400,
                     ),
                     items: ActionStatus.values.map((item) => DropdownItem<ActionStatus>(
                       value: item,
                       child: Text(
                         item.name??"",
                         style: TextStyleConstant.textStyleBlack13w400,
                       ),
                     )).toList(),
                     validator: (value) {
                       if (value == null) {
                         return L10nX.getStr.grade_str;
                       }
                       return null;
                     },
                     onChanged: (value) {
                       state.status = value;
                       BlocProvider.of<RequestRegisterListBloc>(context).add(
                           RequestRegisterListOnSearchByFilterEvent(
                                state: state,
                               searchCommonRequest: state.searchCommonRequest!.copyWith(status: mapActionStatusToStr[value],)
                           ));
                     },
                     onSaved: (value) {
                     },
                     buttonStyleData:  ButtonStyleData(
                       height: Dimens.size30,
                       
                       padding: EdgeInsets.only(right: Dimens.size8),
                     ),
                     iconStyleData:  IconStyleData(
                       icon: Icon(
                         Icons.arrow_drop_down,
                         color: Colors.black45,
                       ),
                       iconSize: Dimens.size24,
                     ),
                     dropdownStyleData: DropdownStyleData(
                       maxHeight:Dimens.size200,
                       //width: 150,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(Dimens.size16),
                         color: ColorConst.whiteColor,
                       ),
                     ),
                     menuItemStyleData: MenuItemStyleData(
                       padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
                     ),
                   ),
                 ),*/
                 Gap(Dimens.size16),
                 Visibility(
                   visible: constraints.maxWidth> 600,
                   child: ActionButton1(
                     text: L10nX.getStr.search,
                     radius: Dimens.size16,
                     onTap: () {
                       BlocProvider.of<RequestRegisterListBloc>(context).add(RequestRegisterListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text, pageNumber: 0)));
                     },
                   ),
                 ),
                 Visibility(
                   visible: constraints.maxWidth< 600,
                   child: InkWell(
                       onTap: () {
                         BlocProvider.of<RequestRegisterListBloc>(context).add(RequestRegisterListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text, pageNumber: 0)));
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
  Widget buildTestTableList({required RequestRegisterListState state, required BuildContext context}){
    return Padding(
        padding:  EdgeInsets.all(Dimens.size8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            switch (state.blocStatus) {
              case null:
              // TODO: Handle this case.
              case RequestRegisterListStatus.initial:
              // TODO: Handle this case.
              case RequestRegisterListStatus.onLoading:
              // TODO: Handle this case.           // TODO: Handle this case.
              case RequestRegisterListStatus.onSearchByParams:
              // TODO: Handle this case.
                return Center(child: CircularProgressIndicator());
              case RequestRegisterListStatus.onLoadEnd:
              // TODO: Handle this case.
                RequestListDataSource employeeDataSource = RequestListDataSource(
                  lessonData: state.listResponseModel?.content??[],
                  onDelete: (p0) async {
                  },
                  onReject: (p0) {
                    ConfirmPopupPage(
                      title: L10nX.getStr.reject_str,
                      content: "${L10nX.getStr.reject_str} ${L10nX.getStr.request_str}",
                      onAccept: () async {
                        MonitorLoading().showLoading("");
                        UnlockCourseApi unlockCourseApi = UnlockCourseApi(status: mapActionStatusToStr[ActionStatus.Decline]!, requestId: p0.id!);
                        dynamic data = await unlockCourseApi.call();
                        MonitorLoading().dismiss();
                        BlocProvider.of<RequestRegisterListBloc>(context).add(RequestRegisterListInitEvent());
                      },
                    ).show(context);
                  },
                  onAccept: (p0)  {
                    ConfirmPopupPage(
                      title:  L10nX.getStr.unlock_course,
                      content: L10nX.getStr.your_are_ready_unlock_for_this_user,
                      onAccept: () async {
                        MonitorLoading().showLoading("");
                        UnlockCourseApi unlockCourseApi = UnlockCourseApi(status: mapActionStatusToStr[ActionStatus.Accept]!, requestId: p0.id!);
                        dynamic data = await unlockCourseApi.call();
                        MonitorLoading().dismiss();
                        BlocProvider.of<RequestRegisterListBloc>(context).add(RequestRegisterListInitEvent());
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
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'ID', style: TextStyleConstant.textStyleBlack14w500,
                                  ))),
                          GridColumn(
                              columnName: L10nX.getStr.register_user,
                              minimumWidth: Dimens.size200,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    L10nX.getStr.register_user,
                                    overflow: TextOverflow.ellipsis, style: TextStyleConstant.textStyleBlack14w500,
                                  ))),
                          GridColumn(
                              columnName: L10nX.getStr.course_str,
                              minimumWidth: Dimens.size200,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.course_str, style: TextStyleConstant.textStyleBlack14w500,))),
                          GridColumn(
                              columnName: L10nX.getStr.created_at,
                              minimumWidth: Dimens.size120,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.created_at, style: TextStyleConstant.textStyleBlack14w500,))),
                          GridColumn(
                              columnName: L10nX.getStr.status,
                              maximumWidth: Dimens.size120,
                              label: Container(
                                  padding: EdgeInsets.all(Dimens.size8),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.status, style: TextStyleConstant.textStyleBlack14w500,))),
                          GridColumn(
                              columnName: L10nX.getStr.action_str,
                              maximumWidth: Dimens.size250,
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
class RequestListDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  Function(RegisteredInfo) onAccept, onReject, onDelete;
  int? starIndex;
  RequestListDataSource({
    required List<RegisteredInfo> lessonData, 
    this.starIndex,
    required this.onDelete, 
    required this.onReject, 
    required this.onAccept
  }) {
    
    _lessonData = lessonData.map<DataGridRow>((e) {
      starIndex = (starIndex ??0)+1;
      return  DataGridRow(
          cells: [
            DataGridCell<Widget>(columnName: 'id', value: Text("$starIndex", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.register_user, value:Row(
              children: [
                Expanded(child: Text(e.userName??"", style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            ) ),
            DataGridCell<Widget>(columnName: L10nX.getStr.course_str, value: Row(
              children: [
                Expanded(child: Text(e.courseName??"", style: TextStyleConstant.textStyleBlack14w400,)),
              ],
            )),
            DataGridCell<Widget>(columnName: L10nX.getStr.created_at, value: Text(e.createdAt??"", style: TextStyleConstant.textStyleBlack14w400,)),

            DataGridCell<Widget>(columnName: L10nX.getStr.status, value: Text(e.status??"", style: TextStyleConstant.textStyleBlack14w400,)),
            //DataGridCell<Widget>(columnName: L10nX.getStr.doing_time_str, value: Text("${(e.}", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.action_str, 
                value: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ActionButton1(
                      text: L10nX.getStr.str_accept,
                      height: Dimens.size40,
                      enable: e.status== "New",
                      onTap: () {
                        onAccept(e);
                      },
                    ),
                    Gap(Dimens.size12),
                    ActionButton1(
                      text: L10nX.getStr.reject_str,
                      height: Dimens.size40,
                      enable: e.status== "New",
                      enableBgColor: ColorConst.whiteColor,
                      borderColor: ColorConst.greyColor,
                      textStype: TextStyleConstant.textStyleBlack16w600,
                      onTap: () {
                        onReject(e);
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

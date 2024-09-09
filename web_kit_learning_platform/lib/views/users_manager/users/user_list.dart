import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/page_common/permission_page.dart';
import 'package:webkit/base/permission/permisstion.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/base/widgets/widget_common/widget_with_title_common.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/roles/models/roles_info.dart';
import 'package:webkit/views/lessson/lesson_detail/create_edit_lesson.dart';
import 'package:webkit/widgets/item_edit_view_delete/item_edit_view_delete.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import 'bloc/user_list_bloc.dart';

class UserListPage extends StatefulWidget {
  UserType? userType;
  UserListPage({super.key, this.userType});
  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> with SingleTickerProviderStateMixin, UIMixin {
 TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState>? formKey = GlobalKey();
  ScrollController scrollController=ScrollController();
  @override
  void initState() {
    super.initState();
  }

  int? page = 1;
  final int pageItemCount = 16;
  late int pageCount;
  bool isOnVolume=  false;
  List<String>permission =[
    "users.get.get_user_list"
  ];
  @override
  Widget build(BuildContext context) {
    return PermissionPage(
      permissionList: permission,
      child: BlocProvider(
        create: (context) {
          return UserListBloc(UserListState(userType: widget.userType))..add(UserListInitEvent());
        },
        child: BlocConsumer<UserListBloc, UserListState>(
          listener: (context, state) {
            switch (state.blocStatus) {
              case UserListStatus.initial:
                break;
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
                        child: Text(state.userType == UserType.Teacher? L10nX.getStr.teacher_list:L10nX.getStr.student_list,
                          style: TextStyleConstant.textStyleBlack18w600,),),
                      padding: EdgeInsets.only(top: 35 + 16, bottom: 0),
                      child: buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType));
                }
                else
                {
                  return Layout(
                      isScroll: false,
                      title: Center(child: Text(
                        state.userType ==UserType.Teacher? L10nX.getStr.teacher_list:L10nX.getStr.student_list,
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
    required UserListState state
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
              child: buildUserList(state: state, context: context),
            )),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterCustomPagination(
                  key: GlobalKey(debugLabel: (state.userListResponseModel?.total??0).toString()),
                  currentPage: state.userListResponseModel!.getCurrentPage(),
                  limitPerPage: state.userListResponseModel!.pageSize??10,
                  totalDataCount: state.userListResponseModel!.getTotalElement(),
                  onPreviousPage: (p0) {
                    BlocProvider.of<UserListBloc>(context).add(UserListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onBackToFirstPage: (p0) {
                    BlocProvider.of<UserListBloc>(context).add(UserListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onNextPage: (p0) {
                    BlocProvider.of<UserListBloc>(context).add(UserListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onGoToLastPage: (p0) {
                    BlocProvider.of<UserListBloc>(context).add(UserListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
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
    required UserListState state
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
                      maxWidth:  constraints.maxWidth> Dimens.size800?Dimens.size600:Dimens.size250
                  ),
                  child: Form(
                    key: formKey,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLines: 1,
                            controller: textEditingController,
                            onChanged: (value) {
                    
                            },
                            onFieldSubmitted: (value) {
                              BlocProvider.of<UserListBloc>(context).add(UserListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
                            },
                            onTapOutside: (event) {
                            },
                            style: MyTextStyle.bodyMedium(),
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
                        Gap(Dimens.size12),
                        roleDropDownSearch(state: state, context: context, onChange: (p0) {
                          BlocProvider.of<UserListBloc>(context).add(UserListOnSearchByFilterEvent(
                              searchCommonRequest: state.searchCommonRequest!.copyWith(roleId: p0?.id)));
                        },)
                      ],
                    ),
                  ),
                ),
                Gap(Dimens.size16),
                Visibility(
                  visible: constraints.maxWidth> Dimens.size800,
                  child: ActionButton1(
                    text: L10nX.getStr.search,
                    onTap: () {
                      BlocProvider.of<UserListBloc>(context).add(UserListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                    },
                  ),
                ),
                Visibility(
                  visible: constraints.maxWidth< Dimens.size800,
                  child: InkWell(
                      onTap: () {
                        BlocProvider.of<UserListBloc>(context).add(UserListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                      },
                      child: Icon(Icons.search, color: ColorConst.mainColor,size: Dimens.size40,)),
                ),
              ],
            ),
            Visibility(
              visible: UserManager().userContainPermission(permissionList: [
                "users.post.create_user"
              ]),
              child: Row(
                children: [
                  Gap(Dimens.size10),
                  Visibility(
                    visible: constraints.maxWidth< Dimens.size800,
                    child: InkWell(
                        onTap: () {
                          CreateEditLesson(lessonActionType: ActionType.create,).show(context);
                        },
                        child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
                  ),
                  Visibility(
                    visible: constraints.maxWidth >Dimens.size800,
                    child: ActionButton1(
                      preIcon: Icon(Icons.add_circle_outline, color: ColorConst.whiteColor,size: Dimens.size15,),
                      text: L10nX.getStr.add_new_str,
                      onTap: () {
                       AppPages.routeName(Routes.userEdit,arguments: {
                         'userProfile':null,
                         'actionType':ActionType.create,
                         'editSelfProfile':false
                       });
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
  Widget buildUserList({required UserListState state, required BuildContext context}){

    return Padding(
        padding:  EdgeInsets.all(Dimens.size8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            switch (state.blocStatus) {
              case null:
              // TODO: Handle this case.
              case UserListStatus.initial:
              // TODO: Handle this case.
              case UserListStatus.onLoading:
              // TODO: Handle this case.           // TODO: Handle this case.
              case UserListStatus.onSearchByParams:
              // TODO: Handle this case.
                return Center(child: CircularProgressIndicator());
              case UserListStatus.onLoadEnd:
              // TODO: Handle this case.
                UserDataSource employeeDataSource = UserDataSource(
                  lessonData: state.userListResponseModel?.content??[],
                  starIndex: (state.searchCommonRequest?.pageNumber??0)* (state.searchCommonRequest?.pageSize??0),
                  onDelete: (p0) {
                    ConfirmPopupPage(
                      content: L10nX.getStr.you_want_remove,
                      onAccept: () async {
                      },

                    ).show(context);
                  },
                  onEdit: (p0) {
                    AppPages.routeName(
                        Routes.userEdit,
                        arguments: {
                          'userProfile': p0,
                          'actionType': ActionType.edit,
                          'editSelfProfile':false
                        });
                  },
                  onViewDetail: (p0) {
                    AppPages.routeName(Routes.userEdit,arguments: {'userProfile': p0, 'actionType': ActionType.view, 'editSelfProfile':false});
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
                              columnName: L10nX.getStr.username,
                              minimumWidth: Dimens.size200,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    L10nX.getStr.username,
                                    overflow: TextOverflow.ellipsis,
                                  ))),
                          GridColumn(
                              columnName: L10nX.getStr.full_name,
                              minimumWidth: Dimens.size250,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.full_name))),
                          GridColumn(
                              columnName: L10nX.getStr.email,
                              minimumWidth: Dimens.size300,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.email))),
                          GridColumn(
                              columnName: L10nX.getStr.phone_number,
                              minimumWidth: Dimens.size120,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.phone_number))),
                          GridColumn(
                              columnName: L10nX.getStr.gender,
                              minimumWidth: Dimens.size120,
                              maximumWidth: Dimens.size120,

                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.gender))),
                          GridColumn(
                              columnName: L10nX.getStr.positions,
                              minimumWidth: Dimens.size180,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.positions))),
                          GridColumn(
                              columnName: L10nX.getStr.role_str,
                              maximumWidth: Dimens.size150,
                              minimumWidth: Dimens.size120,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.role_str))),
                          GridColumn(
                              columnName: L10nX.getStr.created_at,
                              maximumWidth: Dimens.size150,
                              minimumWidth: Dimens.size120,
                              label: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(L10nX.getStr.created_at))),
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
          },
        ));

  }

 Widget roleDropDownSearch({
   Function(RoleInfo?)?onChange,
   required BuildContext context,
   required UserListState state
 }) {
   return SizedBox(
     width: Dimens.size150,
     child: FutureBuilder(
       future: PermissionManager().getRoleModel(),
       builder: (context, snapshot) {
         RolesListResponseModel? rolesListResponseModel = RolesListResponseModel(content: []);
         if(snapshot.hasData){
           rolesListResponseModel = snapshot.data?? RolesListResponseModel(content: []);
           if((rolesListResponseModel.content??[]).where((element) => (element.id??'').isEmpty,).isEmpty)
             {
               (rolesListResponseModel.content??[]).insert(0, RoleInfo(name: L10nX.getStr.all_str, id: ""));
             }
         }
         return DropdownSearch<RoleInfo>(
           enabled: true,
           
           popupProps: PopupProps.menu(
             constraints: BoxConstraints(
               maxHeight: (65 + (rolesListResponseModel.content??[]).length * 50 < 210) ? 65 + (rolesListResponseModel.content??[]).length * 50 : 210,
             ),
             showSearchBox: true,
             searchDelay: Duration(milliseconds: 300),
             showSelectedItems: false,
           ),
           
           items: (rolesListResponseModel.content??[]).toList(),
           //selectedItem: selectedItem,
           dropdownDecoratorProps: DropDownDecoratorProps(
             dropdownSearchDecoration: InputDecoration(
               enabled: true,
               hintText: L10nX.getStr.role_str,
               //labelText: value,
               hintTextDirection: TextDirection.ltr,
               border: outlineInputBorder.copyWith(borderRadius: BorderRadius.circular(Dimens.size16)),
               enabledBorder: outlineInputBorder.copyWith(borderRadius: BorderRadius.circular(Dimens.size16)),
               focusedBorder: focusedInputBorder.copyWith(borderRadius: BorderRadius.circular(Dimens.size16)),
               contentPadding: MySpacing.all(Dimens.size16),
               isCollapsed: true,
               floatingLabelBehavior: FloatingLabelBehavior.never,
               
               constraints: BoxConstraints(
                 //minHeight: Dimens.size45
               ),
             ),
           ),
           itemAsString: (item) => item.name??"",
           onChanged: (value) {
             if(onChange!=null)
             {
               onChange(value);
             }
           },
         );
       },
     ),
   );
 }
}

class UserDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  Function(UserProfile) onViewDetail, onEdit, onDelete;
  int? starIndex;
  UserDataSource({
    required List<UserProfile> lessonData,
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
            DataGridCell<Widget>(columnName: L10nX.getStr.username, value:Row(
              mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: Dimens.size40,
                    height: Dimens.size40,
                    decoration: BoxDecoration(
                      color: ColorConst.whiteColor,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: ImageManager().getImageByUrl(
                        e.avatar??"", 
                        errorBuilder: ImageManager().getPngImage(ImageManager.user_png, boxFit: BoxFit.contain)
                    ),
                  ),
                  Gap(Dimens.size8),
                  Expanded(child: Text(e.userName??"", style: TextStyleConstant.textStyleBlack14w400,))
                ]) ),
            DataGridCell<Widget>(columnName: L10nX.getStr.full_name, value: Text(e.fullName??"", style: TextStyleConstant.textStyleBlack14w400,)),

            DataGridCell<Widget>(columnName: L10nX.getStr.email, value: Text(e.email??"", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.phone_number, value: Text(e.phoneNumber??"", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.gender, value: Text(e.gender??"", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.positions, value: Text(e.position??"", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.role_str, value: Text(e.roleName??"", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.created_at, value: Text(e.createdAt??"", style: TextStyleConstant.textStyleBlack14w400,)),

            DataGridCell<Widget>(columnName: L10nX.getStr.action_str,
                value: ItemViewEditDelete(
                  itemInfo: e,
                  enableEditDelete: UserManager().userContainPermission(permissionList: ["users.put.edit_user"]),
                  enableEdit: UserManager().userContainPermission(permissionList: ["users.put.edit_user"]),
                  enableView: UserManager().userContainPermission(permissionList: ["users.get.get_user"]),
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


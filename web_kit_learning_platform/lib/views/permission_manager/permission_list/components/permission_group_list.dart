import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/page_common/permission_page.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/permission/models/permission_info.dart';
import 'package:webkit/views/layouts/layout.dart';
import 'package:webkit/views/permission_manager/permission_list/bloc/permission_list_bloc.dart';
import 'package:webkit/views/permission_manager/permission_list/components/add_permission.dart';
import 'package:webkit/views/permission_manager/permission_list/components/permission_item_view.dart';

class PermissionGroupListPage extends StatefulWidget {
  PermissionGroupListPage({super.key});
  @override
  State<PermissionGroupListPage> createState() => _PermissionGroupListPageState();
}

class _PermissionGroupListPageState extends State<PermissionGroupListPage> with SingleTickerProviderStateMixin, UIMixin {
 TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState>? formKey = GlobalKey();
  ScrollController scrollController=ScrollController();
  List<String>permission =[
    "claim.post.get_claims"
  ];
  @override
  void initState() {
    super.initState();
  }

  int? page = 1;
  final int pageItemCount = 16;
  late int pageCount;
  bool isOnVolume=  false;

  @override
  Widget build(BuildContext context) {
    return PermissionPage(
      permissionList: permission,
      child: BlocProvider(
        create: (context) {
          return PermissionListBloc(PermissionListState())..add(PermissionListInitEvent());
        },
        child: BlocConsumer<PermissionListBloc, PermissionListState>(
          listener: (context, state) {
            switch (state.blocStatus) {
              case PermissionListStatus.initial:
                break;
                // TODO: Handle this case.
              case PermissionListStatus.onSelectTag:
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
                    return buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType);
                  }
                else
                  {
                    return buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType);
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
    required PermissionListState state
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
              child: buildPermissionList(state: state, context: context),
            )),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterCustomPagination(
                  key: GlobalKey(debugLabel: (state.tagListResponseModel?.total??0).toString()),
                  currentPage: state.tagListResponseModel!.getCurrentPage(),
                  limitPerPage: state.tagListResponseModel!.pageSize??10,
                  totalDataCount: state.tagListResponseModel!.getTotalElement(),
                  onPreviousPage: (p0) {
                    BlocProvider.of<PermissionListBloc>(context).add(PermissionListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onBackToFirstPage: (p0) {
                    BlocProvider.of<PermissionListBloc>(context).add(PermissionListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onNextPage: (p0) {
                    BlocProvider.of<PermissionListBloc>(context).add(PermissionListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onGoToLastPage: (p0) {
                    BlocProvider.of<PermissionListBloc>(context).add(PermissionListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
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
    required PermissionListState state
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
                      maxWidth:  constraints.maxWidth> 800?400:250
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
                                BlocProvider.of<PermissionListBloc>(context).add(PermissionListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
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
                  visible: constraints.maxWidth> 800,
                  child: ActionButton1(
                    text: L10nX.getStr.search,
                    radius: 16,
                    onTap: () {
                      BlocProvider.of<PermissionListBloc>(context).add(PermissionListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                    },
                  ),
                ),
                Visibility(
                  visible: constraints.maxWidth< 800,
                  child: InkWell(
                      onTap: () {
                        BlocProvider.of<PermissionListBloc>(context).add(PermissionListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                      },
                      child: Icon(Icons.search, color: ColorConst.mainColor,size: Dimens.size40,)),
                ),
              ],
            ),
            Visibility(
              visible: UserManager().userContainPermission(permissionList: ["tags.post.create_tag"]),
              child: Row(
                children: [
                  Gap(Dimens.size10),
                  Visibility(
                    visible: constraints.maxWidth< 800,
                    child: InkWell(
                        onTap: () {
                          AddPermissionPage(tagPageAction: GradePageAction.create,).show(context, callBack: (p0) {
                            BlocProvider.of<PermissionListBloc>(context).add(PermissionListInitEvent());
                          },);
                        },
                        child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
                  ),
                  Visibility(
                    visible: constraints.maxWidth >800,
                    child: ActionButton1(
                      preIcon: Icon(Icons.add_circle_outline, color: ColorConst.whiteColor,),
                      enable: false,
                      text: L10nX.getStr.add_new_str,
                      onTap: () {
                        AddPermissionPage(tagPageAction: GradePageAction.create,).show(context, callBack: (p0) {
                          BlocProvider.of<PermissionListBloc>(context).add(PermissionListInitEvent());
                        },);
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
 
  Widget buildPermissionList({required PermissionListState state, required BuildContext context}){
    switch (state.blocStatus){
      case null:
        // TODO: Handle this case.
      case PermissionListStatus.initial:
        // TODO: Handle this case.
      case PermissionListStatus.onLoading:
        // TODO: Handle this case.
      case PermissionListStatus.onSearchByParams:
        // TODO: Handle this case.
        return Center(child: CircularProgressIndicator());
      case PermissionListStatus.onSelectTag:
      case PermissionListStatus.onLoadEnd:
        // TODO: Handle this case.
        return  ((state.contentView ?? []).isEmpty) ?
        Center(child:NoData()) :
        StatefulBuilder(
          builder: (context, setState) {
            List<Widget> listOfLesson = List.empty(growable: true);
            for (PermissionGroupInfo info in state.contentView ?? []) {
              listOfLesson.add(GroupPermissionItemView(
                controller: scrollController,
                info: info,
                onChange: (p0) {
                  
                },
              )
              );
            }
            return RawScrollbar(
              controller: scrollController,
              thumbColor: ColorConst.colorIconRed,
              thickness: Dimens.size10,
              child: ListView(
                scrollDirection: Axis.vertical,
                controller: scrollController,
                children:  listOfLesson,
              ),
            );
          },
        );
    }
  }
  
}

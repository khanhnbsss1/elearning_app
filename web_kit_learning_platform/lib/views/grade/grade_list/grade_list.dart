import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/page_common/permission_page.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/grade/models/grade_info.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import 'bloc/grade_list_bloc.dart';
import 'components/add_grade.dart';
import 'components/grade_item_view.dart';

class GradeListPage extends StatefulWidget {
  GradeListPage({super.key});
  @override
  State<GradeListPage> createState() => _GradeListPageState();
}

class _GradeListPageState extends State<GradeListPage> with SingleTickerProviderStateMixin, UIMixin {
  late MemberListController controller;
 TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState>? formKey = GlobalKey();
  ScrollController scrollController=ScrollController();
  List<String>permission =[
    "grades.get.get_grades"
  ];
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
    return PermissionPage(
      permissionList: permission,
      child: BlocProvider(
        create: (context) {
          return GradeListBloc(GradeListState())..add(GradeListInitEvent());
        },
        child: BlocConsumer<GradeListBloc, GradeListState>(
          listener: (context, state) {
            switch (state.blocStatus) {
              case GradeListStatus.initial:
                break;
                // TODO: Handle this case.
              case GradeListStatus.onSelectTag:
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
                          child: Text(L10nX.getStr.grade_str,
                            style: TextStyleConstant.textStyleBlack18w600,),),
                        padding: EdgeInsets.only(top: 35 + 16, bottom: 0),
                        child: buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType));
                  }
                else
                  {
                    return Layout(
                      isScroll: false,
                        title: Center(
                          child: Text(L10nX.getStr.grade_str,
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
    required GradeListState state
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
              child: buildTagList(state: state, context: context),
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
                    BlocProvider.of<GradeListBloc>(context).add(GradeListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onBackToFirstPage: (p0) {
                    BlocProvider.of<GradeListBloc>(context).add(GradeListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onNextPage: (p0) {
                    BlocProvider.of<GradeListBloc>(context).add(GradeListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onGoToLastPage: (p0) {
                    BlocProvider.of<GradeListBloc>(context).add(GradeListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
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
    required GradeListState state
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
                            child: SizedBox(
                              height:Dimens.size45,
                              child: TextFormField(
                                maxLines: 1,
                                controller: textEditingController,
                                onChanged: (value) {
                              
                                },
                                onFieldSubmitted: (value) {
                                  BlocProvider.of<GradeListBloc>(context).add(GradeListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
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
                        BlocProvider.of<GradeListBloc>(context).add(GradeListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                      },
                    ),
                  ),
                  Visibility(
                    visible: constraints.maxWidth< 800,
                    child: InkWell(
                        onTap: () {
                          BlocProvider.of<GradeListBloc>(context).add(GradeListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
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
                            AddGradePage(tagPageAction: GradePageAction.create,).show(context, callBack: (p0) {
                              BlocProvider.of<GradeListBloc>(context).add(GradeListInitEvent());
                            },);
                          },
                          child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
                    ),
                    Visibility(
                      visible: constraints.maxWidth >800,
                      child: ActionButton1(
                        preIcon: Icon(Icons.add_circle_outline, color: ColorConst.whiteColor, size: Dimens.size15),
                        text: L10nX.getStr.add_new_str,
                        onTap: () {
                          AddGradePage(tagPageAction: GradePageAction.create,).show(context, callBack: (p0) {
                            BlocProvider.of<GradeListBloc>(context).add(GradeListInitEvent());
                          },);
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
 
  Widget buildTagList({required GradeListState state, required BuildContext context}){
    List<Widget> listOfLesson = List.empty(growable: true);

    for (GradeInfo lessonInfo in state.contentView ?? []) {
      listOfLesson.add(
        InkWell(
          onTap: () {
            BlocProvider.of<GradeListBloc>(context).add(TagListOnSelectTagEvent(selectTagInfo: lessonInfo));
          },
          child: GradeItemView(
            tagInfo: lessonInfo,
            
            onViewDetail: (p0) {
              AddGradePage(tagPageAction: GradePageAction.view,).show(context);
            },
            onEdit: (p0) {
              AddGradePage(info: p0,tagPageAction: GradePageAction.edit,).show(context, callBack: (p0) {
                BlocProvider.of<GradeListBloc>(context).add(GradeListInitEvent());
              },);
            },
            onDelete: (p0) {
              ConfirmPopupPage(
                title: L10nX.getStr.remove_tags,
                content: L10nX.getStr.you_want_remove,
                onAccept: () {
                  BlocProvider.of<GradeListBloc>(context).add(GradeListOnDeleteTagEvent(selectTagInfo: p0));
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
      case GradeListStatus.initial:
        // TODO: Handle this case.
      case GradeListStatus.onLoading:
        // TODO: Handle this case.
      case GradeListStatus.onSearchByParams:
        // TODO: Handle this case.
        return Center(child: CircularProgressIndicator());
      case GradeListStatus.onSelectTag:
      case GradeListStatus.onLoadEnd:
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
  
}

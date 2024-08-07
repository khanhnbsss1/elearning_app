import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/theme/theme_customizer.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/views/lessson/lesson_detail/create_edit_lesson.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import 'bloc/tag_list_bloc.dart';
import 'components/add_tag.dart';
import 'components/tag_item_view.dart';

class TagListPage extends StatefulWidget {
  TagListPage({super.key});
  @override
  State<TagListPage> createState() => _TagListPageState();
}

class _TagListPageState extends State<TagListPage> with SingleTickerProviderStateMixin, UIMixin {
  late MemberListController controller;
 TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState>? formKey = GlobalKey();
  ScrollController scrollController=ScrollController();
  @override
  void initState() {
    super.initState();
    controller = Get.put(MemberListController());
    WidgetsBinding.instance.addPostFrameCallback((_){
      ThemeCustomizer().toggleLeftBarCondensedByValue(leftBarCondensed: true);
    });
  }

  int? page = 1;
  final int pageItemCount = 16;
  late int pageCount;
  bool isOnVolume=  false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TagListBloc(TagListState())..add(TagListInitEvent());
      },
      child: BlocConsumer<TagListBloc, TagListState>(
        listener: (context, state) {
          switch (state.blocStatus) {
            case TagListStatus.initial:
              break;
              // TODO: Handle this case.
            case TagListStatus.onSelectTag:
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
                      padding: EdgeInsets.only(top: 35 + 16, bottom: 0),
                      child: buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType));
                }
              else
                {
                  return Layout(
                    isScroll: false,
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
    required TagListState state
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
                  limitPerPage: state.tagListResponseModel!.getTotalPage(),
                  totalDataCount: state.tagListResponseModel!.getTotalPage(),
                  onPreviousPage: (p0) {
                    BlocProvider.of<TagListBloc>(context).add(TagListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onBackToFirstPage: (p0) {
                    BlocProvider.of<TagListBloc>(context).add(TagListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onNextPage: (p0) {
                    BlocProvider.of<TagListBloc>(context).add(TagListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onGoToLastPage: (p0) {
                    BlocProvider.of<TagListBloc>(context).add(TagListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
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
    required TagListState state
  }){
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: ColorConst.dividerColor)
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
                      BlocProvider.of<TagListBloc>(context).add(TagListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
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
                    BlocProvider.of<TagListBloc>(context).add(TagListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                  },
                  child: Icon(Icons.search_rounded, color: ColorConst.mainColor,size: Dimens.size40,)),
            ],
          ),
         
          Row(
            children: [
              Gap(Dimens.size10),
              InkWell(
                  onTap: () {
                    // CourseDetail(courseInfo: state.courseResponseModel!.content,).show(context);
                    AddTagPage(tagPageAction: TagPageAction.create,).show(context, callBack: (p0) {
                      BlocProvider.of<TagListBloc>(context).add(TagListInitEvent());
                    },);
                  },
                  child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
            ],
          ),
        ],
      ),
    );
  }
  Widget buildTagList({required TagListState state, required BuildContext context}){
    List<Widget> listOfLesson = List.empty(growable: true);

    for (TagsInfo lessonInfo in state.tagListResponseModel?.content ?? []) {
      listOfLesson.add(
        InkWell(
          onTap: () {
            BlocProvider.of<TagListBloc>(context).add(TagListOnSelectTagEvent(selectTagInfo: lessonInfo));
          },
          child: TagItemView(
            tagInfo: lessonInfo,
            onViewDetail: (p0) {
              AddTagPage(tagPageAction: TagPageAction.view,).show(context);
            },
            onEdit: (p0) {
              AddTagPage(tagsInfo: p0,tagPageAction: TagPageAction.edit,).show(context, callBack: (p0) {
                BlocProvider.of<TagListBloc>(context).add(TagListInitEvent());
              },);
            },
            onDelete: (p0) {
              ConfirmPopupPage(
                title: L10nX.getStr.remove_tags,
                content: L10nX.getStr.you_want_remove,
                onAccept: () {
                  BlocProvider.of<TagListBloc>(context).add(TagListOnDeleteTagEvent(selectTagInfo: p0));
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
      case TagListStatus.initial:
        // TODO: Handle this case.
      case TagListStatus.onLoading:
        // TODO: Handle this case.
      case TagListStatus.onSearchByParams:
        // TODO: Handle this case.
        return Center(child: CircularProgressIndicator());
      case TagListStatus.onSelectTag:
      case TagListStatus.onLoadEnd:
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/quiz/models/quiz_info.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import 'bloc/quiz_list_bloc.dart';
import 'components/quiz_detail.dart';
import 'components/quiz_item_view.dart';

class QuizListPage extends StatefulWidget {
  QuizListPage({super.key});
  @override
  State<QuizListPage> createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> with SingleTickerProviderStateMixin, UIMixin {
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return QuizListBloc(QuizListState())..add(QuizListInitEvent());
      },
      child: BlocConsumer<QuizListBloc, QuizListState>(
        listener: (context, state) {
          switch (state.blocStatus) {
            case QuizListStatus.initial:
              break;
          // TODO: Handle this case.
            case QuizListStatus.onSelectTag:
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
              child: buildQuizList(state: state, context: context),
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
                    BlocProvider.of<QuizListBloc>(context).add(QuizListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onBackToFirstPage: (p0) {
                    BlocProvider.of<QuizListBloc>(context).add(QuizListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onNextPage: (p0) {
                    BlocProvider.of<QuizListBloc>(context).add(QuizListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onGoToLastPage: (p0) {
                    BlocProvider.of<QuizListBloc>(context).add(QuizListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
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
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: ColorConst.dividerColor, width: 0.2)
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
                      BlocProvider.of<QuizListBloc>(context).add(QuizListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
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
                    BlocProvider.of<QuizListBloc>(context).add(QuizListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
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
                    QuizDetailPage(tagPageAction: QuizPageAction.create,).show(context, callBack: (p0) {
                      BlocProvider.of<QuizListBloc>(context).add(QuizListInitEvent());
                    },);
                  },
                  child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
            ],
          ),
        ],
      ),
    );
  }
  Widget buildQuizList({required QuizListState state, required BuildContext context}){
    List<Widget> listOfLesson = List.empty(growable: true);

    for (QuizInfo lessonInfo in state.listResponseModel?.content ?? []) {
      listOfLesson.add(
          InkWell(
            onTap: () {
              BlocProvider.of<QuizListBloc>(context).add(QuizListOnSelectTagEvent(selectInfo: lessonInfo));
            },
            child: QuizItemView(
              info: lessonInfo,
              onViewDetail: (p0) {
                QuizDetailPage(tagPageAction: QuizPageAction.view,).show(context);
              },
              onEdit: (p0) {
                QuizDetailPage(tagsInfo: p0,tagPageAction: QuizPageAction.edit,).show(context, callBack: (p0) {
                  BlocProvider.of<QuizListBloc>(context).add(QuizListInitEvent());
                },);
              },
              onDelete: (p0) {
                ConfirmPopupPage(
                  title: L10nX.getStr.remove_tags,
                  content: L10nX.getStr.you_want_remove,
                  onAccept: () {
                    BlocProvider.of<QuizListBloc>(context).add(QuizListOnDeleteTagEvent(selectInfo: p0));
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
      case QuizListStatus.initial:
      // TODO: Handle this case.
      case QuizListStatus.onLoading:
      // TODO: Handle this case.
      case QuizListStatus.onSearchByParams:
      // TODO: Handle this case.
        return Center(child: CircularProgressIndicator());
      case QuizListStatus.onSelectTag:
      case QuizListStatus.onLoadEnd:
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


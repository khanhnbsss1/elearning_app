import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/views/lessson/components/lesson_item_view.dart';
import 'package:webkit/views/lessson/lesson_detail/create_edit_lesson.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import 'bloc/lesson_list_bloc.dart';

class LessonListPage extends StatefulWidget {
  LessonListPage({super.key});
  @override
  State<LessonListPage> createState() => _LessonListPageState();
}

class _LessonListPageState extends State<LessonListPage> with SingleTickerProviderStateMixin, UIMixin {
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
        return LessonListBloc(LessonListState())..add(LessonListInitEvent());
      },
      child: BlocConsumer<LessonListBloc, LessonListState>(
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
    required LessonListState state
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
              child: buildLessonList(state: state, context: context),
            )),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterCustomPagination(
                  key: GlobalKey(debugLabel: (state.lessonListResponseModel?.total??0).toString()),
                  currentPage: state.lessonListResponseModel!.getCurrentPage(),
                  limitPerPage: state.lessonListResponseModel!.getTotalPage(),
                  totalDataCount: state.lessonListResponseModel!.getTotalPage(),
                  onPreviousPage: (p0) {
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onBackToFirstPage: (p0) {
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onNextPage: (p0) {
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onGoToLastPage: (p0) {
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
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
    required LessonListState state
  }){
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: ColorConst.dividerColor, width: 0.1)
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
                      BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
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
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
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
                    CreateEditLesson(lessonActionType: LessonActionType.create,).show(context);
                  },
                  child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
            ],
          ),
        ],
      ),
    );
  }
  Widget buildLessonList({required LessonListState state, required BuildContext context}){
    List<Widget> listOfLesson = List.empty(growable: true);

    for (LessonInfo lessonInfo in state.lessonListResponseModel?.content ?? []) {
      listOfLesson.add(
        InkWell(
          onTap: () {
            BlocProvider.of<LessonListBloc>(context).add(LessonListOnSelectLessonEvent(selectLessonInfo: lessonInfo));
          },
          child: LessonItemView(
            lessonInfo: lessonInfo,
            onViewDetail: (p0) {
              CreateEditLesson(lessonActionType: LessonActionType.view, lessonInfo: p0,).show(context);
            },
            onEdit: (p0) {
              CreateEditLesson(lessonActionType: LessonActionType.edit,lessonInfo: p0,).show(context);
            },
            onDelete: (p0) {
            },
          ),
        )
      );
    }
    switch (state.blocStatus){
      case null:
        // TODO: Handle this case.
      case LessonListStatus.initial:
        // TODO: Handle this case.
      case LessonListStatus.onLoading:
        // TODO: Handle this case.
      case LessonListStatus.onSearchByParams:
        // TODO: Handle this case.
        return Center(child: CircularProgressIndicator());
      case LessonListStatus.onSelectLesson:
      case LessonListStatus.onLoadEnd:
        // TODO: Handle this case.
        return  (listOfLesson.isEmpty) ?
        Center(child:NoData()) :
        Scrollbar(
          controller: scrollController,
          thickness: Dimens.size10,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: scrollController,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.spaceBetween,
              children: listOfLesson,
            ),
          ),
        );
    }
  }
  
}

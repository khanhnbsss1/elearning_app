import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/widgets/course_item.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/plugins/screenshot/lib/screenshot.dart';
import 'package:webkit/views/course/course_detail/course_detail.dart';
import 'package:webkit/views/course/course_list/bloc/course_list_bloc.dart';
import 'package:webkit/views/vocabulary/vocabulary_detail/add_words.dart';
import '../../../base/constant/dimens_constant.dart';
import '../../../helpers/theme/app_style.dart';
import '../../../helpers/widgets/course_item_grid_view.dart';
import '../../../helpers/widgets/my_button.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../../landing_page/mediaquery/mq.dart';
import '../../../services/apis/course/course_list/models/course_models.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../layouts/layout.dart';
import 'components/filter_menu_item.dart';

class CourseList extends StatefulWidget {
  CourseList({super.key, this.courseType}){
    courseType??=CourseType.courseList;
  }
  CourseType? courseType;
  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList>
    with SingleTickerProviderStateMixin, UIMixin {
  late MemberListController controller;
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CourseListBloc(CourseListState(courseType: widget.courseType))..add(CourseListInitEvent());
      },
      child: BlocConsumer<CourseListBloc, CourseListState>(
        listener: (context, state) {
          switch (state.blocStatus) {
            case CourseStatus.initial:
              break;
            default:
              break;
          }
        },
        builder: (BuildContext context, state) {
          return MyResponsive(
            builder: (context , boxConstraints , myScreenMediaType ) {
              return Layout(
                  isScroll: false,
                  padding: EdgeInsets.only(top: 35 + 16, bottom: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            state.courseType == CourseType.courseList?
                            MyButton(
                              onTap: () {
                                CourseDetail().show(context);
                              },
                              elevation: 0,
                              padding: MySpacing.xy(12, 16),
                              backgroundColor: contentTheme.primary,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.plusCircle,
                                    color: contentTheme.light,
                                    size: 16,
                                  ),
                                  MySpacing.width(16),
                                  MyText.bodySmall(
                                    "Add New",
                                    color: contentTheme.onPrimary,
                                  ),
                                ],
                              ),
                            ):SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FilterCoursePopupMenu(onSelect: (p0) {
                                  BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(
                                      searchCommonRequest: state.searchCommonRequest!.copyWith(filterType: p0.filterType,gradeId: p0.selectSubFilter?.id,)));
                                },),
                                Gap(Dimens.size10),
                                SizedBox(
                                  width: 200,
                                  height: Dimens.size40,
                                  child: Form(
                                    key: formKey,
                                    child: TextFormField(
                                      maxLines: 1,
                                      onChanged: (value) {
                  
                                      },
                                      controller: editingController,
                                      onFieldSubmitted: (value) {
                                        BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
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
                                ActionButton1(
                                  text: S.of(context).search,
                                  height: Dimens.size40,
                                  radius: Dimens.size16,
                                  onTap: () {
                                    BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(
                                        searchCommonRequest: state.searchCommonRequest!.copyWith(keyword:editingController.text )));

                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      myScreenMediaType.isMobile?
                      buildCourseList(state: state):
                      Expanded(child: buildCourseList(state: state)),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlutterCustomPagination(
                            key: GlobalKey(debugLabel: (state.courseResponseModel?.total??0).toString()),
                            currentPage: state.courseResponseModel!.getCurrentPage(),
                            limitPerPage: state.courseResponseModel!.getTotalPage(),
                            totalDataCount: state.courseResponseModel!.getTotalPage(),
                            onPreviousPage: (p0) {
                              BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                            },
                            onBackToFirstPage: (p0) {
                              BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                            },
                            onNextPage: (p0) {
                              BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                            },
                            onGoToLastPage: (p0) {
                              BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
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
                  ));
            },);
          
        },
      ),
    );
  }
  Widget buildCourseList({required CourseListState state}){
    List<Widget> listOfCourse = List.empty(growable: true);

    for (CourseInfo courseInfo in state.courseResponseModel?.content ?? []) {
      listOfCourse.add(CourseItemGridView(courseInfo: courseInfo,));
    }
    
    switch (state.blocStatus)
    {
      case null:
        // TODO: Handle this case.
      case CourseStatus.initial:
        // TODO: Handle this case.
      case CourseStatus.onLoading:
        // TODO: Handle this case.
      case CourseStatus.onSearchByParams:
        // TODO: Handle this case.
        return Center(child: CircularProgressIndicator());
      case CourseStatus.onLoadEnd:
        // TODO: Handle this case.
        return  (listOfCourse.isEmpty) ?
        Center(child:NoData()) :
        Scrollbar(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: scrollController,
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.spaceBetween,
                children: listOfCourse,
                
              ),
            ),
          ),
        );
    }
  }
}

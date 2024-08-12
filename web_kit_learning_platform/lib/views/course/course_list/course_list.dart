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
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/views/course/course_detail/course_study/course_study.dart';
import 'package:webkit/views/course/course_list/bloc/course_list_bloc.dart';
import 'package:webkit/views/course/course_detail/course_preview.dart';
import 'package:webkit/views/course/create_edit_course/create_edit_course.dart';
import '../../../helpers/theme/app_style.dart';
import '../../../helpers/widgets/course_item_grid_view.dart';
import '../../../helpers/widgets/my_button.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import 'components/filter_menu_item.dart';

class CourseList extends StatefulWidget {
  CourseList({super.key, this.courseType}) {
    courseType ??= CourseType.courseList;
  }
  CourseType? courseType;
  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> with SingleTickerProviderStateMixin, UIMixin {
  late MemberListController controller;
  GlobalKey<FormState>? formKey = GlobalKey();
  ScrollController scrollController = ScrollController();
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
            builder: (context, boxConstraints, myScreenMediaType) {
              return Column(
                children: [
                  Expanded(
                    child: Layout(
                        isScroll: false,
                        padding: EdgeInsets.only(top: 35 + 16, bottom: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Material(
                              elevation: 1,
                              child: Container(
                                color: ColorConst.whiteColor,
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      state.courseType == CourseType.courseList
                                          ? MyButton(
                                              onTap: () {
                                                CreateEditCourse(
                                                  coursePageType: CoursePageType.create,
                                                ).show(context);
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
                                            )
                                          : SizedBox(),
                                      Gap(Dimens.size10),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            ResponsiveInfo.isPhone()
                                                ? Expanded(
                                                    child: SizedBox(
                                                      height: Dimens.size40,
                                                      child: Form(
                                                        key: formKey,
                                                        child: TextFormField(
                                                          maxLines: 1,
                                                          onChanged: (value) {},
                                                          controller: editingController,
                                                          onFieldSubmitted: (value) {
                                                            BlocProvider.of<CourseListBloc>(context)
                                                                .add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
                                                          },
                                                          onTapOutside: (event) {},
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
                                                              prefixIconConstraints: const BoxConstraints(minWidth: 36, maxWidth: 36, minHeight: 32, maxHeight: 32),
                                                              contentPadding: MySpacing.xy(16, 12),
                                                              //isCollapsed: true,
                                                              floatingLabelBehavior: FloatingLabelBehavior.auto),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: Dimens.size40,
                                                    width: Dimens.size200,
                                                    child: Form(
                                                      key: formKey,
                                                      child: TextFormField(
                                                        maxLines: 1,
                                                        onChanged: (value) {},
                                                        controller: editingController,
                                                        onFieldSubmitted: (value) {
                                                          BlocProvider.of<CourseListBloc>(context)
                                                              .add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
                                                        },
                                                        onTapOutside: (event) {},
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
                                                            prefixIconConstraints: const BoxConstraints(minWidth: 36, maxWidth: 36, minHeight: 32, maxHeight: 32),
                                                            contentPadding: MySpacing.xy(16, 12),
                                                            //isCollapsed: true,
                                                            floatingLabelBehavior: FloatingLabelBehavior.auto),
                                                      ),
                                                    ),
                                                  ),
                                            Gap(Dimens.size10),
                                            ResponsiveInfo.isTablet()
                                                ? ActionButton1(
                                                    text: S.of(context).search,
                                                    height: Dimens.size40,
                                                    radius: Dimens.size16,
                                                    onTap: () {
                                                      BlocProvider.of<CourseListBloc>(context)
                                                          .add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: editingController.text)));
                                                    },
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<CourseListBloc>(context)
                                                          .add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: editingController.text)));
                                                    },
                                                    child: Icon(
                                                      Icons.search,
                                                      color: ColorConst.mainColor,
                                                    ),
                                                  ),
                                            Gap(Dimens.size10),
                                            FilterCoursePopupMenu(
                                              onSelect: (p0) {
                                                BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(
                                                    searchCommonRequest: state.searchCommonRequest!.copyWith(
                                                  filterType: p0.filterType,
                                                  gradeId: p0.selectSubFilter?.id,
                                                )));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            myScreenMediaType.isMobile ?
                            Expanded(child: buildCourseList(state: state, boxConstraints: boxConstraints)) :
                            Expanded(child: buildCourseList(state: state, boxConstraints: boxConstraints)),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        )),
                  ),
                  Center(
                    child: FlutterCustomPagination(
                      key: UniqueKey(),
                      currentPage: state.courseResponseModel!.getCurrentPage(),
                      limitPerPage: state.courseResponseModel!.pageSize??10,
                      totalDataCount: state.courseResponseModel!.getTotalElement(),
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
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget buildCourseList({required CourseListState state, required BoxConstraints boxConstraints}) {
    List<Widget> listOfCourse = List.empty(growable: true);

    bool? enableEdit = state.userProfile?.getPermission().contains("");
    double maxWidthItem = 400;
    double heightOfItem = 460;
    int numberRow = (boxConstraints.maxWidth / maxWidthItem).toInt();
    double widthItem = (boxConstraints.maxWidth - (50 * numberRow)) / numberRow;
    for (CourseInfo courseInfo in state.courseResponseModel?.content ?? []) {
      listOfCourse.add(CourseItemGridView(
        courseInfo: courseInfo,
        enableEdit: enableEdit,
        onDelete: (p0) {},
        onEdit: (p0) {
          CreateEditCourse(
            coursePageType: CoursePageType.edit,
            courseInfo: p0,
          ).show(context);
        },
        onViewDetail: (p0) {
          CoursePreview(
            courseInfo: courseInfo,
          ).show(context);
        },
        onStudy: (p0) {
          CourseStudy1(
            courseInfo: courseInfo,
          ).show(context);
        },
      ));
    }

    switch (state.blocStatus) {
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
        double width = MediaQuery.of(context).size.width;
        return (listOfCourse.isEmpty)
            ? Center(child: NoData())
            : Align(
                alignment: Alignment.topLeft,
                child: Scrollbar(
                  controller: scrollController,
                  thickness: ResponsiveInfo.isPhone()?5: 15,
                  radius: Radius.circular(0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: numberRow>1?GridView.count(
                              //padding: const EdgeInsets.all(20),
                              controller: scrollController,
                              crossAxisSpacing: 24,
                              childAspectRatio: (widthItem) / (heightOfItem) - 0.1,
                              mainAxisSpacing: 24,
                              crossAxisCount: numberRow,
                              shrinkWrap: true,
                              children: listOfCourse,
                            ): ListView(
                              shrinkWrap: true,
                              controller: scrollController,
                              scrollDirection: Axis.vertical,
                              children: listOfCourse,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
    }
  }
}

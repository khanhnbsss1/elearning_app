import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/instance_mananger/filter_manager.dart';
import 'package:webkit/base/page_common/permission_page.dart';
import 'package:webkit/base/widgets/pagination/pagination_custom.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/my_screen_media_type.dart';
import 'package:webkit/models/user.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/course/delete_course/delete_course_api.dart';
import 'package:webkit/views/course/course_detail/course_study/course_study.dart';
import 'package:webkit/views/course/course_list/bloc/course_list_bloc.dart';
import 'package:webkit/views/course/course_detail/course_preview.dart';
import 'package:webkit/views/course/create_edit_course/create_edit_course.dart';
import '../../../helpers/widgets/course_item_grid_view.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';

class CourseList extends StatefulWidget {
  CourseList({super.key, this.courseType, this.isActivate}) {
    courseType ??= CourseType.courseList;
    isActivate??=true;
  }
  CourseType? courseType;
  bool? isActivate;
  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> with SingleTickerProviderStateMixin, UIMixin {
  late MemberListController controller;
  GlobalKey<FormState>? formKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  TextEditingController editingController = TextEditingController();
  
  List<String>permission =[
    //"courses.post.get_my_course",
    "courses.post.search_course"
  ];
  @override
  void initState() {
    super.initState();
    controller = Get.put(MemberListController());
  }
  
  @override
  Widget build(BuildContext context) {
    return PermissionPage(
      permissionList: permission,
      child: BlocProvider(
        create: (context) {
          return CourseListBloc(CourseListState(courseType: widget.courseType,isActivate: widget.isActivate ))..add(CourseListInitEvent());
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
                return Layout(
                    isScroll: false,
                    title: Text(
                      state.courseType == CourseType.courseList ? L10nX.getStr.courses_list : L10nX.getStr.your_course,
                      style: TextStyleConstant.textStyleBlack18w600,
                    ),
                    padding: EdgeInsets.only(top: Dimens.size60),

                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorConst.whiteColor,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildListFilter(
                                    context: context,
                                    myScreenMediaType: myScreenMediaType,
                                    state: state,
                                    boxConstraints: boxConstraints
                                ),
                                myScreenMediaType.isMobile
                                    ? Expanded(child: buildCourseList(state: state, boxConstraints: boxConstraints))
                                    : Expanded(child: buildCourseList(state: state, boxConstraints: boxConstraints)),
                                SizedBox(
                                  height:Dimens.size8,
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: PaginationCustom(
                              key: UniqueKey(),
                              currentPage: state.courseResponseModel!.getCurrentPage(),
                              limitPerPage: state.courseResponseModel!.pageSize ?? 10,
                              totalDataCount: state.courseResponseModel!.getTotalElement(),
                              onPreviousPage: (p0) {
                                BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                              },
                              onBackToFirstPage: (p0) {
                                BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                              },
                              onNextPage: (p0) {
                                BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                              },
                              onGoToLastPage: (p0) {
                                BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
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
                      ),
                    ));
              },
            );
          },
        ),
      ),
    );
  }
  Widget buildListFilter(  {
    required MyScreenMediaType myScreenMediaType,
    required BoxConstraints boxConstraints,
    required BuildContext context,
    required CourseListState state
  }){
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: ColorConst.dividerColor, width: 0.2)
            )
        ),
        padding: EdgeInsets.symmetric(vertical: Dimens.size8, horizontal: Dimens.size16),
        child: SizedBox(
          height: Dimens.size50,
          child: Form(
            key: formKey,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: Dimens.size250,
                                height: Dimens.size40,
                                child: TextFormField(
                                  maxLines: 1,
                                  controller: editingController,
                                  onChanged: (value) {
                                              
                                  },
                                  onFieldSubmitted: (value) {
                                    BlocProvider.of<CourseListBloc>(context)
                                        .add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value, pageNumber: 0)));
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
                                          minWidth: Dimens.size36,
                                          maxWidth: Dimens.size36,
                                          minHeight: Dimens.size40,
                                          maxHeight: Dimens.size40),
                                      contentPadding: MySpacing.xy(Dimens.size16, Dimens.size12),
                                      //isCollapsed: true,
                                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                                ),
                              ),
                              Gap(Dimens.size12),
                              FilterManager().buildGrade(
                                context: context, 
                                title: "", 
                                enableInit: false,
                                onChanged: (p0) {
                                  BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(
                                      searchCommonRequest: state.searchCommonRequest!.copyWith(
                                          gradeId: p0?.id,
                                          pageNumber: 0
                                      )));
                              },),
                              Gap(Dimens.size12),
                              FilterManager().buildCategory(
                                context: context,
                                title: "",
                                enableInit: false,
                                onChanged: (p0) {
                                  BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(
                                      searchCommonRequest: state.searchCommonRequest!.copyWith(
                                          categoryId: p0?.id,
                                          pageNumber: 0
                                      )));
                                },),
                              Gap(Dimens.size12),
                              FilterManager().buildAuthor(
                                context: context,
                                title: "",
                                onChanged: (p0) {
                                  BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(
                                      searchCommonRequest: state.searchCommonRequest!.copyWith(
                                          producerName: p0.value,
                                          pageNumber: 0
                                      )));
                                },),
                              Gap(Dimens.size12),
                              FilterManager().buildMode(
                                context: context,
                                title: "",
                                enableInit: false,
                                onChanged: (p0) {
                                  BlocProvider.of<CourseListBloc>(context).add(CourseListOnSearchByFilterEvent(
                                      searchCommonRequest: state.searchCommonRequest!.copyWith(
                                         mode : p0,
                                         pageNumber: 0
                                      )));
                                },),
                              Gap(Dimens.size12),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Visibility(
                                    visible: constraints.maxWidth< Dimens.size800,
                                    child: InkWell(
                                        onTap: () {
                                          BlocProvider.of<CourseListBloc>(context)
                                              .add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: editingController.text)));                                           },
                                        child: Icon(Icons.search, color: ColorConst.mainColor,size: Dimens.size40,)),
                                  ),
                                  Visibility(
                                    visible: constraints.maxWidth> Dimens.size800,
                                    child: ActionButton1(
                                      text: L10nX.getStr.search,
                                      radius: Dimens.size16,
                                      onTap: () {
                                        BlocProvider.of<CourseListBloc>(context)
                                            .add(CourseListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: editingController.text)));                                         },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(Dimens.size16),
                    ],
                  ),
                ),
                
                Visibility(
                  visible: state.courseType == CourseType.courseList &&
                      UserManager().userContainPermission(permissionList: [
                        "courses.post.create_course",
                      ]),
                  child: Row(
                    children: [
                      Visibility(
                        visible: constraints.maxWidth< Dimens.size800,
                        child: InkWell(
                            onTap: () {
                              CreateEditCourse(
                                coursePageType: CoursePageType.create,
                              ).show(context);
                            },
                            child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
                      ),
                      Visibility(
                        visible: constraints.maxWidth >Dimens.size800,
                        child: ActionButton1(
                          preIcon: Icon(Icons.add_circle_outline, color: ColorConst.whiteColor,size: Dimens.size15,),
                          text: L10nX.getStr.add_new_str,
                          onTap: () {
                            CreateEditCourse(
                              coursePageType: CoursePageType.create,
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
        ),
      );
    },);
  }
  Widget buildCourseList({required CourseListState state, required BoxConstraints boxConstraints}) {
    return Padding(
      padding:  EdgeInsets.all(Dimens.size8),
      child: LayoutBuilder(
        builder: (context, constraints) {
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
              return ((state.courseResponseModel?.content ?? []).isEmpty)
                  ? Center(child: NoData())
                  : LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        List<Widget> listOfCourse = List.empty(growable: true);
                        bool? enableEdit = state.courseType == CourseType.courseList && UserManager().userContainPermission(
                            permissionList: [
                              "courses.put.update_course"
                            ]);
                        double maxWidthItem = Dimens.size260;
                        double heightOfItem = Dimens.size240;
                        int numberRow = (constraints.maxWidth ~/ (maxWidthItem + Dimens.size10));
                        double widthItem = maxWidthItem;
                        double crossAxisSpacing = (constraints.maxWidth - numberRow * (maxWidthItem + Dimens.size10)) / numberRow;
                        if (crossAxisSpacing > Dimens.size30) {
                          crossAxisSpacing = Dimens.size30;
                        } else if (crossAxisSpacing <= Dimens.size20) {
                          crossAxisSpacing = Dimens.size20;
                        }
                        for (CourseInfo courseInfo in state.courseResponseModel?.content ?? []) {
                          listOfCourse.add(CourseItemGridView(
                            courseInfo: courseInfo,
                            enableEdit: enableEdit,
                            row: numberRow,
                            onDelete: (p0) async {
                              ConfirmPopupPage(
                                title: L10nX.getStr.course_delete,
                                onAccept: () async {
                                  MonitorLoading().showLoading("");
                                  DeleteCourseApi api = DeleteCourseApi(info: p0);
                                  dynamic data = await api.call();
                                  MonitorLoading().dismiss();
                                  BlocProvider.of<CourseListBloc>(context).add(CourseListInitEvent());
                                },
                              ).show(context);
                            
                            },
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
      
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Scrollbar(
                            controller: scrollController,
                            thickness: ResponsiveInfo.isPhone() ? Dimens.size5 : Dimens.size15,
                            radius: Radius.circular(0),
                            child: Padding(
                              padding:  EdgeInsets.only(right: Dimens.size16),
                              child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) { 
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: numberRow > 1
                                              ? Padding(
                                            padding: EdgeInsets.only(top: Dimens.size16, left: crossAxisSpacing / 2, right: crossAxisSpacing / 2),
                                            child: GridView.count(
                                              controller: scrollController,
                                              crossAxisSpacing: crossAxisSpacing,
                                              childAspectRatio: (widthItem) / (heightOfItem),
                                              mainAxisSpacing: Dimens.size16,
                                              crossAxisCount: numberRow,
                                              shrinkWrap: true,
                                              children: listOfCourse,
                                            ),
                                          )
                                              : ListView.builder(
                                            shrinkWrap: true,
                                            controller: scrollController,
                                            itemCount: listOfCourse.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:  EdgeInsets.symmetric(horizontal:  Dimens.size8, vertical: Dimens.size4),
                                                child: listOfCourse.elementAt(index),
                                              );
                                            },
                                          )),
                                    ),
                                  ],
                                );
                              },
                              ),
                            ),
                          ),
                        );
                      },
                    );
          }
        },
      ),
    );
  }
}

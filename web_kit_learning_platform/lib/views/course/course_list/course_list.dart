import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/widgets/course_item.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/plugins/screenshot/lib/screenshot.dart';
import 'package:webkit/views/course/course_list/add_words.dart';
import 'package:webkit/views/course/course_list/course_detail.dart';
import 'package:webkit/views/course/course_list/bloc/course_list_bloc.dart';
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

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList>
    with SingleTickerProviderStateMixin, UIMixin {
  late MemberListController controller;

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
        return CourseListBloc(CourseListState())..add(CourseListInitEvent());
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
                  child: GetBuilder(
                    init: controller,
                    builder: (controller) {
                      double width = MediaQuery.of(context).size.width;
                      double height = MediaQuery.of(context).size.height;
                      double gridViewItemRowCount = width > 1400
                          ? 4
                          : width > 1150
                          ? 3
                          : 1;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                  onTap: () {
                                    CourseDetail(courseInfo: state.courseResponseModel!.content,).show(context);
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
                                ),
                                MyButton(
                                  onTap: () {
                                    AddWords().show(context);
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
                                        "Add new word",
                                        color: contentTheme.onPrimary,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: TextFormField(
                                    maxLines: 1,
                                    style: MyTextStyle.bodyMedium(),
                                    decoration: InputDecoration(
                                        hintText: "search",
                                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: focusedInputBorder,
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
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          myScreenMediaType.isMobile?
                          buildCourseList(state: state):
                          Expanded(child: buildCourseList(state: state)),
                          SizedBox(height: 8,),
                          FlutterCustomPagination(
                            key: GlobalKey(debugLabel: (state.courseResponseModel?.total??0).toString()),
                            currentPage: state.courseResponseModel!.getCurrentPage(),
                            limitPerPage: state.courseResponseModel!.getTotalPage(),
                            totalDataCount: state.courseResponseModel!.getTotalPage(),
                            onPreviousPage: (p0) {
                              // BlocProvider.of<PaymentHistoryBloc>(context).add(PaymentHistorySelectPageEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(page: p0)));
                            },
                            onBackToFirstPage: (p0) {
                              // BlocProvider.of<PaymentHistoryBloc>(context).add(PaymentHistorySelectPageEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(page: p0)));
                            },
                            onNextPage: (p0) {
                              // BlocProvider.of<PaymentHistoryBloc>(context).add(PaymentHistorySelectPageEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(page: p0)));
                            },
                            onGoToLastPage: (p0) {
                              // BlocProvider.of<PaymentHistoryBloc>(context).add(PaymentHistorySelectPageEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(page: p0)));
                            },
                            backgroundColor: ColorConst.whiteColor,
                            textStyle: TextStyleConstant.textStyleBlack14w700.copyWith(color: ColorConst.mainColor),
                            previousPageIcon: Icons.keyboard_arrow_left,
                            backToFirstPageIcon: Icons.first_page,
                            nextPageIcon: Icons.keyboard_arrow_right,
                            goToLastPageIcon: Icons.last_page,
                          ),
                        ],
                      );
                    },
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
    return  (listOfCourse.isEmpty) ? 
    Center(child: CircularProgressIndicator()) : 
    SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            children: listOfCourse,
          ),
        ],
      ),
    );
  }
}

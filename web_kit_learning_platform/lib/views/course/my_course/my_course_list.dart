import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/views/course/course_list/course_detail.dart';
import '../../../helpers/theme/app_style.dart';
import '../../../helpers/widgets/course_item_grid_view.dart';
import '../../../helpers/widgets/my_button.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../../services/apis/course/course_list/models/course_models.dart';
import '../../layouts/layout.dart';
import 'bloc/my_course_list_bloc.dart';

class MyCourseList extends StatefulWidget {
  const MyCourseList({super.key});

  @override
  State<MyCourseList> createState() => _MyCourseListState();
}

class _MyCourseListState extends State<MyCourseList>
    with SingleTickerProviderStateMixin, UIMixin {
  late MemberListController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(MemberListController());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MyCourseListBloc(MyCourseListState())..add(MyCourseListInitEvent());
      },
      child: BlocConsumer<MyCourseListBloc, MyCourseListState>(
        listener: (context, state) {
          switch (state.blocStatus) {
            case MyCourseListStatus.initial:
              break;
            default:
              break;
          }
        },
        builder: (BuildContext context, state) {
          return Layout(
              isScroll: false,
              padding: EdgeInsets.only(top: 35 + 16,bottom:  16),
              child: MyResponsive(builder: (buildContext , boxConstraints , myScreenMediaType ) { 
                return  GetBuilder(
                  init: controller,
                  builder: (controller) {
                    if (state.myCourseResponseModel == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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
                          myScreenMediaType.isMobile?buildCourseList(state: state):Expanded(child: buildCourseList(state: state)),
                          SizedBox(height: 8,),
                          Center(
                            child: FlutterCustomPagination(
                              key: GlobalKey(debugLabel: (state.myCourseResponseModel?.total??0).toString()),
                              currentPage: state.myCourseResponseModel!.getCurrentPage(),
                              limitPerPage: state.myCourseResponseModel!.getTotalPage(),
                              totalDataCount: state.myCourseResponseModel!.getTotalPage(),
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
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              ));
        },
      ),
    );
  }
  Widget buildCourseList({required MyCourseListState state}){
    List<Widget> listOfCourse = List.empty(growable: true);
    for (CourseInfo courseInfo in state.myCourseResponseModel
        ?.content ?? []) {
      listOfCourse.add(CourseItemGridView(
          courseInfo: courseInfo));
    }
    return (listOfCourse.isNotEmpty) ? Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      runAlignment: WrapAlignment.start,
      children: listOfCourse,
    ) : Center(child: CircularProgressIndicator());
  }
}

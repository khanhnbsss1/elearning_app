import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/widgets/course_item.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
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
          return Layout(
              isScroll: false,
              padding: EdgeInsets.only(top: 35 + 16, bottom: 16),
              child: GetBuilder(
                init: controller,
                builder: (controller) {
                  double width = MediaQuery.of(context).size.width;
                  double height = MediaQuery.of(context).size.height;
                  double gridViewItemRowCount = width > 1400 ? 4 : width > 1150 ? 3 : 1;
                  double gridViewItemColumnCount = 2;
                  List<Widget> listOfCourse = List.empty(growable: true);
                  // (kIsWeb ? width / 4 : width) > Dimens.size300
                  //     ? (kIsWeb ? width / 4 : width)
                  //     : Dimens.size300;

                  for (CourseInfo courseInfo
                      in state.courseResponseModel?.data ?? []) {
                    listOfCourse.add(CourseItemGridView(
                      courseInfo: courseInfo,));
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                            ),
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                maxLines: 1,
                                style: MyTextStyle.bodyMedium(),
                                decoration: InputDecoration(
                                    hintText: "search",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
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
                      (listOfCourse.isNotEmpty) ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: width < 550 ? 1 : width < 850 ? 2 : width < 1150 ? 3 : 4, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 5/6),
                            itemBuilder: (_, index) => listOfCourse[index],
                            itemCount: state.courseResponseModel?.data?.length,
                            // shrinkWrap: true,
                          ),
                        ),
                      ) : SizedBox()
                      // Expanded(
                      //   child: Padding(
                      //     padding: EdgeInsets.all(16),
                      //     child: SingleChildScrollView(
                      //       scrollDirection: Axis.vertical,
                      //       child: Column(
                      //         children: [
                      //           for (int i = 0; i < gridViewItemColumnCount; i += 1)
                      //             Row(
                      //               children: [
                      //                 for (int j = 0; j < gridViewItemRowCount; j++)
                      //                   if (i * 4 + j < state.courseResponseModel!.data!.length)
                      //                     listOfCourse[i*4+j]
                      //                 else SizedBox(),
                      //               ],
                      //             ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  );
                },
              ));
        },
      ),
    );
  }
}

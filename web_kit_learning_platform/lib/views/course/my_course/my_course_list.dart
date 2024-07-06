import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/views/course/course_list/add_course.dart';
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
              child: GetBuilder(
                init: controller,
                builder: (controller) {
                  double width = MediaQuery.of(context).size.width;
                  double height = MediaQuery.of(context).size.height;
                  List<Widget> listOfCourse = List.empty(growable: true);

                  for (CourseInfo courseInfo in state.myCourseResponseModel?.data ?? []) {
                    listOfCourse.add(CourseItemGridView(
                      courseInfo: courseInfo));
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // MyButton(
                            //   onTap: () {
                            //     showDialog(
                            //       context: context,
                            //       builder: (context) => AddCourseForm(),
                            //     );
                            //   },
                            //   elevation: 0,
                            //   padding: MySpacing.xy(12, 16),
                            //   backgroundColor: contentTheme.primary,
                            //   borderRadiusAll: AppStyle.buttonRadius.medium,
                            //   child: Row(
                            //     children: [
                            //       Icon(
                            //         LucideIcons.plusCircle,
                            //         color: contentTheme.light,
                            //         size: 16,
                            //       ),
                            //       MySpacing.width(16),
                            //       MyText.bodySmall(
                            //         "Add New",
                            //         color: contentTheme.onPrimary,
                            //       ),
                            //     ],
                            //   ),
                            // ),
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: width < 750 ? 1 : width < 1000 ? 2 : width < 1500 ? 3 : 4, crossAxisSpacing: 20, mainAxisSpacing: 20, childAspectRatio: 1 - 0.1),
                            itemBuilder: (_, index) => listOfCourse[index],
                            itemCount: state.myCourseResponseModel?.data?.length,
                            shrinkWrap: true,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ));
        },
      ),
    );
  }
}

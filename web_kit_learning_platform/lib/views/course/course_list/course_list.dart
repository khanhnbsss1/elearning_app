import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/widgets/course_item.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/services/apis/course/models/course_models.dart';
import 'package:webkit/views/course/course_list/bloc/course_list_bloc.dart';
import '../../../base/constant/dimens_constant.dart';
import '../../../helpers/theme/app_style.dart';
import '../../../helpers/widgets/course_item_grid_view.dart';
import '../../../helpers/widgets/my_button.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../../landing_page/mediaquery/mq.dart';
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
              padding: EdgeInsets.only(top: 35 + 16,bottom:  16),
              child: GetBuilder(
            init: controller,
            builder: (controller) {
              double width = MediaQuery.of(context).size.width;
              double height = MediaQuery.of(context).size.height;
              List<Widget> listOfCourse = List.empty(growable: true);
              double heightItem = height / 1.2;
              double widthItem = width / 1.2;
              // (kIsWeb ? width / 4 : width) > Dimens.size300
              //     ? (kIsWeb ? width / 4 : width)
              //     : Dimens.size300;

              BoxConstraints constraints = BoxConstraints(
                maxWidth: widthItem,
                maxHeight: heightItem,
              );

              for (CourseInfo courseInfo in state.courseResponseModel?.data ?? []) {
                listOfCourse.add(CourseItemGridView(
                    constraints: constraints,
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
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.titleMedium(
                                    "Add item",
                                  ),
                                ],
                              ),
                              titlePadding: MySpacing.xy(16, 12),
                              insetPadding: MySpacing.y(210),
                              actionsPadding: MySpacing.xy(190, 16),
                              contentPadding: MySpacing.x(16),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.bodyMedium("Name :"),
                                  MySpacing.height(8),
                                  TextFormField(
                                    validator: controller.basicValidator
                                        .getValidation('name'),
                                    controller: controller.basicValidator
                                        .getController('name'),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: "Name",
                                      labelStyle:
                                      MyTextStyle.bodySmall(xMuted: true),
                                      border: outlineInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                    ),
                                  ),
                                  MySpacing.height(16),
                                  MyText.bodyMedium("Address :"),
                                  MySpacing.height(8),
                                  TextFormField(
                                    validator: controller.basicValidator
                                        .getValidation('address'),
                                    controller: controller.basicValidator
                                        .getController('address'),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: "Address",
                                      labelStyle:
                                      MyTextStyle.bodySmall(xMuted: true),
                                      border: outlineInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                MyButton(
                                  // onPressed: controller.onSubmit,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },

                                  elevation: 0,
                                  backgroundColor: contentTheme.primary,
                                  borderRadiusAll: AppStyle.buttonRadius.medium,
                                  child: MyText.bodyMedium(
                                    "Ok",
                                    color: contentTheme.onPrimary,
                                  ),
                                ),
                                MyButton(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  elevation: 0,
                                  backgroundColor: contentTheme.primary,
                                  borderRadiusAll: AppStyle.buttonRadius.medium,
                                  child: MyText.bodyMedium(
                                    "Cancel",
                                    color: contentTheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: width < 750 ? 1 : width < 1200 ? 2 : width < 1500 ? 3 : 4),
                        itemBuilder: (_, index) => listOfCourse[index],
                        itemCount: state.courseResponseModel?.data?.length,
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

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/controller/ui/add_course_controller.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/services/apis/test/get_test_list_api.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import 'package:webkit/views/course/create_edit_course/bloc/add_course_bloc.dart';

class CourseLinkTestListPage extends StatefulWidget {
  CourseLinkTestListPage({super.key});
  void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => this,
    );
  }

  @override
  State<CourseLinkTestListPage> createState() => _CourseIntroductionPageState();
}

class _CourseIntroductionPageState extends State<CourseLinkTestListPage> with SingleTickerProviderStateMixin, UIMixin {
  ScrollController scrollController=ScrollController();
  final TextEditingController _subjectDropdownSearchFieldController = TextEditingController();
  final TextEditingController _lessonDropdownSearchFieldController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCourseBloc, AddCourseState>(
      listener: (context, state) {
        switch (state.blocStatus) {
          case AddCourseStatus.initial:
            break;
          default:
            break;
        }
      },
      builder: (BuildContext context, state) {
        return Material(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return buildTestList(constraints: constraints, state: state, context: context);
            },
          ),
        );
      },
    );
  }

  Widget buildTestList({required BoxConstraints constraints, required AddCourseState state, required BuildContext context}) {
    return GetBuilder<AddCourseController>(
      init: state.controller,
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            // color: Color.fromRGBO(255, 233, 233, 1.0),
            border: Border.all(
              color: ColorConst.colorHintTextSearch,
            ),
              borderRadius: BorderRadius.circular(Dimens.size20)

          ),
          padding: EdgeInsets.all(Dimens.size16),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      firstTestDropDownSearch(context: context, state: state, title: L10nX.getStr.search_lesson_str, onSelectTest: (p0) {
                      },),
                    ],
                  ),
                  Gap(Dimens.size16),
                  Row(
                    children: [
                      firstTestDropDownSearch(context: context, state: state, title: L10nX.getStr.search_lesson_str, onSelectTest: (p0) {
                      },),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
  
  Widget firstTestDropDownSearch(
      {
        Function(TestInfo)? onSelectTest, 
        required AddCourseState state, 
        required BuildContext context,
        required String title
      }) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: Dimens.size300,
            child: StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
                return DropDownSearchFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
                    controller: _lessonDropdownSearchFieldController,
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontStyle: FontStyle.italic
                    ),

                    decoration: InputDecoration(
                      labelText: title, 
                      hintTextDirection: AppTheme.textDirection,
                      labelStyle: TextStyleConstant.textStyleBlack14w400,
                      hintStyle: TextStyleConstant.textStyleBlack14w400,
                      border: outlineInputBorder,
                      prefixIcon: Icon(
                        Icons.edit_document,
                        size: 20,
                        color: ColorConst.colorIconRed,
                      ),
                      suffixIcon: Icon(
                        LucideIcons.search,
                        size: 20,
                        color: ColorConst.colorIconRed,
                      ),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),

                  suggestionsCallback: (pattern) async {
                    return await getTestFilterList(pattern);
                  },

                  itemBuilder: (context, suggestion) {
                    return OnHoverWidget(
                      builder: (bool isHovered) {
                        return  Container(
                          decoration: BoxDecoration(
                              color: isHovered?ColorConst.mainColor.withOpacity(0.05):ColorConst.whiteColor,
                              border: Border(
                                  bottom: BorderSide(color: ColorConst.dividerColor)
                              )
                          ),
                          child: ListTile(
                            leading: Icon(Icons.edit_document),
                            title: Text(suggestion.lectureName??""),
                          ),
                        );
                      },
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    if((BlocProvider.of<AddCourseBloc>(context).state.currentSubject??'').isEmpty)
                    {
                      ToastUtils.showToastError(L10nX.getStr.please_choose_a_subject);
                      return;
                    }
                    if(onSelectTest!=null)
                    {
                      _lessonDropdownSearchFieldController.text = suggestion.lectureName??"";
                      onSelectTest(suggestion);
                    }
                    else
                    {
                      ToastUtils.showToastError(L10nX.getStr.unknown_str);
                    }
                    print("object");
                  },
                  transitionBuilder: (context, child, controller) {
                    return Container(
                      constraints: BoxConstraints(
                          maxHeight: Dimens.size300
                      ),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: ColorConst.whiteColor,
                          borderRadius: BorderRadius.circular(Dimens.size10)
                      ),
                      padding: EdgeInsets.all(Dimens.size8),
                      child: child,
                    );
                  },
                  displayAllSuggestionWhenTap: false,
                  hideSuggestionsOnKeyboardHide: true,
                );
              },
            ),
          ),
          Gap(Dimens.size16),
/*          InkWell(
            onTap: () {
              CreateEditLesson().show(context);
            },
            child: Icon(Icons.add_circle, color: ColorConst.mainColor,size: Dimens.size50,),
          )*/
        ]
    );
  }
  Future<List<TestInfo>>getTestFilterList(String keyWord) async{
    if(keyWord.isEmpty) {
      return [];
    }
    GetTestListApi getLessonListApi= GetTestListApi(searchCommonRequest: SearchCommonRequest(keyword: keyWord));
    TestListResponseModel data = await getLessonListApi.call();
    return data.content??[];
  }

}

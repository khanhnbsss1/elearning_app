import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/ui/add_course_controller.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
import 'package:webkit/views/course/create_edit_course/bloc/add_course_bloc.dart';

class CourseLinkLessonListPage extends StatefulWidget {
  CourseLinkLessonListPage({super.key});
  void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => this,
    );
  }

  @override
  State<CourseLinkLessonListPage> createState() => _CourseIntroductionPageState();
}

class _CourseIntroductionPageState extends State<CourseLinkLessonListPage> with SingleTickerProviderStateMixin, UIMixin {
  late List<CourseInfo> coursesInfo;
  var position = 0;

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
              return buildLessonList(constraints: constraints, state: state, context: context);
            },
          ),
        );
      },
    );
  }

  Widget buildLessonList({required BoxConstraints constraints, required AddCourseState state, required BuildContext context}) {
    return GetBuilder<AddCourseController>(
      init: state.controller,
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            // color: Color.fromRGBO(255, 233, 233, 1.0),
            border: Border.all(
              color: ColorConst.colorHintTextSearch,
            ),
          ),
          padding: EdgeInsets.all(Dimens.size16),
          child: Column(
            children: [
              buildSearchBar(state: state, context: context),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(Dimens.size16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildLessonTableList(state: state, context: context)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget buildSearchBar({ required AddCourseState state, required BuildContext context}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        subjectDropDownSearch(onSelectSubject: (p0) {
          
        },),
        lessonDropDownSearch(onSelectLesson: (p0) {
          
        },)
      ],
    );
  }
  Widget buildLessonTableList({required AddCourseState state, required BuildContext context}){
    return SizedBox();
  }

  Widget subjectDropDownSearch({Function(String)? onSelectSubject}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: Dimens.size300,
          child: DropdownSearch<String>(
          popupProps: PopupProps.menu(
            constraints: BoxConstraints(
              maxHeight:  Dimens.size210
            ),
            showSearchBox: true,
            searchDelay: Duration(seconds: 0),
            showSelectedItems: true,
          ),
          asyncItems: (text) {
            return getSubjectList(text);
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              hintText: L10nX.getStr.search_subject_str,
              labelText: L10nX.getStr.search_subject_str,
              hintTextDirection: AppTheme.textDirection,
              labelStyle: TextStyleConstant.textStyleBlack14w400,
              hintStyle: TextStyleConstant.textStyleBlack14w400,
              border: outlineInputBorder,
              prefixIcon: Icon(
                LucideIcons.book,
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
          onChanged: (value) {
            if(onSelectSubject!=null)
              {
                onSelectSubject(value??"");
              }
          },
          onSaved: (newValue) {
            
          },
                ),
        ),
        Gap(Dimens.size16),
        InkWell(
          onTap: () {
          },
          child: Icon(Icons.add_circle, color: ColorConst.mainColor,size: Dimens.size50,),
        )
      ]
    );
  }
  Widget lessonDropDownSearch({Function(String)? onSelectLesson}) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: Dimens.size300,
            child: DropdownSearch<String>(
              popupProps: PopupProps.menu(
                constraints: BoxConstraints(
                    maxHeight:  Dimens.size210
                ),
                showSearchBox: true,
                searchDelay: Duration(seconds: 0),
                showSelectedItems: true,
              ),
              asyncItems: (text) {
                return getSubjectList(text);
              },
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: L10nX.getStr.search_lesson_str,
                  labelText: L10nX.getStr.search_lesson_str,
                  hintTextDirection: AppTheme.textDirection,
                  labelStyle: TextStyleConstant.textStyleBlack14w400,
                  hintStyle: TextStyleConstant.textStyleBlack14w400,
                  border: outlineInputBorder,
                  prefixIcon: Icon(
                    LucideIcons.book,
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
              onChanged: (value) {
                if(onSelectLesson!=null)
                {
                  onSelectLesson(value??"");
                }
              },
              onSaved: (newValue) {

              },
            ),
          ),
          Gap(Dimens.size16),
          InkWell(
            onTap: () {

            },
            child: Icon(Icons.add_circle, color: ColorConst.mainColor,size: Dimens.size50,),
          )
        ]
    );
  }
  Future<List<String>>getSubjectList(String keyWord) async{
    List<String> listSubject=[];
    return listSubject;
  }
  Future<List<String>>getLessonList(String keyWord) async{
    List<String> listLesson=[];
    return listLesson;
  }
}
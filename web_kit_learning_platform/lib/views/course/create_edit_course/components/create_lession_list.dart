import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/controller/ui/add_course_controller.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/lessson/lesson_list_filter/lesson_list_filter_api.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/views/course/create_edit_course/bloc/add_course_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:webkit/views/lessson/lesson_detail/create_edit_lesson.dart';

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
            borderRadius: BorderRadius.circular(Dimens.size20)
          ),
          padding: EdgeInsets.all(Dimens.size16),
          child: Column(
            children: [
              buildSearchBar(state: state, context: context),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical:  Dimens.size16),
                  child: buildLessonTableList(state: state, context: context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget buildSearchBar({ required AddCourseState state, required BuildContext context}){
    return Wrap(
      runAlignment: WrapAlignment.spaceBetween,
      alignment: WrapAlignment.spaceBetween,
      children: [
        subjectDropDownSearch(
          state: state,
          context: context,
          onSelectSubject: (p0) {
            BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateCurrentSubjectEvent(subject: p0));
        },),
        Gap(Dimens.size50),
        lessonDropDownSearch(
          state: state,
          context: context,
          onSelectLesson: (p0) {
            BlocProvider.of<AddCourseBloc>(context).add(AddCourseLinkLessonEvent(
                subject: state.currentSubject??"Test", 
                courseId: state.courseInfo!.id!, 
                lessonId: p0.id!));
        },)
      ],
    );
  }
  Widget buildLessonTableList({required AddCourseState state, required BuildContext context}){
    LessonDataSource employeeDataSource = LessonDataSource(
        lessonData: state.courseInfo?.lectures??[],
      onDelete: (p0) {
        BlocProvider.of<AddCourseBloc>(context).add(AddCourseUnLinkLessonEvent(
            courseId: state.courseInfo!.id!, 
            lessonId: p0.id!,
          subject: p0.subName??""
        ));
      },
      onEdit: (p0) {
        
      },
      onViewDetail: (p0) {
        
      },
    );
    return SfDataGridTheme(
      data: SfDataGridThemeData(
          headerColor: ColorConst.mainColor.withOpacity(0.1), 
      ),
      child: SfDataGrid(
        source: employeeDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        isScrollbarAlwaysShown: false,
        gridLinesVisibility: GridLinesVisibility.both,
        rowHeight: Dimens.size80,
        showHorizontalScrollbar: true,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'id',
              maximumWidth: Dimens.size80,
              label: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'ID',
                  ))),
          GridColumn(
              columnName: L10nX.getStr.lecture_name_str,
              minimumWidth: Dimens.size150,
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(L10nX.getStr.lecture_name_str))),
          GridColumn(
              columnName: L10nX.getStr.subject_name_str,
              minimumWidth: Dimens.size150,
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    L10nX.getStr.subject_name_str,
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: L10nX.getStr.lecture_link_str,
              minimumWidth: Dimens.size300,
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(L10nX.getStr.lecture_link_str))),
          GridColumn(
              columnName: L10nX.getStr.document_str,
              minimumWidth: Dimens.size200,
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(L10nX.getStr.document_str))),
          GridColumn(
              columnName: L10nX.getStr.word_str,
              minimumWidth: Dimens.size250,
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(L10nX.getStr.word_str))),
          GridColumn(
              columnName: L10nX.getStr.payment_str,
              minimumWidth: Dimens.size80,
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(L10nX.getStr.payment_str))),
          GridColumn(
              columnName: L10nX.getStr.action_str,
              minimumWidth: Dimens.size120,
              label: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(L10nX.getStr.action_str))),
      
        ],
      ),
    );
  }

  Widget subjectDropDownSearch({Function(String)? onSelectSubject, required AddCourseState state,required BuildContext context}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return SizedBox(
              width:Dimens.size300,
              child: DropDownSearchField(
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                   controller: _subjectDropdownSearchFieldController,
                  style: DefaultTextStyle.of(context).style.copyWith(
                      fontStyle: FontStyle.italic
                  ),
                  decoration: InputDecoration(
                    //hintText: L10nX.getStr.search_lesson_str,
                    labelText: L10nX.getStr.search_subject_str,
                    hintTextDirection: AppTheme.textDirection,
                    labelStyle: TextStyleConstant.textStyleBlack14w400,
                    hintStyle: TextStyleConstant.textStyleBlack14w400,
                    border: outlineInputBorder,
                    prefixIcon: Icon(
                      Icons.topic,
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
                  return await getSubjectList(keyWord: pattern, state: state);
                },
                keepSuggestionsOnSuggestionSelected: true,
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
                          leading: Icon(Icons.topic),
                          title: Text(suggestion??""),
                        ),
                      );
                    },
                  );
                },
                onSuggestionSelected: (suggestion) {
                  if(onSelectSubject!=null)
                    {
                      _subjectDropdownSearchFieldController.text = suggestion;
                      onSelectSubject(suggestion);
                    }
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
                    child: FadeTransition(
                      opacity: CurvedAnimation(
                          parent: controller!,
                          curve: Curves.fastOutSlowIn
                      ),
                      child: child,
                    ),
                  );
                },
                displayAllSuggestionWhenTap: false,
              ),
            );
            },
        ),
        Gap(Dimens.size16),
        InkWell(
          onTap: () {
            _addSubjectDialog(context);
          },
          child: Icon(Icons.add_circle, color: ColorConst.mainColor,size: Dimens.size50,),
        )
      ]
    );
  }
  Widget lessonDropDownSearch({Function(LessonInfo)? onSelectLesson, required AddCourseState state, required BuildContext context}) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width:Dimens.size300,
            child: DropDownSearchFormField(
              textFieldConfiguration: TextFieldConfiguration(
                autofocus: true,
                controller: _lessonDropdownSearchFieldController,
                style: DefaultTextStyle.of(context).style.copyWith(
                    fontStyle: FontStyle.italic
                ),
                          
                decoration: InputDecoration(
                  labelText: L10nX.getStr.search_lesson_str,
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
                return await getLessonFilterList(pattern);
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
                if(onSelectLesson!=null)
                {
                  _lessonDropdownSearchFieldController.text = suggestion.lectureName??"";
                  onSelectLesson(suggestion);
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
            ),
          ),
          Gap(Dimens.size16),
          InkWell(
            onTap: () {
              CreateEditLesson().show(context);
            },
            child: Icon(Icons.add_circle, color: ColorConst.mainColor,size: Dimens.size50,),
          )
        ]
    );
  }
  Future<List<String>>getSubjectList({required String keyWord, required AddCourseState state,}) async{
    List<String> listSubject=[];
    for(String lessonInfo in state.subjectList??[])
      {
        if(!listSubject.contains(lessonInfo) && (lessonInfo??"").isNotEmpty && (lessonInfo??"").toLowerCase().contains(keyWord.toLowerCase()))
          {
            listSubject.add(lessonInfo??"");
          }
      }
    return listSubject;
  }
  Future<List<LessonInfo>>getLessonFilterList(String keyWord) async{
    if(keyWord.isEmpty) {
      return [];
    }
    GetLessonListFilterApi getLessonListApi= GetLessonListFilterApi(searchCommonRequest: SearchCommonRequest(keyword: keyWord));
    LessonListResponseModel data = await getLessonListApi.call();
    return data.content??[];
  }
  void _addSubjectDialog(BuildContext context) {
    final tagController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(L10nX.getStr.create_subject_str),
        content: TextFormField(
          controller: tagController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              labelText: L10nX.getStr.create_subject_str,
              labelStyle: MyTextStyle.bodySmall(xMuted: true),
              border: outlineInputBorder,
              contentPadding: EdgeInsets.all(16),
              isCollapsed: true,
              floatingLabelBehavior:
              FloatingLabelBehavior.never),
        ),
        actions: [
          Row(
            children: [
              ActionButton1(
                text: L10nX.getStr.create_subject_str,
                onTap: () {
                  List<String> list = BlocProvider.of<AddCourseBloc>(context).state.subjectList??[];
                  if(list.contains(tagController.text))
                  {
                    ToastUtils.showToastError(L10nX.getStr.subject_is_exit_str);
                  }
                  else
                  {
                    ToastUtils.showToastError(L10nX.getStr.success);
                    list.add(tagController.text);
                    BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateSubjectListEvent(subjectList: list));
                    Navigator.of(context).pop();
                  }
                },
              ),
              Gap(Dimens.size50),
              ActionButton1(
                text: L10nX.getStr.close,
                enableBgColor: ColorConst.whiteColor,
                textStype: TextStyleConstant.textStyleBlack14w400,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),

        ],
      ),
    );
  }

}
class LessonDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  Function(LessonInfo) onViewDetail, onEdit, onDelete; 
  LessonDataSource({required List<LessonInfo> lessonData, required this.onDelete, required this.onEdit, required this.onViewDetail}) {
    _lessonData = lessonData.map<DataGridRow>((e) {
      List<Widget> wordList = [];
      for(int index =0; index <10; index++){
        wordList.add(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConst.whiteColor,
                  borderRadius: BorderRadius.circular(Dimens.size20),
                  border: Border.all(color: ColorConst.blackColor, width: 1)
                ), 
                  padding: EdgeInsets.symmetric(vertical: Dimens.size8, horizontal: Dimens.size16),
                  child: Text("data", style: TextStyleConstant.textStyleBlack14w400,)),
            ));
      }
      
      return  DataGridRow(
          cells: [
            DataGridCell<Widget>(columnName: 'id', value: Text(e.id.toString(), style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.lecture_name_str, value:Text(e.lectureName??"", style: TextStyleConstant.textStyleBlack14w400,) ),
            DataGridCell<Widget>(columnName: L10nX.getStr.subject_name_str, value: Text(e.subName??"", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.lecture_link_str, value: Text(e.link??"", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.document_str, value: Text("abcsssij", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.word_str, value: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: wordList,
              ),
            )),
            DataGridCell<Widget>(columnName: L10nX.getStr.payment_str, value: Text(e.mode??"", style: TextStyleConstant.textStyleBlack14w400,)),
            DataGridCell<Widget>(columnName: L10nX.getStr.payment_str, value: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    onViewDetail(e);
                  },
                  child: Icon(Icons.remove_red_eye, size: Dimens.size20,color: ColorConst.colorIconGrays,),
                ),
                Gap(Dimens.size10),
                InkWell(
                  onTap: () {
                    onEdit(e);
                  },
                  child: Icon(Icons.note_alt_outlined, size: Dimens.size20,color: ColorConst.colorIconGrays,),
                ),
                Gap(Dimens.size10),
                InkWell(
                  onTap: () {
                    onDelete(e);
                    },
                  child: Icon(Icons.delete_forever, size: Dimens.size20,color: Colors.red,),
                ),
                Gap(Dimens.size10),
              ],
            )),

          ]);
    },).toList();
  }

  List<DataGridRow> _lessonData = [];

  @override
  List<DataGridRow> get rows => _lessonData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: e.value,
          );
        }).toList());
  }
}

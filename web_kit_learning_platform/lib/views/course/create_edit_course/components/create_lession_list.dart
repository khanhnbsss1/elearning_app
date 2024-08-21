import 'package:async_searchable_dropdown/async_searchable_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/models/search_common_request.dart';
import 'package:webkit/controller/ui/add_course_controller.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/plugins/dropdown_flutter-1.0.1/lib/custom_dropdown.dart';
import 'package:webkit/services/apis/lessson/lesson_list_filter/lesson_list_filter_api.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/views/course/create_edit_course/bloc/add_course_bloc.dart';
import 'package:webkit/views/lessson/lesson_detail/create_edit_lesson.dart';
import 'package:webkit/widgets/item_edit_view_delete/item_edit_view_delete.dart';

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
  ScrollController scrollController = ScrollController();
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
              borderRadius: BorderRadius.circular(Dimens.size20)),
          padding: EdgeInsets.all(Dimens.size16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSearchBar(state: state, context: context),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimens.size16),
                  child: buildLessonTableList(state: state, context: context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSearchBar({required AddCourseState state, required BuildContext context}) {
    return Wrap(
      runAlignment: WrapAlignment.start,
      alignment: WrapAlignment.start,
      children: [
        subjectDropDownSearch(
          state: state,
          context: context,
          onSelectSubject: (p0) {
            BlocProvider.of<AddCourseBloc>(context).add(AddCourseUpdateCurrentSubjectEvent(subject: p0));
          },
        ),
        Gap(Dimens.size50),
        lessonDropDownSearch(
          state: state,
          context: context,
          onSelectLesson: (p0) {
            BlocProvider.of<AddCourseBloc>(context).add(AddCourseLinkLessonEvent(subject: state.currentSubject ?? "Test", courseId: state.courseInfo!.id!, lessonId: p0.id!));
          },
        )
      ],
    );
  }

  Widget buildLessonTableList({required AddCourseState state, required BuildContext context}) {
    LessonDataSource employeeDataSource = LessonDataSource(
      lessonData: state.courseInfo?.lectures ?? [],
      onDelete: (p0) {
        BlocProvider.of<AddCourseBloc>(context).add(AddCourseUnLinkLessonEvent(courseId: state.courseInfo!.id!, lessonId: p0.id!, subject: p0.subName ?? ""));
      },
      onEdit: (p0) {
        CreateEditLesson(
          lessonInfo: p0,
          lessonActionType: LessonActionType.edit,
        ).show(context);
      },
      onViewDetail: (p0) {
        CreateEditLesson(
          lessonInfo: p0,
          lessonActionType: LessonActionType.view,
        ).show(context);
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
        headerGridLinesVisibility: GridLinesVisibility.both,
        headerRowHeight: Dimens.size50,
        rowHeight: Dimens.size80,
        showHorizontalScrollbar: true,
        allowColumnsDragging: true,
        allowColumnsResizing: true,
        shrinkWrapRows: true,
        onQueryRowHeight: (details) {
          return details.rowHeight;
        },
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
              minimumWidth: Dimens.size250,
              label: Container(padding: EdgeInsets.all(8.0), alignment: Alignment.center, child: Text(L10nX.getStr.lecture_name_str))),
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
              label: Container(padding: EdgeInsets.all(8.0), alignment: Alignment.center, child: Text(L10nX.getStr.lecture_link_str))),
          GridColumn(
              columnName: L10nX.getStr.document_str, minimumWidth: Dimens.size200, label: Container(padding: EdgeInsets.all(8.0), alignment: Alignment.center, child: Text(L10nX.getStr.document_str))),
          GridColumn(
              columnName: L10nX.getStr.word_str,
              minimumWidth: Dimens.size300,
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              label: Container(padding: EdgeInsets.all(8.0), alignment: Alignment.center, child: Text(L10nX.getStr.word_str))),
          GridColumn(
              columnName: L10nX.getStr.payment_str, maximumWidth: Dimens.size120, label: Container(padding: EdgeInsets.all(8.0), alignment: Alignment.center, child: Text(L10nX.getStr.payment_str))),
          GridColumn(
              columnName: L10nX.getStr.action_str, maximumWidth: Dimens.size180, label: Container(padding: EdgeInsets.all(8.0), alignment: Alignment.center, child: Text(L10nX.getStr.action_str))),
        ],
      ),
    );
  }

  Widget subjectDropDownSearch({Function(String)? onSelectSubject, required AddCourseState state, required BuildContext context}) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return SizedBox(
            width: Dimens.size300,
            child: SearchableDropdown<String>(
              isEnabled: true,
              inputDecoration: InputDecoration(
                constraints: BoxConstraints(maxHeight: Dimens.size45),
                hintTextDirection: AppTheme.textDirection,
                labelStyle: TextStyleConstant.textStyleBlack14w400,
                hintStyle: TextStyleConstant.textStyleBlack14w400,
                border: outlineInputBorder,
                labelText: L10nX.getStr.search_subject_str,
                prefixIcon: Icon(
                  Icons.subject,
                  color: ColorConst.colorIconRed,
                ),
              ),
              remoteItems: (search) async {
                return await getSubjectList(keyWord: search ?? "", state: state);
              },
              itemLabelFormatter: (value) {
                return value ?? "";
              },
              onChanged: (String? value) {
                if (onSelectSubject != null) {
                  _subjectDropdownSearchFieldController.text = value ?? "";
                  onSelectSubject(value ?? "");
                }
              },
              value: _subjectDropdownSearchFieldController.text,
            ),
          );
        },
      ),
      Gap(Dimens.size16),
      InkWell(
        onTap: () {
          _addSubjectDialog(context);
        },
        child: Icon(
          Icons.add_circle,
          color: ColorConst.mainColor,
          size: Dimens.size50,
        ),
      )
    ]);
  }

  Widget lessonDropDownSearch({Function(LessonInfo)? onSelectLesson, required AddCourseState state, required BuildContext context}) {
    
    return StatefulBuilder(
      builder: (BuildContext blocContext, void Function(void Function()) setState) {
        return Row(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            width: Dimens.size300,
            child: SearchableDropdown<LessonInfo>(
              inputDecoration: InputDecoration(
                constraints: BoxConstraints(maxHeight: Dimens.size45),
                hintTextDirection: AppTheme.textDirection,
                labelStyle: TextStyleConstant.textStyleBlack14w400,
                hintStyle: TextStyleConstant.textStyleBlack14w400,
                border: outlineInputBorder,
                labelText: L10nX.getStr.search_lesson_str,
                prefixIcon: Icon(
                  Icons.play_lesson,
                  color: ColorConst.colorIconRed,
                ),
              ),
              remoteItems: (search) async {
                return await getLessonFilterList(search ?? "");
              },
              itemLabelFormatter: (value) {
                return value.lectureName ?? "";
              },
              onChanged: (LessonInfo? value) {
                if ((BlocProvider.of<AddCourseBloc>(blocContext).state.currentSubject ?? '').isEmpty) {
                  ToastUtils.showToastError(L10nX.getStr.please_choose_a_subject);
                  return;
                }
                if (onSelectLesson != null) {
                  //_lessonDropdownSearchFieldController.text = suggestion.lectureName??"";
                  onSelectLesson(value!);
                } else {
                  ToastUtils.showToastError(L10nX.getStr.unknown_str);
                }
                print("object");
              },
              value: null,
              dropDownListHeight: Dimens.size400,
              dropDownListWidth: Dimens.size300,
            ),
          ),
          Gap(Dimens.size16),
          InkWell(
            onTap: () {
              CreateEditLesson().show(blocContext);
            },
            child: Icon(
              Icons.add_circle,
              color: ColorConst.mainColor,
              size: Dimens.size50,
            ),
          )
        ]);
      },
    );
  }

  Future<List<String>> getSubjectList({
    required String keyWord,
    required AddCourseState state,
  }) async {
    List<String> listSubject = [];
    for (String lessonInfo in state.subjectList ?? []) {
      if (!listSubject.contains(lessonInfo) && (lessonInfo ?? "").isNotEmpty && (lessonInfo ?? "").toLowerCase().contains(keyWord.toLowerCase())) {
        listSubject.add(lessonInfo ?? "");
      }
    }
    return listSubject;
  }

  Future<List<LessonInfo>> getLessonFilterList(String keyWord) async {
    if (keyWord.isEmpty) {
      return [];
    }
    GetLessonListFilterApi getLessonListApi = GetLessonListFilterApi(searchCommonRequest: SearchCommonRequest(keyword: keyWord));
    LessonListResponseModel data = await getLessonListApi.call();
    return data.content ?? [];
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
              floatingLabelBehavior: FloatingLabelBehavior.never),
        ),
        actions: [
          Row(
            children: [
              ActionButton1(
                text: L10nX.getStr.create_subject_str,
                onTap: () {
                  List<String> list = BlocProvider.of<AddCourseBloc>(context).state.subjectList ?? [];
                  if (list.contains(tagController.text)) {
                    ToastUtils.showToastError(L10nX.getStr.subject_is_exit_str);
                  } else {
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
    _lessonData = lessonData.map<DataGridRow>(
      (e) {
        List<Widget> wordList = [];
        for (int index = 0; index < 10; index++) {
          wordList.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
                decoration: BoxDecoration(color: ColorConst.whiteColor, borderRadius: BorderRadius.circular(Dimens.size20), border: Border.all(color: ColorConst.blackColor, width: 1)),
                padding: EdgeInsets.symmetric(vertical: Dimens.size4, horizontal: Dimens.size16),
                child: Text(
                  "data",
                  style: TextStyleConstant.textStyleBlack14w400,
                )),
          ));
        }

        return DataGridRow(cells: [
          DataGridCell<Widget>(
              columnName: 'id',
              value: Text(
                e.id.toString(),
                style: TextStyleConstant.textStyleBlack14w400,
              )),
          DataGridCell<Widget>(
              columnName: L10nX.getStr.lecture_name_str,
              value: Text(
                e.lectureName ?? "",
                softWrap: true,
                textAlign: TextAlign.start,
                style: TextStyleConstant.textStyleBlack14w400,
              )),
          DataGridCell<Widget>(
              columnName: L10nX.getStr.subject_name_str,
              value: Text(
                e.subName ?? "",
                softWrap: true,
                style: TextStyleConstant.textStyleBlack14w400,
              )),
          DataGridCell<Widget>(
              columnName: L10nX.getStr.lecture_link_str,
              value: Text(
                e.link ?? "",
                softWrap: true,
                style: TextStyleConstant.textStyleBlack14w400,
              )),
          DataGridCell<Widget>(
              columnName: L10nX.getStr.document_str,
              value: Text(
                e.docName ?? "",
                softWrap: true,
                style: TextStyleConstant.textStyleBlack14w400,
              )),
          DataGridCell<Widget>(
              columnName: L10nX.getStr.word_str,
              value: Container(
                constraints: BoxConstraints(maxHeight: Dimens.size150, minHeight: Dimens.size100),
                child: SingleChildScrollView(
                  child: Wrap(
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: Dimens.size4,
                    runSpacing: Dimens.size4,
                    children: wordList,
                  ),
                ),
              )),
          DataGridCell<Widget>(
              columnName: L10nX.getStr.payment_str,
              value: Text(
                e.mode ?? "",
                softWrap: true,
                style: TextStyleConstant.textStyleBlack14w400,
              )),
          DataGridCell<Widget>(
            columnName: L10nX.getStr.action_str,
            value: ItemViewEditDelete(
              itemInfo: e,
              onViewDetail: (p0) {
                onViewDetail(e);
              },
              onDelete: (p0) {
                onDelete(e);
              },
              onEdit: (p0) {
                onEdit(e);
              },
            ),
          ),
        ]);
      },
    ).toList();
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
        padding: EdgeInsets.all(Dimens.size8),
        child: e.value,
      );
    }).toList());
  }
}

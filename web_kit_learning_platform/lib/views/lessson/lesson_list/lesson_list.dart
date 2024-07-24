import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/theme/theme_customizer.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/views/vocabulary/vocabulary_detail/add_words.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import 'bloc/lesson_list_bloc.dart';

class LessonList extends StatefulWidget {
  LessonList({super.key, this.courseType}){
    courseType??=VocabularyType.vocabularyList;
  }
  VocabularyType? courseType;
  @override
  State<LessonList> createState() => _LessonListState();
}

class _LessonListState extends State<LessonList> with SingleTickerProviderStateMixin, UIMixin {
  late MemberListController controller;
 TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState>? formKey = GlobalKey();
  ScrollController scrollController=ScrollController();
  @override
  void initState() {
    super.initState();
    controller = Get.put(MemberListController());
    ThemeCustomizer().toggleLeftBarCondensedByValue(leftBarCondensed: true);
  }

  int? page = 1;
  final int pageItemCount = 16;
  late int pageCount;
  bool isOnVolume=  false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LessonListBloc(LessonListState(vocabularyType: widget.courseType))..add(LessonListInitEvent());
      },
      child: BlocConsumer<LessonListBloc, LessonListState>(
        listener: (context, state) {
          switch (state.blocStatus) {
            case VocabularyStatus.initial:
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
                  child: buildLessonListPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType),);
            },);
          
        },
      ),
    );
  }
  Widget buildLessonListPage(
  {
    required MyScreenMediaType myScreenMediaType,
    required BoxConstraints boxConstraints,
    required BuildContext context,
    required LessonListState state
  }
      ){
    return Container(
      color: ColorConst.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildListFilter(context: context, state: state, myScreenMediaType: myScreenMediaType, boxConstraints: boxConstraints),
            myScreenMediaType.isMobile?
            buildLessonList(state: state, context: context):
            Expanded(child: buildLessonList(state: state, context: context)),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterCustomPagination(
                  key: GlobalKey(debugLabel: (state.vocabularyResponseModel?.total??0).toString()),
                  currentPage: state.vocabularyResponseModel!.getCurrentPage(),
                  limitPerPage: state.vocabularyResponseModel!.getTotalPage(),
                  totalDataCount: state.vocabularyResponseModel!.getTotalPage(),
                  onPreviousPage: (p0) {
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onBackToFirstPage: (p0) {
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onNextPage: (p0) {
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  onGoToLastPage: (p0) {
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                  },
                  backgroundColor: ColorConst.whiteColor,
                  textStyle: TextStyleConstant.textStyleBlack14w700.copyWith(color: ColorConst.mainColor),
                  previousPageIcon: Icons.keyboard_arrow_left,
                  backToFirstPageIcon: Icons.first_page,
                  nextPageIcon: Icons.keyboard_arrow_right,
                  goToLastPageIcon: Icons.last_page,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget buildListFilter(  {
    required MyScreenMediaType myScreenMediaType,
    required BoxConstraints boxConstraints,
    required BuildContext context,
    required LessonListState state
  }){
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: ColorConst.dividerColor)
          )
      ),
      padding: EdgeInsets.symmetric(vertical: Dimens.size8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible:  state.vocabularyType== VocabularyType.vocabularyList,
            child: Row(
              children: [
                Gap(Dimens.size10),
                InkWell(
                    onTap: () {
                      // CourseDetail(courseInfo: state.courseResponseModel!.content,).show(context);
                      AddWords().show(context);
                    },
                    child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: Dimens.size40,
                width: Dimens.size250,
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    maxLines: 1,
                    controller: textEditingController,
                    onChanged: (value) {
                      
                    },
                    onFieldSubmitted: (value) {
                      BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
                    },
                    onTapOutside: (event) {
                    },
                    style: MyTextStyle.bodyMedium(),
                    decoration: InputDecoration(
                        hintText: L10nX.getStr.search,
                        fillColor: ColorConst.whiteColor,
                        filled: true,
                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: outlineInputBorder.copyWith(borderRadius: BorderRadius.circular(16)),
                        enabledBorder: outlineInputBorder.copyWith(borderRadius: BorderRadius.circular(16)),
                        focusedBorder: focusedInputBorder.copyWith(borderRadius: BorderRadius.circular(16)),
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
                        //isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                  ),
                ),
              ),
              Gap(Dimens.size10),
              InkWell(
                  onTap: () {
                    BlocProvider.of<LessonListBloc>(context).add(LessonListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
                  },
                  child: Icon(Icons.search_rounded, color: ColorConst.mainColor,size: Dimens.size40,)),
            ],
          ),
         

        ],
      ),
    );
  }
  Widget buildLessonList({required LessonListState state, required BuildContext context}){
    List<Widget> listOfVocabulary = List.empty(growable: true);
    LessonDataSource employeeDataSource = LessonDataSource(employeeData: state.vocabularyResponseModel?.content??[]);
    switch (state.blocStatus){
      case null:
        // TODO: Handle this case.
      case VocabularyStatus.initial:
        // TODO: Handle this case.
      case VocabularyStatus.onLoading:
        // TODO: Handle this case.
      case VocabularyStatus.onSearchByParams:
        // TODO: Handle this case.
        return Center(child: CircularProgressIndicator());
      case VocabularyStatus.onLoadEnd:
        // TODO: Handle this case.
        return (listOfVocabulary.isEmpty) ?
        Center(child:NoData()) :
        Scrollbar(
          controller: scrollController,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: scrollController,
            child: SfDataGrid(
              source: employeeDataSource,
              columnWidthMode: ColumnWidthMode.fill,
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'id',
                    label: Container(
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: Text(
                          'ID',
                        ))),
                GridColumn(
                    columnName: 'simplified',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Simplified'))),
                GridColumn(
                    columnName: 'translationVn',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'translationVn',
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    columnName: 'translationEn',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('translationEn'))),
              ],
            )
          ),
        );
    }
  }
}
class LessonDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  LessonDataSource({required List<VocabularyInfo> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: e.id),
      DataGridCell<String>(columnName: 'simplified', value: e.simplified),
      DataGridCell<String>(
          columnName: 'translationVn', value: e.translationVn),
      DataGridCell<String>(columnName: 'translationEn', value: e.translationEn),
    ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}

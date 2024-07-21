import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/pages_common/list_body_page_common.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/views/course/course_list/components/filter_menu_item.dart';
import 'package:webkit/views/vocabulary/vocabulary_detail/add_words.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import '../components/vocabulary_item_view.dart';
import 'bloc/vocabulary_list_bloc.dart';

class VocabularyList extends StatefulWidget {
  VocabularyList({super.key, this.courseType}){
    courseType??=VocabularyType.vocabularyList;
  }
  VocabularyType? courseType;
  @override
  State<VocabularyList> createState() => _VocabularyListState();
}

class _VocabularyListState extends State<VocabularyList>
    with SingleTickerProviderStateMixin, UIMixin {
  late MemberListController controller;
  GlobalKey<FormState>? formKey = GlobalKey();
  ScrollController scrollController=ScrollController();
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
        return VocabularyListBloc(VocabularyListState(vocabularyType: widget.courseType))..add(VocabularyListInitEvent());
      },
      child: BlocConsumer<VocabularyListBloc, VocabularyListState>(
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
                  child: ListBodyCommon(
                    minOfWidthOfListRatio: 0.1,
                    maxOfWidthOfListRatio: 0.5,
                    widthOfListRatio: 0.2,
                    list:  Stack(
                      children: [
                        Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FilterCoursePopupMenu(onSelect: (p0) {
                                  BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListOnSearchByFilterEvent(
                                      searchCommonRequest: state.searchCommonRequest!.copyWith(filterType: p0.filterType,gradeId: p0.selectSubFilter?.id,)));
                                },),
                                Gap(Dimens.size10),
                                Expanded(
                                  child: SizedBox(
                                    height: Dimens.size40,
                                    child: Form(
                                      key: formKey,
                                      child: TextFormField(
                                        maxLines: 1,
                                        onChanged: (value) {
                                                        
                                        },
                                        onFieldSubmitted: (value) {
                                          BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: value)));
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
                                ),
                                Gap(Dimens.size10),
                                InkWell(
                                    onTap: () {
                                      // CourseDetail(courseInfo: state.courseResponseModel!.content,).show(context);
                                      AddWords().show(context);
                                    },
                                    child: Icon(Icons.search_rounded, color: ColorConst.mainColor,size: Dimens.size50,)),
                              ],
                            ),
                          ),
                          myScreenMediaType.isMobile?
                          buildVocabularyList(state: state):
                          Expanded(child: buildVocabularyList(state: state)),
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
                                  BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                                },
                                onBackToFirstPage: (p0) {
                                  BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                                },
                                onNextPage: (p0) {
                                  BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
                                },
                                onGoToLastPage: (p0) {
                                  BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0)));
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
                        Visibility(
                          visible:  state.vocabularyType== VocabularyType.vocabularyList,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding:  EdgeInsets.only(bottom: Dimens.size40),
                              child: InkWell(
                                  onTap: () {
                                    // CourseDetail(courseInfo: state.courseResponseModel!.content,).show(context);
                                    AddWords().show(context);
                                  },
                                  child: Icon(Icons.add_circle_outlined, color: ColorConst.mainColor,size: Dimens.size50,)),
                            ),
                          ),
                        )
                      ]
                    ),
                    body: SizedBox(),
                  ));
            },);
          
        },
      ),
    );
  }
  Widget buildVocabularyList({required VocabularyListState state}){
    List<Widget> listOfVocabulary = List.empty(growable: true);

    for (VocabularyInfo vocabularyInfo in state.vocabularyResponseModel?.content ?? []) {
      listOfVocabulary.add(VocabularyItemView(vocabularyInfo: vocabularyInfo,));
    }
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
        return  (listOfVocabulary.isEmpty) ?
        Center(child:NoData()) :
        Scrollbar(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: scrollController,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.spaceBetween,
                children: listOfVocabulary,
                
              ),
            ),
          ),
        );
    }
  }
}

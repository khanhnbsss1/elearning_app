import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/page_common/permission_page.dart';
import 'package:webkit/base/widgets/audio/audio_speaker.dart';
import 'package:webkit/base/widgets/pages_common/list_body_page_common.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/base/widgets/widget_common/widget_with_title_common.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/theme/theme_customizer.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/sentence/models/sentence_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/services/apis/vocabulary/words/delete_word_api.dart';
import 'package:webkit/views/vocabulary/vocabulary_detail/create_edit_words.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../layouts/layout.dart';
import '../components/vocabulary_item_view.dart';
import '../vocabulary_detail/vocabulary_view_detail.dart';
import 'bloc/vocabulary_list_bloc.dart';

class VocabularyList extends StatefulWidget {
  VocabularyList({super.key, this.courseType}){
    courseType??=VocabularyType.vocabularyNonImage;
  }
  VocabularyType? courseType;
  @override
  State<VocabularyList> createState() => _VocabularyListState();
}

class _VocabularyListState extends State<VocabularyList> with SingleTickerProviderStateMixin, UIMixin {
  late MemberListController controller;
 TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState>? formKey = GlobalKey();
  ScrollController scrollController=ScrollController();
  @override
  void initState() {
    super.initState();
    controller = Get.put(MemberListController());
    WidgetsBinding.instance.addPostFrameCallback((_){
      ThemeCustomizer().toggleLeftBarCondensedByValue(leftBarCondensed: true);
    });
  }

  int? page = 1;
  final int pageItemCount = 16;
  late int pageCount;
  bool isOnVolume=  false;
  List<String>permission =[
    "vocabulary.get.getlist",
  ];
  @override
  Widget build(BuildContext context) {
    return PermissionPage(
      permissionList: permission,
      child: BlocProvider(
        create: (context) {
          return VocabularyListBloc(VocabularyListState(vocabularyType: widget.courseType))..add(VocabularyListInitEvent());
        },
        child: BlocConsumer<VocabularyListBloc, VocabularyListState>(
          listener: (context, state) {
            switch (state.blocStatus) {
              case VocabularyStatus.initial:
                break;
            // TODO: Handle this case.
              case VocabularyStatus.onSelectWord:
                break;
              default:
                break;
            // TODO: Handle this case.
            }
          },
          builder: (BuildContext context, state) {
            return MyResponsive(
              builder: (context , boxConstraints , myScreenMediaType ) {
                if(!myScreenMediaType.isMobile)
                {
                  return Layout(
                      isScroll: false,
                      title: Center(child: Text(
                        state.vocabularyType == VocabularyType.vocabularyImage? L10nX.getStr.vocabulary_str: L10nX.getStr.vocabulary_str,
                        style: TextStyleConstant.textStyleBlack18w600,
                      ),),
                      padding: EdgeInsets.only(top: 35 + 16, bottom: 0),
                      child: ListBodyCommon(
                        minOfWidthOfListRatio: 0.2,
                        maxOfWidthOfListRatio: 0.3,
                        widthOfListRatio: 0.3,
                        enableDragIcon: false,
                        list: buildLeftPage(state: state, boxConstraints: boxConstraints, context: context, myScreenMediaType: myScreenMediaType),
                        body: Container(
                            decoration: BoxDecoration(
                                border: Border(left: BorderSide(color: ColorConst.mainColor, width: 0.1))
                            ),
                            child: state.selectVocabularyInfo!=null?
                            VocabularyViewDetail(
                              key: UniqueKey(),
                              selectVocabularyInfo: state.selectVocabularyInfo!,enableCloseButton: false,):SizedBox()
                        ),
                      ));
                }
                else
                {
                  return Layout(
                      isScroll: false,
                      child: buildLeftPage(
                          state: state,
                          boxConstraints: boxConstraints,
                          context: context, myScreenMediaType: myScreenMediaType));
                }
              },);

          },
        ),
      ),
    );
  }
  Widget buildLeftPage(
  {
    required MyScreenMediaType myScreenMediaType,
    required BoxConstraints boxConstraints,
    required BuildContext context,
    required VocabularyListState state
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
            Expanded(child: buildVocabularyList(state: state, context: context)),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterCustomPagination(
                  key: GlobalKey(debugLabel: (state.vocabularyResponseModel?.total??0).toString()),
                  currentPage: state.vocabularyResponseModel!.getCurrentPage(),
                  limitPerPage: state.vocabularyResponseModel!.pageSize??10,
                  totalDataCount: state.vocabularyResponseModel!.getTotalElement(),
                  onPreviousPage: (p0) {
                    BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onBackToFirstPage: (p0) {
                    BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onNextPage: (p0) {
                    BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
                  },
                  onGoToLastPage: (p0) {
                    BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(pageNumber: p0 -1)));
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
    required VocabularyListState state
  }){
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: ColorConst.blackColor, width: 0.2)
          )
      ),
      padding: EdgeInsets.symmetric(vertical: Dimens.size8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              height: Dimens.size40,
              child: Form(
                key: formKey,
                child: TextFormField(
                  maxLines: 1,
                  controller: textEditingController,
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
                BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListOnSearchByFilterEvent(searchCommonRequest: state.searchCommonRequest!.copyWith(keyword: textEditingController.text)));
              },
              child: Icon(Icons.search_rounded, color: ColorConst.mainColor,size: Dimens.size40,)),
          Visibility(
            visible:  UserManager().userContainPermission(permissionList: [
              "vocabulary.post.create_vocabulary",
            ]),
            child: Row(
              children: [
                Gap(Dimens.size10),
                InkWell(
                    onTap: () {
                      // CourseDetail(courseInfo: state.courseResponseModel!.content,).show(context);
                      CreateEditWordsPage(
                        wordsPageActionType: WordsPageActionType.create,
                        key: UniqueKey(),
                        onCreated: () {
                          BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListInitEvent());
                        },
                      ).show(context);
                    },
                    child: Icon(Icons.add_circle_outline, color: ColorConst.mainColor,size: Dimens.size40,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildVocabularyList({required VocabularyListState state, required BuildContext context}){
    List<Widget> listOfVocabulary = List.empty(growable: true);

    for (VocabularyInfo vocabularyInfo in state.vocabularyResponseModel?.content ?? []) {
      listOfVocabulary.add(
        InkWell(
          onTap: () {
            if(ResponsiveInfo.isPhone())
            {
              VocabularyViewDetail(selectVocabularyInfo: state.selectVocabularyInfo!,).show(context);
            }
            else
              {
                BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListOnSelectVocabularyEvent(selectVocabularyInfo: vocabularyInfo));
              }
          },
          child: VocabularyItemView(
            vocabularyInfo: vocabularyInfo,
            onDelete: (p0) async {
              ConfirmPopupPage(
                content: L10nX.getStr.you_want_remove,
                onAccept: () async {
                  MonitorLoading().showLoading("");
                  DeleteWordApi api = DeleteWordApi(info: p0);
                  dynamic data = await api.call();
                  MonitorLoading().dismiss();

                  BlocProvider.of<VocabularyListBloc>(context).add(VocabularyListInitEvent());
                },

              ).show(context);
            },
            onEdit: (p0) {
              CreateEditWordsPage(
                key: UniqueKey(),
                vocabularyInfo: p0,
                wordsPageActionType: WordsPageActionType.edit,).show(context);
            },
            onViewDetail: (p0) {
              CreateEditWordsPage(
                key: UniqueKey(),
                vocabularyInfo: p0,
                wordsPageActionType: WordsPageActionType.view,).show(context);
            },
          ),)
            
          
      );
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
      case VocabularyStatus.onSelectWord:
      case VocabularyStatus.onLoadEnd:
        // TODO: Handle this case.
        return  (listOfVocabulary.isEmpty) ?
        Center(child:NoData()) :
        Scrollbar(
          controller: scrollController,
          thickness: Dimens.size10,
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
        );
    }
  }
  
  Widget buildVocabularyDetail({required VocabularyListState state}){
    return Container(
      decoration: BoxDecoration(
        color: ColorConst.whiteColor
      ),
      child: Stack(
        children: [
          Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*(ResponsiveInfo.isPhone()?1/8:1/6),
              decoration: BoxDecoration(
                color: ColorConst.mainColor
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.selectVocabularyInfo?.simplified??"", style: TextStyleConstant.textStyleBlack28w700.copyWith(color: ColorConst.whiteColor, fontSize: Dimens.size60),),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Visibility(
                        visible: (state.selectVocabularyInfo?.pinyinTones??"").isNotEmpty,
                        child: WidgetWithColumnTitleCommon(
                          title: "${L10nX.getStr.pinyin_tone_str}: ",
                          titleStyle: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor),
                          child: Row(
                            children: [
                              Text(state.selectVocabularyInfo?.pinyinTones??""),
                              Gap(Dimens.size4),
                              Visibility(
                                //visible: (state.selectVocabularyInfo?.audio??"").isNotEmpty,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: StatefulBuilder(
                                      builder: (BuildContext context, void Function(void Function()) setState) { 
                                        return AudioSpeaker(url: state.selectVocabularyInfo?.audioLink??"",);
                                      },
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                      Gap(Dimens.size10),
                      WidgetWithColumnTitleCommon(
                        title: "${L10nX.getStr.category_word}: ",
                        titleStyle: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text((state.selectVocabularyInfo?.categoryWord??"").isNotEmpty?state.selectVocabularyInfo?.categoryWord??"":L10nX.getStr.unknown_str),
                        ),
                      ),
                      Gap(Dimens.size10),
                      Visibility(
                        visible: (state.selectVocabularyInfo?.translationVn??"").isNotEmpty,
                        child: WidgetWithColumnTitleCommon(
                          title: "${L10nX.getStr.viet_nam_text}: ",
                          titleStyle: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(state.selectVocabularyInfo?.translationVn??""),
                          ),
                        ),
                      ),
                      Gap(Dimens.size10),
                      Visibility(
                        visible: (state.selectVocabularyInfo?.traditional??"").isNotEmpty,
                        child: WidgetWithColumnTitleCommon(
                          title: "${L10nX.getStr.traditional_str}: ",
                          titleStyle: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(state.selectVocabularyInfo?.traditional??""),
                          ),
                        ),
                      ),
                      buildExamplesListForView( state: state),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
          Visibility(
            visible: ResponsiveInfo.isPhone(),
            child: Align(
              alignment:Alignment.topRight ,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.close, color: ColorConst.whiteColor,size: Dimens.size20,),
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
  Widget buildExamplesListForView({required VocabularyListState state}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetWithColumnTitleCommon(
                  title: L10nX.getStr.examples_str,
                  child: (state.selectVocabularyInfo?.sentenceInfos??[]).isNotEmpty?ListView.builder(
                    itemCount:(state.selectVocabularyInfo?.sentenceInfos??[]).length,
                    shrinkWrap: true,
                    itemBuilder: (context, exampleIndex) {
                      SentenceInfo sentenceInfo = (state.selectVocabularyInfo?.sentenceInfos??[]).elementAt(exampleIndex);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('$exampleIndex. '),
                            Text('${sentenceInfo.chineseSentence??''}(${L10nX.getStr.pinyin_tone_str}:${sentenceInfo.pinyionSentence??''})'),
                            AudioSpeaker(url: sentenceInfo.audioLink??'')
                          ],),
                      );
                    },
                  ):Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(L10nX.getStr.has_not_example, style: TextStyleConstant.textStyleBlack13w300,)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

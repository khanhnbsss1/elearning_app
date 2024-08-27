import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/constant/dimens_constant.dart';
import 'package:webkit/base/widgets/audio/audio_speaker.dart';
import 'package:webkit/base/widgets/widget_common/widget_with_title_common.dart';
import 'package:webkit/services/apis/sentence/models/sentence_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/services/apis/vocabulary/words/get_vocabulary_detail.dart';

class VocabularyViewDetail extends StatefulWidget{
  void show(BuildContext context){
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Material(
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height*(ResponsiveInfo.isPhone()?0.95: 0.8),
                  width: MediaQuery.of(context).size.width*(ResponsiveInfo.isPhone()?0.95: 0.5),
                  child: this),
            ));
      },
    );
  }
  
  VocabularyInfo selectVocabularyInfo;

  bool? enableCloseButton;
  VocabularyViewDetail({
    super.key,
    required this.selectVocabularyInfo, this.enableCloseButton}){
    enableCloseButton??=true;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VocabularyViewDetailState();
  }
  
}

class VocabularyViewDetailState extends State<VocabularyViewDetail>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
        child: Dialog(
          insetPadding: EdgeInsets.zero,
          child: buildVocabularyDetail(context),
        ));
  }
  Widget buildVocabularyDetail(BuildContext context){
    return PointerInterceptor(
      child: Container(
        decoration: BoxDecoration(
            color: ColorConst.whiteColor
        ),
        child: Stack(
            children: [
              FutureBuilder(
                future: getDetail(),
                builder: (context, snapshot) {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height *(ResponsiveInfo.isPhone()?1/5:1/4)*((widget.selectVocabularyInfo.imageLink??"").isEmpty?0.7:1),
                      decoration: BoxDecoration(
                          color: ColorConst.mainColor
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                                visible: (widget.selectVocabularyInfo.imageLink??"").isNotEmpty,
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Gap(Dimens.size16),
                                      Expanded(
                                        child: SizedBox(
                                          //height:  MediaQuery.of(context).size.height*(ResponsiveInfo.isPhone()?1/8:1/5) -Dimens.size20,
                                          // width: MediaQuery.of(context).size.height*(ResponsiveInfo.isPhone()?1/8:1/5),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ImageManager().getImageByUrl(
                                                (widget.selectVocabularyInfo.imageLink??""),
                                                errorBuilder: SizedBox()),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                            Visibility(
                                visible: (widget.selectVocabularyInfo.imageLink??"").isEmpty,
                                child: Text((widget.selectVocabularyInfo.simplified??"").trim(),  style: TextStyleConstant.textStyleBlack30w700.copyWith(
                                    color: ColorConst.whiteColor, fontSize: Dimens.size60
                                ),)
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: LayoutBuilder(builder: (context, constraints) {
                          double maxWidth = constraints.maxWidth/(ResponsiveInfo.isPhone() ? 2 : 2);
                          double height = Dimens.size100;
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  GridView.count(
                                    crossAxisCount: ResponsiveInfo.isPhone() ? 2 : 2,
                                    shrinkWrap: true,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
                                    childAspectRatio: (maxWidth) / (height),
                                    children: [
                                      Visibility(
                                        visible: (widget.selectVocabularyInfo.simplified??"").isNotEmpty,
                                        child: WidgetWithColumnTitleCommon(
                                          title: "${L10nX.getStr.simplified_str}: ",
                                          titleStyle: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Gap(Dimens.size8),
                                              Visibility(
                                                //visible: (widget.selectVocabularyInfo.audio??"").isNotEmpty,
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                                      return AudioSpeaker(url: widget.selectVocabularyInfo.audioLink??"",);
                                                    },
                                                  )
                                              ),
                                              Gap(Dimens.size4),
                                              Expanded(child: Text((widget.selectVocabularyInfo.simplified??"").trim(),)),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: (widget.selectVocabularyInfo.pinyinTones??"").isNotEmpty,
                                        child: WidgetWithColumnTitleCommon(
                                          title: "${L10nX.getStr.pinyin_tone_str}: ",
                                          titleStyle: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Gap(Dimens.size8),
                                              Visibility(
                                                //visible: (widget.selectVocabularyInfo.audio??"").isNotEmpty,
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                                      return AudioSpeaker(
                                                        url: widget.selectVocabularyInfo.audioLink??"",);
                                                    },
                                                  )
                                              ),
                                              Gap(Dimens.size4),
                                              Expanded(child: Text((widget.selectVocabularyInfo.pinyinTones??"").trim(),)),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: (widget.selectVocabularyInfo.translationVn??"").isNotEmpty,
                                        child: WidgetWithColumnTitleCommon(
                                          title: "${L10nX.getStr.viet_nam_text}: ",
                                          titleStyle: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Gap(Dimens.size8),
                                              Expanded(child: Text(widget.selectVocabularyInfo.translationVn??"")),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: (widget.selectVocabularyInfo.traditional??"").isNotEmpty,
                                        child: WidgetWithColumnTitleCommon(
                                          title: "${L10nX.getStr.traditional_str}: ",
                                          titleStyle: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Gap(Dimens.size8),
                                              Expanded(
                                                  child: Text(widget.selectVocabularyInfo.traditional??"")),
                                            ],
                                          ),
                                        ),
                                      ),
                                      WidgetWithColumnTitleCommon(
                                        title: "${L10nX.getStr.category_word}: ",
                                        titleStyle: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Gap(Dimens.size8),
                                            Expanded(child: Text((widget.selectVocabularyInfo.categoryWord??"").isNotEmpty?widget.selectVocabularyInfo.categoryWord??"":L10nX.getStr.unknown_str)),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  buildExamplesListForView(),
                                ],
                              ),
                            ),
                          );
                        },)
                    )
                  ],
                );
              },),
              Visibility(
                visible: widget.enableCloseButton??false,
                child: Align(
                  alignment:Alignment.topRight ,
                  child: Padding(
                    padding: EdgeInsets.all(Dimens.size16),
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
      ),
    );
  }
  Future<VocabularyInfo> getDetail() async {
    GetVocabularyDetailApi getVocabularyDetailApi = GetVocabularyDetailApi(
      vocabularyId: widget.selectVocabularyInfo.id!
    );
    widget.selectVocabularyInfo = await getVocabularyDetailApi.call()?? widget.selectVocabularyInfo;
    return widget.selectVocabularyInfo;
  }
  
  Widget buildExamplesListForView() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Dimens.size16),
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
                    titleStyle: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor),
                    child: (widget.selectVocabularyInfo.sentenceInfos??[]).isNotEmpty?ListView.builder(
                      itemCount:(widget.selectVocabularyInfo.sentenceInfos??[]).length,
                      shrinkWrap: true,
                      itemBuilder: (context, exampleIndex) {
                        SentenceInfo sentenceInfo = (widget.selectVocabularyInfo.sentenceInfos??[]).elementAt(exampleIndex);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('$exampleIndex. ', style: TextStyleConstant.textStyleBlack13w500,),
                                  Gap(Dimens.size8,),
                                  Text( sentenceInfo.chineseSentence??'', style: TextStyleConstant.textStyleBlack13w500,),
                                  Gap(Dimens.size8,),
                                  Visibility(
                                    visible: (sentenceInfo.audioLink??'').isNotEmpty,
                                      child: AudioSpeaker(url: sentenceInfo.audioLink??'')),
                                  Gap(Dimens.size8),
                                  
                                ],),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: Dimens.size16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Gap(Dimens.size16),
                                    Text('${L10nX.getStr.pinyin_tone_str}: (${sentenceInfo.pinyionSentence??''})', style: TextStyleConstant.textStyleBlack13w400,),
                                    Gap(Dimens.size8),
                                    Text('${L10nX.getStr.translation_vn_str.trim()}: (${sentenceInfo.translationVn??''})', style: TextStyleConstant.textStyleBlack13w400,),
                                  ],
                                ),
                              ),
                             

                            ],
                          ),
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
      ),
    );
  }

}
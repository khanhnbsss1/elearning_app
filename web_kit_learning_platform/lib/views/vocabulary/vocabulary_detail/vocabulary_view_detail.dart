import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:universal_html/html.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/audio/audio_speaker.dart';
import 'package:webkit/base/widgets/widget_common/widget_with_title_common.dart';
import 'package:webkit/services/apis/sentence/models/sentence_info.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class VocabularyViewDetail extends StatefulWidget{
  void show(BuildContext context){
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Material(
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width*(ResponsiveInfo.isPhone()?0.95: 0.5),
                  child: this),
            ));
      },
    );
  }
  VocabularyInfo selectVocabularyInfo;

  VocabularyViewDetail({required this.selectVocabularyInfo});
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
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*(ResponsiveInfo.isPhone()?1/8:1/5),
                    decoration: BoxDecoration(
                        color: ColorConst.mainColor
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.selectVocabularyInfo.simplified??"", style: TextStyleConstant.textStyleBlack28w700.copyWith(color: ColorConst.whiteColor, fontSize: Dimens.size60),),
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
                              visible: (widget.selectVocabularyInfo.pinyinTones??"").isNotEmpty,
                              child: WidgetWithColumnTitleCommon(
                                title: "${L10nX.getStr.pinyin_tone_str}: ",
                                titleStyle: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor),
                                child: Row(
                                  children: [
                                    Text(widget.selectVocabularyInfo.pinyinTones??""),
                                    Gap(Dimens.size4),
                                    Visibility(
                                      //visible: (widget.selectVocabularyInfo.audio??"").isNotEmpty,
                                        child: StatefulBuilder(
                                          builder: (BuildContext context, void Function(void Function()) setState) {
                                            return AudioSpeaker(url: widget.selectVocabularyInfo.audio??"",);
                                          },
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
                              child: Text((widget.selectVocabularyInfo.categoryWord??"").isNotEmpty?widget.selectVocabularyInfo.categoryWord??"":L10nX.getStr.unknown_str),
                            ),
                            Gap(Dimens.size10),
                            Visibility(
                              visible: (widget.selectVocabularyInfo.translationVn??"").isNotEmpty,
                              child: WidgetWithColumnTitleCommon(
                                title: "${L10nX.getStr.viet_nam_text}: ",
                                titleStyle: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor),
                                child: Text(widget.selectVocabularyInfo.translationVn??""),
                              ),
                            ),
                            Gap(Dimens.size10),
                            Gap(Dimens.size10),
                            Visibility(
                              visible: (widget.selectVocabularyInfo.traditional??"").isNotEmpty,
                              child: WidgetWithColumnTitleCommon(
                                title: "${L10nX.getStr.traditional_str}: ",
                                titleStyle: TextStyleConstant.normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor),
                                child: Text(widget.selectVocabularyInfo.traditional??""),
                              ),
                            ),
                            buildExamplesListForView(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Align(
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
              )
            ]
        ),
      ),
    );
  }
  Widget buildExamplesListForView() {
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
                  child: (widget.selectVocabularyInfo.sentenceInfos??[]).isNotEmpty?ListView.builder(
                    itemCount:(widget.selectVocabularyInfo.sentenceInfos??[]).length,
                    shrinkWrap: true,
                    itemBuilder: (context, exampleIndex) {
                      SentenceInfo sentenceInfo = (widget.selectVocabularyInfo.sentenceInfos??[]).elementAt(exampleIndex);
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
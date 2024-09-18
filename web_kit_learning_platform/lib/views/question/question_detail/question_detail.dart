import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/instance_mananger/filter_manager.dart';
import 'package:webkit/base/widgets/audio/audio_speaker.dart';
import 'package:webkit/base/widgets/drop_down/drop_down_search.dart';
import 'package:webkit/base/widgets/widget_common/widget_with_title_common.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/question/models/question_info.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';

import 'components/answer_widget_edit_item.dart';
import 'question_detail_bloc/question_detail_bloc.dart';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';

class QuestionCreateEditDetailPage extends StatefulWidget {
  QuestionInfo? info;
  ActionType? actionType;
  Function()?callBack;
  QuestionCreateEditDetailPage({super.key, this.info, this.actionType, this.callBack}){
    actionType??= ActionType.create;
  }

  void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * (ResponsiveInfo.isTablet() ? 0.4 : 0.9),
                height: MediaQuery.of(context).size.height * (ResponsiveInfo.isTablet() ? 0.9 : 1),
                key: UniqueKey(),
                child: this
            ),
          );
        });
  }

  @override
  State<QuestionCreateEditDetailPage> createState() => _CreateEditLesson();
}

class _CreateEditLesson extends State<QuestionCreateEditDetailPage>
    with TickerProviderStateMixin, UIMixin {

  var position = 0;
  String mode = 'FREE';
  int price = 0;
  late QuestionDetailState _state;
  late bool enableEdit;
  ScrollController controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enableEdit = widget.actionType!=ActionType.view;

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.size20))
      ),
      clipBehavior: Clip.antiAlias,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConst.mainColor,
          iconTheme: IconThemeData(
            color: ColorConst.whiteColor, //change your color here
          ),
          title: Text( 
            widget.info?.id==null?L10nX.getStr.question_create:L10nX.getStr.question_edit,
            style: TextStyleConstant.textStyleBlack20w700.copyWith(color: ColorConst.whiteColor),),
          centerTitle: true,
        ),
        body: Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: ColorConst.dividerColor, width: 1)),
                color: ColorConst.whiteColor
            ),
            child: questionDetail()),
      ),
    );
  }

  final ImagePicker imagePicker = ImagePicker();

  Widget questionDetail() {
    return BlocProvider(
      create: (context) {
        return QuestionDetailBloc(QuestionDetailState(questionInfo: widget.info,))
          ..add(QuestionDetailInitEvent());
      },
      child: BlocConsumer<QuestionDetailBloc, QuestionDetailState>(
        listener: (context, state) {
          switch (state.blocStatus) {
            case QuestionDetailStatus.initial:
              break;
            case QuestionDetailStatus.onCreateQuestion:
              {
                Navigator.of(context).pop();
              }
              break;
            case QuestionDetailStatus.onUpdateQuestion:
              {
                Navigator.of(context).pop();

              }
              break;
            case QuestionDetailStatus.onAddAnswer:
              {
               controller.animateTo(controller.position.pixels + Dimens.size400, duration: Duration(milliseconds: 500), curve: Curves.linear);

              }
              break;
            default:
              break;
          }
          state.blocStatus = QuestionDetailStatus.unKnown;
        },
        builder: (BuildContext context, state) {
          _state= state;
          return LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    Expanded(
                        child: buildPageView(context: context, state: state)
                    ),
                    Divider(color: ColorConst.dividerColor.withOpacity(0.3),),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: widget.actionType != ActionType.view,
                          child: ActionButton1(
                            text: widget.actionType == ActionType.create?L10nX.getStr.question_create:L10nX.getStr.str_update,
                            width: Dimens.size150,
                            onTap: () {
                              state.questionInfo??= QuestionInfo();
                              state.questionInfo?.questionName = state.editingControllerQuestionName?.text;
                              state.questionInfo?.weightage = int.tryParse(state.editingControllerQuestionScore?.text??"0");
                              switch(widget.actionType){

                                case ActionType.view:
                                // TODO: Handle this case.
                                  break;
                                case ActionType.edit:
                                // TODO: Handle this case.
                                  {
                                    BlocProvider.of<QuestionDetailBloc>(context).add(QuestionDetailUpdateQuestionEvent(info: state.questionInfo!));
                                  }
                                  break;
                                case ActionType.create:
                                // TODO: Handle this case.
                                  {
                                    BlocProvider.of<QuestionDetailBloc>(context).add(QuestionDetailCreateQuestionEvent(info: state.questionInfo!));
                                  }
                                  break;
                                default:
                                  break;
                              }
                            },
                          ),
                        ),
                        Gap(Dimens.size20),
                        ActionButton1(
                          text: L10nX.getStr.close,
                          width: Dimens.size80,
                          enableBgColor: ColorConst.whiteColor,
                          textStype: TextStyleConstant.textStyleBlack14w400.copyWith(color: ColorConst.blackColor),
                          onTap: () {
                            Navigator.of(context).pop();

                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
  Tab buildTabItem( { required int index, required String title}){
    TextStyle textStyle = TextStyleConstant.textStyleBlack15w700.copyWith(
        color: (position == index?ColorConst.textColorSelectTabBar : ColorConst.subtext));
    return Tab(
      child: Container(
        height:(Dimens.size30),
        alignment: Alignment.center,
        child: Center(
          child: Text(
            title,
            style: textStyle,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
  Widget buildPageView({required BuildContext context, required QuestionDetailState state}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.size16,),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildQuestionIntro(state: state, context: context),
                  Gap(Dimens.size16),
                  Divider(color: ColorConst.colorIconGrays,thickness: 0.2,),
                  Gap(Dimens.size16),
                  buildAnswerList(context: context, state: state),
                  
                ],
              ),
            ),
          ),
          Center(
            child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, color: ColorConst.mainColor,),
                  Text(L10nX.getStr.add_selection, style: TextStyleConstant.textStyleBlack13w400.copyWith(color: ColorConst.mainColor,),)
                ],
              ),
              onTap: () {
                BlocProvider.of<QuestionDetailBloc>(context).add(QuestionDetailAddAnswerInfoEvent());
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildQuestionIntro({required BuildContext context, required QuestionDetailState state}){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Gap(Dimens.size16),
        buildQuestionName(context: context),
        Gap(Dimens.size16),
        buildQuestionFileAttack(context: context, state: state),
        Gap(Dimens.size16),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: buildGrade(state: state, context: context)),
            Gap(Dimens.size50),
            Expanded(child: buildQuestionScore(context: context)),
          ],
        )
      ],
    );
  }
  Widget buildQuestionName({required BuildContext context}) {
    return WidgetWithColumnTitleCommon(
      // title: '${L10nX.getStr.name}: ',
      title: L10nX.getStr.question_str,
      isRequirement: true,
      // titleStyle: ,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        controller: _state.editingControllerQuestionName,
        enabled: enableEdit,
        minLines: 3,
        maxLines: 5,
        decoration: InputDecoration(
          labelText: L10nX.getStr.quiz_type_str,
          alignLabelWithHint: true,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          labelStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
  Widget buildQuestionFileAttack({required BuildContext context, required QuestionDetailState state}) {
    return WidgetWithColumnTitleCommon(
       titleWidget: Column(
         children: [
           Row(
             children: [
               Gap(Dimens.size4),
               Text("${L10nX.getStr.question_type}: ", style: TextStyleConstant.textStyleBlack14w400.copyWith(fontWeight:FontWeight.w600 ),),
               Gap(Dimens.size16),
               Expanded(child: Center(child: buildRadioButtonQuestionTypes(
                   context: context, 
                   state: state,
                 onChanged: (p0) {
                       state.questionInfo?.questionType = p0;
                       BlocProvider.of<QuestionDetailBloc>(context).add(QuestionDetailUpdateQuestionInfoEvent(info: state.questionInfo!));
                 },
               ))),
             ],
           ),
           Gap(Dimens.size16),
         ],
       ),
      isRequirement: true,
      // titleStyle: ,
      child: Visibility(
        visible: state.questionInfo?.questionType == QuestionType.image ||
            state.questionInfo?.questionType == QuestionType.audio,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L10nX.getStr.attack_file,
              style: TextStyleConstant.textStyleBlack13w500.copyWith(fontWeight: FontWeight.w600),
            ),
            Gap(Dimens.size8),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: state.questionInfo?.questionType == QuestionType.image && ((state.questionInfo?.questionLink??"").isNotEmpty),
                  child: SizedBox(
                    width: Dimens.size150,
                    height: Dimens.size120,
                    child: ImageManager().getImageByUrl(
                      state.questionInfo?.questionLink??"",
                      boxFit: BoxFit.contain,
                    ),
                  ),
                ),
                Visibility(
                  visible: state.questionInfo?.questionType == QuestionType.audio  && ((state.questionInfo?.questionLink??"").isNotEmpty),
                  child: AudioSpeaker(
                    url: state.questionInfo?.questionLink??"",
                  ),
                ),
                Gap(Dimens.size8),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _state.editingControllerAttackFile,
                    enabled: enableEdit,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: L10nX.getStr.attack_file,
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      suffixIcon: InkWell(
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions:state.questionInfo?.questionType== QuestionType.audio? ['wav', 'mp3']:['png', 'jpg'],
                          );
                          if(result==null) {
                            return;
                          }
                          dio.MultipartFile file = dio.MultipartFile.fromBytes(result.files.first.bytes!.toList(growable: true), filename: result.names[0]);
                          
                          UploadFileInfo uploadFileInfo = UploadFileInfo(
                              data: SubjectType.vocabulary,
                              fileName: result.files.first.name,
                              file: file
                          );
                          BlocProvider.of<QuestionDetailBloc>(context).add(QuestionDetailUpLoadFileInfoEvent(uploadFileInfo: uploadFileInfo));
                        },
                        child: Icon(
                          Icons.cloud_upload_rounded,
                          size: 20,
                          color: ColorConst.colorIconRed,
                        ),
                      ),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget buildGrade({required QuestionDetailState state, required BuildContext context}) {
    return FilterManager().buildGrade(
      context: context,
      enable: enableEdit,
      width: Dimens.size250,
      onChanged: (p0) {
        state.questionInfo?.gradeId = p0?.id;
        BlocProvider.of<QuestionDetailBloc>(context).add(QuestionDetailUpdateQuestionInfoEvent(info: state.questionInfo!));

      },
      inputGradeId: (state.questionInfo?.gradeId),
    );
  }
  Widget buildQuestionScore({required BuildContext context}) {
    List<QuestionType> items = enableEdit?QuestionType.values:[];
    return Container(
      constraints: BoxConstraints(
          maxWidth: Dimens.size250
      ),
      child: WidgetWithColumnTitleCommon(
        title: L10nX.getStr.score_str,
        isRequirement: true,
        child:TextFormField(
          keyboardType: TextInputType.text,
          controller: _state.editingControllerQuestionScore,
          enabled: enableEdit,
          maxLines: 1,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          decoration: InputDecoration(
            labelText: L10nX.getStr.score_str,
            alignLabelWithHint: true,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelStyle: MyTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder,
            contentPadding: MySpacing.all(16),
            isCollapsed: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ),
    );
  }

  Widget buildAnswerList({required BuildContext context, required QuestionDetailState state}) {
    return WidgetWithColumnTitleCommon(
      title: L10nX.getStr.answer_str_2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: buildRadioButtonAnswerTypes(context: context, state: state, onChange: (p0) {
                    state.answerType = p0;
                    BlocProvider.of<QuestionDetailBloc>(context).add(QuestionDetailChangeAnswerTypeEvent(answerType: state.answerType!));
                  },),
                ),
              ),
              Gap(Dimens.size16),
              Text(L10nX.getStr.answer_str_2, style: TextStyleConstant.textStyleBlack13w400,)
            ],
          ),
          Gap(Dimens.size16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: (state.questionInfo?.answerGetDetail??[]).length,
            itemBuilder: (context, index) {
              AnswerInfo answerUploadInfo = (state.questionInfo?.answerGetDetail??[]).elementAt(index);
              return Visibility(
                visible: state.questionInfo?.questionType != QuestionType.fill || index==0,
                child: AnswerWidgetEditItem(
                  answerUploadInfo: answerUploadInfo,
                  answerType: state.answerType,
                  onChange: (p1) {
                    BlocProvider.of<QuestionDetailBloc>(context).add(QuestionDetailChangeAnswerInfoEvent(answerUploadInfo: p1));
                  },
                  onCheckRightAnswer: (p0) {
                    BlocProvider.of<QuestionDetailBloc>(context).add(QuestionDetailChangeAnswerInfoEvent(answerUploadInfo: p0));
                  },
                  onRemove: (p0) {
                    BlocProvider.of<QuestionDetailBloc>(context).add(QuestionDetailRemoveAnswerInfoEvent(answerUploadInfo: p0));
                  },
                  
                ),
              );
          },)
            
        ],
      ),
    );
  }
  
  Widget buildRadioButtonQuestionTypes({required BuildContext context, required QuestionDetailState state, Function(QuestionType?)? onChanged}){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        key: UniqueKey(),
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<QuestionType>(
                value: QuestionType.fill,
                groupValue: state.questionInfo?.questionType,
                onChanged: (QuestionType? value) {
                  if(onChanged!=null)
                    {
                      onChanged(value);
                    }
                },
              ),
              Gap(Dimens.size4),
              Text(L10nX.getStr.type_word_str, style: TextStyleConstant.textStyleBlack12w400,),

            ],
          ),
          Gap(Dimens.size16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<QuestionType>(
                value: QuestionType.text,
                groupValue: state.questionInfo?.questionType,
                onChanged: (QuestionType? value) {
                  if(onChanged!=null)
                  {
                    onChanged(value);
                  }
                },
              ),
              Gap(Dimens.size4),
              Text(L10nX.getStr.text_type_str, style: TextStyleConstant.textStyleBlack12w400,),
              
              
            ],
          ),
          Gap(Dimens.size16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Radio<QuestionType>(
                value: QuestionType.image,
                groupValue: state.questionInfo?.questionType,
                onChanged: (QuestionType? value) {
                  if(onChanged!=null)
                  {
                    onChanged(value);
                  }
                },
              ),
              Gap(Dimens.size4),
              Text(L10nX.getStr.image_type_str, style: TextStyleConstant.textStyleBlack12w400,),
            ],
          ),
          Gap(Dimens.size16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Radio<QuestionType>(
                value: QuestionType.audio,
                groupValue: state.questionInfo?.questionType,
                onChanged: (QuestionType? value) {
                  if(onChanged!=null)
                  {
                    onChanged(value);
                  }
                },
              ),
              Gap(Dimens.size4),
              Text(L10nX.getStr.audio_type_str, style: TextStyleConstant.textStyleBlack12w400,),
            ],
          ),
        ],
      ),
    );
  }
  Widget buildRadioButtonAnswerTypes({required BuildContext context, required QuestionDetailState state, required Function(AnswerType?)onChange}){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<AnswerType>(
                value: AnswerType.text,
                toggleable:  state.questionInfo?.questionType!=QuestionType.fill,
                groupValue: state.answerType,
                onChanged: (AnswerType? value) {
                  setState(() {
                    onChange(value);
                  });
                },
              ),
              Gap(Dimens.size4),
              Text(L10nX.getStr.text_type_str, style: TextStyleConstant.textStyleBlack12w400,),
            ],
          ),
          Gap(Dimens.size16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<AnswerType>(
                value: AnswerType.image,
                toggleable:  state.questionInfo?.questionType!=QuestionType.fill,
                groupValue: state.answerType,
                onChanged: (AnswerType? value) {
                  onChange(value);
                },
              ),
              Gap(Dimens.size4),
              Text(L10nX.getStr.image_type_str, style: TextStyleConstant.textStyleBlack12w400,),
              
             
            ],
          ),
          Gap(Dimens.size16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<AnswerType>(
                value: AnswerType.audio,
                groupValue: state.answerType,
                toggleable: state.questionInfo?.questionType!=QuestionType.fill,
                onChanged: (AnswerType? value) {
                  onChange(value);
                },
              ),
              Gap(Dimens.size4),
              Text(L10nX.getStr.audio_type_str, style: TextStyleConstant.textStyleBlack12w400,),
              
            ],
          ),
        ],
      ),
    );
  }

}

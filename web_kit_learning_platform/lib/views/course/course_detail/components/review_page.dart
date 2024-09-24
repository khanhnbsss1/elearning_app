import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/expands/expand_widget.dart';
import 'package:webkit/base/widgets/popup_confirm/confirm_popup_page.dart';
import 'package:webkit/base/widgets/text/text_link.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/rating/models/rating_info.dart';
import 'package:webkit/services/apis/topic/model/topic_info.dart';
import 'package:webkit/views/course/course_detail/bloc/course_detail_bloc.dart';

enum RatingState{
  notRating,
  createdRating,
  editRating
}
class ReviewPage extends StatelessWidget with UIMixin {
  late CourseDetailState _state;
  List<bool> showLecture = List.filled(3, false, growable: true); 
  TextEditingController ratingTextEditingController = TextEditingController();
  int lessonIndex=0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<CourseDetailBloc, CourseDetailState>(
      listenWhen: (previous, current) {
        return true;
      },
        buildWhen: (previous, current) {
          return true;
        },
        listener: (context, state) {
          switch (state.blocStatus) {
            case AddCourseStatus.initial:
              break;
            default:
              break;
          }
        },
        builder: (BuildContext context, state) {
          _state = state;
          return StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  Gap(Dimens.size50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${L10nX.getStr.review_str} ${L10nX.getStr.course_str.toLowerCase()}",
                        style: TextStyleConstant.textStyleBlack20w700,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  
                  Divider(color: ColorConst.dividerColor,),
                  buildReviewEdit(state: state),
                  //Divider(color: ColorConst.dividerColor,),
                  Gap(Dimens.size32),
                  buildReviewList(state: state, context: context),
                ],
              );
            },
          );
        });
  }
  
  Widget buildReviewList({required CourseDetailState state, required BuildContext context}){
    List<Widget>listSubject = [];
    int index =0;
    for(RatingInfo subjects in state.ratingListResponseModel?.content??[])
      {
        index++;
        listSubject.add(buildReviewItem(ratingInfo:subjects,context: context));
      }
    return Container(
      constraints: BoxConstraints(
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimens.size24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: listSubject,
          ),
        ),
      ),
    );
  }
  
  Widget buildReviewItem({required RatingInfo ratingInfo, required BuildContext context}){
    List<Widget>listLesson = [];
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(
          color: ColorConst.colorIconGrays,
          width: 0.1
        ))
      ),
      padding: EdgeInsets.symmetric(vertical: Dimens.size12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${ratingInfo.fullname??""}.", style: TextStyleConstant.textStyleBlack15w400.copyWith(color: ColorConst.mainColor),),
                  Gap(Dimens.size12),
                  StarRating(
                    color: Colors.yellow,
                    allowHalfRating: true,
                    rating:(ratingInfo.ratePoint??5).toDouble(),
                    size: Dimens.size15,
                    onRatingChanged: (rating) {
                    
                    },
                  ),
                  Gap(Dimens.size12),
                  Text(ratingInfo.createdAt??"", style: TextStyleConstant.textStyleBlack13w400.copyWith(color: ColorConst.greyColor),),
                    
                ],
              ),
              Visibility(
                visible: UserManager().userContainPermission(permissionList: ["rating.delete.delete_rating"]),
                child: InkWell(
                  onTap: () {
                    ConfirmPopupPage(
                      title: "${L10nX.getStr.delete_str} ${L10nX.getStr.review_str.toLowerCase()}",
                      content: L10nX.getStr.you_want_remove,
                      onAccept: () {
                        BlocProvider.of<CourseDetailBloc>(context).add(CourseDetailOnRemoveRatingEvent(
                          ratingInfo: ratingInfo
                        ));
                        },
                    ).show(context);
                  },
                  child: Icon(Icons.delete_forever, color: ColorConst.mainColor, size: Dimens.size15,),
                ),
              )
            ],
          ),
          Gap(Dimens.size12),
          Padding(
            padding:  EdgeInsets.all(Dimens.size8),
            child: Text(ratingInfo.review??"", style: TextStyleConstant.textStyleBlack14w400),
          ),
        ],
      ),
    );
  }
  
  Widget buildReviewEdit({required CourseDetailState state}){
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) { 
        return Visibility(
          visible: state.courseInfo?.isPayment==true,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimens.size24),
            child: Stack(
                children: [
                  Visibility(
                    visible: state.ratingState == RatingState.editRating,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller:ratingTextEditingController,
                          enabled: true,
                          minLines: 3, maxLines: 6,
                          decoration: InputDecoration(
                            labelText: "${L10nX.getStr.enter_text_str} ${L10nX.getStr.review_str}",
                            labelStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            floatingLabelAlignment: FloatingLabelAlignment.start,
                            alignLabelWithHint: true,
                            prefixIconConstraints: BoxConstraints(
                                maxHeight: Dimens.size20
                            ),
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                        ),
                        Gap(Dimens.size16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ActionButton1(
                                  text: L10nX.getStr.review_str,
                                  onTap: () {
                                    if(state.myRate==0)
                                      {
                                        ToastUtils.showToastError("Vui lòng chọn điểm đánh giá");
                                        return;
                                      }
                                    BlocProvider.of<CourseDetailBloc>(context).add(CourseDetailOnRatingEvent(
                                        myRating: state.myRate??0, 
                                        comment: ratingTextEditingController.text));
                                  },
                                ),
                                Gap(Dimens.size16),
                                StarRating(
                                  color: Colors.yellow,
                                  allowHalfRating: true,
                                  rating:(state.myRate??0.0),
                                  onRatingChanged: (rating) {
                                    setState(() {
                                      state.myRate  = rating;
                                    },);
                                    
                                  },
                                ),
                              ],
                            ),
                            ActionButton1(
                              text: L10nX.getStr.cancel,
                              enableBgColor: ColorConst.whiteColor,
                              textStype: TextStyleConstant.textStyleBlack14w600,
                              onTap: () {
                               setState(() {
                                 if(state.courseInfo?.myRating!=0)
                                 {
                                   state.ratingState = RatingState.createdRating;
                                   state.myRate  = state.courseInfo?.myRating;
                                 }
                                 else
                                 {
                                   state.ratingState = RatingState.notRating;
                                   state.myRate  = state.courseInfo?.myRating;
                                 }
                               },);
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Visibility(
                      visible: state.ratingState == RatingState.createdRating,
                      child: Row(
                        children: [
                          Text("${L10nX.getStr.my_rating}: ", style: TextStyleConstant.textStyleBlack14w500,),
                          Gap(Dimens.size16),
                          StarRating(
                            color: Colors.yellow,
                            allowHalfRating: true,
                            rating:(state.courseInfo?.myRating??0.0),
                          ),
                          Gap(Dimens.size16),
                          InkWell(
                            onTap: () {
                              setState(() {
                                state.ratingState = RatingState.editRating;
                              },);
                              
                            },
                            child: Icon(Icons.edit, size: Dimens.size20, color: ColorConst.mainColor,),
                          )
                        ],
                      )),
                  Visibility(
                      visible: state.ratingState == RatingState.notRating,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(L10nX.getStr.you_yet_rating, style: TextStyleConstant.textStyleBlack16w500,),
                          Gap(Dimens.size16),
                          TextLink(
                            text: L10nX.getStr.review_str,
                            style: TextStyleConstant.textStyleBlack16w500.copyWith(color: ColorConst.mainColor),
                            isUnderLine: false,
                            onTap: () {
                              setState(() {
                                state.ratingState = RatingState.editRating;
                              });
                            },
                          ),
                        ],
                      ))
                ]
            ),
          ),
        );
      },
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/helpers/widgets/my.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/l10n/l10n_extention.dart';
import 'package:webkit/landing_page/components/colornotifier.dart';
import 'package:webkit/services/apis/landing_page/course/models/course_list_landing_page_response_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:webkit/views/layouts/left_bar.dart';
import '../../services/apis/course/course_detail/models/course_detail_model.dart';
import '../../services/apis/course/course_list/models/course_models.dart';
enum CourseItemAction { viewDetail, edit, delete , study}

class CourseItemGridView extends StatelessWidget {
  CourseItemGridView({
    required this.courseInfo,
    this.enableEdit,
    this.onViewDetail,
    this.onDelete,
    this.onEdit,
    this.onStudy,
  }){
    enableEdit??=false;
  }

  CourseInfo courseInfo;
  bool? enableEdit;
  Function(CourseInfo)? onEdit, onDelete, onViewDetail, onStudy;
  late ColorNotifier notifier;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Container(
      width: MediaQuery.of(context).size.width* (ResponsiveInfo.isPhone()?1:1/6),
      constraints: BoxConstraints(
        minWidth: 350,
        //maxWidth: 500
      ),
      child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { 
        return  LayoutBuilder(builder: (context, constraints) {
          return OnHoverWidget(
            builder: (isHovered) {
              return Card(
                color: isHovered && !notifier.isDark
                // ? Color.fromRGBO(255, 243, 94, 1.0)
                    ? Color.fromRGBO(252, 173, 106, 1.0)
                    : isHovered && notifier.isDark
                    ? ColorConst.backGroundColor
                    : notifier.whitecolor,
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: isHovered && !notifier.isDark
                    // ? Color.fromRGBO(255, 243, 94, 1.0)
                        ? Color.fromRGBO(252, 173, 106, 1.0)
                        : isHovered && notifier.isDark
                        ? ColorConst.backGroundColor
                        : notifier.whitecolor,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      Padding(
                      padding: (width > 550) ? const EdgeInsets.all(12.0) : EdgeInsets.all(4),
                      child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 2,
                            color: (isHovered) ? Colors.deepPurple : notifier.whitecolor,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child:
                            Image.network(
                                courseInfo.image!.isNotEmpty?
                                courseInfo.image!:
                                'assets/deshboard/adventure/adventure5.png',
                                  fit: BoxFit.cover,
                                  width: constraints.maxWidth * 0.9, 
                                  height: constraints.maxWidth * 0.5,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                  'assets/deshboard/adventure/adventure5.png',
                                  fit: BoxFit.cover,
                                  width: constraints.maxWidth * 0.9,
                                  height: constraints.maxWidth * 0.5,
                                );
                              },
                                )
                          ),
                          SizedBox(height: 4,),
                          Text(
                            '${courseInfo.name} \n' ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleConstant
                                .textStyleBlack16w600
                                .copyWith(
                                fontWeight: FontWeight.bold,
                                // fontSize: Dimens.size24,
                                fontSize: ResponsiveInfo.isPhone()?Dimens.size20:Dimens.size18,
                                color: Color.fromRGBO(163, 20, 19, 1.0)),
                            maxLines: width < 550 ? 1 : 2,
                          ),
                          Gap(Dimens.size4),
                          Text(
                            courseInfo.producerName??"",
                            maxLines: 1,
                            style: TextStyleConstant
                                .textStyleBlack12w400
                                .copyWith(
                              fontWeight: FontWeight.w100,
                                              
                              // fontSize: Dimens.size18,
                              fontSize: ResponsiveInfo.isPhone()?Dimens.size16: width < 1300 ? Dimens.size10 :Dimens.size15,
                              color: notifier.subgreycolor,
                            ),
                          ),
                          Row(
                            children: [
                              Text('${courseInfo.totalLectures} bài giảng - ${courseInfo.gradeName??""} - ${(courseInfo.isStandard == 1) ? 'Chính quy' : 'Không chính quy'} ',
                                style: baseStyle.copyWith(
                                              
                                  // fontSize: Dimens.size16,
                                  fontSize: ResponsiveInfo.isPhone()?Dimens.size16: width < 1300  ? Dimens.size10 :Dimens.size15,
                                  color: notifier.subgreycolor,
                                ),
                                maxLines: 2,),
                              Spacer(),
                            ],
                          ),
                          SizedBox(height: 4,),
                          Gap(Dimens.size4),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  StarRating(
                                    rating: (courseInfo.ratePoint ?? 0)
                                        .toDouble(),
                                    // size: Dimens.size24,
                                    size: ResponsiveInfo.isPhone()?Dimens.size18: width < 1300  ? Dimens.size12 :Dimens.size22,
                                    allowHalfRating: true,
                                    onRatingChanged: (rating) {},
                                  ),
                                              
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    color: notifier.isDark && isHovered
                                        ? notifier.whitecolor
                                        : notifier.isDark && !isHovered
                                        ? notifier.blackcolor
                                        : notifier.blackcolor,
                                    // size: Dimens.size24 ,
                                    size: ResponsiveInfo.isPhone()?Dimens.size18: width < 1300  ? Dimens.size10 :Dimens.size22,
                                  ),
                                  Text(
                                      NumberHelper()
                                          .numberToString(
                                          courseInfo.payment,
                                          decimalDigits: 0)
                                          .trim(),
                                      style: baseStyle.copyWith(
                                              
                                          color: notifier.isDark && isHovered
                                              ? notifier.whitecolor
                                              : notifier.isDark && !isHovered
                                              ? notifier.blackcolor
                                              : notifier.blackcolor,
                                          // fontSize: Dimens.size18,
                                          fontSize: ResponsiveInfo.isPhone()?Dimens.size16: width < 1300  ? Dimens.size10 :Dimens.size15,
                                          fontWeight: FontWeight.bold
                                      )),
                                  Text(" ${L10nX.getStr.vnd_str}",
                                      style: TextStyleConstant
                                          .textStyleBlack16w400
                                          .copyWith(
                                        color: notifier.isDark &&
                                            isHovered
                                            ? notifier.whitecolor
                                            : notifier.isDark &&
                                            !isHovered
                                            ? notifier.blackcolor
                                            : notifier.blackcolor,
                                        // fontSize: Dimens.size18,
                                        fontSize: ResponsiveInfo.isPhone()?Dimens.size16: width < 1300  ? Dimens.size10 :Dimens.size15,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                                              ),
                    ),
                      Visibility(
                        visible: enableEdit??false,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton<CourseItemAction>(
                            color: ColorConst.whiteColor,
                            tooltip: "",
                            //icon: Icon(Icons.filter_alt_outlined, size: Dimens.size30, color: ColorConst.mainColor,),
                            onSelected: (CourseItemAction item) {
                              switch(item){
                                
                                case CourseItemAction.viewDetail:
                                  // TODO: Handle this case.
                                if(onViewDetail!=null)
                                  {
                                    onViewDetail!(courseInfo);
                                  }
                                  break;
                                case CourseItemAction.edit:
                                  // TODO: Handle this case.
                                  if(onEdit!=null)
                                  {
                                    onEdit!(courseInfo);
                                  }
                                  break;
                                case CourseItemAction.delete:
                                  // TODO: Handle this case.
                                  if(onDelete!=null)
                                  {
                                    onDelete!(courseInfo);
                                  }
                                  break;
                                case CourseItemAction.study:
                                  // TODO: Handle this case.
                                  if(onStudy!=null)
                                  {
                                    onStudy!(courseInfo);
                                  }
                              }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<CourseItemAction>>[
                              PopupMenuItem<CourseItemAction>(
                                value: CourseItemAction.viewDetail,
                                child: Text(L10nX.getStr.detail_str),
                              ),
                              PopupMenuItem<CourseItemAction>(
                                value: CourseItemAction.edit,
                                child: Text(L10nX.getStr.edit_str),
                              ),
                              PopupMenuItem<CourseItemAction>(
                                value: CourseItemAction.delete,
                                child: Text(L10nX.getStr.delete_str),
                              ),
                              PopupMenuItem<CourseItemAction>(
                                value: CourseItemAction.study,
                                child: Text(L10nX.getStr.lets_study),
                              ),
                            ],
                        
                          ),
                        ),
                      )
                    ]
                  ),
                ),
              );
            },
          );
        },);
      },
      ),
    );
  }
}

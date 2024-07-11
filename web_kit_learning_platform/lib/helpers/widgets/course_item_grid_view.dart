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
import 'package:webkit/landing_page/components/colornotifier.dart';
import 'package:webkit/services/apis/landing_page/course/models/course_list_landing_page_response_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:webkit/views/layouts/left_bar.dart';
import '../../services/apis/course/course_list/models/course_models.dart';

class CourseItemGridView extends StatelessWidget {
  CourseItemGridView({
    required this.courseInfo,
  });

  CourseInfo courseInfo;
  late ColorNotifier notifier;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 254;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
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
            child: Padding(
              padding: (width > 550) ? const EdgeInsets.all(12.0) : EdgeInsets.all(4),
              child: Stack(children: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: (isHovered) ? Colors.deepPurple : notifier.whitecolor,
                      )),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (courseInfo.image!.isNotEmpty)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                courseInfo.image!,
                                fit: BoxFit.fill,
                                // width: constraints.maxWidth * 0.5,
                                // height: imageHeight * 2 / 4
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                  'assets/deshboard/adventure/adventure5.png',
                                  fit: BoxFit.cover,
                                  // width: constraints.maxWidth,
                                  // height: constraints.maxHeight
                              ),
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
                            fontSize: width < 600 ? width/40 : width < 800 ? width/40 :width < 1150 ? width/50 : width/65,
                            color: Color.fromRGBO(163, 20, 19, 1.0)),
                        maxLines: width < 550 ? 1 : 2,
                      ),
                      Spacer(),
                      Text(
                        '${courseInfo.producerName}',
                        maxLines: 1,
                        style: TextStyleConstant
                            .textStyleBlack12w400
                            .copyWith(
                          fontWeight: FontWeight.w100,
                          
                          // fontSize: Dimens.size18,
                          fontSize: width < 600 ? width/50 :width < 800 ? width/80 : width < 1150 ? width/75 : width/85,
                          color: notifier.subgreycolor,
                        ),
                      ),

                      // constraints.maxWidth < 550
                      //     ? MyText.bodySmall('${courseInfo.producerName}', fontSize: 12 * 0.8)
                      //     : constraints.maxWidth < 1100
                      //     ? MyText.bodySmall('${courseInfo.producerName}', fontSize: 12 * 0.9)
                      //     : MyText.bodySmall('${courseInfo.producerName}',),

                      // constraints.maxWidth > 800 ? SizedBox(height: 8,) : SizedBox(height: 4,),
                      Row(
                        children: [
                          Text('${courseInfo.totalLectures} bài giảng - ${courseInfo.gradeName} - ${(courseInfo.isStandard == 1) ? 'Chính quy' : 'Không chính quy'} ',
                          style: baseStyle.copyWith(
                            
                            // fontSize: Dimens.size16,
                            fontSize: width < 600 ? width/55 :width < 800 ? width/80 :width < 1150 ? width/75 : width/85,
                            color: notifier.subgreycolor,
                          ),
                          maxLines: 2,),
                          Spacer(),
                          // Text('Cấp độ: ${courseInfo.gradeName}',
                          // style: baseStyle.copyWith(
                          //     
                          //     fontSize:
                          //     // constraints.maxWidth < 550
                          //     //     ? Dimens.size26
                          //     //     : constraints.maxWidth < 1100
                          //     //     ? Dimens.size10
                          //     //     : (constraints.maxWidth < 1300)
                          //     //     ? Dimens.size16 :
                          //     Dimens.size16,
                          //     color: notifier.subgreycolor,),)
                        ],
                      ),
                      SizedBox(height: 4,),
                      // Row(
                      //   children: [
                      //     StarRating(
                      //       rating: (courseInfo.ratePoint ?? 0)
                      //           .toDouble(),
                      //       size: (constraints.maxWidth <
                      //           550)
                      //           ? Dimens.size22
                      //           : constraints.maxWidth < 1100
                      //           ? Dimens.size14
                      //           : (constraints.maxWidth < 1300)
                      //           ? Dimens.size24
                      //           : Dimens.size24,
                      //       allowHalfRating: true,
                      //       onRatingChanged: (rating) {},
                      //     ),
                      //   ],
                      // ),
                      Spacer(),
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
                                size: width < 600 ? width/50 :width < 800 ? width/70 :width < 1150 ? width/65 : width/75,
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
                                size: width < 600 ? width/50 :width < 800 ? width/70 :width < 1150 ? width/65 : width/75,
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
                                      fontSize: width < 600 ? width/50 :width < 800 ? width/70 :width < 1150 ? width/65 : width/75,
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
                                    fontSize: width < 600 ? width/50 :width < 800 ? width/70 :width < 1150 ? width/65 : width/75,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/helpers/widgets/my_screen_media.dart';
import 'package:webkit/helpers/widgets/my_screen_media_type.dart';
import 'package:webkit/landing_page/components/colornotifier.dart';
import '../../services/apis/course/course_list/models/course_models.dart';

class CourseItem extends StatelessWidget{
  CourseItem({required this.constraints, required this.courseInfo, isGirdView});
  bool isGirdView = false;
  BoxConstraints constraints;
  CourseInfo courseInfo;
  late ColorNotifier notifier;

  @override
  Widget build(BuildContext context) {
    MyScreenMediaType type;
    notifier = Provider.of<ColorNotifier>(context, listen: true);

    return OnHoverWidget(
      builder: (isHovered) {
        return Padding(
          padding: (constraints.maxWidth < 550)
              ? EdgeInsets.only(right: 4.0)
              : (constraints.maxWidth < 800)
              ? EdgeInsets.only(right: 8)
              : EdgeInsets.only(right: 16),
          child: Card(
            color: isHovered && !notifier.isDark
                ? ColorConst.onHoverColor
                : isHovered && notifier.isDark
                ? ColorConst.backGroundColor
                : notifier.whitecolor,
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                color: isHovered && !notifier.isDark
                    ? ColorConst.onHoverColor
                    : isHovered && notifier.isDark
                    ? ColorConst.backGroundColor
                    : notifier.whitecolor,
                borderRadius: BorderRadius.circular(16),
              ),
              width: constraints.maxWidth / (3 + 0.3),
              // width: constraints.maxWidth / (state.courseListLandingPageResponseModel!.data!.length + 0.2),
              height: (constraints.maxWidth < 550) ? constraints.maxWidth / 0.5 : (constraints.maxWidth < 1100)  ? constraints.maxWidth : (constraints.maxWidth < 1300) ? constraints.maxWidth / 1.7
                  : constraints.maxWidth / 2,
              constraints: BoxConstraints(
                // minHeight: (constraints.maxWidth < 550) ? 630 : (constraints.maxWidth < 1300) ? 750 : 1250,
                maxHeight: (constraints.maxWidth < 550) ? 650 : (constraints.maxWidth < 1100)  ? 850 : (constraints.maxWidth < 1300) ? 900 : 1300,
                minWidth: constraints.maxWidth < 576 ? constraints.maxWidth - 8 : 350,
              ),
              clipBehavior: Clip.hardEdge,
              // margin: EdgeInsets.all(Dimens.size16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: (isHovered)
                            ? Colors.red
                            : notifier.whitecolor,
                      )),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (courseInfo
                          .image!.isNotEmpty)
                          ? ClipRRect(
                        borderRadius:
                        BorderRadius.circular(16),
                        child: Image.network(
                          courseInfo
                              .image!,
                          fit: BoxFit.fill,
                          width: constraints.maxWidth * 2,
                          // height: imageHeight * 2 / 4
                        ),
                      )
                          : ClipRRect(
                        borderRadius:
                        BorderRadius.circular(16),
                        child: Image.network(
                            'assets/deshboard/adventure/adventure5.png',
                            fit: BoxFit.cover,
                            width: constraints.maxWidth,
                            height: constraints.maxHeight),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 8),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '${courseInfo
                                    .name}',
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style: TextStyleConstant
                                      .textStyleBlack16w600
                                      .copyWith(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize:
                                      (constraints.maxWidth < 900) ? Dimens.size20
                                          : (constraints.maxWidth < 1100) ? Dimens.size22
                                          : Dimens.size24,
                                      color: Colors.red),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          (constraints.maxWidth < 1100) ? Gap(Dimens.size4) :Gap(Dimens.size16),
                          Container(
                            height: (constraints.maxWidth < 1300) ? 96 : 120,
                            alignment: Alignment.center,
                            child: Text(
                              '${courseInfo.introduction} \n  \n \n \n!' ??
                                  "",
                              maxLines: (constraints.maxWidth < 550) ? 2 : (constraints.maxWidth < 1100) ? 3 : 4,
                              overflow:
                              TextOverflow.ellipsis,
                              style: TextStyleConstant
                                  .textStyleBlack16w400
                                  .copyWith(
                                fontSize: (constraints.maxWidth < 900) ? Dimens.size16
                                    : (constraints.maxWidth < 1100) ? Dimens.size18
                                    : Dimens.size20,
                                color: notifier.isDark &&
                                    isHovered
                                    ? notifier.whitecolor
                                    : notifier.isDark &&
                                    !isHovered
                                    ? notifier
                                    .blackcolor
                                    : notifier
                                    .blackcolor,
                              ),
                            ),
                          ),
                          Gap(Dimens.size16),
                          Table(
                            columnWidths: {
                              0: FlexColumnWidth(
                                  constraints.maxWidth /
                                      (3 + 0.3) *
                                      0.1),
                              1: FlexColumnWidth(
                                  constraints.maxWidth /
                                      (3 + 0.3) *
                                      0.4),
                              2: FlexColumnWidth(
                                  constraints.maxWidth /
                                      (3 + 0.3) *
                                      0.5),
                            },
                            children: [
                              TableRow(children: [
                                Column(
                                  children: [
                                    Icon(Icons.check,
                                        size: (constraints.maxWidth < 1100) ? Dimens.size16
                                            :Dimens.size24,
                                        color: Colors.red),
                                  ],
                                ),
                                Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text('Số buổi học:',
                                          style: TextStyleConstant
                                              .textStyleBlack16w400
                                              .copyWith(
                                            
                                            fontSize: (constraints.maxWidth < 1100) ? Dimens.size14
                                                :Dimens
                                                .size18,
                                            color: notifier
                                                .isDark &&
                                                isHovered
                                                ? notifier
                                                .whitecolor
                                                : notifier.isDark &&
                                                !isHovered
                                                ? notifier
                                                .blackcolor
                                                : notifier
                                                .blackcolor,
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                          ))
                                    ]),
                                Column(
                                  children: [
                                    Text(
                                      '${courseInfo.totalLectures}',
                                      style: TextStyleConstant
                                          .textStyleBlack12w400
                                          .copyWith(
                                        
                                        fontSize: (constraints.maxWidth < 1100) ? Dimens.size14
                                            : Dimens.size18,
                                        color: notifier
                                            .isDark &&
                                            isHovered
                                            ? notifier
                                            .whitecolor
                                            : notifier.isDark &&
                                            !isHovered
                                            ? notifier
                                            .blackcolor
                                            : notifier
                                            .blackcolor,
                                      ),
                                    )
                                  ],
                                )
                              ]),
                              TableRow(children: const [
                                Column(
                                  children: [
                                    Text(''),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(''),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(''),
                                  ],
                                ),
                              ]),
                              TableRow(children: [
                                Column(
                                  children: [
                                    Icon(Icons.check,
                                        size: (constraints.maxWidth < 1100) ? Dimens.size16
                                            :Dimens.size20,
                                        color: Colors.red),
                                  ],
                                ),
                                Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text('Giáo trình:',
                                          style: TextStyleConstant
                                              .textStyleBlack16w400
                                              .copyWith(
                                            
                                            fontSize: (constraints.maxWidth < 1100) ? Dimens.size14
                                                :Dimens.size18,
                                            color: notifier
                                                .isDark &&
                                                isHovered
                                                ? notifier
                                                .whitecolor
                                                : notifier.isDark &&
                                                !isHovered
                                                ? notifier
                                                .blackcolor
                                                : notifier
                                                .blackcolor,
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                          ))
                                    ]),
                                Column(
                                  children: [
                                    Text(
                                      'Emotional Chinese',
                                      style: TextStyleConstant
                                          .textStyleBlack12w400
                                          .copyWith(
                                        
                                        fontSize: (constraints.maxWidth < 1100) ? Dimens.size14
                                            : Dimens.size18,
                                        color: notifier
                                            .isDark &&
                                            isHovered
                                            ? notifier
                                            .whitecolor
                                            : notifier.isDark &&
                                            !isHovered
                                            ? notifier
                                            .blackcolor
                                            : notifier
                                            .blackcolor,
                                      ),
                                    )
                                  ],
                                )
                              ]),
                            ],
                          ),
                          (constraints.maxWidth < 550)  ? Gap(Dimens.size8) : Gap(Dimens.size24),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .center,
                                  children: [
                                    StarRating(
                                      rating: (courseInfo
                                          .ratePoint ??
                                          0)
                                          .toDouble(),
                                      allowHalfRating: true,
                                      onRatingChanged:
                                          (rating) {},
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      color: notifier
                                          .isDark &&
                                          isHovered
                                          ? notifier
                                          .whitecolor
                                          : notifier.isDark &&
                                          !isHovered
                                          ? notifier
                                          .blackcolor
                                          : notifier
                                          .blackcolor,
                                    ),
                                    Text(
                                        NumberHelper()
                                            .numberToString(
                                            courseInfo
                                                .payment,
                                            decimalDigits:
                                            0)
                                            .trim(),
                                        style: baseStyle.copyWith(
                                            overflow: TextOverflow.ellipsis,
                                            color: notifier
                                                .isDark &&
                                                isHovered
                                                ? notifier
                                                .whitecolor
                                                : notifier.isDark &&
                                                !isHovered
                                                ? notifier
                                                .blackcolor
                                                : notifier
                                                .blackcolor,
                                            fontSize:  constraints.maxWidth < 550
                                                ? constraints.maxWidth / 20
                                                : constraints.maxWidth < 700
                                                ? constraints.maxWidth / 35
                                                : constraints.maxWidth < 900
                                                ? constraints.maxWidth / 40
                                                : constraints.maxWidth < 1100
                                                ? constraints.maxWidth / 50
                                                : constraints.maxWidth < 1300
                                                ? constraints.maxWidth / 65
                                                : constraints.maxWidth / 100)),
                                    Text(
                                        " (${L10nX.getStr.vnd_str})",
                                        style: TextStyleConstant
                                            .textStyleBlack16w400
                                            .copyWith(
                                            color: notifier
                                                .isDark &&
                                                isHovered
                                                ? notifier
                                                .whitecolor
                                                : notifier.isDark &&
                                                !isHovered
                                                ? notifier
                                                .blackcolor
                                                : notifier
                                                .blackcolor,
                                            fontSize: constraints.maxWidth < 550
                                                ? constraints.maxWidth / 30
                                                : constraints.maxWidth < 700
                                                ? constraints.maxWidth / 35
                                                : constraints.maxWidth < 900
                                                ? constraints.maxWidth / 45
                                                : constraints.maxWidth < 1100
                                                ? constraints.maxWidth / 60
                                                : constraints.maxWidth < 1300
                                                ? constraints.maxWidth / 80
                                                : constraints.maxWidth / 110)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding:
                        EdgeInsets.all((constraints.maxWidth < 1100) ? Dimens.size4
                            :Dimens.size16),
                        child: Center(
                          child: ActionButton1(
                            onTap: () {},
                            //contentPadding: EdgeInsets.symmetric(horizontal: Dimens.size24),
                            text: L10nX.getStr.register_now,
                            width: Dimens.size200,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
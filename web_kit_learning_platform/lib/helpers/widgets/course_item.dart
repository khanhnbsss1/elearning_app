import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/helpers/widgets/my_screen_media_type.dart';
import 'package:webkit/landing_page/components/colornotifier.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import '../../base/widgets/text/read_more_text_custom.dart';

class CourseItem extends StatelessWidget {
  CourseItem({required this.constraints, required this.courseInfo, isGirdView});

  bool isGirdView = false;
  BoxConstraints constraints;
  CourseInfo courseInfo;
  late ColorNotifier notifier;

  @override
  Widget build(BuildContext context) {
    MyScreenMediaType type;
    notifier = Provider.of<ColorNotifier>(context, listen: true);

    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
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
                  constraints: BoxConstraints(
                    maxHeight: (constraints.maxWidth < 550)
                        ? 650
                        : (constraints.maxWidth < 1100)
                            ? 850
                            : (constraints.maxWidth < 1300)
                                ? 900
                                : 1300,
                    minWidth: constraints.maxWidth < 576
                        ? constraints.maxWidth - 8
                        : 350,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 2,
                            color:
                                (isHovered) ? Colors.red : notifier.whitecolor,
                          )),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (courseInfo.image!.isNotEmpty)
                              ? SizedBox(
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      courseInfo.image!,
                                      //"https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
                                      fit: BoxFit.contain,
                                      //width: constraints.maxWidth * 2,
                                      //  height: constraints.maxWidth
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      'assets/deshboard/adventure/adventure5.png',
                                      fit: BoxFit.contain,
                                      width: constraints.maxWidth,
                                      //height: constraints.maxHeight
                                    ),
                                  ),
                                ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 8),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${courseInfo.name}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyleConstant.titleMedium
                                          .copyWith(color: Colors.red),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              (constraints.maxWidth < 1100)
                                  ? Gap(Dimens.size4)
                                  : Gap(Dimens.size16),
                              Container(
                                height:
                                    (constraints.maxWidth < 1300) ? 96 : 120,
                                alignment: Alignment.center,
                                child: SingleChildScrollView(
                                  child: ReadMoreText(
                                    ("${(courseInfo.introduction)} ") ?? "",
                                    trimMode: TrimMode.Line,
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimCollapsedText: "  ${L10nX.getStr.show_more}",
                                    trimExpandedText: L10nX.getStr.show_less,
                                    style: TextStyleConstant.bodyLarge.copyWith(
                                      color: notifier.isDark && isHovered
                                          ? notifier.whitecolor
                                          : notifier.isDark && !isHovered
                                              ? notifier.blackcolor
                                              : notifier.blackcolor,
                                    ),
                                  ),
                                ),
                                // Text(
                                //   '${courseInfo.introduction} \n  \n \n \n!' ??
                                //       "",
                                //   maxLines: (constraints.maxWidth < 550) ? 2 : (constraints.maxWidth < 1100) ? 3 : 4,
                                //   overflow:
                                //   TextOverflow.ellipsis,
                                //   style: TextStyleConstant
                                //       .textStyleBlack16w400
                                //       .copyWith(
                                //     fontSize: (constraints.maxWidth < 900) ? Dimens.size16
                                //         : (constraints.maxWidth < 1100) ? Dimens.size18
                                //         : Dimens.size20,
                                //     color: notifier.isDark &&
                                //         isHovered
                                //         ? notifier.whitecolor
                                //         : notifier.isDark &&
                                //         !isHovered
                                //         ? notifier
                                //         .blackcolor
                                //         : notifier
                                //         .blackcolor,
                                //   ),
                                // ),
                              ),
                              Gap(Dimens.size16),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                          children: [
                                            Icon(Icons.check,
                                                size: (constraints.maxWidth <
                                                        1100)
                                                    ? Dimens.size20
                                                    : Dimens.size20,
                                                color: Colors.red),
                                            Gap(Dimens.size8),
                                            Text('Số buổi học:',
                                                style: TextStyleConstant
                                                    .bodyLarge
                                                    .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: notifier.isDark &&
                                                          isHovered
                                                      ? notifier.whitecolor
                                                      : notifier.isDark &&
                                                              !isHovered
                                                          ? notifier.blackcolor
                                                          : notifier.blackcolor,
                                                )),
                                            Gap(Dimens.size4),
                                          ]),
                                    ],
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            '${courseInfo.totalLectures}',
                                            style: TextStyleConstant.bodyLarge
                                                .copyWith(
                                              color: notifier.isDark && isHovered
                                                  ? notifier.whitecolor
                                                  : notifier.isDark && !isHovered
                                                      ? notifier.blackcolor
                                                      : notifier.blackcolor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          // Spacer(),
                          Gap(Dimens.size16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              StarRating(
                                rating:
                                (courseInfo.ratePoint ?? 0).toDouble(),
                                allowHalfRating: false,
                                onRatingChanged: (rating) {},
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      "${NumberHelper().numberToString(courseInfo.payment, decimalDigits: 0).trim()}(${L10nX.getStr.vnd_str})",
                                      style: TextStyleConstant.titleSmall
                                          .copyWith(
                                        color: notifier.isDark && isHovered
                                            ? notifier.whitecolor
                                            : notifier.isDark && !isHovered
                                            ? notifier.blackcolor
                                            : notifier.blackcolor,
                                      ))
                                ],
                              )
                            ],
                          ),
                          Gap(Dimens.size16),
                          Padding(
                            padding: EdgeInsets.all(
                                (constraints.maxWidth < 1100)
                                    ? Dimens.size4
                                    : Dimens.size16),
                            child: Center(
                              child: ActionButton1(
                                onTap: () {
                                  AppPages.routeName(Routes.courseList);
                                },
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
      },
    );
  }
}

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
              padding: EdgeInsets.only(right: 16),
              child: Card(
                color: isHovered && !notifier.isDark
                    ? ColorConst.onHoverColor
                    : isHovered && notifier.isDark
                        ? ColorConst.backGroundColor
                        : notifier.whitecolor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: isHovered && !notifier.isDark
                        ? ColorConst.onHoverColor
                        : isHovered && notifier.isDark
                            ? ColorConst.backGroundColor
                            : notifier.whitecolor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  width: Dimens.size300,
                  clipBehavior: Clip.hardEdge,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 2,
                            color:
                                (isHovered) ? Colors.red : notifier.whitecolor,
                          )),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: Dimens.size120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: (courseInfo.image!.isNotEmpty)
                                            ? Image.network(
                                                courseInfo.image!,
                                                fit: BoxFit.cover,
                                                //width: constraints.maxWidth * 2,
                                                //  height: constraints.maxWidth
                                              )
                                            : Image.asset(
                                                'assets/deshboard/adventure/adventure5.png',
                                                fit: BoxFit.cover,
                                                // width: constraints.maxWidth,
                                                //height: constraints.maxHeight
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(Dimens.size8),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${courseInfo.name}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyleConstant.textStyleBlack18w600
                                      .copyWith(color: Colors.red),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          Gap(Dimens.size16),
                          Expanded(
                            child: Center(
                              child: (courseInfo.introduction != "") ? ReadMoreText(
                                ("${(courseInfo.introduction)} ") ?? "",
                                trimMode: TrimMode.Line,
                                trimLines: 4,
                                colorClickableText: Colors.pink,
                                trimCollapsedText:
                                    "  ${L10nX.getStr.show_more}",
                                trimExpandedText: L10nX.getStr.show_less,
                                style: TextStyleConstant
                                    .textStyleBlack14w400
                                    .copyWith(
                                  color: notifier.isDark && isHovered
                                      ? notifier.whitecolor
                                      : notifier.isDark && !isHovered
                                          ? notifier.blackcolor
                                          : notifier.blackcolor,
                                ),
                              ) : Placeholder(),
                            ),
                          ),
                          Column(
                            children: [
                              Gap(Dimens.size16),
                              Row(
                                  children: [
                                Icon(Icons.check,
                                    size: (constraints.maxWidth < 1100)
                                        ? Dimens.size20
                                        : Dimens.size20,
                                    color: Colors.red),
                                Gap(Dimens.size8),
                                Text('Số buổi học: ${courseInfo.totalLectures}',
                                    style: TextStyleConstant
                                        .textStyleBlack16w500
                                        .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: notifier.isDark && isHovered
                                          ? notifier.whitecolor
                                          : notifier.isDark && !isHovered
                                          ? notifier.blackcolor
                                          : notifier.blackcolor,
                                    )),
                              ]),
                              Gap(Dimens.size16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  StarRating(
                                    rating: (courseInfo.rating ?? 0).toDouble(),
                                    allowHalfRating: false,
                                    onRatingChanged: (rating) {},
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          "${NumberHelper().numberToString(courseInfo.price, decimalDigits: 0).trim()}(${L10nX.getStr.vnd_str})",
                                          style: TextStyleConstant
                                              .textStyleBlack16w500
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
                              Center(
                                child: ActionButton1(
                                  onTap: () {
                                    AppPages.routeName(Routes.courseList);
                                  },
                                  text: L10nX.getStr.register_now,
                                  width: Dimens.size200,
                                ),
                              ),
                            ],
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

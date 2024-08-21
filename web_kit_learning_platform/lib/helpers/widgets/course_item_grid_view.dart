import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/landing_page/components/colornotifier.dart';
import '../../services/apis/course/course_detail/models/course_detail_model.dart';

enum CourseItemAction { viewDetail, edit, delete, study }
class CourseItemGridView extends StatelessWidget {
  CourseItemGridView({
    required this.courseInfo,
    this.enableEdit,
    this.onViewDetail,
    this.onDelete,
    this.onEdit,
    this.onStudy,
    this.row
  }) {
    enableEdit ??= false;
  }

  CourseInfo courseInfo;
  bool? enableEdit;
  int? row;
  Function(CourseInfo)? onEdit, onDelete, onViewDetail, onStudy;
  late ColorNotifier notifier;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    enableEdit = (enableEdit??false)&& UserManager().userContainPermission(
        permissionList: [
          "courses.post.create_course",
          "courses.put.update_course",
        ]);
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return InkWell(
      onTap: () {
        if (onViewDetail != null) {
          onViewDetail!(courseInfo);
        }
      },
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return OnHoverWidget(
            builder: (isHovered) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    decoration: BoxDecoration(
                        color: isHovered && !notifier.isDark
                        // ? Color.fromRGBO(255, 243, 94, 1.0)
                            ? Color.fromRGBO(252, 173, 106, 1.0)
                            : isHovered && notifier.isDark
                            ? ColorConst.backGroundColor
                            : notifier.whitecolor,
                        borderRadius: BorderRadius.circular(Dimens.size16),
                        border: Border.all(
                            color: ColorConst.greyColor,
                            width: 0.1
                        )
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                        children: [
                          Visibility(
                            visible: constraints.maxWidth< Dimens.size370 && row!=1,
                              child:  Padding(
                                padding:  EdgeInsets.all(Dimens.size8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(Dimens.size16),
                                                child: Image.network(
                                                  (courseInfo.image??'').isNotEmpty
                                                      ? (courseInfo.image??"")
                                                      : 'assets/deshboard/adventure/adventure5.png',
                                                  fit: BoxFit.cover,
                                                  //height: 120,
                                                  errorBuilder:
                                                      (context, error, stackTrace) {
                                                    return Image.network(
                                                      'assets/deshboard/adventure/adventure5.png',
                                                      fit: BoxFit.cover,
                                                      //height: 150,
                                                    );
                                                  },
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          height: Dimens.size12,
                                        ),
                                        Text(
                                          '${courseInfo.name} \n' ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyleConstant.textStyleBlack14w500.copyWith(
                                              fontSize: Dimens.size14,
                                              color:ColorConst.mainColor),
                                          maxLines: 1,
                                        ),
                                        Gap(Dimens.size8),
                                        Text(
                                          '${courseInfo.totalLectures} bài giảng - ${courseInfo.gradeName ?? ""}',
                                          style: TextStyleConstant
                                              .textStyleBlack12w400.copyWith(
                                            color: notifier.subgreycolor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        Gap(Dimens.size8),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Wrap(
                                              runAlignment: WrapAlignment.spaceBetween,
                                              alignment: WrapAlignment.spaceBetween,
                                              spacing: Dimens.size5,
                                              runSpacing: Dimens.size5,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    StarRating(
                                                      rating: (courseInfo.rating ?? 0).toDouble(),
                                                      size: Dimens.size15,
                                                      allowHalfRating: true,
                                                      onRatingChanged: (rating) {},
                                                    ),
                                                  ],
                                                ),
                                                Text(" ${NumberHelper().numberToString(
                                                    courseInfo.price,
                                                    decimalDigits: 0).trim()} (${L10nX.getStr.vnd_str})",
                                                    style: TextStyleConstant.textStyleBlack12w200.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      // fontSize: ResponsiveInfo.isPhone()?Dimens.size16: width < 1300  ? Dimens.size10 :Dimens.size15,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),),
                          Visibility(
                            visible: constraints.maxWidth>=Dimens.size370 || row ==1,
                            child:  Padding(
                              padding:  EdgeInsets.all(Dimens.size8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Dimens.size100,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(Dimens.size8),
                                        child: Image.network(
                                          courseInfo.image!.isNotEmpty
                                              ? courseInfo.image!
                                              : 'assets/deshboard/adventure/adventure5.png',
                                          fit: BoxFit.fill,
                                          //height: 120,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.network(
                                              'assets/deshboard/adventure/adventure5.png',
                                              fit: BoxFit.fill,
                                              //height: 150,
                                            );
                                          },
                                        )),
                                  ),
                                  Gap(Dimens.size8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '${courseInfo.name} \n' ?? "",
                                          overflow: TextOverflow.visible,
                                          style: TextStyleConstant.textStyleBlack14w500.copyWith(
                                              fontSize: Dimens.size14,
                                              color:ColorConst.mainColor),
                                          maxLines: 1,
                                        ),
                                        Gap(Dimens.size8),
                                        Text(
                                          '${courseInfo.totalLectures} bài giảng - ${courseInfo.gradeName ?? ""}',
                                          style: TextStyleConstant
                                              .textStyleBlack12w400.copyWith(
                                            color: notifier.subgreycolor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Gap(Dimens.size8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                StarRating(
                                                  rating: (courseInfo.rating ?? 0).toDouble(),
                                                  size: Dimens.size15,
                                                  allowHalfRating: true,
                                                  onRatingChanged: (rating) {},
                                                ),
                                              ],
                                            ),
                                            Text(" ${NumberHelper().numberToString(
                                                courseInfo.price,
                                                decimalDigits: 0).trim()} (${L10nX.getStr.vnd_str})",
                                                style: TextStyleConstant.textStyleBlack12w200.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  // fontSize: ResponsiveInfo.isPhone()?Dimens.size16: width < 1300  ? Dimens.size10 :Dimens.size15,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(Dimens.size12)
                                ],
                              ),
                            ),),
                          Visibility(
                            visible: enableEdit??false,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorConst.whiteColor.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(Dimens.size20)
                                ),
                                
                                child: PopupMenuButton<CourseItemAction>(
                                  color: ColorConst.whiteColor,
                                  iconSize: Dimens.size15,
                                  icon: Icon(Icons.adaptive.more),
                                  tooltip: "",
                                  onSelected: (CourseItemAction item) {
                                    switch (item) {
                                      case CourseItemAction.viewDetail:
                                      // TODO: Handle this case.
                                        if (onViewDetail != null) {
                                          onViewDetail!(courseInfo);
                                        }
                                        break;
                                      case CourseItemAction.edit:
                                      // TODO: Handle this case.
                                        if (onEdit != null) {
                                          onEdit!(courseInfo);
                                        }
                                        break;
                                      case CourseItemAction.delete:
                                      // TODO: Handle this case.
                                        if (onDelete != null) {
                                          onDelete!(courseInfo);
                                        }
                                        break;
                                      case CourseItemAction.study:
                                      // TODO: Handle this case.
                                        if (onStudy != null) {
                                          onStudy!(courseInfo);
                                        }
                                    }
                                  },
                                  itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<CourseItemAction>>[
                                    PopupMenuItem<CourseItemAction>(
                                      value: CourseItemAction.viewDetail,
                                      child: Text(L10nX.getStr.detail_str),
                                    ),
                                    if(enableEdit ?? false)
                                      PopupMenuItem<CourseItemAction>(
                                        value: CourseItemAction.edit,
                                        child: Text(L10nX.getStr.edit_str),
                                      ),
                                    if(enableEdit ?? false)
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
                            ),
                          )
                        ]),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class CourseItemGridView1 extends StatelessWidget {
  CourseItemGridView1({
    required this.courseInfo,
    this.enableEdit,
    this.onViewDetail,
    this.onDelete,
    this.onEdit,
    this.onStudy,
  }) {
    enableEdit ??= false;
  }

  CourseInfo courseInfo;
  bool? enableEdit;
  Function(CourseInfo)? onEdit, onDelete, onViewDetail, onStudy;
  late ColorNotifier notifier;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return InkWell(
      onTap: () {
        if (onViewDetail != null) {
          onViewDetail!(courseInfo);
        }
      },
      child: SizedBox(
        height: Dimens.size270,
        width: Dimens.size300,
        child: StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return OnHoverWidget(
                  builder: (isHovered) {
                    return Card(
                      color: isHovered && !notifier.isDark
                          // ? Color.fromRGBO(255, 243, 94, 1.0)
                          ? Color.fromRGBO(252, 173, 106, 1.0)
                          : isHovered && notifier.isDark
                              ? ColorConst.backGroundColor
                              : notifier.whitecolor,
                      elevation: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: isHovered && !notifier.isDark
                              // ? Color.fromRGBO(255, 243, 94, 1.0)
                              ? Color.fromRGBO(252, 173, 106, 1.0)
                              : isHovered && notifier.isDark
                                  ? ColorConst.backGroundColor
                                  : notifier.whitecolor,
                          borderRadius: BorderRadius.circular(Dimens.size16),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(
                            children: [
                          Container(
                            padding: EdgeInsets.all(Dimens.size12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimens.size16),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: Dimens.size120,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(Dimens.size16),
                                            child: Image.network(
                                              courseInfo.image!.isNotEmpty
                                                  ? courseInfo.image!
                                                  : 'assets/deshboard/adventure/adventure5.png',
                                              fit: BoxFit.cover,
                                              //height: 120,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.network(
                                                  'assets/deshboard/adventure/adventure5.png',
                                                  fit: BoxFit.cover,
                                                  //height: 150,
                                                );
                                              },
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      height: Dimens.size12,
                                    ),
                                    Text(
                                      '${courseInfo.name} \n' ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyleConstant.textStyleBlack16w600.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimens.size16,
                                              color: Color.fromRGBO(
                                                  163, 20, 19, 1.0)),
                                      maxLines: 1,
                                    ),
                                    Gap(Dimens.size4),
                                    if((courseInfo.producerName??"").isNotEmpty)Text(
                                      courseInfo.producerName ?? "",
                                      maxLines: 1,
                                      style: TextStyleConstant
                                          .textStyleBlack12w400.copyWith(
                                        color: notifier.subgreycolor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${courseInfo.totalLectures} bài giảng - ${courseInfo.gradeName ?? ""}',
                                      style: TextStyleConstant
                                          .textStyleBlack12w400.copyWith(
                                        color: notifier.subgreycolor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Gap(Dimens.size4),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Wrap(
                                          runAlignment: WrapAlignment.spaceBetween,
                                          alignment: WrapAlignment.spaceBetween,
                                          spacing: Dimens.size5,
                                          runSpacing: Dimens.size5,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                StarRating(
                                                  rating: (courseInfo.rating ?? 0).toDouble(),
                                                  size: Dimens.size15,
                                                  allowHalfRating: true,
                                                  onRatingChanged: (rating) {},
                                                ),
                                              ],
                                            ),
                                            Text(" ${NumberHelper().numberToString(
                                                courseInfo.price,
                                                decimalDigits: 0).trim()} (${L10nX.getStr.vnd_str})",
                                                style: TextStyleConstant.textStyleBlack12w200.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  // fontSize: ResponsiveInfo.isPhone()?Dimens.size16: width < 1300  ? Dimens.size10 :Dimens.size15,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: enableEdit??false,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: PopupMenuButton<CourseItemAction>(
                                color: ColorConst.whiteColor,
                                iconSize: Dimens.size15,
                                icon: Icon(Icons.adaptive.more),
                                tooltip: "",
                                //icon: Icon(Icons.filter_alt_outlined, size: Dimens.size30, color: ColorConst.mainColor,),
                                onSelected: (CourseItemAction item) {
                                  switch (item) {
                                    case CourseItemAction.viewDetail:
                                      // TODO: Handle this case.
                                      if (onViewDetail != null) {
                                        onViewDetail!(courseInfo);
                                      }
                                      break;
                                    case CourseItemAction.edit:
                                      // TODO: Handle this case.
                                      if (onEdit != null) {
                                        onEdit!(courseInfo);
                                      }
                                      break;
                                    case CourseItemAction.delete:
                                      // TODO: Handle this case.
                                      if (onDelete != null) {
                                        onDelete!(courseInfo);
                                      }
                                      break;
                                    case CourseItemAction.study:
                                      // TODO: Handle this case.
                                      if (onStudy != null) {
                                        onStudy!(courseInfo);
                                      }
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<CourseItemAction>>[
                                  PopupMenuItem<CourseItemAction>(
                                    value: CourseItemAction.viewDetail,
                                    child: Text(L10nX.getStr.detail_str),
                                  ), 
                                if(enableEdit ?? false)
                                  PopupMenuItem<CourseItemAction>(
                                    value: CourseItemAction.edit,
                                    child: Text(L10nX.getStr.edit_str),
                                    ),
                                if(enableEdit ?? false)
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
                        ]),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

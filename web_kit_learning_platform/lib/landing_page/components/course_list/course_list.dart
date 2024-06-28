// ignore_for_file: camel_case_types

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/table_common/animation/onhover_widget.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/landing_page/mediaquery/mq.dart';
import 'package:webkit/services/apis/course/models/course_list_response_model.dart';

import '../colornotifier.dart';
import 'bloc/course_list_bloc.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  late ColorNotifier notifier;
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocProvider(
        create: (context) {
          return CourseListBloc(CourseListState())..add(CourseListInitEvent());
        },
        child: BlocConsumer<CourseListBloc, CourseListState>(
            listener: (context, state) {
          switch (state.blocStatus) {
            case CourseListStatus.initial:
              break;
            default:
              break;
          }
        }, builder: (BuildContext context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return buildCourseList(constraints: constraints, state: state);
            },
          );
        }));
  }

  Widget buildCourseList(
      {required BoxConstraints constraints, required CourseListState state}) {
    int lengthOfView = (state.isExpand ?? false)
        ? constraints.maxWidth < 1300
            ? 6
            : 8
        : (state.courseListLandingPageResponseModel?.data ?? []).length;
    if (lengthOfView >
        (state.courseListLandingPageResponseModel?.data ?? []).length) {
      lengthOfView =
          (state.courseListLandingPageResponseModel?.data ?? []).length;
    }

    return Column(
      children: [
        Center(
          child: Text(L10nX.getStr.courses_list,
              style: TextStyleConstant
                  .titleTextColorOnBackgroundColorStyle14w400
                  .copyWith(
                      fontSize: constraints.maxWidth < 550 ? 28 : 45,
                      color: notifier.blackcolor)),
        ),
        Center(
          child: Text(L10nX.getStr.register_to_enjoy_the_best_deals_for_you,
              style: TextStyleConstant
                  .titleTextColorOnBackgroundColorStyle14w400
                  .copyWith(
                      fontSize: constraints.maxWidth < 550 ? 18 : 20,
                      color: notifier.greycolor)),
        ),
        SizedBox(
          height: constraints.maxWidth < 550 ? 10 : 20,
        ),
        Container(
          width: constraints.maxWidth < 1300
              ? constraints.maxWidth / 0.5
              : constraints.maxWidth / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: notifier.isDark
                  ? Colors.transparent
                  : const Color(0xFFF4F5F6),
              border: Border.all(
                  color: notifier.isDark
                      ? notifier.sugestionbutton
                      : Colors.transparent)),
          child: Padding(
            padding: EdgeInsets.all(
              constraints.maxWidth < 900 ? 20 : 30,
            ),
            child: Column(
              crossAxisAlignment: constraints.maxWidth < 550
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  // height: constraints.maxWidth < 900 ? constraints.maxWidth / 0.152 : constraints.maxWidth < 1100 ? constraints.maxWidth / 0.66 : constraints.maxWidth < 1300 ? constraints.maxWidth / 1.35 : constraints.maxWidth / 1.8,
                  width: constraints.maxWidth < 900
                      ? constraints.maxWidth / 0.2
                      : constraints.maxWidth < 1300
                          ? constraints.maxWidth / 0.5
                          : constraints.maxWidth / 1.2,
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      List<Widget> listOfCourse = List.empty(growable: true);
                      double imageHeight = constraints.maxWidth < 300
                          ? constraints.maxWidth / 1.32
                          : constraints.maxWidth < 550
                              ? constraints.maxWidth / 1.30
                              : constraints.maxWidth < 750
                                  ? constraints.maxWidth / 1.26
                                  : constraints.maxWidth < 900
                                      ? constraints.maxWidth / 1.22
                                      : constraints.maxWidth < 1100
                                          ? constraints.maxWidth / 2.85
                                          : constraints.maxWidth < 1300
                                              ? constraints.maxWidth / 5
                                              : constraints.maxWidth / 6.3;
                      double imageWidth = (kIsWeb
                                  ? constraints.maxWidth / 4
                                  : constraints.maxWidth) >
                              Dimens.size300
                          ? (kIsWeb
                              ? constraints.maxWidth / 4
                              : constraints.maxWidth)
                          : Dimens.size300;
                      for (CourseLandingPageInfo courseLandingPageInfo
                          in state.courseListLandingPageResponseModel?.data ??
                              []) {
                        listOfCourse.add(OnHoverWidget(
                          builder: (isHovered) {
                            return Padding(
                              padding: (constraints.maxWidth < 500)
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
                                  height: kIsWeb ? 700 : 350,
                                  constraints: BoxConstraints(
                                    minWidth: 350,
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
                                          (courseLandingPageInfo
                                                  .image!.isNotEmpty)
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: Image.network(
                                                    courseLandingPageInfo
                                                        .image!,
                                                    fit: BoxFit.cover,
                                                    width: imageWidth * 2,
                                                    // height: imageHeight * 2 / 4
                                                  ),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: Image.network(
                                                      'assets/deshboard/adventure/adventure5.png',
                                                      fit: BoxFit.cover,
                                                      width: imageWidth,
                                                      height: imageHeight),
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
                                                  Text(
                                                    courseLandingPageInfo
                                                            .name ??
                                                        "" '\n',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyleConstant
                                                        .textStyleBlack16w600
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                Dimens.size36,
                                                            color: Colors.red),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                              Gap(Dimens.size16),
                                              Container(
                                                height: 96,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${courseLandingPageInfo.introduction} \n  \n \n \n!' ??
                                                      "",
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyleConstant
                                                      .textStyleBlack16w400
                                                      .copyWith(
                                                    fontFamily: 'gilroybold',
                                                    fontSize: Dimens.size16,
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
                                                            size: Dimens.size24,
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
                                                                fontFamily:
                                                                    'gilroybold',
                                                                fontSize: Dimens
                                                                    .size20,
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
                                                          '${courseLandingPageInfo.totalLectures}',
                                                          style: TextStyleConstant
                                                              .textStyleBlack12w400
                                                              .copyWith(
                                                            fontFamily:
                                                                'gilroybold',
                                                            fontSize:
                                                                Dimens.size20,
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
                                                            size: Dimens.size24,
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
                                                                fontFamily:
                                                                    'gilroybold',
                                                                fontSize: Dimens
                                                                    .size20,
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
                                                            fontFamily:
                                                                'gilroybold',
                                                            fontSize:
                                                                Dimens.size20,
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
                                              Gap(Dimens.size24),
                                              Row(
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
                                                        rating: (courseLandingPageInfo
                                                                    .ratePoint ??
                                                                0)
                                                            .toDouble(),
                                                        allowHalfRating: true,
                                                        onRatingChanged:
                                                            (rating) {},
                                                      ),
                                                    ],
                                                  ),
                                                  Gap(Dimens.size16),
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
                                                                  courseLandingPageInfo
                                                                      .payment,
                                                                  decimalDigits:
                                                                      0)
                                                              .trim(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'gilroysemi',
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
                                                              fontSize: constraints
                                                                          .maxWidth <
                                                                      550
                                                                  ? constraints
                                                                          .maxWidth /
                                                                      35
                                                                  : constraints
                                                                              .maxWidth <
                                                                          700
                                                                      ? constraints
                                                                              .maxWidth /
                                                                          40
                                                                      : constraints.maxWidth <
                                                                              900
                                                                          ? constraints.maxWidth /
                                                                              50
                                                                          : constraints.maxWidth < 1100
                                                                              ? constraints.maxWidth / 70
                                                                              : constraints.maxWidth < 1300
                                                                                  ? constraints.maxWidth / 90
                                                                                  : constraints.maxWidth / 110)),
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
                                                                  fontSize: constraints
                                                                              .maxWidth <
                                                                          550
                                                                      ? constraints
                                                                              .maxWidth /
                                                                          30
                                                                      : constraints.maxWidth <
                                                                              700
                                                                          ? constraints.maxWidth /
                                                                              35
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
                                            ],
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding:
                                                EdgeInsets.all(Dimens.size16),
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
                        ));
                      }
                      return Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: listOfCourse,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: constraints.maxWidth / 25,
                ),
                Center(
                  child: InkWell(
                    onTap: () {},
                    onHover: (value) {
                      setState(() {
                        isHover = value;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: isHover
                            ? (notifier.isDark
                                ? const Color(0xFF777E90)
                                : notifier.blackcolor)
                            : Colors.transparent,
                        border: Border.all(
                            color: isHover
                                ? Colors.transparent
                                : (notifier.isDark
                                    ? const Color(0xFF777E90)
                                    : Colors.grey.shade300),
                            width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'View all',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'gilroysemi',
                            color: isHover
                                ? (notifier.isDark
                                    ? const Color(0xFFFFFFFF)
                                    : notifier.whitecolor)
                                : notifier.blackcolor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

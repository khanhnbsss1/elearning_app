import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../base/constant/dimens_constant.dart';
import '../../../base/theme/text_stype_constant.dart';
import '../../../l10n/l10n_extention.dart';
import '../../mediaquery/mq.dart';
import '../colornotifier.dart';

class WhoThisCourseIsFor extends StatefulWidget {
  const WhoThisCourseIsFor({super.key});

  @override
  State<WhoThisCourseIsFor> createState() => _WhoThisCourseIsForState();
}

class _WhoThisCourseIsForState extends State<WhoThisCourseIsFor> {
  late ColorNotifier notifier;

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(children: [
      Center(
        child: Text(L10nX.getStr.who_this_course_is_for,
            style: TextStyleConstant.titleTextColorOnBackgroundColorStyle14w400
                .copyWith(
                    fontSize: width < 550 ? 28 : 45,
                    color: notifier.blackcolor)),
      ),
      Center(
        child: Text(L10nX.getStr.who_this_course_is_for_subtitle,
            style: TextStyleConstant.titleTextColorOnBackgroundColorStyle14w400
                .copyWith(
                    fontSize: width < 550 ? 18 : 20,
                    color: notifier.greycolor)),
      ),
      SizedBox(
        height: 16,
      ),
      LayoutBuilder(
        builder: (context, constraints) {
          return (width > 900)
              ? buildWhoThisCourseIsFor(constraints: constraints)
              : Column(
                  children: [
                    avatarAndComment(),
                    buildWhoThisCourseIsFor(constraints: constraints),
                  ],
                );
        },
      ),
    ]);
  }

  Widget buildWhoThisCourseIsFor({required BoxConstraints constraints}) {
    return Column(
      children: [
        Container(
          width: constraints.maxWidth < 1300
              ? constraints.maxWidth / 0.5
              : constraints.maxWidth / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: notifier.isDark
                  ? Colors.transparent
                  : const Color(0xFFF4F5F6),
              border: Border.all(
                  color: notifier.isDark
                      ? notifier.sugestionbutton
                      : Colors.transparent)),
          child: Padding(
            padding: EdgeInsets.all(width < 900 ? 20 : 40),
            child: Stack(
              children: [
                Row(
                  children: [
                    (width > 900)
                        ? Flexible(
                            flex: 4,
                            child: Image.asset(
                              'assets/deshboard/prof/prof4.png',
                              fit: BoxFit.fill,
                              width: width * 0.45,
                              height:width * 0.45,
                            ),
                          )
                        : SizedBox(),
                    (width > 900)
                        ? SizedBox(
                            width: 30,
                          )
                        : SizedBox(),
                    Flexible(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Table(
                          children: [
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Container(
                                  width: (width < 900)
                                      ? Dimens.size40
                                      : (width < 1300)
                                          ? Dimens.size50
                                          : Dimens.size60,
                                  height: (width < 900)
                                      ? Dimens.size40
                                      : (width < 1300)
                                          ? Dimens.size50
                                          : Dimens.size60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '01',
                                      style: TextStyleConstant
                                          .titleTextColorOnBackgroundColorStyle14w700
                                          .copyWith(
                                              fontSize: (width < 900)
                                                  ? Dimens.size18
                                                  : (width < 1300)
                                                      ? Dimens.size20
                                                      : Dimens.size24,
                                              fontFamily: 'gilroybold',
                                              color: notifier.whitecolor),
                                    ),
                                  ),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Container(
                                  width: (width < 900)
                                      ? Dimens.size40
                                      : (width < 1300)
                                          ? Dimens.size50
                                          : Dimens.size60,
                                  height: (width < 900)
                                      ? Dimens.size40
                                      : (width < 1300)
                                          ? Dimens.size50
                                          : Dimens.size60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '02',
                                      style: TextStyleConstant
                                          .titleTextColorOnBackgroundColorStyle14w700
                                          .copyWith(
                                              fontSize: (width < 900)
                                                  ? Dimens.size18
                                                  : (width < 1300)
                                                      ? Dimens.size20
                                                      : Dimens.size24,
                                              fontFamily: 'gilroybold',
                                              color: notifier.whitecolor),
                                    ),
                                  ),
                                ),
                              )),
                            ]),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12, top: 12, bottom: 12),
                                    child: Text(
                                      L10nX.getStr.who_this_course_is_for_table_title_1,
                                      maxLines: 2,
                                      style: TextStyleConstant
                                          .textStyleBlack16w400
                                          .copyWith(
                                        fontFamily: 'gilroybold',
                                        fontWeight: FontWeight.bold,
                                        fontSize: (width < 900)
                                            ? Dimens.size14
                                            : (width < 1300)
                                                ? Dimens.size16
                                                : Dimens.size20,
                                        color: notifier.blackcolor,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 12, bottom: 12),
                                    child: Text(
                                      L10nX.getStr.who_this_course_is_for_table_title_2,
                                      maxLines: 2,
                                      style: TextStyleConstant
                                          .textStyleBlack16w400
                                          .copyWith(
                                        fontFamily: 'gilroybold',
                                        fontWeight: FontWeight.bold,
                                        fontSize: (width < 900)
                                            ? Dimens.size14
                                            : (width < 1300)
                                                ? Dimens.size16
                                                : Dimens.size20,
                                        color: notifier.blackcolor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      L10nX.getStr.who_this_course_is_for_table_content_1,
                                      style: TextStyleConstant
                                          .textStyleBlack16w400
                                          .copyWith(
                                        fontFamily: 'gilroybold',
                                        fontSize: (width < 900)
                                            ? Dimens.size14
                                            : (width < 1300)
                                                ? Dimens.size16
                                                : Dimens.size20,
                                        color: notifier.blackcolor,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      L10nX.getStr.who_this_course_is_for_table_content_2,
                                      style: TextStyleConstant
                                          .textStyleBlack16w400
                                          .copyWith(
                                        fontFamily: 'gilroybold',
                                        fontSize: (width < 900)
                                            ? Dimens.size14
                                            : (width < 1300)
                                                ? Dimens.size16
                                                : Dimens.size20,
                                        color: notifier.blackcolor,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Container(
                                  width: (width < 900)
                                      ? Dimens.size40
                                      : (width < 1300)
                                          ? Dimens.size50
                                          : Dimens.size60,
                                  height: (width < 900)
                                      ? Dimens.size40
                                      : (width < 1300)
                                          ? Dimens.size50
                                          : Dimens.size60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '03',
                                      style: TextStyleConstant
                                          .titleTextColorOnBackgroundColorStyle14w700
                                          .copyWith(
                                              fontSize: (width < 900)
                                                  ? Dimens.size18
                                                  : (width < 1300)
                                                      ? Dimens.size20
                                                      : Dimens.size24,
                                              fontFamily: 'gilroybold',
                                              color: notifier.whitecolor),
                                    ),
                                  ),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Container(
                                  width: (width < 900)
                                      ? Dimens.size40
                                      : (width < 1300)
                                          ? Dimens.size50
                                          : Dimens.size60,
                                  height: (width < 900)
                                      ? Dimens.size40
                                      : (width < 1300)
                                          ? Dimens.size50
                                          : Dimens.size60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '04',
                                      style: TextStyleConstant
                                          .titleTextColorOnBackgroundColorStyle14w700
                                          .copyWith(
                                              fontSize: (width < 900)
                                                  ? Dimens.size18
                                                  : (width < 1300)
                                                      ? Dimens.size20
                                                      : Dimens.size24,
                                              fontFamily: 'gilroybold',
                                              color: notifier.whitecolor),
                                    ),
                                  ),
                                ),
                              )),
                            ]),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12, top: 12, bottom: 12),
                                    child: Text(
                                      L10nX.getStr.who_this_course_is_for_table_title_3,
                                      style: TextStyleConstant
                                          .textStyleBlack16w400
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'gilroybold',
                                        fontSize: (width < 900)
                                            ? Dimens.size14
                                            : (width < 1300)
                                                ? Dimens.size16
                                                : Dimens.size20,
                                        color: notifier.blackcolor,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12, top: 12, bottom: 12),
                                    child: Text(
                                      L10nX.getStr.who_this_course_is_for_table_title_4,
                                      style: TextStyleConstant
                                          .textStyleBlack16w400
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'gilroybold',
                                        fontSize: (width < 900)
                                            ? Dimens.size14
                                            : (width < 1300)
                                                ? Dimens.size16
                                                : Dimens.size20,
                                        color: notifier.blackcolor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      L10nX.getStr.who_this_course_is_for_table_content_3,
                                      maxLines: 4,
                                      style: TextStyleConstant
                                          .textStyleBlack16w400
                                          .copyWith(
                                        fontFamily: 'gilroybold',
                                        fontSize: (width < 900)
                                            ? Dimens.size14
                                            : (width < 1300)
                                                ? Dimens.size16
                                                : Dimens.size20,
                                        color: notifier.blackcolor,
                                      ),
                                      textAlign: TextAlign.justify,

                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      L10nX.getStr.who_this_course_is_for_table_content_4,
                                      maxLines: 4,
                                      style: TextStyleConstant
                                          .textStyleBlack16w400
                                          .copyWith(
                                        fontFamily: 'gilroybold',
                                        fontSize: (width < 900)
                                            ? Dimens.size14
                                            : (width < 1300)
                                                ? Dimens.size16
                                                : Dimens.size20,
                                        color: notifier.blackcolor,
                                      ),
                                      textAlign: TextAlign.justify,

                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Container(
                                  width: (width < 900)
                                      ? Dimens.size40
                                      : (width < 1300)
                                          ? Dimens.size50
                                          : Dimens.size60,
                                  height: (width < 900)
                                      ? Dimens.size40
                                      : (width < 1300)
                                          ? Dimens.size50
                                          : Dimens.size60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '05',
                                      style: TextStyleConstant
                                          .titleTextColorOnBackgroundColorStyle14w700
                                          .copyWith(
                                              fontSize: (width < 900)
                                                  ? Dimens.size18
                                                  : (width < 1300)
                                                      ? Dimens.size20
                                                      : Dimens.size24,
                                              fontFamily: 'gilroybold',
                                              color: notifier.whitecolor),
                                    ),
                                  ),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Container(
                                  width: (width < 900)
                                      ? Dimens.size40
                                      : (width < 1300)
                                          ? Dimens.size50
                                          : Dimens.size60,
                                  height: (width < 900)
                                      ? Dimens.size40
                                      : (width < 1300)
                                          ? Dimens.size50
                                          : Dimens.size60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '06',
                                      style: TextStyleConstant
                                          .titleTextColorOnBackgroundColorStyle14w700
                                          .copyWith(
                                              fontSize: (width < 900)
                                                  ? Dimens.size18
                                                  : (width < 1300)
                                                      ? Dimens.size20
                                                      : Dimens.size24,
                                              fontFamily: 'gilroybold',
                                              color: notifier.whitecolor),
                                    ),
                                  ),
                                ),
                              )),
                            ]),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 12, bottom: 12),
                                    child: Text(
                                      L10nX.getStr.who_this_course_is_for_table_title_5,
                                      style: TextStyleConstant
                                          .textStyleBlack16w400
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'gilroybold',
                                        fontSize: (width < 900)
                                            ? Dimens.size14
                                            : (width < 1300)
                                                ? Dimens.size16
                                                : Dimens.size20,
                                        color: notifier.blackcolor,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 12, bottom: 12),
                                    child: Text(
                                      L10nX.getStr.who_this_course_is_for_table_title_6,
                                      style: TextStyleConstant
                                          .textStyleBlack16w400
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'gilroybold',
                                        fontSize: (width < 900)
                                            ? Dimens.size14
                                            : (width < 1300)
                                                ? Dimens.size16
                                                : Dimens.size20,
                                        color: notifier.blackcolor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      L10nX.getStr.who_this_course_is_for_table_content_5,
                                      maxLines: 4,
                                      style: TextStyleConstant
                                          .textStyleBlack16w400
                                          .copyWith(
                                        fontFamily: 'gilroybold',
                                        fontSize: (width < 900)
                                            ? Dimens.size14
                                            : (width < 1300)
                                                ? Dimens.size16
                                                : Dimens.size20,
                                        color: notifier.blackcolor,
                                      ),
                                      textAlign: TextAlign.justify,

                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      L10nX.getStr.who_this_course_is_for_table_content_6,
                                      maxLines: 4,
                                      style: TextStyleConstant
                                          .textStyleBlack16w400
                                          .copyWith(
                                        fontFamily: 'gilroybold',
                                        fontSize: (width < 900)
                                            ? Dimens.size14
                                            : (width < 1300)
                                                ? Dimens.size16
                                                : Dimens.size20,
                                        color: notifier.blackcolor,
                                      ),
                                      textAlign: TextAlign.justify,

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                (constraints.maxWidth > 900)
                    ? Positioned(
                        top: width < 1100 ? height / 2.1 : height / 1.6,
                        left: width < 900
                            ? width / 7
                            : width < 1100
                                ? width / 8.5
                                : width < 1300
                                    ? width / 9
                                    : width / 10,
                        child: avatarAndComment())
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget avatarAndComment() {
    return (width < 900) ? Column(
        children: [
      Image.asset(
        'assets/deshboard/prof/prof4.png',
        fit: BoxFit.fill,
        width: width * 0.6,
        height: width * 0.6,
      ),
      SizedBox(height: 16,),
      Container(
        width: width / 1.5,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: notifier.isDark
              ? Colors.transparent
              : const Color(0xFFF4F5F6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Image.asset(
              //   'assets/deshboard/avatar.png',
              //   height: width < 1100 ? width / 25 : width / 28,
              // ),
              Image.asset('assets/Icons/lightbulbicon.png',
                  height: width/25, color: notifier.yellowcolor),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  L10nX.getStr.who_this_course_is_for_comment,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Dimens.size12,
                    fontFamily: 'gilroysemi',
                    fontWeight: FontWeight.bold,
                    color: notifier.textcolor,
                  ),
                ),
              ),
              SizedBox(height: 12,)
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),
    ]) : Container(
      height: width < 1100
          ? height / 3
          : width > 1600
          ? height / 4
          : height / 5,
      width: width < 1000
          ? width / 4.5
          : width > 1600
          ? width / 4.25
          : width / 4.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Image.asset(
            //   'assets/deshboard/avatar.png',
            //   height: width < 1100 ? width / 25 : width / 28,
            // ),
            Image.asset('assets/Icons/lightbulbicon.png',
                height: width/25, color: notifier.yellowcolor),
            Expanded(
              child: Text(
                L10nX.getStr.who_this_course_is_for_comment,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: width / 75,
                  fontFamily: 'gilroysemi',
                  fontWeight: FontWeight.bold,
                  color: notifier.textcolor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

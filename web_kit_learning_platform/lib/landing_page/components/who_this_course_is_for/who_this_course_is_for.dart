import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../base/constant/dimens_constant.dart';
import '../../../base/theme/colors_app.dart';
import '../../../base/theme/text_stype_constant.dart';
import '../../../l10n/l10n_extention.dart';
import '../../mediaquery/mq.dart';
import '../colornotifier.dart';

class WhoThisCourseIsFor extends StatefulWidget {
  @override
  State<WhoThisCourseIsFor> createState() => _WhoThisCourseIsForState();
}

class _WhoThisCourseIsForState extends State<WhoThisCourseIsFor>
    with AutomaticKeepAliveClientMixin {
  late ColorNotifier notifier;

  final double splitScreenWidth = 1050;

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(children: [
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: const [
              Colors.white,
              Color.fromRGBO(246, 122, 122, 1.0),
            ])),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return (width > splitScreenWidth)
                ? buildWhoThisCourseIsFor(constraints: constraints)
                : Column(
                    children: [
                      avatarAndComment(),
                      buildWhoThisCourseIsFor(constraints: constraints),
                    ],
                  );
          },
        ),
      ),
    ]);
  }

  Widget buildWhoThisCourseIsFor({required BoxConstraints constraints}) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Column(
          children: [
            Container(
              width: constraints.maxWidth < 1300
                  ? constraints.maxWidth / 0.5
                  : constraints.maxWidth / 1.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  // color: notifier.isDark
                  //     ? Colors.transparent
                  //     : const Color(0xFFF4F5F6),
                  border: Border.all(
                      color: notifier.isDark
                          ? notifier.sugestionbutton
                          : Colors.transparent)),
              child: Padding(
                padding: EdgeInsets.all(width < 1050 ? 16 : 40),
                child: Column(
                  children: [
                    (width > splitScreenWidth)
                        ? Center(
                            child: Text(L10nX.getStr.who_this_course_is_for,
                                textAlign: TextAlign.center,
                                style: TextStyleConstant.titleTextColorOnBackgroundColorStyle14w400
                                    .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: constraints.maxWidth < 550 ? 28 : 45,
                                    color: notifier.blackcolor)),
                          )
                        : SizedBox(),
                    (width > splitScreenWidth)
                        ? Center(
                            child: Text(
                                L10nX.getStr.who_this_course_is_for_subtitle,
                                style: TextStyleConstant.titleSmall.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: ColorConst.blackColor45)),
                          )
                        : SizedBox(),
                    (width > splitScreenWidth)
                        ? SizedBox(
                            height: 16,
                          )
                        : SizedBox(),
                    Row(
                      children: [
                        (width > splitScreenWidth)
                            ? Stack(children: [
                                Flexible(
                                  child: Container(
                                    width: width * 0.35,
                                    height: width * 0.35,
                                    constraints: BoxConstraints(
                                      minWidth: 450,
                                      minHeight: 450,
                                    ),
                                    child: Image.asset(
                                      'assets/deshboard/prof/prof4.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                (constraints.maxWidth > splitScreenWidth)
                                    ? Positioned(
                                        bottom: 0,
                                        left: width < 1100
                                            ? (width * 0.35 - width / 4.5) / 2
                                            : width < 1600
                                                ? (width * 0.35 - width / 3.5) /
                                                    2
                                                : (width * 0.35 - width / 3.75) / 2,
                                        child: avatarAndComment())
                                    : SizedBox(),
                              ])
                            : SizedBox(),
                        (width > 900)
                            ? SizedBox(
                                width: 30,
                              )
                            : SizedBox(),
                        Flexible(
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
                                          style: TextStyleConstant.bodyLarge
                                              .copyWith(
                                                  color: ColorConst.whiteColor),
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
                                          style: TextStyleConstant.bodyLarge
                                              .copyWith(
                                                  color: ColorConst.whiteColor),
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
                                          L10nX.getStr
                                              .who_this_course_is_for_table_title_1,
                                          maxLines: 2,
                                          style: TextStyleConstant.titleSmall
                                              .copyWith(
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
                                          L10nX.getStr
                                              .who_this_course_is_for_table_title_2,
                                          maxLines: 2,
                                          style: TextStyleConstant.titleSmall
                                              .copyWith(
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
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Text(
                                          L10nX.getStr
                                              .who_this_course_is_for_table_content_1,
                                          style: TextStyleConstant.bodyLarge
                                              .copyWith(
                                            color: ColorConst.blackColor,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Text(
                                          L10nX.getStr
                                              .who_this_course_is_for_table_content_2,
                                          style: TextStyleConstant.bodyLarge
                                              .copyWith(
                                            color: ColorConst.blackColor,
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
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
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
                                          style: TextStyleConstant.bodyLarge
                                              .copyWith(
                                                  color: ColorConst.whiteColor),
                                        ),
                                      ),
                                    ),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
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
                                          style: TextStyleConstant.bodyLarge
                                              .copyWith(
                                                  color: ColorConst.whiteColor),
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
                                          L10nX.getStr
                                              .who_this_course_is_for_table_title_3,
                                          style: TextStyleConstant.titleSmall
                                              .copyWith(
                                            color: ColorConst.blackColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12, top: 12, bottom: 12),
                                        child: Text(
                                          L10nX.getStr
                                              .who_this_course_is_for_table_title_4,
                                          style: TextStyleConstant.titleSmall
                                              .copyWith(
                                            color: ColorConst.blackColor,
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
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Text(
                                          L10nX.getStr
                                              .who_this_course_is_for_table_content_3,
                                          style: TextStyleConstant.bodyLarge
                                              .copyWith(
                                            color: ColorConst.blackColor,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Text(
                                          L10nX.getStr
                                              .who_this_course_is_for_table_content_4,
                                          style: TextStyleConstant.bodyLarge
                                              .copyWith(
                                            color: ColorConst.blackColor,
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
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
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
                                          style: TextStyleConstant.bodyLarge
                                              .copyWith(
                                                  color: ColorConst.whiteColor),
                                        ),
                                      ),
                                    ),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
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
                                          style: TextStyleConstant.bodyLarge
                                              .copyWith(
                                                  color: ColorConst.whiteColor),
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
                                          L10nX.getStr
                                              .who_this_course_is_for_table_title_5,
                                          style: TextStyleConstant.titleSmall
                                              .copyWith(
                                            color: ColorConst.blackColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16, top: 12, bottom: 12),
                                        child: Text(
                                          L10nX.getStr
                                              .who_this_course_is_for_table_title_6,
                                          style: TextStyleConstant.titleSmall
                                              .copyWith(
                                            color: ColorConst.blackColor,
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
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Text(
                                          L10nX.getStr
                                              .who_this_course_is_for_table_content_5,
                                          style: TextStyleConstant.bodyLarge
                                              .copyWith(
                                            color: ColorConst.blackColor,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Text(
                                          L10nX.getStr
                                              .who_this_course_is_for_table_content_6,
                                          style: TextStyleConstant.bodyLarge
                                              .copyWith(
                                            color: ColorConst.blackColor,
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
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget avatarAndComment() {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) { 
      return  StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return (width < splitScreenWidth)
              ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                // color: notifier.isDark
                //     ? Colors.transparent
                //     : const Color(0xFFF4F5F6),
                border: Border.all(
                    color: notifier.isDark
                        ? notifier.sugestionbutton
                        : Colors.transparent)),
            child: Column(children: [
              Center(
                child: Text(L10nX.getStr.who_this_course_is_for,
                    style: TextStyleConstant.titleTextColorOnBackgroundColorStyle14w400
                        .copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: constraints.maxWidth < 550 ? 28 : 45,
                        color: ColorConst.blackColor)),
              ),
              Center(
                child: Text(L10nX.getStr.who_this_course_is_for_subtitle,
                    style: TextStyleConstant.titleSmall
                        .copyWith(color: ColorConst.blackColor45)),
              ),
              SizedBox(
                height: 16,
              ),
              Image.asset(
                'assets/deshboard/prof/prof4.png',
                fit: BoxFit.fill,
                width: width * 0.6,
                height: width * 0.6,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: width / 1.5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.black12,
                  // color: notifier.isDark
                  //     ? Colors.transparent
                  //     : const Color(0xFFF4F5F6),
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
                          height: width / 25, color: notifier.yellowcolor),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          L10nX.getStr.who_this_course_is_for_comment,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConstant.titleSmall.copyWith(
                            color: ColorConst.blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ]),
          )
              : Container(
            height: width < 1100
                ? height / 4
                : width < 1600
                ? height / 5
                : height / 6,
            width: width < 1100
                ? width / 4.5
                : width < 1600
                ? width / 3.5
                : width / 3.75,
            constraints: BoxConstraints(minWidth: 300),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.black12,
              // color: notifier.isDark
              //     ? Colors.transparent
              //     : const Color(0xFFF4F5F6),
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
                      height: width / 25, color: notifier.yellowcolor),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      L10nX.getStr.who_this_course_is_for_comment,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConstant.titleSmall.copyWith(
                        color: ColorConst.blackColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
          );
        },
      );
    },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

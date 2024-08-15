// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/landing_page/mediaquery/mq.dart';
import 'package:readmore/readmore.dart';
import 'package:webkit/plugins/screenshot/lib/screenshot.dart';
import 'package:webkit/services/apis/landing_page/review/models/landing_page_review_list_response_model.dart';

import '../colornotifier.dart';
import 'bloc/review_list_bloc.dart';

class ReviewList extends StatefulWidget {
  ReviewList({super.key, required this.typeName});

  final UserTypeName typeName;

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList>
    with AutomaticKeepAliveClientMixin {
  late ColorNotifier notifier;
  int b = 9;

  bool isHover = false;
  ScrollController scrollCont = PageController();
  bool scrollHover = false;
  bool scrollHover2 = false;

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: ColorConst.whiteColor,
        image: DecorationImage(
            image: AssetImage('assets/deshboard/landingpage6.jpg'),
            fit: (width < 1100) ? BoxFit.contain : BoxFit.fill),
      ),
      // color: Colors.green,
      child: BlocProvider(
          create: (context) {
            return ReviewListBloc(ReviewListState(typeName: widget.typeName))
              ..add(ReviewListInitEvent());
          },
          child: BlocConsumer<ReviewListBloc, ReviewListState>(
              listener: (context, state) {
            switch (state.blocStatus) {
              case ReviewListStatus.initial:
                break;
              default:
                break;
            }
          }, builder: (BuildContext context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return buildReviewList(constraints: constraints, state: state);
              },
            );
          })),
    );
  }

  Widget buildReviewList(
      {required BoxConstraints constraints, required ReviewListState state}) {
    int lengthOfView = (state.isExpand ?? false)
        ? constraints.maxWidth < 1300
            ? 6
            : 8
        : (state.reviewListLandingPageResponseModel?.data ?? []).length;
    if (lengthOfView >
        (state.reviewListLandingPageResponseModel?.data ?? []).length) {
      lengthOfView =
          (state.reviewListLandingPageResponseModel?.data ?? []).length;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: constraints.maxWidth < 1300
                ? constraints.maxWidth / 0.5
                : constraints.maxWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                constraints.maxWidth < 550 ? 20 : 45,
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                        state.typeName == UserTypeName.teacher
                            ? L10nX.getStr.teacher_review_list_str
                            : L10nX.getStr.student_review_list_str,
                        textAlign: TextAlign.center,
                        style: TextStyleConstant
                            .titleTextColorOnBackgroundColorStyle14w400
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: constraints.maxWidth < 550 ? 28 : 45,
                                color: notifier.blackcolor)),
                  ),
                  SizedBox(
                    height: constraints.maxWidth < 550 ? 10 : 20,
                  ),
                  SizedBox(
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        List<Widget> listOfReview = List.empty(growable: true);
                        for (ReviewLandingPageInfo reviewLandingPageInfo
                            in state.reviewListLandingPageResponseModel?.data ??
                                []) {
                          listOfReview.add(
                            (state.typeName == UserTypeName.user)
                                ? buildReviewItemUser(
                                    constraints: constraints,
                                    reviewLandingPageInfo:
                                        reviewLandingPageInfo,
                                    state: state)
                                : buildReviewItemTeacher(
                                    constraints: constraints,
                                    reviewLandingPageInfo:
                                        reviewLandingPageInfo,
                                    state: state),
                          );
                        }
                        return Center(
                            child: Scrollbar(
                          controller: scrollCont,
                          thumbVisibility: false,
                          trackVisibility: false,
                          child: SingleChildScrollView(
                            controller: scrollCont,
                            // physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: listOfReview,
                            ),
                          ),
                        ));
                      },
                    ),
                  ),
                  (constraints.maxWidth < 550)
                      ? const SizedBox(height: 4)
                      : const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StatefulBuilder(
                        builder: (context, setState) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 2,
                                  color: (scrollHover)
                                      ? notifier.sugestionbutton
                                      : Colors.transparent),
                            ),
                            child: InkWell(
                                hoverColor: Colors.transparent,
                                onTap: () {
                                  if (scrollCont.offset > 0) {
                                    scrollCont.animateTo(
                                      scrollCont.offset - 200,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                onHover: (val) {
                                  setState(() {
                                    scrollHover = val;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: Image.asset(
                                      'assets/Icons/arrowlefticon.png',
                                      width: 15,
                                      color: notifier.subgreycolor),
                                )),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 2,
                                  color: (scrollHover2)
                                      ? notifier.sugestionbutton
                                      : Colors.transparent),
                            ),
                            child: InkWell(
                                hoverColor: Colors.transparent,
                                onTap: () {
                                  if (scrollCont.offset <
                                      scrollCont.position.maxScrollExtent) {
                                    scrollCont.animateTo(
                                      scrollCont.offset + 200,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                onHover: (val) {
                                  setState(() {
                                    scrollHover2 = val;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: Image.asset(
                                    'assets/Icons/arrowrighticon.png',
                                    width: 15,
                                    color: notifier.subgreycolor,
                                  ),
                                )),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildReviewItemTeacher(
      {required BoxConstraints constraints,
      required ReviewLandingPageInfo reviewLandingPageInfo,
      required ReviewListState state}) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: Container(
            width: ResponsiveInfo.isPhone() ? constraints.maxWidth / 1.2 : 600,
            // constraints: BoxConstraints(minWidth: 500),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: notifier.isDark
                  ? Colors.transparent
                  : ColorConst.whiteColor,
            ),
            child: !ResponsiveInfo.isPhone() ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: reviewLandingPageInfo.avatar!.isNotEmpty
                        ? ImageManager().getImageByUrl(
                            reviewLandingPageInfo.avatar ?? "",
                            boxFit: BoxFit.fill)
                        : Image.asset('assets/deshboard/latestdeals.png',
                            fit: BoxFit.fill),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: constraints.maxWidth < 550
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              reviewLandingPageInfo.name ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleConstant.titleSmall.copyWith(
                                color: notifier.redcolor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                  reviewLandingPageInfo.position ?? "",
                                  style:
                                      TextStyleConstant.titleSmall.copyWith(
                                    color: notifier.blackcolor,
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: constraints.maxWidth < 550 ? 0 : 8,
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight: constraints.maxWidth / 1.5),
                              child: SingleChildScrollView(
                                child: ReadMoreText(
                                  ("\"${(reviewLandingPageInfo.review! ) * 10}\" ") ??
                                      "",
                                  trimMode: TrimMode.Line,
                                  trimLines: 3,
                                  colorClickableText: Colors.pink,
                                  trimCollapsedText: L10nX.getStr.show_more,
                                  trimExpandedText: L10nX.getStr.show_less,
                                  style:
                                      TextStyleConstant.bodyLarge.copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: notifier.blackcolor,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
            : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: reviewLandingPageInfo.avatar!.isNotEmpty
                        ? ImageManager().getImageByUrl(
                        reviewLandingPageInfo.avatar ?? "",
                        boxFit: BoxFit.fill)
                        : Image.asset('assets/deshboard/latestdeals.png',
                        fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reviewLandingPageInfo.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConstant.titleSmall.copyWith(
                        color: notifier.redcolor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                          reviewLandingPageInfo.position ?? "",
                          style:
                          TextStyleConstant.titleSmall.copyWith(
                            color: notifier.blackcolor,
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8
                ),
                SizedBox(
                  height: 150,
                  child: Center(
                    child: SingleChildScrollView(
                      child: ReadMoreText(
                        ("\"${(reviewLandingPageInfo.review! ) * 10}\" ") ??
                            "",
                        trimMode: TrimMode.Line,
                        trimLines: 3,
                        colorClickableText: Colors.pink,
                        trimCollapsedText: L10nX.getStr.show_more,
                        trimExpandedText: L10nX.getStr.show_less,
                        style:
                        TextStyleConstant.bodyLarge.copyWith(
                          fontStyle: FontStyle.italic,
                          color: notifier.blackcolor,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildReviewItemUser(
      {required BoxConstraints constraints,
      required ReviewLandingPageInfo reviewLandingPageInfo,
      required ReviewListState state}) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: Container(
            height: 300,
            width: ResponsiveInfo.isPhone()
                ? constraints.maxWidth / 2
                : constraints.maxWidth / 4,
            constraints: BoxConstraints(minWidth: 250, maxWidth: 500),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: notifier.isDark
                  ? Colors.transparent
                  : ColorConst.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    width: Dimens.size100,
                    height: Dimens.size100,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(Dimens.size100 / 2),
                      child: reviewLandingPageInfo.avatar!.isNotEmpty
                          ? ImageManager().getImageByUrl(
                              reviewLandingPageInfo.avatar ?? "",
                              boxFit: BoxFit.contain)
                          : Image.asset('assets/deshboard/latestdeals.png',
                              fit: BoxFit.contain),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reviewLandingPageInfo.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConstant.bodyLarge.copyWith(
                        color: notifier.redcolor,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(reviewLandingPageInfo.position ?? "",
                          style: TextStyleConstant.bodySmall.copyWith(
                            fontWeight: fontWeight400,
                            color: notifier.greycolor,
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                SizedBox(
                  height: constraints.maxWidth < 550 ? 0 : 8,
                ),
                Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                                          child: ReadMoreText(
                      ("\"${("${reviewLandingPageInfo.review!} ") * 20}\"") ?? "",
                      trimMode: TrimMode.Line,
                      trimLines: 3,
                      colorClickableText: Colors.pink,
                      trimCollapsedText: L10nX.getStr.show_more,
                      trimExpandedText: L10nX.getStr.show_less,
                      style: TextStyleConstant.bodyLarge.copyWith(
                        fontStyle: FontStyle.italic,
                        color: notifier.blackcolor,
                      ),
                      textAlign: TextAlign.justify,
                                          ),
                                        ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

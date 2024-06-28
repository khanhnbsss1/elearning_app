// ignore_for_file: camel_case_types

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/table_common/animation/onhover_widget.dart';
import 'package:webkit/landing_page/mediaquery/mq.dart';
import 'package:webkit/services/apis/course/models/course_list_response_model.dart';
import 'package:webkit/services/apis/review/models/review_list_response_model.dart';
import 'package:readmore/readmore.dart';

import '../colornotifier.dart';
import 'bloc/review_list_bloc.dart';

class ReviewList extends StatefulWidget {
  ReviewList({super.key, required this.typeName});

  UserTypeName typeName;

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  late ColorNotifier notifier;
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocProvider(
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
        }));
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
          child: Text(
              state.typeName == UserTypeName.teacher
                  ? L10nX.getStr.teacher_review_list_str
                  : L10nX.getStr.student_review_list_str,
              style: TextStyleConstant
                  .titleTextColorOnBackgroundColorStyle14w400
                  .copyWith(
                      fontSize: constraints.maxWidth < 550 ? 28 : 45,
                      color: notifier.blackcolor)),
        ),
        SizedBox(
          height: constraints.maxWidth < 550 ? 10 : 20,
        ),
        Center(
          child: Container(
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
              child: SizedBox(
                // height: constraints.maxWidth < 900 ? constraints.maxWidth / 0.152 : constraints.maxWidth < 1100 ? constraints.maxWidth / 0.66 : constraints.maxWidth < 1300 ? constraints.maxWidth / 1.35 : constraints.maxWidth / 1.8,
                width: constraints.maxWidth < 900
                    ? constraints.maxWidth / 0.2
                    : constraints.maxWidth < 1300
                        ? constraints.maxWidth / 0.5
                        : constraints.maxWidth / 1.2,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    List<Widget> listOfCourse = List.empty(growable: true);
                    for (ReviewLandingPageInfo reviewLandingPageInfo
                        in state.reviewListLandingPageResponseModel?.data ?? []) {
                      listOfCourse.add(
                        buildReviewItem(
                            constraints: constraints,
                            reviewLandingPageInfo: reviewLandingPageInfo,
                            state: state),
                      );
                    }
                    return Center(
                      child: Scrollbar(
                        thumbVisibility: false,
                        thickness: 0,
                        trackVisibility: false,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: listOfCourse,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildReviewItem(
      {required BoxConstraints constraints,
      required ReviewLandingPageInfo reviewLandingPageInfo,
      required ReviewListState state}) {
    return Container(
      width: ResponsiveInfo.isPhone()
          ? MediaQuery.of(context).size.width - Dimens.size50
          : MediaQuery.of(context).size.width / 2.4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Card(
          elevation: 5,
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color:
                  notifier.isDark ? Colors.transparent : ColorConst.whiteColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: SizedBox(
                          width: width / 1.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: reviewLandingPageInfo.avatar!.isNotEmpty
                                ? ImageManager().getImageByUrl(
                                    reviewLandingPageInfo.avatar ?? "",
                                    boxFit: BoxFit.fill)
                                : Image.asset(
                                    'assets/deshboard/latestdeals.png',
                                    fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
                    child: Container(
                      width: constraints.maxWidth / 1.35,
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
                                style: TextStyleConstant
                                    .titleTextColorOnBackgroundColorStyle16w600
                                    .copyWith(
                                        fontFamily: 'gilroysemi',
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            constraints.maxWidth < 550 ? 24 : 30),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(reviewLandingPageInfo.position ?? "",
                                  style: TextStyle(
                                    fontFamily: 'gilroybold',
                                    fontSize: 12,
                                    color: notifier.greycolor,
                                  ),
                                  textAlign: constraints.maxWidth < 550
                                      ? TextAlign.center
                                      : TextAlign.start),
                            ],
                          ),
                          SizedBox(
                            height: constraints.maxWidth < 550 ? 18 : 20,
                          ),
                          SizedBox(
                            height: 100,
                            child: SingleChildScrollView(
                              child: ReadMoreText(
                                ("${reviewLandingPageInfo.review!} ") * 10 ??
                                    "",
                                trimMode: TrimMode.Line,
                                trimLines: 2,
                                colorClickableText: Colors.pink,
                                trimCollapsedText: L10nX.getStr.show_more,
                                trimExpandedText: L10nX.getStr.show_less,
                                style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  fontSize: 16,
                                  color: notifier.blackcolor,
                                ),
                                textAlign: constraints.maxWidth < 550
                                    ? TextAlign.center
                                    : TextAlign.start,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

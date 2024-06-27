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
            },
            builder: (BuildContext context, state) {
              return LayoutBuilder(builder: (context, constraints) {
                return buildReviewList(constraints: constraints, state: state);
              },);
            }));

  }

  Widget buildReviewList({required BoxConstraints constraints, required ReviewListState state}) {
    int lengthOfView = (state.isExpand??false)? constraints.maxWidth < 1300 ? 6 : 8: (state.reviewListLandingPageResponseModel?.data??[]).length;
    if(lengthOfView> (state.reviewListLandingPageResponseModel?.data??[]).length)
      {
        lengthOfView = (state.reviewListLandingPageResponseModel?.data??[]).length;
      }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            state.typeName == UserTypeName.teacher?L10nX.getStr.teacher_review_list_str:L10nX.getStr.student_review_list_str,
            style: TextStyleConstant.textStyleBlack28w700.copyWith(fontSize: constraints.maxWidth < 550 ? 28 : 50,)
        ),
        SizedBox(height: constraints.maxWidth < 550 ? 30 : 40,),
        Container(
          width: constraints.maxWidth < 1300 ? constraints.maxWidth / 0.5 : constraints.maxWidth / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: notifier.isDark ? Colors.transparent : const Color(0xFFF4F5F6),
              border: Border.all(color: notifier.isDark ? notifier.sugestionbutton : Colors.transparent)
          ),
          child: Padding(padding: EdgeInsets.only(
              left: constraints.maxWidth < 900 ? 20 : 50,
              right: constraints.maxWidth < 900 ? 20 : 50,
              top: constraints.maxWidth < 900 ? 20 : 50,
              bottom: constraints.maxWidth < 900 ? 20 : 25),
            child: Column(
              crossAxisAlignment: constraints.maxWidth < 550 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  // height: constraints.maxWidth < 900 ? constraints.maxWidth / 0.152 : constraints.maxWidth < 1100 ? constraints.maxWidth / 0.66 : constraints.maxWidth < 1300 ? constraints.maxWidth / 1.35 : constraints.maxWidth / 1.8,
                  width: constraints.maxWidth < 900 ? constraints.maxWidth / 0.2 : constraints.maxWidth < 1300 ? constraints.maxWidth / 0.5 : constraints.maxWidth / 1.2,
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      List<Widget> listOfCourse = List.empty(growable: true);
                      for(ReviewLandingPageInfo reviewLandingPageInfo in state.reviewListLandingPageResponseModel?.data??[])
                      {
                        listOfCourse.add(buildReviewItem(constraints: constraints, reviewLandingPageInfo: reviewLandingPageInfo, state: state), 
                          
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
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget buildReviewItem({
    required BoxConstraints constraints, 
    required ReviewLandingPageInfo reviewLandingPageInfo,
    required ReviewListState state}) {
    return SizedBox(
      width: ResponsiveInfo.isPhone()? MediaQuery.of(context).size.width-Dimens.size50: MediaQuery.of(context).size.width/2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: notifier.isDark ? Colors.transparent : ColorConst.whiteColor,),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: SizedBox(
                          width: width / 1,
                          child: reviewLandingPageInfo.avatar!.isNotEmpty?
                          ImageManager().getImageByUrl(reviewLandingPageInfo.avatar??"",
                              boxFit: BoxFit.fill):
                          Image.asset('assets/deshboard/latestdeals.png',
                              fit: BoxFit.fill),
                        ),
                      ),
                      Positioned(
                        top: constraints.maxWidth < 600
                            ? constraints.maxWidth / 1.1
                            : constraints.maxWidth < 700
                            ? constraints.maxWidth / 1.07
                            : constraints.maxWidth / 1.03,
                        right: constraints.maxWidth < 550
                            ? constraints.maxWidth / 5
                            : constraints.maxWidth < 600
                            ? constraints.maxWidth / 4
                            : constraints.maxWidth < 700
                            ? constraints.maxWidth / 4
                            : constraints.maxWidth / 4,
                        child: Container(
                          height: constraints.maxWidth < 550
                              ? constraints.maxWidth / 8.3
                              : constraints.maxWidth < 600
                              ? constraints.maxWidth / 9
                              : constraints.maxWidth < 700
                              ? constraints.maxWidth / 10
                              : constraints.maxWidth / 12,
                          width: constraints.maxWidth < 550
                              ? constraints.maxWidth / 2.7
                              : constraints.maxWidth < 600
                              ? constraints.maxWidth / 3
                              : constraints.maxWidth / 3.5,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: const Color(0xFFFCFDFD),
                            gradient: const LinearGradient(
                                colors: [Color(0xFFFCFDFD), Colors.white70]),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(constraints.maxWidth < 550 ? 5 : 14),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/deshboard/avatar.png',
                                  height: constraints.maxWidth < 550 ? constraints
                                      .maxWidth / 6 : constraints.maxWidth / 20,
                                ),
                                SizedBox(width: constraints.maxWidth < 300 ? 7 : 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Antone Heller',
                                      style: TextStyle(
                                        fontSize: constraints.maxWidth < 550 ? constraints
                                            .maxWidth / 30 : constraints.maxWidth / 50,
                                        fontFamily: 'gilroysemi',
                                        color: notifier.textcolor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star_rounded,
                                            color: notifier.yellowcolor,
                                            size: constraints.maxWidth < 550 ? constraints
                                                .maxWidth / 40 : constraints.maxWidth /
                                                70),
                                        const SizedBox(width: 5),
                                        Text(
                                          '4.8',
                                          style: TextStyle(
                                              fontSize: constraints.maxWidth < 550
                                                  ? constraints.maxWidth / 50
                                                  : constraints.maxWidth / 70,
                                              fontFamily: 'gilroysemi'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      // width: constraints.maxWidth / 1.35,
                      child: Column(
                        crossAxisAlignment: constraints.maxWidth < 550
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          Text(reviewLandingPageInfo.name??"",
                            style: TextStyle(
                                fontFamily: 'gilroysemi',
                                color: notifier.blackcolor,
                                fontWeight: FontWeight.w600,
                                fontSize: constraints.maxWidth < 550 ? 28 : 38),
                            
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: constraints.maxWidth < 550 ? 10 : 20,
                          ),
                          Text(reviewLandingPageInfo.position??"",
                              style: TextStyle(
                                fontFamily: 'gilroybold',
                                fontSize: 16,
                                color: notifier.greycolor,
                              ),
                              textAlign: constraints.maxWidth < 550
                                  ? TextAlign.center
                                  : TextAlign.start),
                          SizedBox(
                            height: constraints.maxWidth < 550 ? 18 : 20,
                          ),
                          Text(
                            reviewLandingPageInfo.review??"",
                            style: TextStyle(
                                fontFamily: 'gilroysemi',
                                fontSize: 16,
                                color: notifier.subgreycolor),
                            textAlign: constraints.maxWidth < 550
                                ? TextAlign.center
                                : TextAlign.start,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
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

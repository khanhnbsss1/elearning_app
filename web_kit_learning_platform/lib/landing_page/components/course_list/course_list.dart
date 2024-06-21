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
          return CourseListBloc(CourseListState())
            ..add(CourseListInitEvent());
        },
        child: BlocConsumer<CourseListBloc, CourseListState>(
            listener: (context, state) {
              switch (state.blocStatus) {
                case CourseListStatus.initial:
                  break;
                default:
                  break;
              }
            },
            builder: (BuildContext context, state) {
              return LayoutBuilder(builder: (context, constraints) {
                return buildCourseList(constraints: constraints, state: state);
              },);
            }));

  }

  Widget buildCourseList({required BoxConstraints constraints, required CourseListState state}) {
    int lengthOfView = (state.isExpand??false)? constraints.maxWidth < 1300 ? 6 : 8: (state.courseListLandingPageResponseModel?.data??[]).length;
    if(lengthOfView> (state.courseListLandingPageResponseModel?.data??[]).length)
      {
        lengthOfView = (state.courseListLandingPageResponseModel?.data??[]).length;
      }

    return Container(
      width: constraints.maxWidth < 1300 ? constraints.maxWidth / 0.5 : constraints.maxWidth / 1.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: notifier.isDark ? Colors.transparent : const Color(0xFFF4F5F6),
          border: Border.all(color: notifier.isDark ? notifier.sugestionbutton : Colors.transparent)
      ),
      child: Padding(padding: EdgeInsets.only(left: constraints.maxWidth < 900 ? 40 : 100,right: constraints.maxWidth < 900 ? 40 : 100,top: constraints.maxWidth < 900 ? 40 : 100,bottom: constraints.maxWidth < 900 ? 40 : 50),
        child: Column(
          crossAxisAlignment: constraints.maxWidth < 550 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                L10nX.getStr.courses_list,
                style: TextStyleConstant.textStyleBlack28w700.copyWith(fontSize: constraints.maxWidth < 550 ? 28 : 50,)
            ),
            Text(
                L10nX.getStr.register_to_enjoy_the_best_deals_for_you,
                style: TextStyleConstant.textStyleBlack18w600.copyWith(fontSize: constraints.maxWidth < 550 ? 18 : 25, color: notifier.greycolor)),
            SizedBox(height: constraints.maxWidth < 550 ? 30 : 40,),
            SizedBox(
              // height: constraints.maxWidth < 900 ? constraints.maxWidth / 0.152 : constraints.maxWidth < 1100 ? constraints.maxWidth / 0.66 : constraints.maxWidth < 1300 ? constraints.maxWidth / 1.35 : constraints.maxWidth / 1.8,
              width: constraints.maxWidth < 900 ? constraints.maxWidth / 0.2 : constraints.maxWidth < 1300 ? constraints.maxWidth / 0.5 : constraints.maxWidth / 1.2,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  List<Widget> listOfCourse = List.empty(growable: true);
                  double imageHeight = constraints.maxWidth < 300 ? constraints.maxWidth / 1.32 : constraints.maxWidth <550 ? constraints.maxWidth / 1.30 : constraints.maxWidth < 750 ? constraints.maxWidth / 1.26 : constraints.maxWidth < 900 ? constraints.maxWidth / 1.22 : constraints.maxWidth < 1100 ? constraints.maxWidth / 2.85 : constraints.maxWidth < 1300 ? constraints.maxWidth / 5 : constraints.maxWidth / 6.3;
                  double imageWidth = (kIsWeb? constraints.maxWidth/4: constraints.maxWidth)> Dimens.size300? (kIsWeb? constraints.maxWidth/4: constraints.maxWidth):  Dimens.size300;
                  for(CourseLandingPageInfo courseLandingPageInfo in state.courseListLandingPageResponseModel?.data??[])
                  {
                    listOfCourse.add(
                      OnHoverWidget(
                          builder: (isHovered) {
                            return Container(
                              decoration: BoxDecoration(
                                color:isHovered ? ColorConst.onHoverColor: notifier.whitecolor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: kIsWeb? constraints.maxWidth/5: constraints.maxWidth,
                              constraints: BoxConstraints(
                                minWidth: Dimens.size300,
                              ),
                              clipBehavior: Clip.hardEdge,
                              margin: EdgeInsets.all(Dimens.size16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  (courseLandingPageInfo.image!.isNotEmpty)?
                                  Image.network(
                                      courseLandingPageInfo.image!,
                                      fit: BoxFit.cover,
                                      width: imageWidth,
                                      height: imageHeight
                                  ):
                                  Image.network(
                                      'assets/deshboard/adventure/adventure5.png',
                                      fit: BoxFit.cover,
                                      width:imageWidth ,
                                      height: imageHeight
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(Dimens.size10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              courseLandingPageInfo.language??"",
                                              textAlign: TextAlign.center,
                                              style: TextStyleConstant.textStyleBlack16w400.copyWith(
                                                  color: notifier.subgreycolor,
                                                  fontSize: constraints.maxWidth < 550 ? constraints.maxWidth / 30 : constraints.maxWidth < 700 ? constraints.maxWidth / 35 : constraints.maxWidth < 900 ? constraints.maxWidth / 50 : constraints.maxWidth < 1100 ? constraints.maxWidth / 70 : constraints.maxWidth < 1300 ? constraints.maxWidth / 80 : constraints.maxWidth / 110),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(courseLandingPageInfo.name??"",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyleConstant.textStyleBlack16w400.copyWith(
                                                fontSize: Dimens.size28,
                                                color: notifier.blackcolor,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,),
                                          ],
                                        ),
                                        Gap(Dimens.size16),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                StarRating(
                                                  rating: (courseLandingPageInfo.ratePoint??0).toDouble(),
                                                  allowHalfRating: false,
                                                  onRatingChanged: (rating) {
                              
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.attach_money, color: ColorConst.colorIconGrays,),
                                                Text(NumberHelper().numberToString(courseLandingPageInfo.payment, decimalDigits: 0).trim(),style: TextStyle(fontFamily: 'gilroysemi',color: notifier.blackcolor,fontSize: constraints.maxWidth < 550 ? constraints.maxWidth / 35 : constraints.maxWidth < 700 ? constraints.maxWidth / 40 : constraints.maxWidth < 900 ? constraints.maxWidth / 50 : constraints.maxWidth < 1100 ? constraints.maxWidth / 70 : constraints.maxWidth < 1300 ? constraints.maxWidth / 90 : constraints.maxWidth / 110)),
                                                Text(
                                                    " (${L10nX.getStr.vnd_str})",
                                                    style:TextStyleConstant.textStyleBlack16w400.copyWith(
                                                        color: notifier.blackcolor,
                                                        fontSize: constraints.maxWidth < 550 ? constraints.maxWidth / 30 : constraints.maxWidth < 700 ? constraints.maxWidth / 35 : constraints.maxWidth < 900 ? constraints.maxWidth / 45 : constraints.maxWidth < 1100 ? constraints.maxWidth / 60 : constraints.maxWidth < 1300 ? constraints.maxWidth / 80 : constraints.maxWidth / 110)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(Dimens.size16),
                                    child: Center(
                                      child:
                                      ActionButton1(
                                        onTap: () {
                              
                                        },
                                        //contentPadding: EdgeInsets.symmetric(horizontal: Dimens.size24),
                                        text: L10nX.getStr.register_now,
                                        width: Dimens.size200,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },)
                    );
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
            SizedBox(height: constraints.maxWidth / 25,),
            Center(
              child: InkWell(
                onTap: () {
    
                },
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
                    color: isHover ? (notifier.isDark ? const Color(0xFF777E90) : notifier.blackcolor) : Colors.transparent,
                    border: Border.all(color: isHover ? Colors.transparent : (notifier.isDark ? const Color(0xFF777E90) : Colors.grey.shade300),width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text('View All',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'gilroysemi',color: isHover ? (notifier.isDark ? const Color(0xFFFFFFFF) : notifier.whitecolor) : notifier.blackcolor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

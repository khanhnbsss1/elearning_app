// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/landing_page/mediaquery/mq.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/helpers/widgets/course_item.dart';

import '../colornotifier.dart';
import 'bloc/landing_page_course_list_bloc.dart';

class LandingPageCourseList extends StatefulWidget {
  const LandingPageCourseList({super.key});

  @override
  State<LandingPageCourseList> createState() => _LandingPageCourseListState();
}

class _LandingPageCourseListState extends State<LandingPageCourseList> with AutomaticKeepAliveClientMixin{
  int b = 9;
  bool scrollHover = false;
  bool scrollHover2 = false;
  late ColorNotifier notifier;
  bool isHover = false;
  ScrollController scrollCont = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollCont.addListener(() {
      b = (scrollCont.position.extentAfter/100).toInt();
    },);
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage( image: AssetImage('assets/deshboard/landingpage2.jpg'),fit: BoxFit.fill),),
      child: BlocProvider(
          create: (context) {
            return LandingPageCourseListBloc(LandingPageCourseListState())..add(LandingPageCourseListInitEvent());
          },
          child: BlocConsumer<LandingPageCourseListBloc, LandingPageCourseListState>(
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
          })),
    );
  }

  Widget buildCourseList(
      {required BoxConstraints constraints, required LandingPageCourseListState state}) {
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
        Container(
          width: constraints.maxWidth < 1300 ? constraints.maxWidth / 0.5 : constraints.maxWidth / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              // color: notifier.isDark
              //     ? Colors.transparent
              //     : const Color(0xFFF4F5F6),
              border: Border.all(
                  color: notifier.isDark
                      ? notifier.sugestionbutton
                      : Colors.transparent)),
          padding: EdgeInsets.all(
            constraints.maxWidth < 900 ? 20 : 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(L10nX.getStr.courses_list,
                    style: TextStyleConstant
                        .titleTextColorOnBackgroundColorStyle14w400
                        .copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: constraints.maxWidth < 550 ? 28 : 45,
                        color: notifier.blackcolor)),
              ),
              Center(
                child: Text(L10nX.getStr.register_to_enjoy_the_best_deals_for_you,
                    textAlign: TextAlign.center,
                    style: TextStyleConstant.titleTextColorOnBackgroundColorStyle14w400.copyWith(
                        fontSize: constraints.maxWidth < 550 ? 18 : 20,
                        color: Colors.black54)),
              ),
              SizedBox(
                height: constraints.maxWidth < 550 ? 10 : 20,
              ),
              SizedBox(
                // height: constraints.maxWidth < 900 ? constraints.maxWidth / 0.152 : constraints.maxWidth < 1100 ? constraints.maxWidth / 0.66 : constraints.maxWidth < 1300 ? constraints.maxWidth / 1.35 : constraints.maxWidth / 1.8,
                width: constraints.maxWidth < 900
                    ? constraints.maxWidth / 0.2
                    : constraints.maxWidth < 1300
                        ? constraints.maxWidth / 0.5
                        : constraints.maxWidth / 1.2,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    List<Widget> listOfCourse = List.empty(growable: true);
                    for (CourseInfo courseLandingPageInfo
                        in state.courseListLandingPageResponseModel?.data ?? []) {
                      listOfCourse.add(CourseItem(constraints: constraints, courseInfo: courseLandingPageInfo));
                    }
                    return Center(
                      child: SingleChildScrollView(
                        controller: scrollCont,
                        // physics: const NeverScrollableScrollPhysics(),
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
              (constraints.maxWidth < 550) ? const SizedBox(height: 4) :const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) setState) { 
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
                            onTap: () {
                              if (scrollCont.offset > 0) {
                                scrollCont.animateTo(
                                  scrollCont.offset - 200,
                                  duration: const Duration(milliseconds: 200),
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
                  StatefulBuilder(builder: (context, setState) {
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
                          onTap: () {
                            if (scrollCont.offset <
                                scrollCont.position.maxScrollExtent) {
                              scrollCont.animateTo(
                                scrollCont.offset + 200,
                                duration: const Duration(milliseconds: 200),
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
                  },)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive {
    return true;
  }
}

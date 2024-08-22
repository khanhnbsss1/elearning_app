// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/landing_page/teacher_list/models/landing_page_teacher_list_model.dart';

import '../colornotifier.dart';
import '../../mediaquery/mq.dart';
import 'bloc/teacher_list_bloc.dart';

class TeacherList extends StatefulWidget {
  const TeacherList({super.key});

  @override
  State<TeacherList> createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> with AutomaticKeepAliveClientMixin{
  bool isHover = false;
  bool isHover2 = false;

  bool scrollHover = false;
  bool scrollHover2 = false;
  bool viewallHover = false;
  bool imageHover = false;
  List<bool> hoverborder = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  late ColorNotifier notifier;
  PageController pg = PageController();
  ScrollController scrollCont = PageController();
  int a = 4;
  int b = 9;
  String selectedvalue2 = '';
  String selectedvalue = '';
  List type = ['month', 'year', 'day'];
  List hostplacesimage = [
    'assets/deshboard/prof/hostpic1.png',
    'assets/deshboard/prof/hostpic2.png',
    'assets/deshboard/prof/hostpic3.png',
    'assets/deshboard/prof/hostpic4.png',
    'assets/deshboard/prof/hostpic1.png',
    'assets/deshboard/prof/hostpic2.png',
    'assets/deshboard/prof/hostpic3.png',
    'assets/deshboard/prof/hostpic4.png'
  ];
  List hostimage = [
    'assets/deshboard/prof/prof1.png',
    'assets/deshboard/prof/prof2.png',
    'assets/deshboard/prof/prof3.png',
    'assets/deshboard/prof/prof4.png',
    'assets/deshboard/prof/prof1.png',
    'assets/deshboard/prof/prof2.png',
    'assets/deshboard/prof/prof3.png',
    'assets/deshboard/prof/prof4.png',
  ];
  List hostImage2 = [
    'assets/deshboard/host/f1.png',
    'assets/deshboard/host/f2.png',
    'assets/deshboard/host/f3.png',
    'assets/deshboard/host/f4.png',
    'assets/deshboard/host/f5.png',
    'assets/deshboard/host/f6.png',
    'assets/deshboard/host/f7.png',
    'assets/deshboard/host/f8.png',
    'assets/deshboard/host/f1.png',
    'assets/deshboard/host/f2.png',
    'assets/deshboard/host/f3.png',
    'assets/deshboard/host/f4.png',
    'assets/deshboard/host/f5.png',
    'assets/deshboard/host/f6.png',
    'assets/deshboard/host/f7.png',
    'assets/deshboard/host/f8.png',
  ];
  List hostrating = ['4.9', '4.8', '5.0', '4.7', '4.9', '4.8', '5.0', '4.7'];

  List<int> add = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      // color: Colors.green,
      child: BlocProvider(
          create: (context) {
            return TeacherListBloc(TeacherListState())
              ..add(TeacherListInitEvent());
          },
          child: BlocConsumer<TeacherListBloc, TeacherListState>(
              listener: (context, state) {
            switch (state.blocStatus) {
              case TeacherListStatus.initial:
                break;
              default:
                break;
            }
          }, builder: (BuildContext context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    buildListTeacher1(constraints: constraints, state: state),
                  ],
                );
              },
            );
          })),
    );
  }

  Widget buildListTeacher1(
      {required BoxConstraints constraints, required TeacherListState state}) {
    List<Widget> teacherList = List.empty(growable: true);
    for (LandingPageUserInfo landingPageUserInfo
        in state.landingPageUserListModel?.data ?? []) {
      teacherList.add(buildTeacherItem1(
          landingPageUserInfo: landingPageUserInfo, constraints: constraints));
    }
    return Column(children: [
      Container(
        width: constraints.maxWidth < 1300
            ? constraints.maxWidth / 0.5
            : constraints.maxWidth / 1.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            // color:
            //     notifier.isDark ? Colors.transparent : const Color(0xFFF4F5F6),
            border: Border.all(
                color: notifier.isDark
                    ? notifier.sugestionbutton
                    : Colors.transparent)),
        child: Padding(
            padding: EdgeInsets.all(
              constraints.maxWidth < 900 ? 20 : 30,
            ),
            child: state.landingPageUserListModel?.data?.length != null &&
                    state.landingPageUserListModel!.data!.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(L10nX.getStr.teacher_list,
                            style: TextStyleConstant.titleTextColorOnBackgroundColorStyle14w400
                                .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: constraints.maxWidth < 550 ? 28 : 45,
                                color: notifier.blackcolor)),
                      ),
                      SizedBox(
                        height: constraints.maxWidth < 550 ? 10 : 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: scrollCont,
                        child: Row(
                          children: teacherList,
                        ),
                      ),
                      (constraints.maxWidth < 550) ? const SizedBox(height: 4) :const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
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
                                      scrollCont.offset - 300,
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
                          ),
                          const SizedBox(width: 10),
                          AnimatedContainer(
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
                                      scrollCont.offset + 300,
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
                          ),
                        ],
                      )
                    ],
                  )
                : SizedBox()),
      ),
    ]);
  }

  Widget buildTeacherItem1(
      {required LandingPageUserInfo landingPageUserInfo,
      required BoxConstraints constraints}) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.black,
            //   )
            // ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: Dimens.size300,
                    height: Dimens.size340,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ImageManager().getImageByUrl(
                          landingPageUserInfo.avatar ?? "",
                          boxFit: BoxFit.cover),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorConst.whiteColor,
                        borderRadius: BorderRadius.circular(Dimens.size16)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(landingPageUserInfo.fullname ?? "",
                              style: TextStyleConstant.titleSmall.copyWith(
                                  color: notifier.blackcolor,
                                  )),
                          Text(
                            landingPageUserInfo.position ?? "",
                            style: TextStyleConstant.bodyMedium.copyWith(
                              color: notifier.blackcolor,)
                          ),
                          Gap(Dimens.size20)
                        ],
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 10),
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

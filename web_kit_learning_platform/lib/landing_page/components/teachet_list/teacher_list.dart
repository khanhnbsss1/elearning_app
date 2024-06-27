// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/user/models/landing_page_teacher_model.dart';

import '../colornotifier.dart';
import '../../mediaquery/mq.dart';
import '../../deshboard/deshboard.dart';
import 'bloc/teacher_list_bloc.dart';

class TeacherList extends StatefulWidget {
  const TeacherList({super.key});

  @override
  State<TeacherList> createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
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
  int b = 4;
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

  List<int> add = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return BlocProvider(
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
            },
            builder: (BuildContext context, state) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      //buildListTeacher2(constraints),
                      //const SizedBox(height: 40),
                      buildListTeacher1(constraints:constraints, state: state),
                    ],
                  );
                },
              );;
            }));

  }
  Widget buildListTeacher1({required BoxConstraints constraints, required TeacherListState state}){
    List<Widget>teacherList = List.empty(growable: true);
    for(LandingPageUserInfo landingPageUserInfo in state.landingPageUserListModel?.data??[])
      {
        teacherList.add(buildTeacherItem1(landingPageUserInfo: landingPageUserInfo));
      }
    return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: constraints.maxWidth < 550 ? 10 : 50,right: constraints.maxWidth < 500 ? 5 : 50),
            child: SizedBox(
                width: constraints.maxWidth < 1100 ? 
                constraints.maxWidth / 1 : constraints.maxWidth < 1200 ? 
                constraints.maxWidth / 1.09 : constraints.maxWidth / 1.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    constraints.maxWidth < 1000
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            L10nX.getStr.teacher_list,
                            style: TextStyleConstant.textStyleBlack28w700.copyWith(
                              fontSize: constraints.maxWidth < 550 ? 28 : 32,)
                        ),
                      ],
                    ) 
                        : Row(
                      children: [
                        Text(
                            L10nX.getStr.teacher_list, 
                            style: TextStyleConstant.textStyleBlack28w700.copyWith(
                              fontSize: constraints.maxWidth < 550 ? 28 : 32,)
                        ),
                      ],
                    ),
                    constraints.maxWidth < 800
                        ? const SizedBox() 
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2,
                                color: (isHover)
                                    ? notifier.sugestionbutton
                                    : Colors.transparent),
                          ),
                          child: InkWell(
                              onTap: () {
                                scrollCont.animateTo(
                                    double.parse("${a}00"),
                                    curve: const FlippedCurve(Easing.legacy),
                                    duration: const Duration(seconds: 1)
                                );
                                setState(() {
                                  b = b - constraints.maxWidth < 500 ? 2 : 4;
                                });
                              },
                              onHover: (val) {
                                setState(() {
                                  isHover = val;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: Image.asset(
                                    'assets/Icons/arrowlefticon.png',
                                    width: 15,
                                    color: notifier.subgreycolor
                                ),
                              )),
                        ),
                        const SizedBox(width: 10),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2,
                                color: (isHover2)
                                    ? notifier.sugestionbutton
                                    : Colors.transparent),
                          ),
                          child: InkWell(
                              onTap: () {
                                scrollCont.animateTo(double.parse("${a}00"),
                                    curve:
                                    const FlippedCurve(Easing.legacy),
                                    duration: const Duration(seconds: 1));
                                setState(() {
                                  b = b + constraints.maxWidth < 500 ? 2 : 4;
                                });
                              },
                              onHover: (val) {
                                setState(() {
                                  isHover2 = val;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: Image.asset(
                                    'assets/Icons/arrowrighticon.png',
                                    width: 15,
                                    color: notifier.subgreycolor
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                )
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: constraints.maxWidth < 1100 ? constraints.maxWidth / 1 : constraints.maxWidth < 1200 ? constraints.maxWidth / 1.09 : constraints.maxWidth / 1.2,
            decoration: BoxDecoration(
              color: notifier.hostBGColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
                padding: EdgeInsets.only(top: 20,bottom: 20,left: constraints.maxWidth < 750 ? 20 : 20,),
                child: state.landingPageUserListModel?.data?.length!=null && state.landingPageUserListModel!.data!.isNotEmpty?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: teacherList,
                      ),
                    ),
                    const SizedBox(height: 20),
                    constraints.maxWidth < 750 ? Row(
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
                              onTap: () {
                                scrollCont.animateTo(double.parse("${a}00"),
                                    curve:
                                    const FlippedCurve(Easing.legacy),
                                    duration: const Duration(seconds: 1));
                                setState(() {
                                  b = b - constraints.maxWidth < 500 ? 2 : 4;
                                });
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
                                    color: notifier.subgreycolor
                                ),
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
                              onTap: () {
                                scrollCont.animateTo(double.parse("${a}00"),
                                    curve:
                                    const FlippedCurve(Easing.legacy),
                                    duration: const Duration(seconds: 1));
                                setState(() {
                                  b = b + constraints.maxWidth < 500 ? 2 : 4;
                                });
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
                    ) : SizedBox(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: const WidgetStatePropertyAll(0),
                            backgroundColor: WidgetStatePropertyAll(viewallHover ? notifier.blackcolor : notifier.yellowcolor),
                            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                            ),
                            )
                        ),
                        onHover: (value) {
                          setState(() {
                            viewallHover = value;
                          });
                        },
                        onPressed: () {

                        }, child: Text('View All',style: TextStyle(fontFamily: 'gilroysemi',fontWeight: FontWeight.w500,fontSize: 12,color: viewallHover ? notifier.whitecolor : notifier.blackcolor)
                      ),
                      ),
                    ),
                  ],
                ):SizedBox()
            ),
          ),
        ]
    );
  }
  Widget buildTeacherItem1({required LandingPageUserInfo landingPageUserInfo}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          decoration: BoxDecoration(
            color: ColorConst.whiteColor,
           // borderRadius: BorderRadius.circular(Dimens.size100)
          ),
          child: Column(
           // alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                //width:  210,
                //height: Dimens.size340,
                child: ImageManager().getImageByUrl(landingPageUserInfo.avatar??"",boxFit: BoxFit.cover),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConst.whiteColor,
                    // borderRadius: BorderRadius.circular(Dimens.size100)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          landingPageUserInfo.fullname??"",
                          style: TextStyle(
                              color: notifier.blackcolor,
                              fontSize: 16,fontFamily: 'gilroysemi',
                              fontWeight: FontWeight.w500)),
                      Text(
                        landingPageUserInfo.position??"",
                        style: TextStyle(
                            color: notifier.blackcolor,
                            fontSize: 12,fontFamily: 'gilroysemi'), 
                        maxLines: 2,),
                      Gap(Dimens.size20)
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildListTeacher2(constraints) {
    return SizedBox(
         width: constraints.maxWidth < 1100 ? constraints.maxWidth / 1 : constraints.maxWidth < 1200 ? constraints.maxWidth / 1.09 : constraints.maxWidth / 1.2,
        child: Padding(
          padding: EdgeInsets.only(
            left: constraints.maxWidth < 550 ? 10 : constraints.maxWidth < 1100 ? 50 : 0,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: constraints.maxWidth < 500
                        ? 5
                        :constraints.maxWidth < 800
                        ? 50
                        : constraints.maxWidth < 1100
                            ? 50
                            : 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    constraints.maxWidth < 1000
                        ? Flexible(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Exploring the top hotel',
                                  style: TextStyle(
                                      fontFamily: 'gilroysemi',
                                      fontSize: constraints.maxWidth < 500
                                          ? 28
                                          : 32,
                                      color: notifier.blackcolor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                PopupMenuButton(
                                  tooltip: '',
                                  padding: const EdgeInsets.all(0),
                                  offset: const Offset(0, 60),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  // initialValue: selectedMenu,
                                  constraints: const BoxConstraints(
                                    maxWidth: 800,
                                    maxHeight: 400,
                                  ),
                                  color: notifier.whitecolor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' ${selectedvalue2.isNotEmpty ? selectedvalue2 : selectedvalue2 = type[0]}',
                                        style: TextStyle(
                                            fontFamily: 'gilroysemi',
                                            fontSize: constraints.maxWidth < 550 ? 28 : 32,
                                            color: notifier.buttoncolor),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: notifier.buttoncolor,
                                      ),
                                    ],
                                  ),
                                  onSelected: (SampleItem2 item) {
                                    setState(() {
                                      // selectedMenu = item;
                                    });
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<SampleItem2>>[
                                    PopupMenuItem<SampleItem2>(
                                      enabled: true,
                                      value: SampleItem2.itemOne,
                                      onTap: () {
                                        setState(() {
                                          selectedvalue2 = type[0];
                                        });
                                      },
                                      child: Text(
                                        type[0],
                                        style: TextStyle(
                                            color: selectedvalue2 == type[0]
                                                ? Colors.blue
                                                : notifier.subgreycolor,
                                            fontSize: constraints.maxWidth < 550 ? 28 : 32,
                                            fontFamily: 'gilroysemi'),
                                      ),
                                    ),
                                    PopupMenuItem<SampleItem2>(
                                      enabled: true,
                                      value: SampleItem2.itemOne,
                                      onTap: () {
                                        setState(() {
                                          selectedvalue2 = type[1];
                                        });
                                      },
                                      child: Text(
                                        type[1],
                                        style: TextStyle(
                                            color: selectedvalue2 == type[1]
                                                ? Colors.blue
                                                : notifier.subgreycolor,
                                            fontSize: constraints.maxWidth < 550 ? 28 : 32,
                                            fontFamily: 'gilroysemi'),
                                      ),
                                    ),
                                    PopupMenuItem<SampleItem2>(
                                      enabled: true,
                                      value: SampleItem2.itemOne,
                                      onTap: () {
                                        setState(() {
                                          selectedvalue2 = type[2];
                                        });
                                      },
                                      child: Text(
                                        type[2],
                                        style: TextStyle(
                                            color: selectedvalue2 == type[2]
                                                ? Colors.blue
                                                : notifier.subgreycolor,
                                            fontSize: constraints.maxWidth < 550 ? 28 : 32,
                                            fontFamily: 'gilroysemi'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        )
                        : Row(
                            children: [
                              Text(
                                'Exploring the top hotel',
                                style: TextStyle(
                                    fontFamily: 'gilroysemi',
                                    fontSize: 48,
                                    color: notifier.blackcolor),
                              ),
                              PopupMenuButton(
                                tooltip: '',
                                padding: const EdgeInsets.all(0),
                                offset: const Offset(0, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                // initialValue: selectedMenu,
                                constraints: const BoxConstraints(
                                  maxWidth: 800,
                                  maxHeight: 400,
                                ),
                                color: notifier.whitecolor,
                                child: Row(
                                  children: [
                                    Text(
                                      ' ${selectedvalue2.isNotEmpty ? selectedvalue2 : selectedvalue2 = type[0]}',
                                      style: TextStyle(
                                          fontFamily: 'gilroysemi',
                                          fontSize: 48,
                                          color: notifier.buttoncolor),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: notifier.buttoncolor,
                                    ),
                                  ],
                                ),
                                onSelected: (SampleItem2 item) {
                                  setState(() {
                                    // selectedMenu = item;
                                  });
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<SampleItem2>>[
                                  PopupMenuItem<SampleItem2>(
                                    enabled: true,
                                    value: SampleItem2.itemOne,
                                    onTap: () {
                                      setState(() {
                                        selectedvalue2 = type[0];
                                      });
                                    },
                                    child: Text(
                                      type[0],
                                      style: TextStyle(
                                          color: selectedvalue2 == type[0]
                                              ? Colors.blue
                                              : notifier.subgreycolor,
                                          fontSize: 40,
                                          fontFamily: 'gilroysemi'),
                                    ),
                                  ),
                                  PopupMenuItem<SampleItem2>(
                                    enabled: true,
                                    value: SampleItem2.itemOne,
                                    onTap: () {
                                      setState(() {
                                        selectedvalue2 = type[1];
                                      });
                                    },
                                    child: Text(
                                      type[1],
                                      style: TextStyle(
                                          color: selectedvalue2 == type[1]
                                              ? Colors.blue
                                              : notifier.subgreycolor,
                                          fontSize: 40,
                                          fontFamily: 'gilroysemi'),
                                    ),
                                  ),
                                  PopupMenuItem<SampleItem2>(
                                    enabled: true,
                                    value: SampleItem2.itemOne,
                                    onTap: () {
                                      setState(() {
                                        selectedvalue2 = type[2];
                                      });
                                    },
                                    child: Text(
                                      type[2],
                                      style: TextStyle(
                                          color: selectedvalue2 == type[2]
                                              ? Colors.blue
                                              : notifier.subgreycolor,
                                          fontSize: 40,
                                          fontFamily: 'gilroysemi'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    constraints.maxWidth < 800
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2,
                                      color: (isHover)
                                          ? notifier.sugestionbutton
                                          : Colors.transparent),
                                ),
                                child: InkWell(
                                    onTap: () {
                                      pg.animateTo(double.parse("${a}00"),
                                          curve:
                                              const FlippedCurve(Easing.legacy),
                                          duration: const Duration(seconds: 1));
                                      setState(() {
                                        a = a - constraints.maxWidth < 500 ? 2 : 4;
                                      });
                                    },
                                    onHover: (val) {
                                      setState(() {
                                        isHover = val;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(13),
                                      child: Image.asset(
                                        'assets/Icons/arrowlefticon.png',
                                        width: 15,
                                        color: notifier.subgreycolor
                                      ),
                                    )),
                              ),
                              const SizedBox(width: 10),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2,
                                      color: (isHover2)
                                          ? notifier.sugestionbutton
                                          : Colors.transparent),
                                ),
                                child: InkWell(
                                    onTap: () {
                                      pg.animateTo(double.parse("${a}00"),
                                          curve:
                                              const FlippedCurve(Easing.legacy),
                                          duration: const Duration(seconds: 1));
                                      setState(() {
                                        a = a + constraints.maxWidth < 500 ? 2 : 4;
                                      });
                                    },
                                    onHover: (val) {
                                      setState(() {
                                        isHover2 = val;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(13),
                                      child: Image.asset(
                                        'assets/Icons/arrowrighticon.png',
                                        width: 15,
                                        color: notifier.subgreycolor
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: 350,
                child: ListView.builder(
                  itemCount: hostplacesimage.length,
                  controller: pg,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Stack(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 310,
                              width:  260,
                              decoration: BoxDecoration(
                                color: notifier.whitecolor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: (hoverborder[index])
                                        ? Colors.grey.shade400
                                        : notifier.sugestionbutton),
                              ),
                              child: InkWell(
                                onTap: () {},
                                onHover: (value) {
                                  setState(() {
                                    hoverborder[index] = value;
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            hostplacesimage[index],
                                            height: 180,
                                            width: width / 1,
                                            fit: BoxFit.fill,
                                          ),
                                          Positioned(
                                              top: 10,
                                              left: 10,
                                              child: Container(
                                                height: 22,
                                                width: 50,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: notifier.whitecolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.star_rounded,
                                                        color: notifier
                                                            .yellowcolor,
                                                        size: 14),
                                                    Text(
                                                      hostrating[index],
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: notifier.blackcolor,
                                                          fontFamily:
                                                              'gilroysemi'),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 60),
                                    Text(
                                      'Antone Heller',
                                      style: TextStyle(
                                          fontFamily: 'gilroysemi',
                                          fontSize: 16,
                                          color: notifier.blackcolor),
                                    ),
                                    const SizedBox(height: 8),
                                    Text('Gaylordside',
                                        style: TextStyle(
                                            fontFamily: 'gilroy',
                                            fontSize: 14,
                                            color: notifier.subgreycolor)),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 135,
                              left: 87,
                              child: Container(
                                height: 85,
                                width:  81,
                                decoration: BoxDecoration(
                                  color: notifier.whitecolor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 140,
                              left: 90,
                              child: Container(
                                height: 75,
                                decoration: BoxDecoration(
                                  color: notifier.whitecolor,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  hostimage[index],
                                ),
                              )
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              constraints.maxWidth < 800
                  ? Row(
                      mainAxisAlignment: constraints.maxWidth < 550 ? MainAxisAlignment.center : MainAxisAlignment.start,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2,
                                color: (isHover)
                                    ? notifier.sugestionbutton
                                    : Colors.transparent),
                          ),
                          child: InkWell(
                              onTap: () {
                                pg.animateTo(double.parse("${a}00"),
                                    curve:
                                    const FlippedCurve(Easing.legacy),
                                    duration: const Duration(seconds: 1));
                                setState(() {
                                  a = a - constraints.maxWidth < 500 ? 2 : 4;
                                });
                              },
                              onHover: (val) {
                                setState(() {
                                  isHover = val;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: Image.asset(
                                  'assets/Icons/arrowlefticon.png',
                                  width: 15,
                                  color: notifier.subgreycolor,
                                ),
                              )),
                        ),
                        const SizedBox(width: 10),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2,
                                color: (isHover2)
                                    ? notifier.sugestionbutton
                                    : Colors.transparent),
                          ),
                          child: InkWell(
                              onTap: () {
                                pg.animateTo(double.parse("${a}00"),
                                    curve:
                                    const FlippedCurve(Easing.legacy),
                                    duration: const Duration(seconds: 1));
                                setState(() {
                                  a = a + constraints.maxWidth < 500 ? 2 : 4;
                                });
                              },
                              onHover: (val) {
                                setState(() {
                                  isHover2 = val;
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
                  : const SizedBox(),
            ],
          ),
        ));
  }
}

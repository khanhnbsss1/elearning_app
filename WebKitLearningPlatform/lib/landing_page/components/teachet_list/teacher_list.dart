// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';

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
                      buildListTeacher1(constraints),
                    ],
                  );
                },
              );;
            }));

  }
  Widget buildListTeacher1(constraints){
    return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: constraints.maxWidth < 550 ? 10 : 50,right: constraints.maxWidth < 500 ? 5 : 50),
            child: SizedBox(
                width: constraints.maxWidth < 1100 ? constraints.maxWidth / 1 : constraints.maxWidth < 1200 ? constraints.maxWidth / 1.09 : constraints.maxWidth / 1.2,
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
                                ' ${selectedvalue.isNotEmpty ? selectedvalue : selectedvalue = type[0]}',
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
                                  selectedvalue = type[0];
                                });
                              },
                              child: Text(
                                type[0],
                                style: TextStyle(
                                    color: selectedvalue == type[0]
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
                                  selectedvalue = type[1];
                                });
                              },
                              child: Text(
                                type[1],
                                style: TextStyle(
                                    color: selectedvalue == type[1]
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
                                  selectedvalue = type[2];
                                });
                              },
                              child: Text(
                                type[2],
                                style: TextStyle(
                                    color: selectedvalue == type[2]
                                        ? Colors.blue
                                        : notifier.subgreycolor,
                                    fontSize: constraints.maxWidth < 550 ? 28 : 32,
                                    fontFamily: 'gilroysemi'),
                              ),
                            ),
                          ],
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
                                ' ${selectedvalue.isNotEmpty ? selectedvalue : selectedvalue = type[0]}',
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
                                  selectedvalue = type[0];
                                });
                              },
                              child: Text(
                                type[0],
                                style: TextStyle(
                                    color: selectedvalue == type[0]
                                        ? Colors.blue
                                        : notifier.subgreycolor,
                                    fontSize: 32,
                                    fontFamily: 'gilroysemi'),
                              ),
                            ),
                            PopupMenuItem<SampleItem2>(
                              enabled: true,
                              value: SampleItem2.itemOne,
                              onTap: () {
                                setState(() {
                                  selectedvalue = type[1];
                                });
                              },
                              child: Text(
                                type[1],
                                style: TextStyle(
                                    color: selectedvalue == type[1]
                                        ? Colors.blue
                                        : notifier.subgreycolor,
                                    fontSize: 32,
                                    fontFamily: 'gilroysemi'),
                              ),
                            ),
                            PopupMenuItem<SampleItem2>(
                              enabled: true,
                              value: SampleItem2.itemOne,
                              onTap: () {
                                setState(() {
                                  selectedvalue = type[2];
                                });
                              },
                              child: Text(
                                type[2],
                                style: TextStyle(
                                    color: selectedvalue == type[2]
                                        ? Colors.blue
                                        : notifier.subgreycolor,
                                    fontSize: 32,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    constraints.maxWidth < 750 ?
                    SizedBox(
                      height: 330,
                      child: ListView.builder(
                        controller: scrollCont,
                        scrollDirection: Axis.horizontal,
                        itemCount: hostImage2.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 210,
                                      height: 270,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.asset(hostImage2[index],fit: BoxFit.cover),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text('Anot Heller',style: TextStyle(color: notifier.blackcolor,fontSize: 16,fontFamily: 'gilroysemi',fontWeight: FontWeight.w500)),
                                    // SizedBox(height: 10),
                                    Text('\$47.00',style: TextStyle(color: notifier.blackcolor,fontSize: 12,fontFamily: 'gilroysemi')),
                                  ],
                                ),
                                Positioned(
                                  top: 250,
                                  child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: notifier.isDark ? notifier.sugestionbutton : Colors.white,
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          add[index]>0 ? const SizedBox() : const SizedBox(width: 20),
                                          add[index]>0 ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if(add[index]>0){
                                                  add[index] -= 1;
                                                }
                                              });
                                            }, icon: Icon(Icons.remove_circle_rounded,color: notifier.addHostcolor,size: 16),) : const SizedBox(),
                                          Text(add[index]==0 ? 'Add' : '${add[index]}',style: TextStyle(
                                              fontFamily: 'gilroysemi',color: notifier.blackcolor
                                          ),),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                add[index] += 1;
                                              });
                                            }, icon: Icon(Icons.add_circle_rounded,color: notifier.addHostcolor,size: 16),),
                                        ],
                                      )
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                        : Container(
                      height: 700,
                      alignment: Alignment.center,
                      child: GridView.builder(
                        controller: scrollCont,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 200,
                          mainAxisSpacing: constraints.maxWidth / 18,
                          crossAxisCount: constraints.maxWidth < 500 ? 1 : constraints.maxWidth < 750 ? 2 : constraints.maxWidth < 1100 ? 2 : 2,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: constraints.maxWidth < 750 ? hostImage2.length : constraints.maxWidth < 900 ? 6 : hostImage2.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width:  210,
                                    height: 270,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(hostImage2[index],fit: BoxFit.cover),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text('Anot Heller',style: TextStyle(color: notifier.blackcolor,fontSize: 16,fontFamily: 'gilroysemi',fontWeight: FontWeight.w500)),
                                  // SizedBox(height: 10),
                                  Text('\$47.00',style: TextStyle(color: notifier.blackcolor,fontSize: 12,fontFamily: 'gilroysemi')),
                                ],
                              ),
                              Positioned(
                                top: 250,
                                child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: notifier.isDark ? notifier.sugestionbutton : Colors.white,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: add[index]>0 ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        add[index]>0 ? const SizedBox() : const SizedBox(width: 20),
                                        add[index]>0 ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if(add[index]>0){
                                                add[index] -= 1;
                                              }
                                            });
                                          }, icon: Icon(Icons.remove_circle_rounded,color: notifier.addHostcolor,size: 16),) : const SizedBox(),
                                        Text(add[index]==0 ? 'Add' : '${add[index]}',style: TextStyle(
                                            fontFamily: 'gilroysemi',color: notifier.blackcolor
                                        ),),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              add[index] += 1;
                                            });
                                          }, icon: Icon(Icons.add_circle_rounded,color: notifier.addHostcolor,size: 16),),
                                      ],
                                    ) : InkWell(
                                      onTap: () {
                                        setState(() {
                                          add[index] += 1;
                                        });
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          add[index]>0 ? const SizedBox() : const SizedBox(width: 10),
                                          add[index]>0 ? Icon(Icons.remove_circle_rounded,color: notifier.addHostcolor,size: 16) : const SizedBox(),
                                          Text(add[index]==0 ? 'Add' : '${add[index]}',style: TextStyle(
                                              fontFamily: 'gilroysemi',color: notifier.blackcolor
                                          ),),
                                          const SizedBox(width: 5),
                                          Icon(Icons.add_circle_rounded,color: notifier.addHostcolor,size: 16),
                                          add[index]>0 ? const SizedBox() : const SizedBox(width: 10),
                                        ],
                                      ),
                                    )
                                ),
                              )
                            ],
                          );
                        },
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
                )
            ),
          ),
        ]
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

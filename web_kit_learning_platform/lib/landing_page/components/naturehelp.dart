// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webkit/landing_page/mediaquery/mq.dart';

import '../../base/theme/text_stype_constant.dart';
import 'colornotifier.dart';


class nh extends StatefulWidget {
  const nh({super.key});

  @override
  State<nh> createState() => _nhState();
}

class _nhState extends State<nh> {
  late ColorNotifier notifier;

  List natureimage = [
    'assets/deshboard/naturehouse/nature1.png',
    'assets/deshboard/naturehouse/nature2.png',
    'assets/deshboard/naturehouse/nature3.png',
    'assets/deshboard/naturehouse/nature4.png',
    'assets/deshboard/naturehouse/nature5.png',
    'assets/deshboard/naturehouse/nature6.png',
    'assets/deshboard/naturehouse/nature7.png',
    'assets/deshboard/naturehouse/nature8.png'
  ];

  List chips = ['City','Beach','Outdoors','Romance'];
  List offertag = [
    'Adventure Trips From\nAhmedabad',
    'Relaxing Trips From\nAhmedabad',
    'Family Trips From\nAhmedabad',
    'Outbeats Trips From\nAhmedabad',
    'Romantic Trips From\nAhmedabad',
    'Historical Trips From\nAhmedabad',
    'Tracking Trips From\nAhmedabad',
    'Natural Trips From\nAhmedabad'
  ];
  List natureproplist = [
    '40 Itineraries',
    '33 Itineraries',
    '28 Itineraries',
    '15 Itineraries',
    '6 Itineraries',
    '3 Itineraries',
    '32 Itineraries',
    '4 Itineraries'
  ];
  List<bool> savedHover = [false,false,false,false,false,false,false,false,false];
  List<bool> shareHover = [false,false,false,false,false,false,false,false,false];
  List savedItem = [];

  List<bool> chipshover = [false,false,false,false];
  bool isHover = false;
  bool isHover2 = false;
  int a = 4;
  PageController pc = PageController();
  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        return nature(constraints);
      },
    );
  }

  Widget nature(constraints) {
    return Padding(
      padding: EdgeInsets.only(left: constraints.maxWidth < 550 ? 10 : constraints.maxWidth < 1000 ? 50 : 0 ),
      child: SizedBox(
        width: constraints.maxWidth < 1000 ? width / 1 : constraints.maxWidth / 1.3,
        child: Column(
          crossAxisAlignment: constraints.maxWidth < 550 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Flexible(child: Text('Quick and easy trip planner',
                   style: baseStyle.copyWith(
                       fontSize: constraints.maxWidth < 300 ? 26 : constraints.maxWidth < 500 ? 28 : 40,
                       
                       color: notifier.blackcolor),
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                   textAlign: TextAlign.center,
                 ),),
                constraints.maxWidth < 800
                    ? const SizedBox(
                  height: 0,
                )
                    : Row(
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
                          pc.animateTo(double.parse("${a}00"),
                              curve: const FlippedCurve(Easing.legacy),
                              duration: const Duration(seconds: 1));
                          setState(() {
                            a = a - 4;
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
                        ),
                      ),
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
                            pc.animateTo(double.parse("${a}00"),
                                curve: const FlippedCurve(Easing.legacy),
                                duration: const Duration(seconds: 1));
                            setState(() {
                              a = a + 4;
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
                ),
              ],
            ),
            SizedBox(
              width : width / 1,
              child: Text('Pick a vibe and explore the top destination in India',
                  style: baseStyle.copyWith(
                      fontSize: constraints.maxWidth < 300 ? 16 : constraints.maxWidth < 550 ? 18 : 22,
                      
                      color: notifier.subgreycolor),
                maxLines: 2,
                textAlign: constraints.maxWidth < 550 ? TextAlign.center : TextAlign.start,
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: chips.length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 35,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    side: BorderSide(color: selectedindex == index ? notifier.buttoncolor : Colors.transparent),
                                    borderRadius: BorderRadius.circular(20))),
                            backgroundColor: WidgetStateProperty.all(
                                selectedindex == index
                                    ? notifier.advchips
                                    : Colors.transparent),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedindex = index;
                            });
                          },
                          onHover: (value) {
                            setState(() {
                              chipshover[index] = value;
                            });
                          },
                          child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Image.asset(
                            //     'assets/Icons/dollarcircle.png', height: 15,
                            //     color: selectedindex == index ? notifier
                            //         .buttoncolor : notifier.blackcolor,alignment: Alignment.center),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              child: Text(chips[index], style: baseStyle.copyWith(
                                  
                                  color: (selectedindex == index || chipshover[index]) ? notifier
                                      .buttoncolor : notifier.blackcolor),textAlign: TextAlign.center,),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: constraints.maxWidth < 550 ? 6 : 10,),
                    ],
                  );
              },),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 330,
              width: constraints.maxWidth / 1,
              child: ListView.builder(
                controller: pc,
                scrollDirection: Axis.horizontal,
                itemCount: natureimage.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SizedBox(
                                    width: 230,
                                    child: Stack(
                                      children: [
                                        Image.asset(natureimage[index],
                                          height: 290,
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                          height: 290,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.black,
                                                  Colors.transparent,
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: SizedBox(
                                    width: 210,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                               if(savedItem.contains(natureimage[index])){
                                                 savedItem.remove(natureimage[index]);
                                               }else{
                                                 savedItem.add(natureimage[index]);
                                               }
                                            });
                                          },
                                          onHover: (value) {
                                            setState(() {
                                              savedHover[index] = value;
                                            });
                                          },
                                          child: AnimatedContainer(
                                            height: 30,
                                            width: 30,
                                            duration: const Duration(milliseconds: 200),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: notifier.isDark ? Colors.white.withOpacity(0.8) : Colors.grey.withOpacity(0.8)
                                            ),
                                            child: (savedHover[index] || savedItem.contains(natureimage[index])) ? Icon(
                                              Icons.bookmark_rounded,
                                              size: 18,
                                              color: notifier.whitecolor,
                                              ) : Icon(
                                              Icons.bookmark_border_rounded,
                                              size: 18,
                                              color: notifier.whitecolor,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {

                                          },
                                          onHover: (value) {
                                            setState(() {
                                              shareHover[index] = value;
                                            });
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: notifier.isDark ? Colors.white.withOpacity(0.8) : Colors.grey.withOpacity(0.8)
                                            ),
                                            child: shareHover[index] ? Icon(
                                              Icons.share_rounded,
                                              size: 18,
                                              color: notifier.whitecolor,
                                              ) : Icon(
                                              Icons.share_outlined,
                                              size: 18,
                                              color: notifier.whitecolor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 220,
                                  left: 10,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          offertag[index],
                                          style: baseStyle.copyWith(
                                              fontFamily: 'gilroybold',
                                              fontSize: 16,
                                              color: notifier.isDark ? Colors.white : notifier.whitecolor),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              natureproplist[index],
                                              style: baseStyle.copyWith(
                                                  
                                                  fontSize: 12,
                                                  color: notifier.subgreycolor),
                                            ),
                                            Icon(Icons.arrow_forward_ios_rounded,
                                              size: 12,
                                              color: notifier.subgreycolor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30)
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: constraints.maxWidth < 550 ? 0 : 20),
            constraints.maxWidth < 800
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      constraints.maxWidth < 700
                          ? a = 4
                          : constraints.maxWidth < 800
                          ? a = 10
                          : a = 7;
                      pc.animateTo(double.parse("${-a}00"),
                          curve: const FlippedCurve(Easing.legacy),
                          duration: const Duration(seconds: 1));
                      setState(() {
                        a = a - 4;
                      });
                    });
                  },
                  child: Image.asset(
                    'assets/Icons/arrowlefticon.png',
                    color: notifier.subgreycolor,
                    height: 8,
                  ),
                ),
                const SizedBox(width: 40),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      pc.animateTo(double.parse("${a}00"),
                          curve: const FlippedCurve(Easing.legacy),
                          duration: const Duration(seconds: 1));
                      setState(() {
                        a = a + 4;
                      });
                    });
                  },
                  child: Image.asset('assets/Icons/arrowrighticon.png',
                      color: notifier.subgreycolor,
                      height: 8),
                ),
              ],
            )
                : const SizedBox(
              height: 0,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../mediaquery/mq.dart';
import 'colornotifier.dart';

class TeacherList extends StatefulWidget {
  const TeacherList({super.key});

  @override
  State<TeacherList> createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  late ColorNotifier notifier;
  List propimage = [
    'assets/deshboard/properties/popPlaces1.png',
    'assets/deshboard/properties/popPlaces2.png',
    'assets/deshboard/properties/popPlaces3.png',
    'assets/deshboard/properties/popPlaces1.png'
  ];
  List proptitle = [
    'Things To Do OnYour Trip',
    'Let Your Curiosity Do The Booking',
    'Up to 70% Discount!',
    'Things To Do OnYour Trip'
  ];
  List propsubtitle = [
    '147,681 travelers',
    '88,909 travelers',
    '15,200 travelers',
    '147,681 travelers'
  ];

  bool isHover = false;
  bool arrowRtHover = false;
  bool arrowLHover = false;
  var a = 4;
  bool valid = false;
  PageController pg = PageController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      notifier = Provider.of<ColorNotifier>(context, listen: true);
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
      return properties(constraints, context);
    },);
  }
  Widget properties(constraints, BuildContext context) {
    return constraints.maxWidth < 800
        ? Column(
      children: [
        SizedBox(
          height: constraints.maxWidth / 0.76,
          width: width / 1,
          child: Padding(
            padding: EdgeInsets.only(left: constraints.maxWidth < 550 ? 10 : 30),
            child: ListView.builder(
              itemCount: 4,
              controller: pg,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(propimage[index],
                              height: constraints.maxWidth < 550 ? constraints.maxWidth / 1 : constraints.maxWidth / 0.9,
                              width: constraints.maxWidth / 1.2,
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(proptitle[index],
                            style: TextStyle(
                                color: notifier.blackcolor,
                                fontFamily: 'gilroysemi',
                                fontSize: 18)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          propsubtitle[index],
                          style: TextStyle(
                              fontFamily: 'gilroymed',
                              fontSize: constraints.maxWidth < 800 ? 18 : 16,
                              color: notifier.greycolor),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                  ],
                );
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2,
                    color: (arrowLHover)
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
                      a = a - 4;
                    });
                  },
                  onHover: (val) {
                    setState(() {
                      arrowLHover = val;
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
                    color: (arrowRtHover)
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
                      a = a + 4;
                    });
                  },
                  onHover: (val) {
                    setState(() {
                      arrowRtHover = val;
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
    )
        : constraints.maxWidth < 1050
        ? SizedBox(
        height: constraints.maxWidth / 0.64,
        child: Padding(
          padding: const EdgeInsets.only(right: 10,left: 10),
            child: GridView.builder(
              itemCount: propimage.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisExtent: constraints.maxWidth / 1.4),
              itemBuilder: (context, index) {
                return SizedBox(
                  height: constraints.maxWidth / 1.2,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(propimage[index],
                            height: constraints.maxWidth < 1050
                                ? constraints.maxWidth / 1.7
                                : constraints.maxWidth / 3,
                            fit: BoxFit.cover),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(proptitle[index],
                          style: TextStyle(
                              color: notifier.blackcolor,
                              fontFamily: 'gilroysemi',
                              fontSize: 18)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        propsubtitle[index],
                        style: TextStyle(
                            fontFamily: 'gilroymed',
                            fontSize: constraints.maxWidth < 1050 ? 18 : 16,
                            color: notifier.greycolor),
                      )
                    ],
                  ),
                );
              },
            ),
        ))
        : Column(
      children: [
        Container(
          height: constraints.maxWidth / 2.4,
          alignment: Alignment.center,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(propimage[index],
                            height: constraints.maxWidth / 3,
                            width: constraints.maxWidth / 4,
                            fit: BoxFit.cover
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(proptitle[index],
                          style: TextStyle(
                              color: notifier.blackcolor,
                              fontFamily: 'gilroysemi',
                              fontSize: 18)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        propsubtitle[index],
                        style: TextStyle(
                            fontFamily: 'gilroymed',
                            fontSize:
                            constraints.maxWidth < 800 ? 18 : 16,
                            color: notifier.greycolor),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              );
            },
          ),
        ),
         const SizedBox(height: 50,),
         valid ? Container(
      height: constraints.maxWidth < 1300 ? constraints.maxWidth / 2.4 : constraints.maxWidth / 2.5,
      alignment: Alignment.center,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(propimage[index],
                        height: constraints.maxWidth / 3,
                        width: constraints.maxWidth / 4,
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(proptitle[index],
                      style: TextStyle(
                          color: notifier.blackcolor,
                          fontFamily: 'gilroysemi',
                          fontSize: 18)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    propsubtitle[index],
                    style: TextStyle(
                        fontFamily: 'gilroymed',
                        fontSize:
                        constraints.maxWidth < 800 ? 18 : 16,
                        color: notifier.greycolor),
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          );
        },
      ),
    ) : Container(
           height: 40,
          width: 150,
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {

            },
            onHover: (value) {
              setState(() {
                isHover = value;
              });
            },
            child: ElevatedButton(
                style: ButtonStyle(
                    alignment: Alignment.center,
                    elevation: WidgetStateProperty.all(0),
                    side: WidgetStateProperty.all(BorderSide(color: isHover ? Colors.transparent : notifier.greycolor,width: 1)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                    backgroundColor: WidgetStateProperty.all(isHover ? (notifier.isDark ? const Color(0xFF777E90) : notifier.blackcolor) : Colors.transparent),
                ),
                onPressed: () {
                  setState(() {
                    valid = true;
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitFadingCircle(
                      color: notifier.isDark ? notifier.blackcolor : notifier.greycolor,//ustomize the color
                      size: 20.0,
                    ),
                    const SizedBox(width: 10,),
                    Text('Load More' ,
                      style: TextStyle(
                          fontFamily: 'gilroysemi',
                          fontSize: 14,
                          color: isHover ? Colors.white : notifier.greycolor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

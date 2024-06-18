import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../helper/colornotifier.dart';
import '../mediaquery/mq.dart';
import 'deshboard.dart';

class Tabsbar extends StatefulWidget {
  const Tabsbar({super.key});

  @override
  State<Tabsbar> createState() => _TabsbarState();
}

class _TabsbarState extends State<Tabsbar> {

  late ColorNotifier notifier;
  int tabHover = 0;

  List su1 = [
    'Find trips that fit a flexible lifestyle',
    'Travel with more confidence',
    'See what’s really included'
  ];
  List su2 = [
    'Stacks is a production-ready library of stackable\ncontent blocks built in React Native.',
    'Stacks is a production-ready library of stackable\ncontent blocks built in React Native.',
    'Stacks is a production-ready library of stackable\ncontent blocks built in React Native.'
  ];

  List<bool> addHover = [false, false, false];
  List<bool> subHover = [false, false, false];
  List<int> add = [0, 0, 0];
  List<int> add2 = [0, 0, 0];
  List ageType = ['Adults', 'Children', 'Adults'];
  List ageRange = ['Ages 13 or above', 'Ages 2 - 12', 'Under 2'];
  String selectedvalue = '';
  List travelerstype = ['Stays', 'Flights', 'Things to do', 'Cars'];
  List travelerstype2 = ['Stays', 'Flights', 'Things to do', 'Cars', 'Support'];

  List<bool> chipsHover1 = [false, false, false];
  List<bool> chipsHover2 = [false, false, false];
  List<bool> chipsHover3 = [false, false, false];
  List tabchips = ['Round-trip', 'One-way', 'Multi City'];
  List hotelchips = ['India', 'International'];
  int selectedchip = 0;
  int selectedhotelchip = 0;
  int selectedtrainchip = 0;

  bool isHover = false;
  bool isHover2 = false;
  bool searchHover = false;
  bool searchHover2 = false;
  bool searchHover3 = false;
  bool bHover = false;
  bool langHover = false;

  List checkTrain = [
    'Book Train Tickets',
    'Check PNR Status',
    'Live Train Status'
  ];
  List<bool> check = [true, false, false];
  bool selectedCheck = false;

  DateRangePickerController dateSelecter = DateRangePickerController();
  void _onselectionChanged(DateRangePickerSelectionChangedArgs args) {

  }
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
          child: Card(
            // / shadowColor: notifier.isDark ? const Color(0xFF353945) : Colors.grey.shade50,
            elevation: 0,
            color: notifier.isDark ? const Color(0xFF23262F).withOpacity(0.2) : Colors.white30,
            shape: RoundedRectangleBorder(
              // side: BorderSide(color: notifier.whitecolor,),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  height: constraints.maxWidth < 1800 ? 330 : constraints
                      .maxWidth < 1900
                      ? constraints.maxWidth / 4.6
                      : constraints.maxWidth < 2200 ? 400 : 400,
                  width: constraints.maxWidth < 1000
                      ? constraints.maxWidth / 1.1
                      : constraints.maxWidth < 1300
                      ? constraints.maxWidth / 1.2
                      : constraints.maxWidth / 1.3,
                  child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: SizedBox(
                        child: DefaultTabController(
                          length: 7,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 120,
                                width: width / 1,
                                child: TabBar(
                                  unselectedLabelColor: notifier
                                      .blackcolor,
                                  labelColor: notifier.whitecolor,
                                  onTap: (value) {
                                    setState(() {
                                      tabHover = value;
                                    });
                                  },
                                  isScrollable:
                                  constraints.maxWidth < 800
                                      ? false
                                      : true,
                                  indicatorPadding:
                                  const EdgeInsets.all(9),
                                  indicatorWeight: 1,
                                  indicatorColor: notifier.whitecolor,
                                  tabs: [
                                    Tab(
                                      height: 120,
                                      icon: tabHover == 0 ? Image.asset(
                                          'assets/Icons/tabIcon/flightcoloricon.png',
                                          height: 30) : Image.asset(
                                          'assets/Icons/tabIcon/flightblackicon.png',
                                          height: 30),
                                      child: const Text(
                                        'Fights', style: TextStyle(
                                        fontFamily: 'gilroysemi',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Tab(
                                      height: 120,
                                      icon: tabHover == 1 ? Image.asset(
                                          'assets/Icons/tabIcon/hotelcoloricon.png',
                                          height: 30) : Image.asset(
                                          'assets/Icons/tabIcon/hotelblackicon.png',
                                          height: 30),
                                      child: const Text(
                                        'Hotels', style: TextStyle(
                                        fontFamily: 'gilroysemi',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Tab(
                                      height: 120,
                                      iconMargin: const EdgeInsets.only(
                                          top: 20, bottom: 8),
                                      icon: tabHover == 2 ? Image.asset(
                                          'assets/Icons/tabIcon/homestaycoloricon.png',
                                          height: 30) : Image.asset(
                                          'assets/Icons/tabIcon/homestayblackicon.png',
                                          height: 30),
                                      child: const Text(
                                        'Homestays\n& Villas',
                                        style: TextStyle(
                                          fontFamily: 'gilroysemi',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Tab(
                                      height: 100,
                                      iconMargin: const EdgeInsets.only(
                                          top: 20, bottom: 8),
                                      icon: tabHover == 3 ? Image.asset(
                                          'assets/Icons/tabIcon/holidaycoloricon.png',
                                          height: 30) : Image.asset(
                                          'assets/Icons/tabIcon/holidayblackicon.png',
                                          height: 30),
                                      child: const Text(
                                        'Holiday\nPackages',
                                        style: TextStyle(
                                          fontFamily: 'gilroysemi',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Tab(
                                      height: 100,
                                      iconMargin: const EdgeInsets.only(
                                          bottom: 10),
                                      icon: tabHover == 4 ? Image.asset(
                                          'assets/Icons/tabIcon/traincoloricon.png',
                                          height: 30) : Image.asset(
                                          'assets/Icons/tabIcon/trainblackicon.png',
                                          height: 30),
                                      child: const Text(
                                        'Trains', style: TextStyle(
                                        fontFamily: 'gilroysemi',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Tab(
                                      height: 100,
                                      icon: tabHover == 5 ? Image.asset(
                                          'assets/Icons/tabIcon/buscoloricon.png',
                                          height: 30) : Image.asset(
                                          'assets/Icons/tabIcon/busblackicon.png',
                                          height: 30),
                                      child: const Text(
                                        'Buses', style: TextStyle(
                                        fontFamily: 'gilroysemi',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Tab(
                                      height: 100,
                                      icon: tabHover == 6 ? Image.asset(
                                          'assets/Icons/tabIcon/taxicoloricon.png',
                                          height: 30) : Image.asset(
                                          'assets/Icons/tabIcon/taxiblackicon.png',
                                          height: 30),
                                      child: const Text(
                                        'Cabs', style: TextStyle(
                                        fontFamily: 'gilroysemi',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxWidth > 1800
                                    ? 265
                                    : 210,
                                child: TabBarView(
                                    children: [
                                      flightTab(constraints),
                                      hotelTab(constraints),
                                      flightTab(constraints),
                                      flightTab(constraints),
                                      trainTab(constraints),
                                      busTab(constraints),
                                      flightTab(constraints),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      )
                  )
              ),
            ),
          )
      );
    },);
  }

  Widget flightTab(constraints) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 10,),
            SizedBox(
              height: constraints.maxWidth > 1800 ? 50 : 40,
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              elevation: const WidgetStatePropertyAll(0),
                              backgroundColor: WidgetStatePropertyAll(
                                  (chipsHover1[index] ||
                                      selectedchip == index)
                                      ? notifier.blackcolor : notifier
                                      .whitecolor
                              ),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          constraints.maxWidth > 1800
                                              ? 23
                                              : 20),
                                      side: BorderSide(
                                          color: (chipsHover1[index] ||
                                              selectedchip == index)
                                              ? Colors.transparent
                                              : notifier.sugestionbutton,
                                          width: 1
                                      )
                                  )
                              )
                          ),
                          onHover: (value) {
                            setState(() {
                              chipsHover1[index] = value;
                            });
                          },
                          onPressed: () {
                            setState(() {
                              selectedchip = index;
                            });
                          }, child: Text(tabchips[index], style: TextStyle(
                          fontFamily: 'gilroybold',
                          fontSize: 14,
                          color: (chipsHover1[index] ||
                              selectedchip == index)
                              ? notifier.whitecolor
                              : notifier.blackcolor))),
                      const SizedBox(width: 10,),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: constraints.maxWidth < 800
                  ? 10
                  : 30
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: constraints.maxWidth > 1800 ? 140 : constraints
                      .maxWidth > 2200 ? 170 : 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    border: Border.all(color: notifier.sugestionbutton,),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text('From', style: TextStyle(
                            fontFamily: 'gilroysemi', color: notifier
                            .blackcolor, fontSize: constraints.maxWidth < 1000
                            ? constraints.maxWidth / 110
                            : constraints.maxWidth / 120)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: constraints
                              .maxWidth <
                              1000
                              ? constraints.maxWidth / 60
                              : constraints
                              .maxWidth <
                              1300
                              ? constraints.maxWidth / 60
                              : constraints.maxWidth / 60,
                          child: TextField(
                            style: TextStyle(
                                fontSize: constraints
                                    .maxWidth <
                                    1000
                                    ? constraints.maxWidth / 60
                                    : constraints
                                    .maxWidth <
                                    1300
                                    ? constraints.maxWidth / 60
                                    : constraints.maxWidth / 60,
                                fontFamily:
                                'gilroysemi',
                                color: notifier.blackcolor,
                                fontWeight:
                                FontWeight.w600),
                            decoration:
                            InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                disabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                hintText:
                                'Location',
                                hintStyle:
                                TextStyle(
                                    color: notifier
                                        .blackcolor,
                                    fontSize: constraints.maxWidth <
                                        1000
                                        ? constraints.maxWidth / 60
                                        : constraints.maxWidth <
                                        1300
                                        ? constraints.maxWidth / 60
                                        : constraints.maxWidth / 60,
                                    fontFamily:
                                    'gilroysemi',
                                    fontWeight:
                                    FontWeight
                                        .w600)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Where are you going?',
                          style: TextStyle(
                              fontSize: constraints
                                  .maxWidth <
                                  1000
                                  ? constraints.maxWidth / 100
                                  : constraints
                                  .maxWidth <
                                  1300
                                  ? constraints.maxWidth / 105
                                  : constraints.maxWidth / 100,
                              fontFamily: 'gilroymed',
                              color: Colors
                                  .grey.shade500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    height: constraints.maxWidth > 1800 ? 140 : constraints
                        .maxWidth > 2200 ? 170 : 100,
                    decoration: BoxDecoration(
                      border:
                      Border(right: BorderSide(color: notifier.sugestionbutton),
                        bottom: BorderSide(color: notifier.sugestionbutton),
                        top: BorderSide(color: notifier.sugestionbutton),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text('To', style: TextStyle(
                              fontFamily: 'gilroysemi', color: notifier
                              .blackcolor, fontSize: constraints.maxWidth < 1000
                              ? constraints.maxWidth / 110
                              : constraints.maxWidth / 120)),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: constraints
                                .maxWidth <
                                1000
                                ? constraints.maxWidth / 60
                                : constraints
                                .maxWidth <
                                1300
                                ? constraints.maxWidth / 60
                                : constraints.maxWidth / 60,
                            child: TextField(
                              style: TextStyle(
                                  fontSize: constraints
                                      .maxWidth <
                                      1000
                                      ? constraints.maxWidth / 60
                                      : constraints
                                      .maxWidth <
                                      1300
                                      ? constraints.maxWidth / 60
                                      : constraints.maxWidth / 60,
                                  fontFamily:
                                  'gilroysemi',
                                  color: notifier.blackcolor,
                                  fontWeight:
                                  FontWeight.w600),
                              decoration:
                              InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  disabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  hintText:
                                  'Location',
                                  hintStyle:
                                  TextStyle(
                                      color: notifier
                                          .blackcolor,
                                      fontSize: constraints.maxWidth <
                                          1000
                                          ? constraints.maxWidth / 60
                                          : constraints.maxWidth <
                                          1300
                                          ? constraints.maxWidth / 60
                                          : constraints.maxWidth / 60,
                                      fontFamily:
                                      'gilroysemi',
                                      fontWeight:
                                      FontWeight
                                          .w600)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Where are you going?',
                            style: TextStyle(
                                fontSize: constraints
                                    .maxWidth <
                                    1000
                                    ? constraints.maxWidth / 100
                                    : constraints
                                    .maxWidth <
                                    1300
                                    ? constraints.maxWidth / 105
                                    : constraints.maxWidth / 100,
                                fontFamily: 'gilroymed',
                                color: Colors
                                    .grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Expanded(
                child: Container(
                  height: constraints.maxWidth > 1800 ? 140 : constraints
                      .maxWidth > 2200 ? 170 : 100,
                  decoration: BoxDecoration(
                      border:
                      Border(right: BorderSide(color: notifier.sugestionbutton),
                        bottom: BorderSide(color: notifier.sugestionbutton),
                        top: BorderSide(color: notifier.sugestionbutton),
                      )
                  ),
                  child: InkWell(
                    onTap: () {
                      buildDialog();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Departure', style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  color: notifier.blackcolor,
                                  fontSize: constraints.maxWidth < 1000
                                      ? constraints.maxWidth / 110
                                      : constraints.maxWidth / 120)),
                              Icon(Icons.keyboard_arrow_down_rounded,
                                  size: constraints.maxWidth / 80,
                                  color: notifier.buttoncolor),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            // height: constraints
                            //     .maxWidth <
                            //     1000
                            //     ? constraints.maxWidth / 60
                            //     : constraints
                            //     .maxWidth <
                            //     1300
                            //     ? constraints.maxWidth / 60
                            //     : constraints.maxWidth / 60,
                            child: RichText(
                                text: TextSpan(
                                    text: DateFormat.d().format(DateTime.now()),
                                    style: TextStyle(
                                        fontSize: constraints
                                            .maxWidth <
                                            1000
                                            ? constraints.maxWidth / 60
                                            : constraints
                                            .maxWidth <
                                            1300
                                            ? constraints.maxWidth / 60
                                            : constraints.maxWidth / 60,
                                        color: notifier.blackcolor,
                                        fontFamily:
                                        'gilroysemi',
                                        fontWeight:
                                        FontWeight.w600
                                    ),
                                    children: [
                                      TextSpan(
                                        text: " ${DateFormat.MMM().format(
                                            DateTime.now())}'${DateFormat.y()
                                            .format(DateTime.now())}",
                                        style: TextStyle(
                                          fontSize: constraints
                                              .maxWidth <
                                              1000
                                              ? constraints.maxWidth / 85
                                              : constraints
                                              .maxWidth <
                                              1300
                                              ? constraints.maxWidth / 85
                                              : constraints.maxWidth / 85,
                                          color: notifier.blackcolor,
                                          fontFamily:
                                          'gilroy',
                                        ),
                                      ),
                                    ]
                                )
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            DateFormat.EEEE().format(DateTime.now()),
                            style: TextStyle(
                                fontSize: constraints
                                    .maxWidth <
                                    1000
                                    ? constraints.maxWidth / 100
                                    : constraints
                                    .maxWidth <
                                    1300
                                    ? constraints.maxWidth / 105
                                    : constraints.maxWidth / 100,
                                fontFamily:
                                'gilroymed',
                                color: Colors
                                    .grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: constraints.maxWidth > 1800 ? 140 : constraints
                      .maxWidth > 2200 ? 170 : 100,
                  width: constraints.maxWidth < 1000 ? constraints.maxWidth /
                      8.5 : constraints.maxWidth < 1300 ? constraints.maxWidth /
                      9 : constraints.maxWidth < 1500 ? constraints.maxWidth /
                      10.5 : constraints.maxWidth / 9,
                  decoration: BoxDecoration(
                      border:
                      Border(right: BorderSide(color: notifier.sugestionbutton),
                        bottom: BorderSide(color: notifier.sugestionbutton),
                        top: BorderSide(color: notifier.sugestionbutton),
                      )
                  ),
                  child: InkWell(
                    onTap: () {
                      buildDialog();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Return', style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  color: notifier.blackcolor,
                                  fontSize: constraints.maxWidth < 1500
                                      ? constraints.maxWidth / 110
                                      : constraints.maxWidth / 120)),
                              Icon(Icons.keyboard_arrow_down_rounded,
                                  size: constraints.maxWidth / 80,
                                  color: notifier.buttoncolor),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            // height: constraints
                            //     .maxWidth <
                            //     1000
                            //     ? constraints.maxWidth / 60
                            //     : constraints
                            //     .maxWidth <
                            //     1300
                            //     ? constraints.maxWidth / 60
                            //     : constraints.maxWidth / 60,
                              child: RichText(
                                  text: TextSpan(
                                      text: DateFormat.d().format(
                                          DateTime.now()),
                                      style: TextStyle(
                                          fontSize: constraints
                                              .maxWidth <
                                              1000
                                              ? constraints.maxWidth / 60
                                              : constraints
                                              .maxWidth <
                                              1300
                                              ? constraints.maxWidth / 60
                                              : constraints.maxWidth / 60,
                                          fontFamily:
                                          'gilroysemi',
                                          color: notifier.blackcolor,
                                          fontWeight:
                                          FontWeight.w600
                                      ),
                                      children: [
                                        TextSpan(
                                          text: " ${DateFormat.MMM().format(
                                              DateTime.now())}'${DateFormat.y()
                                              .format(DateTime.now())}",
                                          style: TextStyle(
                                            fontSize: constraints
                                                .maxWidth <
                                                1000
                                                ? constraints.maxWidth / 85
                                                : constraints
                                                .maxWidth <
                                                1300
                                                ? constraints.maxWidth / 90
                                                : constraints.maxWidth / 85,
                                            fontFamily:
                                            'gilroy',
                                          ),
                                        ),
                                      ]
                                  )
                              )
                          ),
                          const SizedBox(height: 10),
                          Text(
                            DateFormat.EEEE().format(DateTime.now()),
                            style: TextStyle(
                                fontSize: constraints
                                    .maxWidth <
                                    1000
                                    ? constraints.maxWidth / 100
                                    : constraints
                                    .maxWidth <
                                    1300
                                    ? constraints.maxWidth / 105
                                    : constraints.maxWidth / 100,
                                fontFamily:
                                'gilroymed',
                                color: Colors
                                    .grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    height: constraints.maxWidth > 1800 ? 140 : constraints
                        .maxWidth > 2200 ? 170 : 100,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border:
                        Border(
                          right: BorderSide(color: notifier.sugestionbutton),
                          bottom: BorderSide(color: notifier.sugestionbutton),
                          top: BorderSide(color: notifier.sugestionbutton),
                        )
                    ),
                    child: PopupMenuButton(
                      tooltip: '',
                      padding: const EdgeInsets.all(0),
                      offset: const Offset(70, -300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // initialValue: selectedMenu,
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                        maxHeight: 400,
                      ),
                      color: notifier.whitecolor,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Row(
                                children: [
                                  Text('Travellers & Class', style: TextStyle(
                                      fontFamily: 'gilroysemi',
                                      color: notifier.blackcolor,
                                      fontSize: constraints.maxWidth < 1500
                                          ? constraints.maxWidth / 110
                                          : constraints.maxWidth / 120)),
                                  Icon(Icons.keyboard_arrow_down_rounded,
                                      size: constraints.maxWidth / 80,
                                      color: notifier.buttoncolor),
                                ],
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                // height: constraints
                                //     .maxWidth <
                                //     1000
                                //     ? constraints.maxWidth / 60
                                //     : constraints
                                //     .maxWidth <
                                //     1300
                                //     ? constraints.maxWidth / 60
                                //     : constraints.maxWidth / 60,
                                child: RichText(
                                  text: TextSpan(
                                    text: "1",
                                    style: TextStyle(
                                        fontSize: constraints
                                            .maxWidth <
                                            1000
                                            ? constraints.maxWidth / 60
                                            : constraints
                                            .maxWidth <
                                            1300
                                            ? constraints.maxWidth / 60
                                            : constraints.maxWidth / 60,
                                        color: notifier.blackcolor,
                                        fontFamily:
                                        'gilroysemi',
                                        fontWeight:
                                        FontWeight.w600
                                    ),
                                    children: [
                                      TextSpan(
                                        text: " Traveller",
                                        style: TextStyle(
                                          fontSize: constraints
                                              .maxWidth <
                                              1000
                                              ? constraints.maxWidth / 85
                                              : constraints
                                              .maxWidth <
                                              1300
                                              ? constraints.maxWidth / 85
                                              : constraints.maxWidth / 85,
                                          fontFamily:
                                          'gilroy',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text('Economy/Premium Economy',
                                style: TextStyle(
                                    fontSize: constraints
                                        .maxWidth <
                                        1000
                                        ? constraints.maxWidth / 100
                                        : constraints
                                        .maxWidth <
                                        1300
                                        ? constraints.maxWidth / 105
                                        : constraints.maxWidth / 100,
                                    fontFamily:
                                    'gilroymed',
                                    color: Colors
                                        .grey.shade500),
                              ),
                            ],
                          )
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
                              selectedvalue = travelerstype[0];
                            });
                          },
                          child: StatefulBuilder(builder: (context, setState) {
                            return Container(
                              height: 240,
                              width: 350,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Container(
                                      height: 240,
                                      alignment: Alignment.center,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: ageType.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(ageType[index],
                                                          style: TextStyle(
                                                              color: notifier
                                                                  .blackcolor,
                                                              fontFamily: 'gilroysemi',
                                                              fontSize: 16)),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                if (add[index] >
                                                                    0) {
                                                                  add[index] -=
                                                                  1;
                                                                }
                                                              });
                                                            },
                                                            onHover: (value) {
                                                              setState(() {
                                                                if (add[index] >
                                                                    0) {
                                                                  subHover[index] =
                                                                      value;
                                                                }
                                                              });
                                                            },
                                                            child: Icon(Icons
                                                                .remove_circle_outline_rounded,
                                                                size: 20,
                                                                color: add[index] ==
                                                                    0
                                                                    ? notifier
                                                                    .sugestionbutton
                                                                    : subHover[index]
                                                                    ? notifier
                                                                    .buttoncolor
                                                                    : add[index] >
                                                                    0
                                                                    ? notifier
                                                                    .subgreycolor
                                                                    : notifier
                                                                    .sugestionbutton),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Container(
                                                            width: 25,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                '${add[index]}',
                                                                style: TextStyle(
                                                                    fontFamily: 'gilroysemi',
                                                                    fontSize: 18,
                                                                    color: notifier
                                                                        .blackcolor)),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  add[index] +=
                                                                  1;
                                                                });
                                                              },
                                                              onHover: (value) {
                                                                setState(() {
                                                                  addHover[index] =
                                                                      value;
                                                                });
                                                              },
                                                              child: AnimatedContainer(
                                                                duration: const Duration(
                                                                    milliseconds: 200),
                                                                child: Icon(
                                                                    Icons
                                                                        .add_circle_outline_rounded,
                                                                    size: 20,
                                                                    color: addHover[index]
                                                                        ? notifier
                                                                        .buttoncolor
                                                                        : notifier
                                                                        .subgreycolor),
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Text(ageRange[index],
                                                      style: TextStyle(
                                                          color: notifier
                                                              .subgreycolor,
                                                          fontFamily: 'gilroymed',
                                                          fontSize: 12)),
                                                ],
                                              ),
                                              index == 2
                                                  ? const SizedBox()
                                                  : const SizedBox(height: 10,),
                                              index == 2
                                                  ? const SizedBox()
                                                  : Divider(
                                                color: notifier.sugestionbutton,
                                              ),
                                              index == 2
                                                  ? const SizedBox()
                                                  : const SizedBox(height: 16),
                                            ],
                                          );
                                        },),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },),
                        ),
                      ],
                    ),
                  )
              ),
              const SizedBox(width: 20),
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    onHover: (value) {
                      setState(() {
                        searchHover2 = value;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: constraints.maxWidth < 1300 ? constraints
                          .maxWidth / 25 : constraints.maxWidth / 30,
                      width: constraints.maxWidth < 1300 ? constraints
                          .maxWidth / 25 : constraints.maxWidth / 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: searchHover2
                              ? Colors.indigoAccent.shade700
                              : notifier.buttoncolor),
                      child: const Icon(Icons.search,
                          color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  void buildDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: Container(
            decoration: BoxDecoration(
              color: notifier.whitecolor,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 300,
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SfDateRangePicker(
                controller: dateSelecter,
                enableMultiView: true,
                monthCellStyle:
                DateRangePickerMonthCellStyle(
                  todayCellDecoration: BoxDecoration(
                      color: notifier.buttoncolor,
                      shape: BoxShape.circle
                  ),
                  textStyle:
                  TextStyle(
                    color: notifier.blackcolor,
                    fontFamily:
                    'gilroymed',
                    fontSize: 14,
                  ),
                  blackoutDateTextStyle:
                  const TextStyle(
                    fontFamily:
                    'gilroymed',
                    fontSize: 14,
                  ),
                  todayTextStyle:
                  TextStyle(
                    fontFamily:
                    'gilroymed',
                    fontSize: 14,
                    color: notifier.blackcolor,
                  ),
                ),
                monthViewSettings:
                DateRangePickerMonthViewSettings(
                  viewHeaderStyle:
                  DateRangePickerViewHeaderStyle(
                    textStyle: TextStyle(
                        color: notifier.blackcolor,
                        fontFamily:
                        'gilroymed',
                        fontSize: 14),
                  ),
                ),
                onSelectionChanged:
                _onselectionChanged,
                backgroundColor:
                notifier
                    .whitecolor,
                view:
                DateRangePickerView
                    .month,
                startRangeSelectionColor:
                notifier
                    .blackcolor,
                endRangeSelectionColor:
                notifier
                    .blackcolor,
                rangeSelectionColor:
                notifier
                    .sugestionbutton,
                selectionColor:
                notifier
                    .blackcolor,
                selectionRadius: 50,
                viewSpacing: 30,
                selectionTextStyle:
                TextStyle(
                    color: notifier.blackwhitecolor,
                    fontFamily:
                    'gilroymed',
                    fontSize: 14),
                headerStyle:
                DateRangePickerHeaderStyle(
                  textStyle: TextStyle(
                      color: notifier.blackcolor,
                      fontFamily:
                      'gilroysemi',
                      fontSize: 18),
                ),
                selectionMode:
                DateRangePickerSelectionMode
                    .range,
                rangeTextStyle:
                TextStyle(
                    color: notifier.blackcolor,
                    fontFamily:
                    'gilroymed',
                    fontSize: 14),
              ),
            ),
          ),
        );
      },);
  }

  Widget hotelTab(constraints) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 10,),
            SizedBox(
              height: constraints.maxWidth > 1800 ? 50 : 40,
              child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              elevation: const WidgetStatePropertyAll(0),
                              backgroundColor: WidgetStatePropertyAll(
                                  (chipsHover2[index] ||
                                      selectedtrainchip == index)
                                      ? notifier.blackcolor : notifier
                                      .whitecolor
                              ),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          constraints.maxWidth > 1800
                                              ? 23
                                              : 20),
                                      side: BorderSide(
                                          color: (chipsHover2[index] ||
                                              selectedtrainchip == index)
                                              ? Colors.transparent
                                              : notifier.sugestionbutton,
                                          width: 1
                                      )
                                  )
                              )
                          ),
                          onHover: (value) {
                            setState(() {
                              chipsHover2[index] = value;
                            });
                          },
                          onPressed: () {
                            setState(() {
                              selectedtrainchip = index;
                            });
                          }, child: Text(hotelchips[index], style: TextStyle(
                          fontFamily: 'gilroybold',
                          fontSize: 14,
                          color: (chipsHover2[index] ||
                              selectedtrainchip == index) ? notifier
                              .whitecolor : notifier.blackcolor))),
                      const SizedBox(width: 10,),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: constraints.maxWidth < 800
                  ? 10
                  : 30
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: constraints.maxWidth > 1800 ? 140 : constraints
                      .maxWidth > 2200 ? 170 : 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    border: Border.all(color: notifier.sugestionbutton,),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text('From', style: TextStyle(
                            fontFamily: 'gilroysemi', color: notifier
                            .blackcolor, fontSize: constraints.maxWidth < 1000
                            ? constraints.maxWidth / 110
                            : constraints.maxWidth / 120)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: constraints
                              .maxWidth <
                              1000
                              ? constraints.maxWidth / 60
                              : constraints
                              .maxWidth <
                              1300
                              ? constraints.maxWidth / 60
                              : constraints.maxWidth / 60,
                          child: TextField(
                            style: TextStyle(
                                fontSize: constraints
                                    .maxWidth <
                                    1000
                                    ? constraints.maxWidth / 60
                                    : constraints
                                    .maxWidth <
                                    1300
                                    ? constraints.maxWidth / 60
                                    : constraints.maxWidth / 60,
                                fontFamily:
                                'gilroysemi',
                                color: notifier.blackcolor,
                                fontWeight:
                                FontWeight.w600),
                            decoration:
                            InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                disabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                hintText:
                                'Location',
                                hintStyle:
                                TextStyle(
                                    color: notifier
                                        .blackcolor,
                                    fontSize: constraints.maxWidth <
                                        1000
                                        ? constraints.maxWidth / 60
                                        : constraints.maxWidth <
                                        1300
                                        ? constraints.maxWidth / 60
                                        : constraints.maxWidth / 60,
                                    fontFamily:
                                    'gilroysemi',
                                    fontWeight:
                                    FontWeight
                                        .w600)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Where are you going?',
                          style: TextStyle(
                              fontSize: constraints
                                  .maxWidth <
                                  1000
                                  ? constraints.maxWidth / 100
                                  : constraints
                                  .maxWidth <
                                  1300
                                  ? constraints.maxWidth / 105
                                  : constraints.maxWidth / 100,
                              fontFamily: 'gilroymed',
                              color: Colors
                                  .grey.shade500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: constraints.maxWidth > 1800 ? 140 : constraints
                      .maxWidth > 2200 ? 170 : 100,
                  decoration: BoxDecoration(
                      border:
                      Border(right: BorderSide(color: notifier.sugestionbutton),
                        bottom: BorderSide(color: notifier.sugestionbutton),
                        top: BorderSide(color: notifier.sugestionbutton),
                      )
                  ),
                  child: InkWell(
                    onTap: () {
                      buildDialog();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Check In', style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  color: notifier.blackcolor,
                                  fontSize: constraints.maxWidth < 1000
                                      ? constraints.maxWidth / 110
                                      : constraints.maxWidth / 120)),
                              Icon(Icons.keyboard_arrow_down_rounded,
                                  size: constraints.maxWidth / 80,
                                  color: notifier.buttoncolor),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            // height: constraints
                            //     .maxWidth <
                            //     1000
                            //     ? constraints.maxWidth / 60
                            //     : constraints
                            //     .maxWidth <
                            //     1300
                            //     ? constraints.maxWidth / 60
                            //     : constraints.maxWidth / 60,
                            child: RichText(
                                text: TextSpan(
                                    text: DateFormat.d().format(DateTime.now()),
                                    style: TextStyle(
                                        fontSize: constraints
                                            .maxWidth <
                                            1000
                                            ? constraints.maxWidth / 60
                                            : constraints
                                            .maxWidth <
                                            1300
                                            ? constraints.maxWidth / 60
                                            : constraints.maxWidth / 60,
                                        color: notifier.blackcolor,
                                        fontFamily:
                                        'gilroysemi',
                                        fontWeight:
                                        FontWeight.w600
                                    ),
                                    children: [
                                      TextSpan(
                                        text: " ${DateFormat.MMM().format(
                                            DateTime.now())}'${DateFormat.y()
                                            .format(DateTime.now())}",
                                        style: TextStyle(
                                          fontSize: constraints
                                              .maxWidth <
                                              1000
                                              ? constraints.maxWidth / 85
                                              : constraints
                                              .maxWidth <
                                              1300
                                              ? constraints.maxWidth / 85
                                              : constraints.maxWidth / 85,
                                          fontFamily:
                                          'gilroy',
                                        ),
                                      ),
                                    ]
                                )
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            DateFormat.EEEE().format(DateTime.now()),
                            style: TextStyle(
                                fontSize: constraints
                                    .maxWidth <
                                    1000
                                    ? constraints.maxWidth / 100
                                    : constraints
                                    .maxWidth <
                                    1300
                                    ? constraints.maxWidth / 105
                                    : constraints.maxWidth / 100,
                                fontFamily:
                                'gilroymed',
                                color: Colors
                                    .grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                    height: constraints.maxWidth > 1800 ? 140 : constraints
                        .maxWidth > 2200 ? 170 : 100,
                    decoration: BoxDecoration(
                        border:
                        Border(
                          right: BorderSide(color: notifier.sugestionbutton),
                          bottom: BorderSide(color: notifier.sugestionbutton),
                          top: BorderSide(color: notifier.sugestionbutton),
                        )
                    ),
                    child: InkWell(
                      onTap: () {
                        buildDialog();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Check Out', style: TextStyle(
                                    fontFamily: 'gilroysemi',
                                    color: notifier.blackcolor,
                                    fontSize: constraints.maxWidth < 1500
                                        ? constraints.maxWidth / 110
                                        : constraints.maxWidth / 120)),
                                Icon(Icons.keyboard_arrow_down_rounded,
                                    size: constraints.maxWidth / 80,
                                    color: notifier.buttoncolor),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              // height: constraints
                              //     .maxWidth <
                              //     1000
                              //     ? constraints.maxWidth / 60
                              //     : constraints
                              //     .maxWidth <
                              //     1300
                              //     ? constraints.maxWidth / 60
                              //     : constraints.maxWidth / 60,
                              child: RichText(
                                  text: TextSpan(
                                      text: DateFormat.d().format(
                                          DateTime.now()),
                                      style: TextStyle(
                                          fontSize: constraints
                                              .maxWidth <
                                              1000
                                              ? constraints.maxWidth / 60
                                              : constraints
                                              .maxWidth <
                                              1300
                                              ? constraints.maxWidth / 60
                                              : constraints.maxWidth / 60,
                                          color: notifier.blackcolor,
                                          fontFamily:
                                          'gilroysemi',
                                          fontWeight:
                                          FontWeight.w600
                                      ),
                                      children: [
                                        TextSpan(
                                          text: " ${DateFormat.MMM().format(
                                              DateTime.now())}'${DateFormat.y()
                                              .format(DateTime.now())}",
                                          style: TextStyle(
                                            fontSize: constraints
                                                .maxWidth <
                                                1000
                                                ? constraints.maxWidth / 85
                                                : constraints
                                                .maxWidth <
                                                1300
                                                ? constraints.maxWidth / 90
                                                : constraints.maxWidth / 85,
                                            fontFamily:
                                            'gilroy',
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              DateFormat.EEEE().format(DateTime.now()),
                              style: TextStyle(
                                  fontSize: constraints
                                      .maxWidth <
                                      1000
                                      ? constraints.maxWidth / 100
                                      : constraints
                                      .maxWidth <
                                      1300
                                      ? constraints.maxWidth / 105
                                      : constraints.maxWidth / 100,
                                  fontFamily:
                                  'gilroymed',
                                  color: Colors
                                      .grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: constraints.maxWidth > 1800 ? 140 : constraints
                      .maxWidth > 2200 ? 170 : 100,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border:
                      Border(right: BorderSide(color: notifier.sugestionbutton),
                        bottom: BorderSide(color: notifier.sugestionbutton),
                        top: BorderSide(color: notifier.sugestionbutton),
                      )
                  ),
                  child: PopupMenuButton(
                    tooltip: '',
                    padding: const EdgeInsets.all(0),
                    offset: const Offset(70, -300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // initialValue: selectedMenu,
                    constraints: const BoxConstraints(
                      maxWidth: 600,
                      maxHeight: 400,
                    ),
                    color: notifier.whitecolor,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Row(
                              children: [
                                Text('Guest & Rooms', style: TextStyle(
                                    fontFamily: 'gilroysemi',
                                    color: notifier.blackcolor,
                                    fontSize: constraints.maxWidth < 1500
                                        ? constraints.maxWidth / 110
                                        : constraints.maxWidth / 120)),
                                Icon(Icons.keyboard_arrow_down_rounded,
                                    size: constraints.maxWidth / 80,
                                    color: notifier.buttoncolor),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              // height: constraints
                              //     .maxWidth <
                              //     1000
                              //     ? constraints.maxWidth / 60
                              //     : constraints
                              //     .maxWidth <
                              //     1300
                              //     ? constraints.maxWidth / 60
                              //     : constraints.maxWidth / 60,
                              child: RichText(
                                  text: TextSpan(
                                      text: "1",
                                      style: TextStyle(
                                          fontSize: constraints
                                              .maxWidth <
                                              1000
                                              ? constraints.maxWidth / 60
                                              : constraints
                                              .maxWidth <
                                              1300
                                              ? constraints.maxWidth / 60
                                              : constraints.maxWidth / 60,
                                          color: notifier.blackcolor,
                                          fontFamily:
                                          'gilroysemi',
                                          fontWeight:
                                          FontWeight.w600
                                      ),
                                      children: [
                                        TextSpan(
                                          text: " Traveller",
                                          style: TextStyle(
                                            fontSize: constraints
                                                .maxWidth <
                                                1000
                                                ? constraints.maxWidth / 85
                                                : constraints
                                                .maxWidth <
                                                1300
                                                ? constraints.maxWidth / 85
                                                : constraints.maxWidth / 85,
                                            fontFamily:
                                            'gilroy',
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('Economy/Premium Economy',
                              style: TextStyle(
                                  fontSize: constraints
                                      .maxWidth <
                                      1000
                                      ? constraints.maxWidth / 100
                                      : constraints
                                      .maxWidth <
                                      1300
                                      ? constraints.maxWidth / 105
                                      : constraints.maxWidth / 100,
                                  fontFamily:
                                  'gilroymed',
                                  color: Colors
                                      .grey.shade500),
                            ),
                          ],
                        )
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
                            selectedvalue = travelerstype[0];
                          });
                        },
                        child: StatefulBuilder(builder: (context, setState) {
                          return Container(
                            height: 240,
                            width: 350,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Container(
                                    height: 240,
                                    alignment: Alignment.center,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: ageType.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(ageType[index],
                                                        style: TextStyle(
                                                            color: notifier
                                                                .blackcolor,
                                                            fontFamily: 'gilroysemi',
                                                            fontSize: 16)),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .center,
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              if (add2[index] >
                                                                  0) {
                                                                add2[index] -=
                                                                1;
                                                              }
                                                            });
                                                          },
                                                          onHover: (value) {
                                                            setState(() {
                                                              if (add2[index] >
                                                                  0) {
                                                                subHover[index] =
                                                                    value;
                                                              }
                                                            });
                                                          },
                                                          child: Icon(Icons
                                                              .remove_circle_outline_rounded,
                                                              size: 20,
                                                              color: add2[index] ==
                                                                  0
                                                                  ? notifier
                                                                  .sugestionbutton
                                                                  : subHover[index]
                                                                  ? notifier
                                                                  .buttoncolor
                                                                  : add2[index] >
                                                                  0
                                                                  ? notifier
                                                                  .subgreycolor
                                                                  : notifier
                                                                  .sugestionbutton),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Container(
                                                          width: 25,
                                                          alignment: Alignment
                                                              .center,
                                                          child: Text(
                                                              '${add2[index]}',
                                                              style: TextStyle(
                                                                  fontFamily: 'gilroysemi',
                                                                  fontSize: 18,
                                                                  color: notifier
                                                                      .blackcolor)),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                add2[index] +=
                                                                1;
                                                              });
                                                            },
                                                            onHover: (value) {
                                                              setState(() {
                                                                addHover[index] =
                                                                    value;
                                                              });
                                                            },
                                                            child: AnimatedContainer(
                                                              duration: const Duration(
                                                                  milliseconds: 200),
                                                              child: Icon(Icons
                                                                  .add_circle_outline_rounded,
                                                                  size: 20,
                                                                  color: addHover[index]
                                                                      ? notifier
                                                                      .buttoncolor
                                                                      : notifier
                                                                      .subgreycolor),
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Text(ageRange[index],
                                                    style: TextStyle(
                                                        color: notifier
                                                            .subgreycolor,
                                                        fontFamily: 'gilroymed',
                                                        fontSize: 12)),
                                              ],
                                            ),
                                            index == 2
                                                ? const SizedBox()
                                                : const SizedBox(
                                              height: 10,),
                                            index == 2
                                                ? const SizedBox()
                                                : Divider(
                                              color: notifier.sugestionbutton,
                                            ),
                                            index == 2
                                                ? const SizedBox()
                                                : const SizedBox(
                                                height: 16),
                                          ],
                                        );
                                      },),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    onHover: (value) {
                      setState(() {
                        searchHover2 = value;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: constraints.maxWidth < 1300 ? constraints
                          .maxWidth / 25 : constraints.maxWidth / 30,
                      width: constraints.maxWidth < 1300 ? constraints
                          .maxWidth / 25 : constraints.maxWidth / 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: searchHover2
                              ? Colors.indigoAccent.shade700
                              : notifier.buttoncolor),
                      child: const Icon(Icons.search,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget trainTab(constraints) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 10,),
            SizedBox(
              height: constraints.maxWidth > 1800 ? 50 : 40,
              child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              elevation: const WidgetStatePropertyAll(0),
                              backgroundColor: WidgetStatePropertyAll(
                                  (chipsHover2[index] ||
                                      selectedtrainchip == index)
                                      ? notifier.blackcolor : notifier
                                      .whitecolor
                              ),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          constraints.maxWidth > 1800
                                              ? 23
                                              : 20),
                                      side: BorderSide(
                                          color: (chipsHover2[index] ||
                                              selectedtrainchip == index)
                                              ? Colors.transparent
                                              : notifier.sugestionbutton,
                                          width: 1
                                      )
                                  )
                              )
                          ),
                          onHover: (value) {
                            setState(() {
                              chipsHover2[index] = value;
                            });
                          },
                          onPressed: () {
                            setState(() {
                              selectedtrainchip = index;
                            });
                          }, child: Text(hotelchips[index], style: TextStyle(
                          fontFamily: 'gilroybold',
                          fontSize: 14,
                          color: (chipsHover2[index] ||
                              selectedtrainchip == index) ? notifier
                              .whitecolor : notifier.blackcolor))),
                      const SizedBox(width: 10,),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
              child: ListView.builder(
                itemCount: checkTrain.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: check[index] ? notifier.lightblue : Colors
                                .transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                              children: [
                                Checkbox(
                                  shape: const CircleBorder(),
                                  value: check[index],
                                  onChanged: (value) {
                                    setState(() {
                                      check[index] = value!;
                                    });
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (check[index] == false) {
                                        check[index] = true;
                                      } else {
                                        check[index] = false;
                                      }
                                    });
                                  },
                                  child: Text(checkTrain[index],
                                      style: TextStyle(fontFamily: 'gilroysemi',
                                          fontSize: 14,
                                          color: check[index] ? Colors.black : const Color(0xFFE6E8EC))),
                                ),
                                const SizedBox(width: 10),
                              ]
                          ),
                        ),
                        const SizedBox(width: 10),
                      ]
                  );
                },),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: constraints.maxWidth < 800
                  ? 10
                  : 30
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: constraints.maxWidth > 1800 ? 140 : constraints
                      .maxWidth > 2200 ? 170 : 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    border: Border.all(color: notifier.sugestionbutton,),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text('From', style: TextStyle(
                            fontFamily: 'gilroysemi', color: notifier
                            .blackcolor, fontSize: constraints.maxWidth < 1000
                            ? constraints.maxWidth / 110
                            : constraints.maxWidth / 120)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: constraints
                              .maxWidth <
                              1000
                              ? constraints.maxWidth / 60
                              : constraints
                              .maxWidth <
                              1300
                              ? constraints.maxWidth / 60
                              : constraints.maxWidth / 60,
                          child: TextField(
                            style: TextStyle(
                                fontSize: constraints
                                    .maxWidth <
                                    1000
                                    ? constraints.maxWidth / 60
                                    : constraints
                                    .maxWidth <
                                    1300
                                    ? constraints.maxWidth / 60
                                    : constraints.maxWidth / 60,
                                fontFamily:
                                'gilroysemi',
                                color: notifier.blackcolor,
                                fontWeight:
                                FontWeight.w600),
                            decoration:
                            InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                disabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                hintText:
                                'Location',
                                hintStyle:
                                TextStyle(
                                    color: notifier
                                        .blackcolor,
                                    fontSize: constraints.maxWidth <
                                        1000
                                        ? constraints.maxWidth / 60
                                        : constraints.maxWidth <
                                        1300
                                        ? constraints.maxWidth / 60
                                        : constraints.maxWidth / 60,
                                    fontFamily:
                                    'gilroysemi',
                                    fontWeight:
                                    FontWeight
                                        .w600)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Where are you going?',
                          style: TextStyle(
                              fontSize: constraints
                                  .maxWidth <
                                  1000
                                  ? constraints.maxWidth / 100
                                  : constraints
                                  .maxWidth <
                                  1300
                                  ? constraints.maxWidth / 105
                                  : constraints.maxWidth / 100,
                              fontFamily: 'gilroymed',
                              color: Colors
                                  .grey.shade500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    height: constraints.maxWidth > 1800 ? 140 : constraints
                        .maxWidth > 2200 ? 170 : 100,
                    decoration: BoxDecoration(
                      border:
                      Border(right: BorderSide(color: notifier.sugestionbutton),
                        bottom: BorderSide(color: notifier.sugestionbutton),
                        top: BorderSide(color: notifier.sugestionbutton),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text('To', style: TextStyle(
                              fontFamily: 'gilroysemi', color: notifier
                              .blackcolor, fontSize: constraints.maxWidth < 1000
                              ? constraints.maxWidth / 110
                              : constraints.maxWidth / 120)),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: constraints
                                .maxWidth <
                                1000
                                ? constraints.maxWidth / 60
                                : constraints
                                .maxWidth <
                                1300
                                ? constraints.maxWidth / 60
                                : constraints.maxWidth / 60,
                            child: TextField(
                              style: TextStyle(
                                  fontSize: constraints
                                      .maxWidth <
                                      1000
                                      ? constraints.maxWidth / 60
                                      : constraints
                                      .maxWidth <
                                      1300
                                      ? constraints.maxWidth / 60
                                      : constraints.maxWidth / 60,
                                  fontFamily:
                                  'gilroysemi',
                                  color: notifier.blackcolor,
                                  fontWeight:
                                  FontWeight.w600),
                              decoration:
                              InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  disabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  hintText:
                                  'Location',
                                  hintStyle:
                                  TextStyle(
                                      color: notifier
                                          .blackcolor,
                                      fontSize: constraints.maxWidth <
                                          1000
                                          ? constraints.maxWidth / 60
                                          : constraints.maxWidth <
                                          1300
                                          ? constraints.maxWidth / 60
                                          : constraints.maxWidth / 60,
                                      fontFamily:
                                      'gilroysemi',
                                      fontWeight:
                                      FontWeight
                                          .w600)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Where are you going?',
                            style: TextStyle(
                                fontSize: constraints
                                    .maxWidth <
                                    1000
                                    ? constraints.maxWidth / 100
                                    : constraints
                                    .maxWidth <
                                    1300
                                    ? constraints.maxWidth / 105
                                    : constraints.maxWidth / 100,
                                fontFamily: 'gilroymed',
                                color: Colors
                                    .grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: constraints.maxWidth > 1800 ? 140 : constraints
                      .maxWidth > 2200 ? 170 : 100,
                  // width: constraints.maxWidth < 1000 ? constraints.maxWidth / 8.5 : constraints.maxWidth < 1300 ? constraints.maxWidth / 9 : constraints.maxWidth < 1500 ? constraints.maxWidth / 10.5 : constraints.maxWidth / 9,
                  decoration: BoxDecoration(
                      border:
                      Border(right: BorderSide(color: notifier.sugestionbutton),
                        bottom: BorderSide(color: notifier.sugestionbutton),
                        top: BorderSide(color: notifier.sugestionbutton),
                      )
                  ),
                  child: InkWell(
                    onTap: () {
                      buildDialog();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Travel Date', style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  color: notifier.blackcolor,
                                  fontSize: constraints.maxWidth < 1500
                                      ? constraints.maxWidth / 110
                                      : constraints.maxWidth / 120)),
                              Icon(Icons.keyboard_arrow_down_rounded,
                                  size: constraints.maxWidth / 80,
                                  color: notifier.buttoncolor),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            // height: constraints
                            //     .maxWidth <
                            //     1000
                            //     ? constraints.maxWidth / 60
                            //     : constraints
                            //     .maxWidth <
                            //     1300
                            //     ? constraints.maxWidth / 60
                            //     : constraints.maxWidth / 60,
                            child: RichText(
                                text: TextSpan(
                                    text: DateFormat.d().format(DateTime.now()),
                                    style: TextStyle(
                                        fontSize: constraints
                                            .maxWidth <
                                            1000
                                            ? constraints.maxWidth / 60
                                            : constraints
                                            .maxWidth <
                                            1300
                                            ? constraints.maxWidth / 60
                                            : constraints.maxWidth / 60,
                                        color: notifier.blackcolor,
                                        fontFamily:
                                        'gilroysemi',
                                        fontWeight:
                                        FontWeight.w600
                                    ),
                                    children: [
                                      TextSpan(
                                        text: " ${DateFormat.MMM().format(
                                            DateTime.now())}'${DateFormat.y()
                                            .format(DateTime.now())}",
                                        style: TextStyle(
                                          fontSize: constraints
                                              .maxWidth <
                                              1000
                                              ? constraints.maxWidth / 85
                                              : constraints
                                              .maxWidth <
                                              1300
                                              ? constraints.maxWidth / 90
                                              : constraints.maxWidth / 85,
                                          fontFamily:
                                          'gilroy',
                                        ),
                                      ),
                                    ]
                                )
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            DateFormat.EEEE().format(DateTime.now()),
                            style: TextStyle(
                                fontSize: constraints
                                    .maxWidth <
                                    1000
                                    ? constraints.maxWidth / 100
                                    : constraints
                                    .maxWidth <
                                    1300
                                    ? constraints.maxWidth / 105
                                    : constraints.maxWidth / 100,
                                fontFamily:
                                'gilroymed',
                                color: Colors
                                    .grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: constraints.maxWidth > 1800 ? 140 : constraints
                      .maxWidth > 2200 ? 170 : 100,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border:
                      Border(right: BorderSide(color: notifier.sugestionbutton),
                        bottom: BorderSide(color: notifier.sugestionbutton),
                        top: BorderSide(color: notifier.sugestionbutton),
                      )
                  ),
                  child: PopupMenuButton(
                    tooltip: '',
                    padding: const EdgeInsets.all(0),
                    offset: const Offset(70, -350),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // initialValue: selectedMenu,
                    constraints: const BoxConstraints(
                      maxWidth: 600,
                      maxHeight: 400,
                    ),
                    color: notifier.whitecolor,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Row(
                              children: [
                                Text('Class', style: TextStyle(
                                    fontFamily: 'gilroysemi',
                                    color: notifier.blackcolor,
                                    fontSize: constraints.maxWidth < 1500
                                        ? constraints.maxWidth / 110
                                        : constraints.maxWidth / 120)),
                                Icon(Icons.keyboard_arrow_down_rounded,
                                    size: constraints.maxWidth / 80,
                                    color: notifier.buttoncolor),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              // height: constraints
                              //     .maxWidth <
                              //     1000
                              //     ? constraints.maxWidth / 60
                              //     : constraints
                              //     .maxWidth <
                              //     1300
                              //     ? constraints.maxWidth / 60
                              //     : constraints.maxWidth / 60,
                              child: Text(
                                  'All', style: TextStyle(fontSize: constraints
                                  .maxWidth <
                                  1000
                                  ? constraints.maxWidth / 60
                                  : constraints
                                  .maxWidth <
                                  1300
                                  ? constraints.maxWidth / 60
                                  : constraints.maxWidth / 60,
                                  color: notifier.blackcolor,
                                  fontFamily:
                                  'gilroysemi',
                                  fontWeight:
                                  FontWeight.w600)),
                            ),
                            const SizedBox(height: 10),
                            Text('All Class',
                              style: TextStyle(
                                  fontSize: constraints
                                      .maxWidth <
                                      1000
                                      ? constraints.maxWidth / 100
                                      : constraints
                                      .maxWidth <
                                      1300
                                      ? constraints.maxWidth / 105
                                      : constraints.maxWidth / 100,
                                  fontFamily:
                                  'gilroymed',
                                  color: Colors
                                      .grey.shade500),
                            ),
                          ],
                        )
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
                            selectedvalue = travelerstype[0];
                          });
                        },
                        child: const SizedBox(
                          height: 300,
                          width: 400,
                          child: Column(
                            children: [
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    onHover: (value) {
                      setState(() {
                        searchHover2 = value;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: constraints.maxWidth < 1300 ? constraints
                          .maxWidth / 25 : constraints.maxWidth / 30,
                      width: constraints.maxWidth < 1300 ? constraints
                          .maxWidth / 25 : constraints.maxWidth / 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: searchHover2
                              ? Colors.indigoAccent.shade700
                              : notifier.buttoncolor),
                      child: const Icon(Icons.search,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget busTab(constraints) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: constraints.maxWidth < 800
                  ? 10
                  : 30
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: constraints.maxWidth > 1800 ? 140 : constraints
                      .maxWidth > 2200 ? 170 : 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    border: Border.all(color: notifier.sugestionbutton,),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text('From', style: TextStyle(
                            fontFamily: 'gilroysemi', color: notifier
                            .blackcolor, fontSize: constraints.maxWidth < 1000
                            ? constraints.maxWidth / 110
                            : constraints.maxWidth / 120)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: constraints
                              .maxWidth <
                              1000
                              ? constraints.maxWidth / 60
                              : constraints
                              .maxWidth <
                              1300
                              ? constraints.maxWidth / 60
                              : constraints.maxWidth / 60,
                          child: TextField(
                            style: TextStyle(
                                fontSize: constraints
                                    .maxWidth <
                                    1000
                                    ? constraints.maxWidth / 60
                                    : constraints
                                    .maxWidth <
                                    1300
                                    ? constraints.maxWidth / 60
                                    : constraints.maxWidth / 60,
                                fontFamily:
                                'gilroysemi',
                                color: notifier.blackcolor,
                                fontWeight:
                                FontWeight.w600),
                            decoration:
                            InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                disabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                hintText:
                                'Location',
                                hintStyle:
                                TextStyle(
                                    color: notifier
                                        .blackcolor,
                                    fontSize: constraints.maxWidth <
                                        1000
                                        ? constraints.maxWidth / 60
                                        : constraints.maxWidth <
                                        1300
                                        ? constraints.maxWidth / 60
                                        : constraints.maxWidth / 60,
                                    fontFamily:
                                    'gilroysemi',
                                    fontWeight:
                                    FontWeight
                                        .w600)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Where are you going?',
                          style: TextStyle(
                              fontSize: constraints
                                  .maxWidth <
                                  1000
                                  ? constraints.maxWidth / 100
                                  : constraints
                                  .maxWidth <
                                  1300
                                  ? constraints.maxWidth / 105
                                  : constraints.maxWidth / 100,
                              fontFamily: 'gilroymed',
                              color: Colors
                                  .grey.shade500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    height: constraints.maxWidth > 1800 ? 140 : constraints
                        .maxWidth > 2200 ? 170 : 100,
                    decoration: BoxDecoration(
                      border:
                      Border(right: BorderSide(color: notifier.sugestionbutton),
                        bottom: BorderSide(color: notifier.sugestionbutton),
                        top: BorderSide(color: notifier.sugestionbutton),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text('To', style: TextStyle(
                              fontFamily: 'gilroysemi', color: notifier
                              .blackcolor, fontSize: constraints.maxWidth < 1000
                              ? constraints.maxWidth / 110
                              : constraints.maxWidth / 120)),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: constraints
                                .maxWidth <
                                1000
                                ? constraints.maxWidth / 60
                                : constraints
                                .maxWidth <
                                1300
                                ? constraints.maxWidth / 60
                                : constraints.maxWidth / 60,
                            child: TextField(
                              style: TextStyle(
                                  fontSize: constraints
                                      .maxWidth <
                                      1000
                                      ? constraints.maxWidth / 60
                                      : constraints
                                      .maxWidth <
                                      1300
                                      ? constraints.maxWidth / 60
                                      : constraints.maxWidth / 60,
                                  fontFamily:
                                  'gilroysemi',
                                  color: notifier.blackcolor,
                                  fontWeight:
                                  FontWeight.w600),
                              decoration:
                              InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  disabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  hintText:
                                  'Location',
                                  hintStyle:
                                  TextStyle(
                                      color: notifier
                                          .blackcolor,
                                      fontSize: constraints.maxWidth <
                                          1000
                                          ? constraints.maxWidth / 60
                                          : constraints.maxWidth <
                                          1300
                                          ? constraints.maxWidth / 60
                                          : constraints.maxWidth / 60,
                                      fontFamily:
                                      'gilroysemi',
                                      fontWeight:
                                      FontWeight
                                          .w600)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Where are you going?',
                            style: TextStyle(
                                fontSize: constraints
                                    .maxWidth <
                                    1000
                                    ? constraints.maxWidth / 100
                                    : constraints
                                    .maxWidth <
                                    1300
                                    ? constraints.maxWidth / 105
                                    : constraints.maxWidth / 100,
                                fontFamily: 'gilroymed',
                                color: Colors
                                    .grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: constraints.maxWidth > 1800 ? 140 : constraints
                        .maxWidth > 2200 ? 170 : 100,
                    // width: constraints.maxWidth < 1000 ? constraints.maxWidth / 8.5 : constraints.maxWidth < 1300 ? constraints.maxWidth / 9 : constraints.maxWidth < 1500 ? constraints.maxWidth / 10.5 : constraints.maxWidth / 9,
                    decoration: BoxDecoration(
                        border:
                        Border(
                          right: BorderSide(color: notifier.sugestionbutton),
                          bottom: BorderSide(color: notifier.sugestionbutton),
                          top: BorderSide(color: notifier.sugestionbutton),
                        )
                    ),
                    child: InkWell(
                      onTap: () {
                        buildDialog();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Travel Date', style: TextStyle(
                                    fontFamily: 'gilroysemi',
                                    color: notifier.blackcolor,
                                    fontSize: constraints.maxWidth < 1500
                                        ? constraints.maxWidth / 110
                                        : constraints.maxWidth / 120)),
                                Icon(Icons.keyboard_arrow_down_rounded,
                                    size: constraints.maxWidth / 80,
                                    color: notifier.buttoncolor),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              // height: constraints
                              //     .maxWidth <
                              //     1000
                              //     ? constraints.maxWidth / 60
                              //     : constraints
                              //     .maxWidth <
                              //     1300
                              //     ? constraints.maxWidth / 60
                              //     : constraints.maxWidth / 60,
                              child: RichText(
                                text: TextSpan(
                                  text: DateFormat.d().format(DateTime.now()),
                                  style: TextStyle(
                                      fontSize: constraints
                                          .maxWidth <
                                          1000
                                          ? constraints.maxWidth / 60
                                          : constraints
                                          .maxWidth <
                                          1300
                                          ? constraints.maxWidth / 60
                                          : constraints.maxWidth / 60,
                                      color: notifier.blackcolor,
                                      fontFamily: 'gilroysemi',
                                      fontWeight:
                                      FontWeight.w600
                                  ),
                                  children: [
                                    TextSpan(
                                      text: " ${DateFormat.MMM().format(
                                          DateTime.now())}'${DateFormat.y()
                                          .format(DateTime.now())}",
                                      style: TextStyle(
                                        fontSize: constraints
                                            .maxWidth <
                                            1000
                                            ? constraints.maxWidth / 85
                                            : constraints
                                            .maxWidth <
                                            1300
                                            ? constraints.maxWidth / 90
                                            : constraints.maxWidth / 85,
                                        fontFamily:
                                        'gilroy',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              DateFormat.EEEE().format(DateTime.now()),
                              style: TextStyle(
                                  fontSize: constraints
                                      .maxWidth <
                                      1000
                                      ? constraints.maxWidth / 100
                                      : constraints
                                      .maxWidth <
                                      1300
                                      ? constraints.maxWidth / 105
                                      : constraints.maxWidth / 100,
                                  fontFamily:
                                  'gilroymed',
                                  color: Colors
                                      .grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
              const SizedBox(width: 20),
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    onHover: (value) {
                      setState(() {
                        searchHover2 = value;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: constraints.maxWidth < 1300 ? constraints
                          .maxWidth / 25 : constraints.maxWidth / 30,
                      width: constraints.maxWidth < 1300 ? constraints
                          .maxWidth / 25 : constraints.maxWidth / 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: searchHover2
                              ? Colors.indigoAccent.shade700
                              : notifier.buttoncolor),
                      child: const Icon(Icons.search,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

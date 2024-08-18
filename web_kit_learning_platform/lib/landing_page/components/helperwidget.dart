// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/landing_page/deshboard/landing_page.dart';

import '../mediaquery/mq.dart';
import 'colornotifier.dart';

class help extends StatefulWidget {
  const help({super.key});

  @override
  State<help> createState() => _helpState();
}

class _helpState extends State<help> {
  late ColorNotifier notifier;
  int tabHover = 0;

  List<bool> addHover = [false, false, false];
  List<bool> subHover = [false, false, false];
  List<int> add = [0, 0, 0];
  List<int> add2 = [0, 0, 0];
  List ageType = ['Adults', 'Children', 'Adults'];
  List ageRange = ['Ages 13 or above', 'Ages 2 - 12', 'Under 2'];

  void _onselectionChanged(DateRangePickerSelectionChangedArgs args) {}
  DateRangePickerController dateSelecter = DateRangePickerController();

  List<bool> chipsHover1 = [false, false, false];
  List<bool> chipsHover2 = [false, false, false];
  List<bool> chipsHover3 = [false, false, false];
  List Tabchips = ['Round-trip', 'One-way', 'Multi City'];
  List hotelchips = ['India', 'International'];
  String selectedvalue = '';
  int selectedchip = 0;
  int selectedVillaChip = 0;
  int selectedHolidayChip = 0;
  int selectedCabChip = 0;
  int selectedhotelchip = 0;
  int selectedtrainchip = 0;
  int selectedHotelchip = 0;

  List checkTrain = [
    'Book Train Tickets',
    'Check PNR Status',
    'Live Train Status'
  ];

  List<bool> check = [true, false, false];

  bool searchHover2 = false;
  List Travelerstype = ['Stays', 'Flights', 'Things to do', 'Cars'];
  List Travelerstype2 = ['Stays', 'Flights', 'Things to do', 'Cars', 'Support'];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return panel(constraints, context);
      },
    );
  }

  Widget panel(constraints, context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        decoration : BoxDecoration(
          borderRadius: BorderRadius.circular(20)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: notifier.isDark
                    ? const Color(0xFF23262F).withOpacity(0.2)
                    : Colors.white30,
              ),
              height: 420,
              width: width / 1.1,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Column(
                  children: [
                    Expanded(
                      // height: height / 2.201,
                      child: DefaultTabController(
                        length: 7,
                        initialIndex: 0,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 120,
                              width: width / 1,
                              child: TabBar(
                                unselectedLabelColor: notifier.textcolor,
                                labelColor: notifier.buttoncolor,
                                onTap: (value) {
                                  setState(() {
                                    tabHover = value;
                                  });
                                },
                                isScrollable: true,
                                indicatorPadding: const EdgeInsets.all(9),
                                indicatorWeight: 1,
                                indicatorColor: notifier.blackcolor,
                                tabs: [
                                  Tab(
                                    height: 120,
                                    icon: tabHover == 0
                                        ? Image.asset(
                                            'assets/Icons/tabIcon/flightcoloricon.png',
                                            height: 30)
                                        : Image.asset(
                                            'assets/Icons/tabIcon/flightblackicon.png',
                                            height: 30),
                                    child: Text(
                                      'Flights',
                                      style: baseStyle.copyWith(
                                        
                                        fontSize:
                                            constraints.maxWidth < 700 ? 12 : 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Tab(
                                    height: 120,
                                    icon: tabHover == 1
                                        ? Image.asset(
                                            'assets/Icons/tabIcon/hotelcoloricon.png',
                                            height: 30)
                                        : Image.asset(
                                            'assets/Icons/tabIcon/hotelblackicon.png',
                                            height: 30),
                                    child: Text(
                                      'Hotels',
                                      style: baseStyle.copyWith(
                                        
                                        fontSize:
                                            constraints.maxWidth < 700 ? 12 : 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Tab(
                                    height: 120,
                                    iconMargin:
                                        const EdgeInsets.only(top: 20, bottom: 8),
                                    icon: tabHover == 2
                                        ? Image.asset(
                                            'assets/Icons/tabIcon/homestaycoloricon.png',
                                            height: 30)
                                        : Image.asset(
                                            'assets/Icons/tabIcon/homestayblackicon.png',
                                            height: 30),
                                    child: Text(
                                      'Homestays &\n Villas',
                                      style: baseStyle.copyWith(
                                        
                                        fontSize:
                                            constraints.maxWidth < 700 ? 11 : 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Tab(
                                    height: 120,
                                    iconMargin:
                                        const EdgeInsets.only(top: 20, bottom: 8),
                                    icon: tabHover == 3
                                        ? Image.asset(
                                            'assets/Icons/tabIcon/holidaycoloricon.png',
                                            height: 30)
                                        : Image.asset(
                                            'assets/Icons/tabIcon/holidayblackicon.png',
                                            height: 30),
                                    child: Text(
                                      'Holiday\nPackages',
                                      style: baseStyle.copyWith(
                                        
                                        fontSize:
                                            constraints.maxWidth < 700 ? 12 : 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Tab(
                                    height: 120,
                                    iconMargin: const EdgeInsets.only(bottom: 10),
                                    icon: tabHover == 4
                                        ? Image.asset(
                                            'assets/Icons/tabIcon/traincoloricon.png',
                                            height: 30)
                                        : Image.asset(
                                            'assets/Icons/tabIcon/trainblackicon.png',
                                            height: 30),
                                    child: Text(
                                      'Trains',
                                      style: baseStyle.copyWith(
                                        
                                        fontSize:
                                            constraints.maxWidth < 700 ? 12 : 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Tab(
                                    height: 120,
                                    icon: tabHover == 5
                                        ? Image.asset(
                                            'assets/Icons/tabIcon/buscoloricon.png',
                                            height: 30)
                                        : Image.asset(
                                            'assets/Icons/tabIcon/busblackicon.png',
                                            height: 30),
                                    child: Text(
                                      'Buses',
                                      style: baseStyle.copyWith(
                                        
                                        fontSize:
                                            constraints.maxWidth < 700 ? 12 : 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Tab(
                                    height: 120,
                                    icon: tabHover == 6
                                        ? Image.asset(
                                            'assets/Icons/tabIcon/taxicoloricon.png',
                                            height: 30)
                                        : Image.asset(
                                            'assets/Icons/tabIcon/taxiblackicon.png',
                                            height: 30),
                                    child: Text(
                                      'Cabs',
                                      style: baseStyle.copyWith(
                                        
                                        fontSize:
                                            constraints.maxWidth < 700 ? 12 : 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(children: [
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
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  void buildDialog(constraints) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          surfaceTintColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                enableMultiView: false,
                monthCellStyle: DateRangePickerMonthCellStyle(
                  todayCellDecoration: BoxDecoration(
                      color: notifier.buttoncolor, shape: BoxShape.circle),
                  textStyle: baseStyle.copyWith(
                    
                    color: notifier.subgreycolor,
                    fontSize: constraints.maxWidth < 550 ? 10 : 14,
                  ),
                  blackoutDateTextStyle: baseStyle.copyWith(
                    
                    color: notifier.blackcolor,
                    fontSize: constraints.maxWidth < 550 ? 10 : 14,
                  ),
                  todayTextStyle: baseStyle.copyWith(
                    
                    fontSize: constraints.maxWidth < 550 ? 10 : 14,
                    color: notifier.blackcolor,
                  ),
                ),
                monthViewSettings: DateRangePickerMonthViewSettings(
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    textStyle: baseStyle.copyWith(
                        color: notifier.blackcolor,
                        
                        fontSize: constraints.maxWidth < 550 ? 10 : 14),
                  ),
                ),
                onSelectionChanged: _onselectionChanged,
                backgroundColor: notifier.whitecolor,
                view: DateRangePickerView.month,
                startRangeSelectionColor: notifier.blackcolor,
                endRangeSelectionColor: notifier.blackcolor,
                rangeSelectionColor: notifier.sugestionbutton,
                selectionColor: notifier.blackcolor,
                selectionRadius: 50,
                viewSpacing: 30,
                selectionTextStyle: baseStyle.copyWith(
                    color: notifier.blackwhitecolor,
                    
                    fontSize: constraints.maxWidth < 550 ? 10 : 14),
                headerStyle: DateRangePickerHeaderStyle(
                  textStyle: baseStyle.copyWith(
                      color: notifier.blackwhitecolor,
                      
                      fontSize: constraints.maxWidth < 550 ? 10 : 14),
                ),
                selectionMode: DateRangePickerSelectionMode.range,
                rangeTextStyle: baseStyle.copyWith(
                    color: notifier.blackcolor,
                    
                    fontSize: constraints.maxWidth < 550 ? 10 : 14),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget flightTab(constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        CustomChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: constraints.maxWidth > 1800 ? 50 : 40,
                child: ListView.builder(
                  itemCount: chipsHover1.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              elevation: const WidgetStatePropertyAll(0),
                              backgroundColor: WidgetStatePropertyAll(
                                  (chipsHover1[index] || selectedchip == index)
                                      ? notifier.blackcolor
                                      : notifier.whitecolor),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      constraints.maxWidth > 1800 ? 23 : 20),
                                  side: BorderSide(
                                      color: (chipsHover1[index] ||
                                              selectedchip == index)
                                          ? Colors.transparent
                                          : notifier.sugestionbutton,
                                      width: 1),
                                ),
                              ),
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
                            },
                            child: Text(Tabchips[index],
                                style: baseStyle.copyWith(
                                    
                                    fontSize: 14,
                                    color: (chipsHover1[index] ||
                                            selectedchip == index)
                                        ? notifier.whitecolor
                                        : notifier.blackcolor))),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 10, right: 10, top: constraints.maxWidth < 800 ? 10 : 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: constraints.maxWidth > 1800
                          ? 140
                          : constraints.maxWidth > 2200
                              ? 170
                              : 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: notifier.sugestionbutton),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From',
                                style: baseStyle.copyWith(
                                    
                                    color: notifier.blackcolor,
                                    fontSize: constraints.maxWidth < 500
                                        ? constraints.maxWidth / 35
                                        : constraints.maxWidth < 750
                                            ? constraints.maxWidth / 70
                                            : constraints.maxWidth / 70)),
                            SizedBox(
                              height: constraints.maxWidth < 500 ? 4 : 6,
                            ),
                            SizedBox(
                              // height: constraints.maxWidth < 500
                              //     ? constraints.maxWidth / 25
                              //     : constraints.maxWidth < 750
                              //         ? constraints.maxWidth / 40
                              //         : constraints.maxWidth / 40,
                              child: TextField(
                                style: baseStyle.copyWith(
                                    fontSize: constraints.maxWidth < 500
                                        ? constraints.maxWidth / 25
                                        : constraints.maxWidth < 750
                                            ? constraints.maxWidth / 40
                                            : constraints.maxWidth / 40,
                                    
                                    color: notifier.blackcolor,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    disabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    hintText: 'Location',
                                    hintStyle: baseStyle.copyWith(
                                        color: notifier.blackcolor,
                                        fontSize: constraints.maxWidth < 500
                                            ? constraints.maxWidth / 25
                                            : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 40
                                                : constraints.maxWidth / 40,
                                        
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Where are you going?',
                              style: baseStyle.copyWith(
                                  fontSize: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 35
                                      : constraints.maxWidth < 750
                                          ? constraints.maxWidth / 70
                                          : constraints.maxWidth / 70,
                                  
                                  color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: constraints.maxWidth > 1800
                          ? 140
                          : constraints.maxWidth > 2200
                              ? 170
                              : 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: notifier.sugestionbutton),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('To',
                                style: baseStyle.copyWith(
                                    
                                    color: notifier.blackcolor,
                                    fontSize: constraints.maxWidth < 500
                                        ? constraints.maxWidth / 35
                                        : constraints.maxWidth < 750
                                            ? constraints.maxWidth / 70
                                            : constraints.maxWidth / 70)),
                            SizedBox(
                              height: constraints.maxWidth < 500 ? 4 : 6,
                            ),
                            SizedBox(
                              // height: constraints.maxWidth < 500
                              //     ? constraints.maxWidth / 25
                              //     : constraints.maxWidth < 750
                              //         ? constraints.maxWidth / 40
                              //         : constraints.maxWidth / 40,
                              child: TextField(
                                style: baseStyle.copyWith(
                                    fontSize: constraints.maxWidth < 500
                                        ? constraints.maxWidth / 25
                                        : constraints.maxWidth < 750
                                            ? constraints.maxWidth / 40
                                            : constraints.maxWidth / 40,
                                    
                                    color: notifier.blackcolor,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    disabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    hintText: 'Location',
                                    hintStyle: baseStyle.copyWith(
                                        color: notifier.blackcolor,
                                        fontSize: constraints.maxWidth < 500
                                            ? constraints.maxWidth / 25
                                            : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 40
                                                : constraints.maxWidth / 40,
                                        
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Where are you going?',
                              style: baseStyle.copyWith(
                                  fontSize: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 35
                                      : constraints.maxWidth < 750
                                          ? constraints.maxWidth / 70
                                          : constraints.maxWidth / 70,
                                  
                                  color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: constraints.maxWidth > 1800
                            ? 140
                            : constraints.maxWidth > 2200
                            ? 170
                            : 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: notifier.sugestionbutton),
                        ),
                        child: InkWell(
                          onTap: () {
                            buildDialog(constraints);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Departure',
                                        style: baseStyle.copyWith(
                                            
                                            color: notifier.blackcolor,
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 35
                                                : constraints.maxWidth < 750
                                                    ? constraints.maxWidth / 70
                                                    : constraints.maxWidth /
                                                        70)),
                                    Icon(Icons.keyboard_arrow_down_rounded,
                                        size: constraints.maxWidth / 80,
                                        color: notifier.buttoncolor),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 25
                                      : constraints.maxWidth < 750
                                          ? constraints.maxWidth / 40
                                          : constraints.maxWidth / 40,
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                          DateFormat.d().format(DateTime.now()),
                                      style: baseStyle.copyWith(
                                          color: notifier.blackcolor,
                                          fontSize: constraints.maxWidth < 500
                                              ? constraints.maxWidth / 25
                                              : constraints.maxWidth < 750
                                                  ? constraints.maxWidth / 40
                                                  : constraints.maxWidth / 40,
                                          
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text:
                                              " ${DateFormat.MMM().format(DateTime.now())}'${DateFormat.y().format(DateTime.now())}",
                                          style: baseStyle.copyWith(
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 30
                                                : constraints.maxWidth < 750
                                                    ? constraints.maxWidth / 50
                                                    : constraints.maxWidth / 50,
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  DateFormat.EEEE().format(DateTime.now()),
                                  style: baseStyle.copyWith(
                                      fontSize: constraints.maxWidth < 500
                                          ? constraints.maxWidth / 35
                                          : constraints.maxWidth < 750
                                              ? constraints.maxWidth / 70
                                              : constraints.maxWidth / 70,
                                      
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: constraints.maxWidth > 1800
                            ? 140
                            : constraints.maxWidth > 2200
                            ? 170
                            : 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: notifier.sugestionbutton),
                        ),
                        child: InkWell(
                          onTap: () {
                            buildDialog(constraints);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Return',
                                        style: baseStyle.copyWith(
                                            
                                            color: notifier.blackcolor,
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 35
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 70
                                                : constraints.maxWidth /
                                                70)),
                                    Icon(Icons.keyboard_arrow_down_rounded,
                                        size: constraints.maxWidth / 80,
                                        color: notifier.buttoncolor),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 25
                                      : constraints.maxWidth < 750
                                      ? constraints.maxWidth / 40
                                      : constraints.maxWidth / 40,
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                      DateFormat.d().format(DateTime.now()),
                                      style: baseStyle.copyWith(
                                          color: notifier.blackcolor,
                                          fontSize: constraints.maxWidth < 500
                                              ? constraints.maxWidth / 25
                                              : constraints.maxWidth < 750
                                              ? constraints.maxWidth / 40
                                              : constraints.maxWidth / 40,
                                          
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text:
                                          " ${DateFormat.MMM().format(DateTime.now())}'${DateFormat.y().format(DateTime.now())}",
                                          style: baseStyle.copyWith(
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 30
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 50
                                                : constraints.maxWidth / 50,
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  DateFormat.EEEE().format(DateTime.now()),
                                  style: baseStyle.copyWith(
                                      fontSize: constraints.maxWidth < 500
                                          ? constraints.maxWidth / 35
                                          : constraints.maxWidth < 750
                                          ? constraints.maxWidth / 70
                                          : constraints.maxWidth / 70,
                                      
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(width: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: constraints.maxWidth > 1800
                          ? 140
                          : constraints.maxWidth > 2200
                              ? 170
                              : 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: notifier.sugestionbutton),
                      ),
                      child: PopupMenuButton(
                        tooltip: '',
                        padding: const EdgeInsets.all(0),
                        offset: const Offset(0, 80),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Travellers & Class',
                                        style: baseStyle.copyWith(
                                            
                                            color: notifier.blackcolor,
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 35
                                                : constraints.maxWidth < 750
                                                    ? constraints.maxWidth / 70
                                                    : constraints.maxWidth /
                                                        70)),
                                    Icon(Icons.keyboard_arrow_down_rounded,
                                        size: constraints.maxWidth / 80,
                                        color: notifier.buttoncolor),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                SizedBox(
                                  height: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 25
                                      : constraints.maxWidth < 750
                                          ? constraints.maxWidth / 40
                                          : constraints.maxWidth / 40,
                                  child: RichText(
                                    text: TextSpan(
                                      text: "1",
                                      style: baseStyle.copyWith(
                                          fontSize: constraints.maxWidth < 500
                                              ? constraints.maxWidth / 25
                                              : constraints.maxWidth < 750
                                                  ? constraints.maxWidth / 40
                                                  : constraints.maxWidth / 40,
                                          color: notifier.blackcolor,
                                          
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text: " Traveller",
                                          style: baseStyle.copyWith(
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 30
                                                : constraints.maxWidth < 750
                                                    ? constraints.maxWidth / 50
                                                    : constraints.maxWidth / 50,
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Economy/Premium Economy',
                                  style: baseStyle.copyWith(
                                      fontSize: constraints.maxWidth < 500
                                          ? constraints.maxWidth / 35
                                          : constraints.maxWidth < 750
                                              ? constraints.maxWidth / 70
                                              : constraints.maxWidth / 70,
                                      
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            )),
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
                                selectedvalue = Travelerstype[0];
                              });
                            },
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                  height: 240,
                                  width: 350,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(ageType[index],
                                                              style: baseStyle.copyWith(
                                                                  color: notifier
                                                                      .blackcolor,
                                                                  
                                                                  fontSize:
                                                                      16)),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
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
                                                                onHover:
                                                                    (value) {
                                                                  setState(() {
                                                                    if (add[index] >
                                                                        0) {
                                                                      subHover[
                                                                              index] =
                                                                          value;
                                                                    }
                                                                  });
                                                                },
                                                                child: Icon(
                                                                    Icons
                                                                        .remove_circle_outline_rounded,
                                                                    size: 20,
                                                                    color: add[index] ==
                                                                            0
                                                                        ? notifier
                                                                            .sugestionbutton
                                                                        : subHover[index]
                                                                            ? notifier.buttoncolor
                                                                            : add[index] > 0
                                                                                ? notifier.subgreycolor
                                                                                : notifier.sugestionbutton),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              Container(
                                                                width: 25,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    '${add[index]}',
                                                                    style: baseStyle.copyWith(
                                                                        
                                                                        fontSize:
                                                                            18,
                                                                        color: notifier
                                                                            .blackcolor)),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      add[index] +=
                                                                          1;
                                                                    });
                                                                  },
                                                                  onHover:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      addHover[
                                                                              index] =
                                                                          value;
                                                                    });
                                                                  },
                                                                  child:
                                                                      AnimatedContainer(
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                            200),
                                                                    child: Icon(
                                                                        Icons
                                                                            .add_circle_outline_rounded,
                                                                        size:
                                                                            20,
                                                                        color: addHover[index]
                                                                            ? notifier.buttoncolor
                                                                            : notifier.subgreycolor),
                                                                  )),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Text(ageRange[index],
                                                          style: baseStyle.copyWith(
                                                              color: notifier
                                                                  .subgreycolor,
                                                              fontSize: 12)),
                                                    ],
                                                  ),
                                                  index == 2
                                                      ? const SizedBox()
                                                      : const SizedBox(
                                                          height: 10,
                                                        ),
                                                  index == 2
                                                      ? const SizedBox()
                                                      : Divider(
                                                          color: notifier
                                                              .sugestionbutton,
                                                        ),
                                                  index == 2
                                                      ? const SizedBox()
                                                      : const SizedBox(
                                                          height: 16),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {},
                    onHover: (value) {
                      setState(() {
                        searchHover2 = value;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: constraints.maxWidth < 550
                          ? constraints.maxWidth / 10
                          : constraints.maxWidth < 750
                              ? constraints.maxWidth / 15
                              : constraints.maxWidth / 15,
                      width: constraints.maxWidth < 550
                          ? constraints.maxWidth / 10
                          : constraints.maxWidth < 750
                              ? constraints.maxWidth / 15
                              : constraints.maxWidth / 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: searchHover2
                              ? Colors.indigoAccent.shade700
                              : notifier.buttoncolor),
                      child: const Icon(Icons.search, color: Colors.white),
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

  Widget hotelTab(constraints) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
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
                                  (chipsHover2[index] || selectedHotelchip == index)
                                      ? notifier.blackcolor
                                      : notifier.whitecolor),
                              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      constraints.maxWidth > 1800 ? 23 : 20),
                                  side: BorderSide(
                                      color: (chipsHover2[index] ||
                                              selectedHotelchip == index)
                                          ? Colors.transparent
                                          : notifier.sugestionbutton,
                                      width: 1)))),
                          onHover: (value) {
                            setState(() {
                              chipsHover2[index] = value;
                            });
                          },
                          onPressed: () {
                            setState(() {
                              selectedHotelchip = index;
                            });
                          },
                          child: Text(hotelchips[index],
                              style: baseStyle.copyWith(
                                  
                                  fontSize: 14,
                                  color: (chipsHover2[index] || selectedtrainchip == index) ? notifier.whitecolor : notifier.blackcolor))),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 10, right: 10, top: constraints.maxWidth < 800 ? 10 : 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: constraints.maxWidth > 1800
                          ? 140
                          : constraints.maxWidth > 2200
                          ? 170
                          : 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: notifier.sugestionbutton),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From',
                                style: baseStyle.copyWith(
                                    
                                    color: notifier.blackcolor,
                                    fontSize: constraints.maxWidth < 500
                                        ? constraints.maxWidth / 35
                                        : constraints.maxWidth < 750
                                        ? constraints.maxWidth / 70
                                        : constraints.maxWidth / 70)),
                            SizedBox(
                              height: constraints.maxWidth < 500 ? 4 : 6,
                            ),
                            SizedBox(
                              // height: constraints.maxWidth < 500
                              //     ? constraints.maxWidth / 25
                              //     : constraints.maxWidth < 750
                              //         ? constraints.maxWidth / 40
                              //         : constraints.maxWidth / 40,
                              child: TextField(
                                style: baseStyle.copyWith(
                                    fontSize: constraints.maxWidth < 500
                                        ? constraints.maxWidth / 25
                                        : constraints.maxWidth < 750
                                        ? constraints.maxWidth / 40
                                        : constraints.maxWidth / 40,
                                    
                                    color: notifier.blackcolor,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    disabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    hintText: 'Location',
                                    hintStyle: baseStyle.copyWith(
                                        color: notifier.blackcolor,
                                        fontSize: constraints.maxWidth < 500
                                            ? constraints.maxWidth / 25
                                            : constraints.maxWidth < 750
                                            ? constraints.maxWidth / 40
                                            : constraints.maxWidth / 40,
                                        
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Where are you going?',
                              style: baseStyle.copyWith(
                                  fontSize: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 35
                                      : constraints.maxWidth < 750
                                      ? constraints.maxWidth / 70
                                      : constraints.maxWidth / 70,
                                  
                                  color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: constraints.maxWidth > 1800
                            ? 140
                            : constraints.maxWidth > 2200
                            ? 170
                            : 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: notifier.sugestionbutton),
                        ),
                        child: InkWell(
                          onTap: () {
                            buildDialog(constraints);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Departure',
                                        style: baseStyle.copyWith(
                                            
                                            color: notifier.blackcolor,
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 35
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 70
                                                : constraints.maxWidth /
                                                70)),
                                    Icon(Icons.keyboard_arrow_down_rounded,
                                        size: constraints.maxWidth / 80,
                                        color: notifier.buttoncolor),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 25
                                      : constraints.maxWidth < 750
                                      ? constraints.maxWidth / 40
                                      : constraints.maxWidth / 40,
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                      DateFormat.d().format(DateTime.now()),
                                      style: baseStyle.copyWith(
                                          color: notifier.blackcolor,
                                          fontSize: constraints.maxWidth < 500
                                              ? constraints.maxWidth / 25
                                              : constraints.maxWidth < 750
                                              ? constraints.maxWidth / 40
                                              : constraints.maxWidth / 40,
                                          
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text:
                                          " ${DateFormat.MMM().format(DateTime.now())}'${DateFormat.y().format(DateTime.now())}",
                                          style: baseStyle.copyWith(
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 30
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 50
                                                : constraints.maxWidth / 50,
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  DateFormat.EEEE().format(DateTime.now()),
                                  style: baseStyle.copyWith(
                                      fontSize: constraints.maxWidth < 500
                                          ? constraints.maxWidth / 35
                                          : constraints.maxWidth < 750
                                          ? constraints.maxWidth / 70
                                          : constraints.maxWidth / 70,
                                      
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: constraints.maxWidth > 1800
                            ? 140
                            : constraints.maxWidth > 2200
                            ? 170
                            : 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: notifier.sugestionbutton),
                        ),
                        child: InkWell(
                          onTap: () {
                            buildDialog(constraints);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Return',
                                        style: baseStyle.copyWith(
                                            
                                            color: notifier.blackcolor,
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 35
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 70
                                                : constraints.maxWidth /
                                                70)),
                                    Icon(Icons.keyboard_arrow_down_rounded,
                                        size: constraints.maxWidth / 80,
                                        color: notifier.buttoncolor),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 25
                                      : constraints.maxWidth < 750
                                      ? constraints.maxWidth / 40
                                      : constraints.maxWidth / 40,
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                      DateFormat.d().format(DateTime.now()),
                                      style: baseStyle.copyWith(
                                          color: notifier.blackcolor,
                                          fontSize: constraints.maxWidth < 500
                                              ? constraints.maxWidth / 25
                                              : constraints.maxWidth < 750
                                              ? constraints.maxWidth / 40
                                              : constraints.maxWidth / 40,
                                          
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text:
                                          " ${DateFormat.MMM().format(DateTime.now())}'${DateFormat.y().format(DateTime.now())}",
                                          style: baseStyle.copyWith(
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 30
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 50
                                                : constraints.maxWidth / 50,
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  DateFormat.EEEE().format(DateTime.now()),
                                  style: baseStyle.copyWith(
                                      fontSize: constraints.maxWidth < 500
                                          ? constraints.maxWidth / 35
                                          : constraints.maxWidth < 750
                                          ? constraints.maxWidth / 70
                                          : constraints.maxWidth / 70,
                                      
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(width: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: constraints.maxWidth > 1800
                          ? 140
                          : constraints.maxWidth > 2200
                          ? 170
                          : 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: notifier.sugestionbutton),
                      ),
                      child: PopupMenuButton(
                        tooltip: '',
                        padding: const EdgeInsets.all(0),
                        offset: const Offset(0, 80),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Travellers & Class',
                                        style: baseStyle.copyWith(
                                            
                                            color: notifier.blackcolor,
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 35
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 70
                                                : constraints.maxWidth /
                                                70)),
                                    Icon(Icons.keyboard_arrow_down_rounded,
                                        size: constraints.maxWidth / 80,
                                        color: notifier.buttoncolor),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                SizedBox(
                                  height: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 25
                                      : constraints.maxWidth < 750
                                      ? constraints.maxWidth / 40
                                      : constraints.maxWidth / 40,
                                  child: RichText(
                                    text: TextSpan(
                                      text: "1",
                                      style: baseStyle.copyWith(
                                          fontSize: constraints.maxWidth < 500
                                              ? constraints.maxWidth / 25
                                              : constraints.maxWidth < 750
                                              ? constraints.maxWidth / 40
                                              : constraints.maxWidth / 40,
                                          color: notifier.blackcolor,
                                          
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text: " Traveller",
                                          style: baseStyle.copyWith(
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 30
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 50
                                                : constraints.maxWidth / 50,
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Economy/Premium Economy',
                                  style: baseStyle.copyWith(
                                      fontSize: constraints.maxWidth < 500
                                          ? constraints.maxWidth / 35
                                          : constraints.maxWidth < 750
                                          ? constraints.maxWidth / 70
                                          : constraints.maxWidth / 70,
                                      
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            )),
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
                                selectedvalue = Travelerstype[0];
                              });
                            },
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                  height: 240,
                                  width: 350,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
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
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(ageType[index],
                                                              style: baseStyle.copyWith(
                                                                  color: notifier
                                                                      .blackcolor,
                                                                  
                                                                  fontSize:
                                                                  16)),
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
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
                                                                onHover:
                                                                    (value) {
                                                                  setState(() {
                                                                    if (add[index] >
                                                                        0) {
                                                                      subHover[
                                                                      index] =
                                                                          value;
                                                                    }
                                                                  });
                                                                },
                                                                child: Icon(
                                                                    Icons
                                                                        .remove_circle_outline_rounded,
                                                                    size: 20,
                                                                    color: add[index] ==
                                                                        0
                                                                        ? notifier
                                                                        .sugestionbutton
                                                                        : subHover[index]
                                                                        ? notifier.buttoncolor
                                                                        : add[index] > 0
                                                                        ? notifier.subgreycolor
                                                                        : notifier.sugestionbutton),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              Container(
                                                                width: 25,
                                                                alignment:
                                                                Alignment
                                                                    .center,
                                                                child: Text(
                                                                    '${add[index]}',
                                                                    style: baseStyle.copyWith(
                                                                       
                                                                        fontSize:
                                                                        18,
                                                                        color: notifier
                                                                            .blackcolor)),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                            () {
                                                                          add[index] +=
                                                                          1;
                                                                        });
                                                                  },
                                                                  onHover:
                                                                      (value) {
                                                                    setState(
                                                                            () {
                                                                          addHover[
                                                                          index] =
                                                                              value;
                                                                        });
                                                                  },
                                                                  child:
                                                                  AnimatedContainer(
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                        200),
                                                                    child: Icon(
                                                                        Icons
                                                                            .add_circle_outline_rounded,
                                                                        size:
                                                                        20,
                                                                        color: addHover[index]
                                                                            ? notifier.buttoncolor
                                                                            : notifier.subgreycolor),
                                                                  )),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Text(ageRange[index],
                                                          style: baseStyle.copyWith(
                                                              color: notifier
                                                                  .subgreycolor,
                                                              
                                                              fontSize: 12)),
                                                    ],
                                                  ),
                                                  index == 2
                                                      ? const SizedBox()
                                                      : const SizedBox(
                                                    height: 10,
                                                  ),
                                                  index == 2
                                                      ? const SizedBox()
                                                      : Divider(
                                                    color: notifier
                                                        .sugestionbutton,
                                                  ),
                                                  index == 2
                                                      ? const SizedBox()
                                                      : const SizedBox(
                                                      height: 16),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {},
                    onHover: (value) {
                      setState(() {
                        searchHover2 = value;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: constraints.maxWidth < 550
                          ? constraints.maxWidth / 10
                          : constraints.maxWidth < 750
                          ? constraints.maxWidth / 15
                          : constraints.maxWidth / 15,
                      width: constraints.maxWidth < 550
                          ? constraints.maxWidth / 10
                          : constraints.maxWidth < 750
                          ? constraints.maxWidth / 15
                          : constraints.maxWidth / 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: searchHover2
                              ? Colors.indigoAccent.shade700
                              : notifier.buttoncolor),
                      child: const Icon(Icons.search, color: Colors.white),
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

  Widget trainTab(constraints) {
    return Column(
      children: [
        const SizedBox(height: 10),
        CustomChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: constraints.maxWidth > 1800 ? 50 : 40,
                child: ListView.builder(
                  itemCount: hotelchips.length,
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
                                      ? notifier.blackcolor
                                      : notifier.whitecolor),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      constraints.maxWidth > 1800 ? 23 : 20),
                                  side: BorderSide(
                                    color: (chipsHover2[index] ||
                                            selectedtrainchip == index)
                                        ? Colors.transparent
                                        : notifier.sugestionbutton,
                                    width: 1,
                                  ),
                                ),
                              ),
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
                            },
                            child: Text(hotelchips[index],
                                style: baseStyle.copyWith(
                                    
                                    fontSize: 14,
                                    color: (chipsHover2[index] ||
                                            selectedtrainchip == index)
                                        ? notifier.whitecolor
                                        : notifier.blackcolor))),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 25,
                child: ListView.builder(
                  itemCount: checkTrain.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(children: [
                      Container(
                        decoration: BoxDecoration(
                          color: check[index]
                              ? notifier.lightblue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(children: [
                          Transform.scale(
                            scale: 0.8,
                            child: Checkbox(
                              shape: const CircleBorder(),
                              value: check[index],
                              onChanged: (value) {
                                setState(() {
                                  check[index] = value!;
                                });
                              },
                            ),
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
                                style: baseStyle.copyWith(
                                    
                                    fontSize: 12,
                                    color: check[index] ? Colors.black : Colors.white)),
                          ),
                          const SizedBox(width: 6),
                        ]),
                      ),
                      const SizedBox(width: 6),
                    ]);
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 10, right: 10, top: constraints.maxWidth < 800 ? 10 : 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: constraints.maxWidth > 1800
                          ? 140
                          : constraints.maxWidth > 2200
                          ? 170
                          : 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: notifier.sugestionbutton),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From',
                                style: baseStyle.copyWith(
                                    
                                    color: notifier.blackcolor,
                                    fontSize: constraints.maxWidth < 500
                                        ? constraints.maxWidth / 35
                                        : constraints.maxWidth < 750
                                        ? constraints.maxWidth / 70
                                        : constraints.maxWidth / 70)),
                            SizedBox(
                              height: constraints.maxWidth < 500 ? 4 : 6,
                            ),
                            SizedBox(
                              // height: constraints.maxWidth < 500
                              //     ? constraints.maxWidth / 25
                              //     : constraints.maxWidth < 750
                              //         ? constraints.maxWidth / 40
                              //         : constraints.maxWidth / 40,
                              child: TextField(
                                style: baseStyle.copyWith(
                                    fontSize: constraints.maxWidth < 500
                                        ? constraints.maxWidth / 25
                                        : constraints.maxWidth < 750
                                        ? constraints.maxWidth / 40
                                        : constraints.maxWidth / 40,
                                    
                                    color: notifier.blackcolor,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    disabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    hintText: 'Location',
                                    hintStyle: baseStyle.copyWith(
                                        color: notifier.blackcolor,
                                        fontSize: constraints.maxWidth < 500
                                            ? constraints.maxWidth / 25
                                            : constraints.maxWidth < 750
                                            ? constraints.maxWidth / 40
                                            : constraints.maxWidth / 40,
                                        
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Where are you going?',
                              style: baseStyle.copyWith(
                                  fontSize: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 35
                                      : constraints.maxWidth < 750
                                      ? constraints.maxWidth / 70
                                      : constraints.maxWidth / 70,
                                  
                                  color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: constraints.maxWidth > 1800
                          ? 140
                          : constraints.maxWidth > 2200
                          ? 170
                          : 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: notifier.sugestionbutton),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('To',
                                style: baseStyle.copyWith(
                                    
                                    color: notifier.blackcolor,
                                    fontSize: constraints.maxWidth < 500
                                        ? constraints.maxWidth / 35
                                        : constraints.maxWidth < 750
                                        ? constraints.maxWidth / 70
                                        : constraints.maxWidth / 70)),
                            SizedBox(
                              height: constraints.maxWidth < 500 ? 4 : 6,
                            ),
                            SizedBox(
                              // height: constraints.maxWidth < 500
                              //     ? constraints.maxWidth / 25
                              //     : constraints.maxWidth < 750
                              //         ? constraints.maxWidth / 40
                              //         : constraints.maxWidth / 40,
                              child: TextField(
                                style: baseStyle.copyWith(
                                    fontSize: constraints.maxWidth < 500
                                        ? constraints.maxWidth / 25
                                        : constraints.maxWidth < 750
                                        ? constraints.maxWidth / 40
                                        : constraints.maxWidth / 40,
                                    
                                    color: notifier.blackcolor,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    disabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    hintText: 'Location',
                                    hintStyle: baseStyle.copyWith(
                                        color: notifier.blackcolor,
                                        fontSize: constraints.maxWidth < 500
                                            ? constraints.maxWidth / 25
                                            : constraints.maxWidth < 750
                                            ? constraints.maxWidth / 40
                                            : constraints.maxWidth / 40,
                                        
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Where are you going?',
                              style: baseStyle.copyWith(
                                  fontSize: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 35
                                      : constraints.maxWidth < 750
                                      ? constraints.maxWidth / 70
                                      : constraints.maxWidth / 70,
                                  
                                  color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: constraints.maxWidth > 1800
                            ? 140
                            : constraints.maxWidth > 2200
                            ? 170
                            : 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: notifier.sugestionbutton),
                        ),
                        child: InkWell(
                          onTap: () {
                            buildDialog(constraints);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Travel Date',
                                        style: baseStyle.copyWith(
                                            
                                            color: notifier.blackcolor,
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 35
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 70
                                                : constraints.maxWidth /
                                                70)),
                                    Icon(Icons.keyboard_arrow_down_rounded,
                                        size: constraints.maxWidth / 80,
                                        color: notifier.buttoncolor),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 25
                                      : constraints.maxWidth < 750
                                      ? constraints.maxWidth / 40
                                      : constraints.maxWidth / 40,
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                      DateFormat.d().format(DateTime.now()),
                                      style: baseStyle.copyWith(
                                          color: notifier.blackcolor,
                                          fontSize: constraints.maxWidth < 500
                                              ? constraints.maxWidth / 25
                                              : constraints.maxWidth < 750
                                              ? constraints.maxWidth / 40
                                              : constraints.maxWidth / 40,
                                          
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text:
                                          " ${DateFormat.MMM().format(DateTime.now())}'${DateFormat.y().format(DateTime.now())}",
                                          style: baseStyle.copyWith(
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 30
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 50
                                                : constraints.maxWidth / 50,
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  DateFormat.EEEE().format(DateTime.now()),
                                  style: baseStyle.copyWith(
                                      fontSize: constraints.maxWidth < 500
                                          ? constraints.maxWidth / 35
                                          : constraints.maxWidth < 750
                                          ? constraints.maxWidth / 70
                                          : constraints.maxWidth / 70,
                                      
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(width: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: constraints.maxWidth > 1800
                          ? 140
                          : constraints.maxWidth > 2200
                          ? 170
                          : 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: notifier.sugestionbutton),
                      ),
                      child: PopupMenuButton(
                        tooltip: '',
                        padding: const EdgeInsets.all(0),
                        offset: const Offset(0, 80),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Class',
                                        style: baseStyle.copyWith(
                                            
                                            color: notifier.blackcolor,
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 35
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 70
                                                : constraints.maxWidth /
                                                70)),
                                    Icon(Icons.keyboard_arrow_down_rounded,
                                        size: constraints.maxWidth / 80,
                                        color: notifier.buttoncolor),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                SizedBox(
                                  height: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 25
                                      : constraints.maxWidth < 750
                                      ? constraints.maxWidth / 40
                                      : constraints.maxWidth / 40,
                                  child: RichText(
                                    text: TextSpan(
                                      text: "1",
                                      style: baseStyle.copyWith(
                                          fontSize: constraints.maxWidth < 500
                                              ? constraints.maxWidth / 25
                                              : constraints.maxWidth < 750
                                              ? constraints.maxWidth / 40
                                              : constraints.maxWidth / 40,
                                          color: notifier.blackcolor,
                                          
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text: " Traveller",
                                          style: baseStyle.copyWith(
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 30
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 50
                                                : constraints.maxWidth / 50,
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'All Class',
                                  style: baseStyle.copyWith(
                                      fontSize: constraints.maxWidth < 500
                                          ? constraints.maxWidth / 35
                                          : constraints.maxWidth < 750
                                          ? constraints.maxWidth / 70
                                          : constraints.maxWidth / 70,
                                      
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            )),
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
                                selectedvalue = Travelerstype[0];
                              });
                            },
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                  height: 240,
                                  width: 350,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
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
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(ageType[index],
                                                              style: baseStyle.copyWith(
                                                                  color: notifier
                                                                      .blackcolor,
                                                                  
                                                                  fontSize:
                                                                  16)),
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
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
                                                                onHover:
                                                                    (value) {
                                                                  setState(() {
                                                                    if (add[index] >
                                                                        0) {
                                                                      subHover[
                                                                      index] =
                                                                          value;
                                                                    }
                                                                  });
                                                                },
                                                                child: Icon(
                                                                    Icons
                                                                        .remove_circle_outline_rounded,
                                                                    size: 20,
                                                                    color: add[index] ==
                                                                        0
                                                                        ? notifier
                                                                        .sugestionbutton
                                                                        : subHover[index]
                                                                        ? notifier.buttoncolor
                                                                        : add[index] > 0
                                                                        ? notifier.subgreycolor
                                                                        : notifier.sugestionbutton),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              Container(
                                                                width: 25,
                                                                alignment:
                                                                Alignment
                                                                    .center,
                                                                child: Text(
                                                                    '${add[index]}',
                                                                    style: baseStyle.copyWith(
                                                                       
                                                                        fontSize:
                                                                        18,
                                                                        color: notifier
                                                                            .blackcolor)),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                            () {
                                                                          add[index] +=
                                                                          1;
                                                                        });
                                                                  },
                                                                  onHover:
                                                                      (value) {
                                                                    setState(
                                                                            () {
                                                                          addHover[
                                                                          index] =
                                                                              value;
                                                                        });
                                                                  },
                                                                  child:
                                                                  AnimatedContainer(
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                        200),
                                                                    child: Icon(
                                                                        Icons
                                                                            .add_circle_outline_rounded,
                                                                        size:
                                                                        20,
                                                                        color: addHover[index]
                                                                            ? notifier.buttoncolor
                                                                            : notifier.subgreycolor),
                                                                  )),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Text(ageRange[index],
                                                          style: baseStyle.copyWith(
                                                              color: notifier
                                                                  .subgreycolor,
                                                              
                                                              fontSize: 12)),
                                                    ],
                                                  ),
                                                  index == 2
                                                      ? const SizedBox()
                                                      : const SizedBox(
                                                    height: 10,
                                                  ),
                                                  index == 2
                                                      ? const SizedBox()
                                                      : Divider(
                                                    color: notifier
                                                        .sugestionbutton,
                                                  ),
                                                  index == 2
                                                      ? const SizedBox()
                                                      : const SizedBox(
                                                      height: 16),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {},
                    onHover: (value) {
                      setState(() {
                        searchHover2 = value;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: constraints.maxWidth < 550
                          ? constraints.maxWidth / 10
                          : constraints.maxWidth < 750
                          ? constraints.maxWidth / 15
                          : constraints.maxWidth / 15,
                      width: constraints.maxWidth < 550
                          ? constraints.maxWidth / 10
                          : constraints.maxWidth < 750
                          ? constraints.maxWidth / 15
                          : constraints.maxWidth / 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: searchHover2
                              ? Colors.indigoAccent.shade700
                              : notifier.buttoncolor),
                      child: const Icon(Icons.search, color: Colors.white),
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

  Widget busTab(constraints) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(
              left: 10, right: 10, top: constraints.maxWidth < 800 ? 10 : 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: constraints.maxWidth > 1800
                          ? 140
                          : constraints.maxWidth > 2200
                          ? 170
                          : 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: notifier.sugestionbutton),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From',
                                style: baseStyle.copyWith(
                                    
                                    color: notifier.blackcolor,
                                    fontSize: constraints.maxWidth < 500
                                        ? constraints.maxWidth / 35
                                        : constraints.maxWidth < 750
                                        ? constraints.maxWidth / 70
                                        : constraints.maxWidth / 70)),
                            SizedBox(
                              height: constraints.maxWidth < 500 ? 4 : 6,
                            ),
                            SizedBox(
                              // height: constraints.maxWidth < 500
                              //     ? constraints.maxWidth / 25
                              //     : constraints.maxWidth < 750
                              //         ? constraints.maxWidth / 40
                              //         : constraints.maxWidth / 40,
                              child: TextField(
                                style: baseStyle.copyWith(
                                    fontSize: constraints.maxWidth < 500
                                        ? constraints.maxWidth / 25
                                        : constraints.maxWidth < 750
                                        ? constraints.maxWidth / 40
                                        : constraints.maxWidth / 40,
                                    
                                    color: notifier.blackcolor,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    disabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    hintText: 'Location',
                                    hintStyle: baseStyle.copyWith(
                                        color: notifier.blackcolor,
                                        fontSize: constraints.maxWidth < 500
                                            ? constraints.maxWidth / 25
                                            : constraints.maxWidth < 750
                                            ? constraints.maxWidth / 40
                                            : constraints.maxWidth / 40,
                                        
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Where are you going?',
                              style: baseStyle.copyWith(
                                  fontSize: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 35
                                      : constraints.maxWidth < 750
                                      ? constraints.maxWidth / 70
                                      : constraints.maxWidth / 70,
                                  
                                  color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: constraints.maxWidth > 1800
                            ? 140
                            : constraints.maxWidth > 2200
                            ? 170
                            : 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: notifier.sugestionbutton),
                        ),
                        child: InkWell(
                          onTap: () {
                            buildDialog(constraints);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Return',
                                        style: baseStyle.copyWith(
                                            
                                            color: notifier.blackcolor,
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 35
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 70
                                                : constraints.maxWidth /
                                                70)),
                                    Icon(Icons.keyboard_arrow_down_rounded,
                                        size: constraints.maxWidth / 80,
                                        color: notifier.buttoncolor),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 25
                                      : constraints.maxWidth < 750
                                      ? constraints.maxWidth / 40
                                      : constraints.maxWidth / 40,
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                      DateFormat.d().format(DateTime.now()),
                                      style: baseStyle.copyWith(
                                          color: notifier.blackcolor,
                                          fontSize: constraints.maxWidth < 500
                                              ? constraints.maxWidth / 25
                                              : constraints.maxWidth < 750
                                              ? constraints.maxWidth / 40
                                              : constraints.maxWidth / 40,
                                          
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text:
                                          " ${DateFormat.MMM().format(DateTime.now())}'${DateFormat.y().format(DateTime.now())}",
                                          style: baseStyle.copyWith(
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 30
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 50
                                                : constraints.maxWidth / 50,
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  DateFormat.EEEE().format(DateTime.now()),
                                  style: baseStyle.copyWith(
                                      fontSize: constraints.maxWidth < 500
                                          ? constraints.maxWidth / 35
                                          : constraints.maxWidth < 750
                                          ? constraints.maxWidth / 70
                                          : constraints.maxWidth / 70,
                                      
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(width: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: constraints.maxWidth > 1800
                          ? 140
                          : constraints.maxWidth > 2200
                          ? 170
                          : 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: notifier.sugestionbutton),
                      ),
                      child: PopupMenuButton(
                        tooltip: '',
                        padding: const EdgeInsets.all(0),
                        offset: const Offset(0, 80),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Travellers & Class',
                                        style: baseStyle.copyWith(
                                            
                                            color: notifier.blackcolor,
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 35
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 70
                                                : constraints.maxWidth /
                                                70)),
                                    Icon(Icons.keyboard_arrow_down_rounded,
                                        size: constraints.maxWidth / 80,
                                        color: notifier.buttoncolor),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                SizedBox(
                                  height: constraints.maxWidth < 500
                                      ? constraints.maxWidth / 25
                                      : constraints.maxWidth < 750
                                      ? constraints.maxWidth / 40
                                      : constraints.maxWidth / 40,
                                  child: RichText(
                                    text: TextSpan(
                                      text: "1",
                                      style: baseStyle.copyWith(
                                          fontSize: constraints.maxWidth < 500
                                              ? constraints.maxWidth / 25
                                              : constraints.maxWidth < 750
                                              ? constraints.maxWidth / 40
                                              : constraints.maxWidth / 40,
                                          color: notifier.blackcolor,
                                          
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text: " Traveller",
                                          style: baseStyle.copyWith(
                                            fontSize: constraints.maxWidth < 500
                                                ? constraints.maxWidth / 30
                                                : constraints.maxWidth < 750
                                                ? constraints.maxWidth / 50
                                                : constraints.maxWidth / 50,
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Economy/Premium Economy',
                                  style: baseStyle.copyWith(
                                      fontSize: constraints.maxWidth < 500
                                          ? constraints.maxWidth / 35
                                          : constraints.maxWidth < 750
                                          ? constraints.maxWidth / 70
                                          : constraints.maxWidth / 70,
                                      
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            )),
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
                                selectedvalue = Travelerstype[0];
                              });
                            },
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                  height: 240,
                                  width: 350,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
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
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(ageType[index],
                                                              style: baseStyle.copyWith(
                                                                  color: notifier
                                                                      .blackcolor,
                                                                  
                                                                  fontSize:
                                                                  16)),
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
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
                                                                onHover:
                                                                    (value) {
                                                                  setState(() {
                                                                    if (add[index] >
                                                                        0) {
                                                                      subHover[
                                                                      index] =
                                                                          value;
                                                                    }
                                                                  });
                                                                },
                                                                child: Icon(
                                                                    Icons
                                                                        .remove_circle_outline_rounded,
                                                                    size: 20,
                                                                    color: add[index] ==
                                                                        0
                                                                        ? notifier
                                                                        .sugestionbutton
                                                                        : subHover[index]
                                                                        ? notifier.buttoncolor
                                                                        : add[index] > 0
                                                                        ? notifier.subgreycolor
                                                                        : notifier.sugestionbutton),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              Container(
                                                                width: 25,
                                                                alignment:
                                                                Alignment
                                                                    .center,
                                                                child: Text(
                                                                    '${add[index]}',
                                                                    style: baseStyle.copyWith(
                                                                       
                                                                        fontSize:
                                                                        18,
                                                                        color: notifier
                                                                            .blackcolor)),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10),
                                                              InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                            () {
                                                                          add[index] +=
                                                                          1;
                                                                        });
                                                                  },
                                                                  onHover:
                                                                      (value) {
                                                                    setState(
                                                                            () {
                                                                          addHover[
                                                                          index] =
                                                                              value;
                                                                        });
                                                                  },
                                                                  child:
                                                                  AnimatedContainer(
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                        200),
                                                                    child: Icon(
                                                                        Icons
                                                                            .add_circle_outline_rounded,
                                                                        size:
                                                                        20,
                                                                        color: addHover[index]
                                                                            ? notifier.buttoncolor
                                                                            : notifier.subgreycolor),
                                                                  )),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Text(ageRange[index],
                                                          style: baseStyle.copyWith(
                                                              color: notifier
                                                                  .subgreycolor,
                                                              fontSize: 12)),
                                                    ],
                                                  ),
                                                  index == 2
                                                      ? const SizedBox()
                                                      : const SizedBox(
                                                    height: 10,
                                                  ),
                                                  index == 2
                                                      ? const SizedBox()
                                                      : Divider(
                                                    color: notifier
                                                        .sugestionbutton,
                                                  ),
                                                  index == 2
                                                      ? const SizedBox()
                                                      : const SizedBox(
                                                      height: 16),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {},
                    onHover: (value) {
                      setState(() {
                        searchHover2 = value;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: constraints.maxWidth < 550
                          ? constraints.maxWidth / 10
                          : constraints.maxWidth < 750
                          ? constraints.maxWidth / 15
                          : constraints.maxWidth / 15,
                      width: constraints.maxWidth < 550
                          ? constraints.maxWidth / 10
                          : constraints.maxWidth < 750
                          ? constraints.maxWidth / 15
                          : constraints.maxWidth / 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: searchHover2
                              ? Colors.indigoAccent.shade700
                              : notifier.buttoncolor),
                      child: const Icon(Icons.search, color: Colors.white),
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

  Widget popAdd(constraints) {
    return PopupMenuButton(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Travellers & Class',
                      style: baseStyle.copyWith(
                          
                          color: notifier.blackcolor,
                          fontSize: constraints.maxWidth < 550
                              ? constraints.maxWidth / 35
                              : constraints.maxWidth < 750
                                  ? constraints.maxWidth / 70
                                  : constraints.maxWidth / 70)),
                  Icon(Icons.keyboard_arrow_down_rounded,
                      size: constraints.maxWidth / 80,
                      color: notifier.buttoncolor),
                ],
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: constraints.maxWidth < 550
                    ? constraints.maxWidth / 25
                    : constraints.maxWidth < 750
                        ? constraints.maxWidth / 40
                        : constraints.maxWidth / 40,
                child: RichText(
                  text: TextSpan(
                    text: "1",
                    style: baseStyle.copyWith(
                        color: notifier.blackcolor,
                        fontSize: constraints.maxWidth < 550
                            ? constraints.maxWidth / 25
                            : constraints.maxWidth < 750
                                ? constraints.maxWidth / 40
                                : constraints.maxWidth / 40,
                        
                        fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: " Traveller",
                        style: baseStyle.copyWith(
                          fontSize: constraints.maxWidth < 550
                              ? constraints.maxWidth / 30
                              : constraints.maxWidth < 750
                                  ? constraints.maxWidth / 50
                                  : constraints.maxWidth / 50,
                          
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Economy/Premium Economy',
                style: baseStyle.copyWith(
                    fontSize: constraints.maxWidth < 550
                        ? constraints.maxWidth / 35
                        : constraints.maxWidth < 750
                            ? constraints.maxWidth / 70
                            : constraints.maxWidth / 70,
                    
                    color: Colors.grey.shade500),
              ),
            ],
          )),
      onSelected: (SampleItem2 item) {
        setState(() {
          // selectedMenu = item;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem2>>[
        PopupMenuItem<SampleItem2>(
          enabled: true,
          value: SampleItem2.itemOne,
          onTap: () {
            setState(() {
              selectedvalue = Travelerstype[0];
            });
          },
          child: const SizedBox(
            height: 300,
            width: 400,
            child: Column(
              children: [],
            ),
          ),
        ),
      ],
    );
  }

  Widget calender() {
    return Container(
      height: 300,
      width: 300,
      color: notifier.whitecolor,
      child: SfDateRangePicker(
        backgroundColor: notifier.whitecolor,
        headerStyle: DateRangePickerHeaderStyle(
          textStyle: baseStyle.copyWith(color: notifier.blackcolor),
        ),
        monthViewSettings: DateRangePickerMonthViewSettings(
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
          textStyle: baseStyle.copyWith(color: notifier.blackcolor),
        )),
        allowViewNavigation: true,
        showNavigationArrow: true,
        monthCellStyle: DateRangePickerMonthCellStyle(
          textStyle: baseStyle.copyWith(
              color: notifier.blackcolor, fontWeight: FontWeight.bold),
          todayTextStyle: const TextStyle(
              color: Color(0xff883DCF), fontWeight: FontWeight.w600),
          todayCellDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffF4ECFB),
            border: const Border.symmetric(
                vertical: BorderSide.none, horizontal: BorderSide.none),
          ),
        ),
        selectionColor: const Color(0xff883DCF),
        selectionShape: DateRangePickerSelectionShape.rectangle,
        todayHighlightColor: const Color(0xff883DCF),
        enablePastDates: true,
        onSelectionChanged: _onSelectionChanged,
        selectionMode: DateRangePickerSelectionMode.single,
        initialSelectedRange: PickerDateRange(
            DateTime.now().subtract(const Duration(days: 4)),
            DateTime.now().add(const Duration(days: 3))),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
      } else if (args.value is DateTime) {
      } else if (args.value is List<DateTime>) {
      } else {}
    });
  }
}

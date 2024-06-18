// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:webkit/landing_page/mediaquery/mq.dart';

import '../../deshboard/deshboard.dart';
import '../colornotifier.dart';

class adventurehelp extends StatefulWidget {
  const adventurehelp({super.key});

  @override
  State<adventurehelp> createState() => _adventurehelpState();
}

class _adventurehelpState extends State<adventurehelp> {
  late ColorNotifier notifier;

  List chips = ['City', 'Beach', 'Outdoors', 'Romance'];
  List added = ['Recently added', 'Long added'];

  List adventureimage = [
    'assets/deshboard/adventure/adventure1.png',
    'assets/deshboard/adventure/adventure2.png',
    'assets/deshboard/adventure/adventure3.png',
    'assets/deshboard/adventure/adventure4.png',
    'assets/deshboard/adventure/adventure5.png',
    'assets/deshboard/adventure/adventure6.png',
    'assets/deshboard/adventure/adventure7.png',
    'assets/deshboard/adventure/adventure8.png',
  ];
  List adventureplaces = [
    'Karineside',
    'East Barrett',
    'Steuberbury',
    'Idaview',
    'Yasminfurt',
    'North Edenshire',
    'Archibaldtown',
    'West Gregoria'
  ];

  List<bool> heartHover = [false,false,false,false,false,false,false,false,false];
  List adventuretype = ['Golden Circle,Kerid Volcanic Crater,and Blue Lagoon Day Trip','Edinburgh Sky to Sea Bike Tour by Manual or E-Bike','Natural Crystal Blue Ice Cave Tour of Vatnaj̣ökull Glacier','South Coast Full Day Tour by Minibus from Reykjavik','Golden Circle,Kerid Volcanic Crater,and Blue Lagoon Day Trip','Edinburgh Sky to Sea Bike Tour by Manual or E-Bike','Natural Crystal Blue Ice Cave Tour of Vatnaj̣ökull Glacier','South Coast Full Day Tour by Minibus from Reykjavik'];
  List adventurelocation = ['westminster Borough,London','Ciutat Vella,Barcelona','Manhattan ,New York','Vaticano Prati,Rome','westminster Borough,London','Ciutat Vella,Barcelona','Manhattan ,New York','Vaticano Prati,Rome'];
  List tag = ['  LIKELY TO SELL OUT  ','','  BEST SELLER  ','  TOP RATED  ','','','','',''];
  List favtrips = [];

  bool isHover = false;
  int selectedindex = 0;
  String selectedvalue = '';
  String selectedvalue2 = '';
  List<bool> chipsHover = [false,false,false,false];
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
      return adventure(constraints);
    },);
  }

  Widget adventure(constraints) {
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
          children: [
            Text('Get inspiration for your next trip',
              style: TextStyle(fontSize: constraints.maxWidth < 550 ? 28 : 50, fontFamily: 'gilroysemi',color: notifier.blackcolor),
            ),
            Text("sign up and we'll send the best deals to you", style: TextStyle(fontSize: constraints.maxWidth < 550 ? 18 : 25,
                fontFamily: 'gilroymed',
                color: notifier.greycolor),
            ),
            SizedBox(height: constraints.maxWidth < 550 ? 30 : 70,),
            constraints.maxWidth < 900 ? Column(
              children: [
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
                  child: Container(
                    height: 50,
                    width: width / 1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: notifier.whitecolor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300,width: 2),
                    ),
                    child: Padding(padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(selectedvalue2.isNotEmpty
                                ? selectedvalue2
                                : selectedvalue2 = chips[0],
                              style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  fontSize: 16,
                                  color: notifier.blackcolor),),
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.shade300,width: 2),
                              ),
                              child: Icon(Icons.keyboard_arrow_down_rounded,color: notifier.greycolor,),
                            ),
                          ],
                        ),
                    ),
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
                          selectedvalue2 = chips[0];
                        });
                      },
                      child: Text(chips[0], style: TextStyle(
                          color: selectedvalue2 == chips[0]
                              ? Colors.blue
                              : notifier.blackcolor,
                          fontSize: 16,
                          fontFamily: 'gilroysemi'),),
                    ),
                    PopupMenuItem<SampleItem2>(
                      enabled: true,
                      value: SampleItem2.itemOne,
                      onTap: () {
                        setState(() {
                          selectedvalue2 = chips[1];
                        });
                      },
                      child: Text(chips[1], style: TextStyle(
                          color: selectedvalue2 == chips[1]
                              ? Colors.blue
                              : notifier.blackcolor,
                          fontSize: 16,
                          fontFamily: 'gilroysemi'),
                      ),
                    ),
                    PopupMenuItem<SampleItem2>(
                      enabled: true,
                      value: SampleItem2.itemOne,
                      onTap: () {
                        setState(() {
                          selectedvalue2 = chips[2];
                        });
                      },
                      child: Text(chips[2], style: TextStyle(
                          color: selectedvalue2 == chips[2]
                              ? Colors.blue
                              : notifier.blackcolor,
                          fontSize: 16,
                          fontFamily: 'gilroysemi'),
                      ),
                    ),
                    PopupMenuItem<SampleItem2>(
                      enabled: true,
                      value: SampleItem2.itemOne,
                      onTap: () {
                        setState(() {
                          selectedvalue2 = chips[3];
                        });
                      },
                      child: Text(chips[3], style: TextStyle(
                          color: selectedvalue2 == chips[3]
                              ? Colors.blue
                              : notifier.blackcolor,
                          fontSize: 16,
                          fontFamily: 'gilroysemi'),),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                PopupMenuButton(
                  elevation: 0,
                  tooltip: '',
                  padding: const EdgeInsets.all(0),
                  offset: const Offset(0, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  // initialValue: selectedMenu,
                  constraints: const BoxConstraints(
                    maxWidth:  400,
                    maxHeight: 400,
                  ),
                  color: notifier.whitecolor,
                  child: Container(
                    height: 50,
                    width: width / 1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: notifier.whitecolor,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey.shade300,width: 2),
                    ),
                    child: Padding(padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(selectedvalue.isNotEmpty
                                ? selectedvalue
                                : selectedvalue = added[0], style: TextStyle(
                                fontFamily: 'gilroysemi',
                                fontSize: 16,
                                color: notifier.blackcolor),),
                            SvgPicture.asset(notifier.isDark ? 'assets/Icons/filtericonDark.svg' : 'assets/Icons/filtericon.svg',height: 18,),
                          ],
                        ),
                    ),
                  ),
                  onSelected: (SampleItem item) {
                    setState(() {
                      // selectedMenu = item;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SampleItem>>[
                    PopupMenuItem<SampleItem>(
                      enabled: true,
                      value: SampleItem.itemOne,
                      onTap: () {
                        setState(() {
                          selectedvalue = added[0];
                        });
                      },
                      child: Text(added[0], style: TextStyle(
                          color: selectedvalue == added[0]
                              ? Colors.blue
                              : notifier.blackcolor,
                          fontSize: 16,
                          fontFamily: 'gilroysemi'),),
                    ),
                    PopupMenuItem<SampleItem>(
                      enabled: true,
                      value: SampleItem.itemOne,
                      onTap: () {
                        setState(() {
                          selectedvalue = added[1];
                        });
                      },
                      child: Text(added[1], style: TextStyle(
                          color: selectedvalue == added[1]
                              ? Colors.blue
                              : notifier.blackcolor,
                          fontSize: 16,
                          fontFamily: 'gilroysemi'),),
                    ),
                  ],
                ),
              ],
            )
            : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                constraints.maxWidth < 1100 ? PopupMenuButton(
                  padding: const EdgeInsets.all(0),
                  tooltip: '',
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
                  child: Container(
                    height: 50,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: notifier.whitecolor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(selectedvalue2.isNotEmpty
                                  ? selectedvalue2
                                  : selectedvalue2 = chips[0],
                                style: TextStyle(
                                    fontFamily: 'gilroysemi',
                                    fontSize: 16,
                                    color: notifier.blackcolor),),
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.grey.shade300,width: 2)
                                ),
                                child: Icon(Icons.keyboard_arrow_down_rounded,color: notifier.greycolor,),
                              ),
                            ],
                          ),
                    ),
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
                          selectedvalue2 = chips[0];
                        });
                      },
                      child: Text(chips[0], style: TextStyle(
                          color: selectedvalue2 == chips[0]
                              ? Colors.blue
                              : notifier.blackcolor,
                          fontSize: 16,
                          fontFamily: 'gilroysemi'),),
                    ),
                    PopupMenuItem<SampleItem2>(
                      enabled: true,
                      value: SampleItem2.itemOne,
                      onTap: () {
                        setState(() {
                          selectedvalue2 = chips[1];
                        });
                      },
                      child: Text(chips[1], style: TextStyle(
                          color: selectedvalue2 == chips[1]
                              ? Colors.blue
                              : notifier.blackcolor,
                          fontSize: 16,
                          fontFamily: 'gilroysemi'),),
                    ),
                    PopupMenuItem<SampleItem2>(
                      enabled: true,
                      value: SampleItem2.itemOne,
                      onTap: () {
                        setState(() {
                          selectedvalue2 = chips[2];
                        });
                      },
                      child: Text(chips[2], style: TextStyle(
                          color: selectedvalue2 == chips[2]
                              ? Colors.blue
                              : notifier.blackcolor,
                          fontSize: 16,
                          fontFamily: 'gilroysemi'),),
                    ),
                    PopupMenuItem<SampleItem2>(
                      enabled: true,
                      value: SampleItem2.itemOne,
                      onTap: () {
                        setState(() {
                          selectedvalue2 = chips[3];
                        });
                      },
                      child: Text(chips[3], style: TextStyle(
                          color: selectedvalue2 == chips[3]
                              ? Colors.blue
                              : notifier.blackcolor,
                          fontSize: 16,
                          fontFamily: 'gilroysemi'),),
                    ),
                  ],
                ) : SizedBox(
                  height: 50,
                  width: 600,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: chips.length,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      side: BorderSide(color: selectedindex == index ? notifier.buttoncolor : Colors.transparent),
                                        borderRadius: BorderRadius.circular(20))),
                                backgroundColor: MaterialStateProperty.all(
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
                                  chipsHover[index] = value;
                                });
                              },
                              child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Image.asset(
                                //     'assets/Icons/dollarcircle.png', height: 15,
                                //     color: selectedindex == index ? notifier
                                //         .buttoncolor : notifier.blackcolor,alignment: Alignment.center),
                                Text(chips[index], style: TextStyle(
                                    fontFamily: 'gilroysemi',
                                    color: (selectedindex == index || chipsHover[index]) ? notifier
                                        .buttoncolor : notifier.blackcolor),textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                        ],
                      );
                    },),
                ),
                PopupMenuButton(
                  tooltip: '',
                  elevation: 0,
                  padding: const EdgeInsets.all(0),
                  offset: const Offset(0, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  // initialValue: selectedMenu,
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                    maxHeight: 400,
                  ),
                  color: notifier.whitecolor,
                  child: Container(
                    height: 50,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: notifier.whitecolor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(selectedvalue.isNotEmpty
                                  ? selectedvalue
                                  : selectedvalue = added[0], style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  fontSize: 16,
                                  color: notifier.blackcolor),),
                              SvgPicture.asset(notifier.isDark ? 'assets/Icons/filtericonDark.svg' : 'assets/Icons/filtericon.svg',height: 18,)
                            ],
                          ),
                    ),
                  ),
                  onSelected: (SampleItem item) {
                    setState(() {
                      // selectedMenu = item;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SampleItem>>[
                    PopupMenuItem<SampleItem>(
                      enabled: true,
                      value: SampleItem.itemOne,
                      onTap: () {
                        setState(() {
                          selectedvalue = added[0];
                        });
                      },
                      child: Text(added[0], style: TextStyle(
                          color: selectedvalue == added[0]
                              ? Colors.blue
                              : notifier.blackcolor,
                          fontSize: 16,
                          fontFamily: 'gilroysemi'),),
                    ),
                    PopupMenuItem<SampleItem>(
                      enabled: true,
                      value: SampleItem.itemOne,
                      onTap: () {
                        setState(() {
                          selectedvalue = added[1];
                        });
                      },
                      child: Text(added[1], style: TextStyle(
                          color: selectedvalue == added[1]
                              ? Colors.blue
                              : notifier.blackcolor,
                          fontSize: 16,
                          fontFamily: 'gilroysemi'),),
                    ),
                  ],
                ),
              ],
            ),
            // Image.asset(adventureimage[0],height: 100,width: 100,),
            const SizedBox(height: 50,),
            SizedBox(
              // height: constraints.maxWidth < 900 ? constraints.maxWidth / 0.152 : constraints.maxWidth < 1100 ? constraints.maxWidth / 0.66 : constraints.maxWidth < 1300 ? constraints.maxWidth / 1.35 : constraints.maxWidth / 1.8,
              width: constraints.maxWidth < 900 ? constraints.maxWidth / 0.2 : constraints.maxWidth < 1300 ? constraints.maxWidth / 0.5 : constraints.maxWidth / 1.2,
              child: GridView.builder(
                itemCount: constraints.maxWidth < 1300 ? 6 : 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth < 900 ? 1 : constraints.maxWidth < 1100 ? 2 : constraints.maxWidth < 1300 ? 3 : 4,
                    mainAxisSpacing: constraints.maxWidth < 900 ? 20 : constraints.maxWidth / 40,
                    crossAxisSpacing: constraints.maxWidth / 40,
                    mainAxisExtent: constraints.maxWidth < 550 ? constraints.maxWidth / 0.917 : constraints.maxWidth < 700 ? constraints.maxWidth / 0.952 : constraints.maxWidth < 900 ? constraints.maxWidth / 0.98 : constraints.maxWidth < 1100 ? constraints.maxWidth / 1.9 : constraints.maxWidth < 1300 ? constraints.maxWidth / 2.9 : constraints.maxWidth / 3.8),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: notifier.whitecolor,
                        borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Image.asset(
                               adventureimage[index],fit: BoxFit.cover,width: width / 1,
                                  height: constraints.maxWidth < 300 ? constraints.maxWidth / 1.32 : constraints.maxWidth <550 ? constraints.maxWidth / 1.30 : constraints.maxWidth < 750 ? constraints.maxWidth / 1.26 : constraints.maxWidth < 900 ? constraints.maxWidth / 1.22 : constraints.maxWidth < 1100 ? constraints.maxWidth / 2.85 : constraints.maxWidth < 1300 ? constraints.maxWidth / 5 : constraints.maxWidth / 6.3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: index == 0 ? notifier.bluecolor : index==2 ? notifier.buttoncolor : index==3 ? notifier.yellowcolor : Colors.transparent,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: Text(tag[index],style: TextStyle(fontFamily: 'gilroymed',fontSize: constraints.maxWidth < 1300 ? 14 : 12,color: index == 0 ? Colors.white : index==2 ? notifier.blackcolor : index==3 ? notifier.blackcolor : Colors.transparent),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10,top: 10),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if(favtrips.contains(adventureimage[index])){
                                            favtrips.remove(adventureimage[index]);
                                          }else{
                                            favtrips.add(adventureimage[index]);
                                          }
                                        });
                                      },
                                      onHover: (value) {
                                        setState(() {
                                          heartHover[index] = value;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        height: 30,
                                        width: 30,
                                        duration: const Duration(milliseconds: 200),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: notifier.whitecolor,
                                        ),
                                        child: (heartHover[index] || favtrips.contains(adventureimage[index])) ? const Center(child: Icon(Icons.favorite_rounded,size: 18,color: Colors.red,),) : Center(child: Icon(Icons.favorite_border_rounded,size: 18,color: notifier.blackcolor)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                       Padding(
                         padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                         child: SizedBox(
                           height: constraints.maxWidth < 550 ? constraints.maxWidth / 3.912 : constraints.maxWidth < 700 ? constraints.maxWidth / 4.75 : constraints.maxWidth < 900 ? constraints.maxWidth / 5.8 : constraints.maxWidth < 1100 ? constraints.maxWidth / 6.6 : constraints.maxWidth < 1300 ? constraints.maxWidth / 8 : constraints.maxWidth / 11,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Flexible(
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text('6+ Hours',style: TextStyle(fontFamily: 'gilroy',color: notifier.subgreycolor,fontSize: constraints.maxWidth < 550 ? constraints.maxWidth / 30 : constraints.maxWidth < 700 ? constraints.maxWidth / 35 : constraints.maxWidth < 900 ? constraints.maxWidth / 50 : constraints.maxWidth < 1100 ? constraints.maxWidth / 70 : constraints.maxWidth < 1300 ? constraints.maxWidth / 80 : constraints.maxWidth / 110),),
                                         const SizedBox(height: 5),
                                         Text(adventuretype[index],
                                           overflow: TextOverflow.ellipsis,
                                           style: TextStyle(fontFamily: 'gilroysemi',fontSize: constraints.maxWidth < 550 ? constraints.maxWidth / 30 : constraints.maxWidth < 700 ? constraints.maxWidth / 35 : constraints.maxWidth < 900 ? constraints.maxWidth / 50 : constraints.maxWidth < 1100 ? constraints.maxWidth / 70 : constraints.maxWidth < 1300 ? constraints.maxWidth / 80 : constraints.maxWidth / 110,color: notifier.blackcolor,
                                             height: constraints.maxWidth < 550 ? constraints.maxWidth / 300 : constraints.maxWidth < 730 ? constraints.maxWidth / 350 : constraints.maxWidth < 900 ? constraints.maxWidth / 450 : constraints.maxWidth < 1100 ? constraints.maxWidth / 700 : constraints.maxWidth < 1300 ? constraints.maxWidth / 650 : constraints.maxWidth >= 1800 ? constraints.maxWidth / 1200 : constraints.maxWidth >= 2000 ? constraints.maxWidth / 1600 : constraints.maxWidth / 1000,
                                           ),
                                           maxLines: 2,),
                                         SizedBox(height: constraints.maxWidth < 900 ? constraints.maxWidth / 60 : constraints.maxWidth < 1100 ? constraints.maxWidth / 60 : constraints.maxWidth / 100),
                                         Text(adventurelocation[index],style: TextStyle(fontFamily: 'gilroymed',color: notifier.subgreycolor,fontSize: constraints.maxWidth < 550 ? constraints.maxWidth / 35 : constraints.maxWidth < 700 ? constraints.maxWidth / 60 : constraints.maxWidth < 900 ? constraints.maxWidth / 60 : constraints.maxWidth < 1300 ? constraints.maxWidth / 90 : constraints.maxWidth / 110,),),
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                               // SizedBox(height: constraints.maxWidth < 550 ? constraints.maxWidth / 25 : constraints.maxWidth < 700 ? constraints.maxWidth / 30 : constraints.maxWidth < 900 ? constraints.maxWidth / 50 : constraints.maxWidth < 1100 ? constraints.maxWidth / 60 : constraints.maxWidth < 1300 ? constraints.maxWidth / 45 : constraints.maxWidth / 45,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Icon(Icons.star_rounded,color: notifier.yellowcolor,size: constraints.maxWidth < 550 ? constraints.maxWidth / 35 : constraints.maxWidth < 700 ? constraints.maxWidth / 40 : constraints.maxWidth < 900 ? constraints.maxWidth / 50 : constraints.maxWidth < 1100 ? constraints.maxWidth / 70 : constraints.maxWidth < 1300 ? constraints.maxWidth / 70 : constraints.maxWidth / 90,),
                                       const SizedBox(width: 5,),
                                       Text('4.82',style: TextStyle(fontFamily: 'gilroysemi',fontSize: constraints.maxWidth < 550 ? constraints.maxWidth / 35 : constraints.maxWidth < 700 ? constraints.maxWidth / 40 : constraints.maxWidth < 900 ? constraints.maxWidth / 50 : constraints.maxWidth < 1100 ? constraints.maxWidth / 70 : constraints.maxWidth < 1300 ? constraints.maxWidth / 90 : constraints.maxWidth / 110,color: notifier.blackcolor)),
                                       const SizedBox(width: 5),
                                       Text('94 reviews',style: TextStyle(color: notifier.subgreycolor,fontFamily: 'gilroy',fontSize: constraints.maxWidth < 550 ? constraints.maxWidth / 35 : constraints.maxWidth < 700 ? constraints.maxWidth / 40 : constraints.maxWidth < 900 ? constraints.maxWidth / 50 : constraints.maxWidth < 1100 ? constraints.maxWidth / 70 : constraints.maxWidth < 1300 ? constraints.maxWidth / 90 : constraints.maxWidth / 110),)
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       Text('From',style: TextStyle(fontFamily: 'gilroy',color: notifier.subgreycolor,fontSize: constraints.maxWidth < 550 ? constraints.maxWidth / 35 : constraints.maxWidth < 700 ? constraints.maxWidth / 40 : constraints.maxWidth < 900 ? constraints.maxWidth / 50 : constraints.maxWidth < 1100 ? constraints.maxWidth / 70 : constraints.maxWidth < 1300 ? constraints.maxWidth / 90 : constraints.maxWidth / 110)),
                                       const SizedBox(width: 5),
                                       Text('US\$72',style: TextStyle(fontFamily: 'gilroysemi',color: notifier.blackcolor,fontSize: constraints.maxWidth < 550 ? constraints.maxWidth / 35 : constraints.maxWidth < 700 ? constraints.maxWidth / 40 : constraints.maxWidth < 900 ? constraints.maxWidth / 50 : constraints.maxWidth < 1100 ? constraints.maxWidth / 70 : constraints.maxWidth < 1300 ? constraints.maxWidth / 90 : constraints.maxWidth / 110)),
                                     ],
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),
                      ],
                    ),
                  );
                },),
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

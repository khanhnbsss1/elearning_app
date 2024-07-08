// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/colornotifier.dart';
import '../mediaquery/mq.dart';

class placeshelp extends StatefulWidget {
  const placeshelp({super.key});

  @override
  State<placeshelp> createState() => _placeshelpState();
}

class _placeshelpState extends State<placeshelp> {
  late ColorNotifier notifier;

  PageController pg = PageController();
  int a = 4;
  List placesimage = [
    'assets/deshboard/places/placespic1.png',
    'assets/deshboard/places/placespic2.png',
    'assets/deshboard/places/placespic3.png',
    'assets/deshboard/places/placespic1.png',
    'assets/deshboard/places/placespic4.png',
    'assets/deshboard/places/placespic5.png',
    'assets/deshboard/places/placespic6.png',
    'assets/deshboard/places/placespic7.png',
    'assets/deshboard/places/placespic8.png'
  ];
  List placesimage2 = [
    'assets/deshboard/places/placespic5.png',
    'assets/deshboard/places/placespic6.png',
    'assets/deshboard/places/placespic7.png',
    'assets/deshboard/places/placespic8.png'
  ];

  List placesname2 = ['North Justen','Port Elyseberg','Danielmouth','Russelville'];
  List placesname = ['Thompsonbury','Hudsontown','Lake Marcelle','New Keagan','MacGyverton','North Justen','Port Elyseberg','Danielmouth','Russelville'];
  List time = ['15 minutes drive','28 minutes drive','35 minutes drive','44 minutes drive','55 minutes drive','1 hours drive','2 hours drive','5 hours drive','8 hours drive'];
  List time2 = ['1 hours drive','2 hours drive','5 hours drive','8 hours drive'];

  List<bool> hoverboeder = [false,false,false,false,false,false,false,false,false,false];
  List<bool> hoverboeder2 = [false,false,false,false,false];
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        return places(constraints);
      },
    );
  }
  Widget places(constraints) {
    return Container(
      height:  constraints.maxWidth < 550 ? 450 : constraints.maxWidth < 800 ? 500  : constraints.maxWidth < 1100 ? 1000  : constraints.maxWidth < 1200 ? 750 : 850,
      width: constraints.maxWidth < 1100 ? constraints.maxWidth / 1 : constraints.maxWidth < 1200 ? constraints.maxWidth / 1.09 : constraints.maxWidth / 1.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: notifier.lightgreycolor,
        border: Border.all(color: notifier.sugestionbutton),
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Popular destination',
              style: baseStyle.copyWith(
                  fontSize: constraints.maxWidth < 550 ? 28 : constraints.maxWidth < 800 ? 40 : constraints.maxWidth < 1100 ? 50 : 50,
                  
                  color: notifier.blackcolor),
          ),
          SizedBox(height: constraints.maxWidth / 80),
          Text('MOST ATTRACTIVE',
              style: baseStyle.copyWith(
                  fontSize: constraints.maxWidth < 550 ? 18 : constraints.maxWidth < 800 ? 20 : constraints.maxWidth < 1100 ? 20 : 25,
                  fontFamily: 'gilroymed',
                  color: notifier.subgreycolor)),
          SizedBox(height: constraints.maxWidth < 550 ? 30 : constraints.maxWidth / 40),
          constraints.maxWidth < 800 ? places3(constraints) : constraints.maxWidth <  1100 ? places2(constraints) : Column(
            children: [
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: constraints.maxWidth < 1200 ? 4 : 5,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                            height: constraints.maxWidth < 1200 ? 220 : 220,
                            width:  constraints.maxWidth < 1200 ? constraints.maxWidth / 5.2 : constraints.maxWidth / 8.5,
                            decoration: BoxDecoration(
                              color: notifier.whitecolor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: hoverboeder[index] ? (notifier.isDark ? notifier.sugestionbutton : notifier.subgreycolor) : Colors.transparent),
                            ),
                            child: InkWell(
                              onTap: () {

                              },
                              onHover: (value) {
                                setState(() {
                                  hoverboeder[index] = value;
                                });
                              },
                              child: Padding(padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: notifier.lightgreycolor,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text('1480',style: baseStyle.copyWith(fontSize: 12,color: notifier.subgreycolor,fontWeight: FontWeight.w800,letterSpacing: 1)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    CircleAvatar(
                                      radius: 45,
                                        backgroundImage: AssetImage(placesimage[index]),),
                                    const SizedBox(height: 20,),
                                    Text(placesname[index],style: baseStyle.copyWith(fontSize: 16,color: notifier.blackcolor)),
                                    const SizedBox(height: 10,),
                                    Text(time[index],style: baseStyle.copyWith(fontFamily: 'gilroymed',fontSize: 12,color: notifier.subgreycolor)),
                                  ],
                                ),
                              ),
                            )
                        ),
                        SizedBox(width: constraints.maxWidth / 50,)
                      ],
                    );
                  },),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: constraints.maxWidth < 1200 ? 3 : 4,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                            height: constraints.maxWidth < 1200 ? 220 : 220,
                            width:  constraints.maxWidth < 1200 ? constraints.maxWidth / 5.2 : constraints.maxWidth / 8.5,
                            decoration: BoxDecoration(
                              color: notifier.whitecolor,
                              borderRadius: BorderRadius.circular(10),
                              border:  Border.all(color: hoverboeder2[index] ? (notifier.isDark ? notifier.sugestionbutton : notifier.subgreycolor) : Colors.transparent)
                            ),
                            child: InkWell(
                              onTap: () {

                              },
                              onHover: (value) {
                                setState(() {
                                  hoverboeder2[index] = value;
                                });
                              },
                              child: Padding(padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: notifier.lightgreycolor,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text('1480',style: baseStyle.copyWith(fontSize: 12,color: notifier.subgreycolor,fontWeight: FontWeight.w800,letterSpacing: 1)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundImage: AssetImage(placesimage2[index],),),
                                    const SizedBox(height: 20,),
                                    Text(placesname2[index],style: baseStyle.copyWith(fontSize: 16,color: notifier.blackcolor)),
                                    const SizedBox(height: 10,),
                                    Text(time2[index],style: baseStyle.copyWith(fontFamily: 'gilroymed',fontSize: 12,color: notifier.subgreycolor)),
                                  ],
                                ),
                              ),
                            ),
                        ),
                        SizedBox(width: constraints.maxWidth / 50,)
                      ],
                    );
                  },),
              ),
            ],
          )
        ],
      ),
    );
  }
  Widget places2(constraints){
    return SizedBox(
      height: 820,
      child: Padding(padding: const EdgeInsets.all(50),
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent:  220,
                mainAxisSpacing: 30,
                crossAxisSpacing: 30
            ),
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: notifier.whitecolor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: hoverboeder[index] ? (notifier.isDark ? notifier.sugestionbutton : notifier.subgreycolor) : Colors.transparent)
                  ),
                  child: InkWell(
                    onTap: () {

                    },
                    onHover: (value) {
                      setState(() {
                        hoverboeder[index] = value;
                      });
                    },
                    child: Padding(padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 45,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: notifier.lightgreycolor,
                                ),
                                alignment: Alignment.center,
                                child: Text('1480',style: baseStyle.copyWith(fontSize: 12,color: notifier.subgreycolor,fontWeight: FontWeight.w800,letterSpacing: 1)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          CircleAvatar(
                            radius: 45,
                              backgroundImage: AssetImage(placesimage[index],),),
                          const SizedBox(height: 20,),
                          Text(placesname[index],style: baseStyle.copyWith(fontSize: 16,color: notifier.blackcolor)),
                          const SizedBox(height: 10,),
                          Text(time[index],style: baseStyle.copyWith(fontFamily: 'gilroymed',fontSize: 12,color: notifier.subgreycolor)),
                        ],
                      ),
                    ),
                  )
              );
            },),
      ),
    );
  }
  Widget places3(constraints){
    return Padding(padding: EdgeInsets.only(left: constraints.maxWidth < 550 ? 10 : 50),
          child: Column(
            children: [
              SizedBox(
                height: 220,
                child: ListView.builder(
                  itemCount: 9,
                  controller: pg,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                            width: constraints.maxWidth / 2,
                            decoration: BoxDecoration(
                              color: notifier.whitecolor,
                              borderRadius: BorderRadius.circular(10),
                              border:  Border.all(color: hoverboeder[index] ? (notifier.isDark ? notifier.sugestionbutton : notifier.subgreycolor) : Colors.transparent)
                            ),
                            child: InkWell(
                              onTap: () {

                              },
                              onHover: (value) {
                                setState(() {
                                  hoverboeder[index] = value;
                                });
                              },
                              child: Padding(padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: notifier.lightgreycolor,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text('1480',style: baseStyle.copyWith(fontSize: 12,color: notifier.subgreycolor,fontWeight: FontWeight.w800,letterSpacing: 1)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    CircleAvatar(
                                      radius: 45,
                                        backgroundImage: AssetImage(placesimage[index])),
                                    const SizedBox(height: 20,),
                                    Text(placesname[index],style: baseStyle.copyWith(fontSize: 16,color: notifier.blackcolor)),
                                    const SizedBox(height: 10,),
                                    Text(time[index],style: baseStyle.copyWith(fontFamily: 'gilroymed',fontSize: 12,color: notifier.subgreycolor)),
                                  ],
                                ),
                              ),
                            ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    );
                  },),
              ),
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        constraints.maxWidth < 700 ? a = 4 : constraints.maxWidth < 800 ? a = 10 : a = 7;
                        pg.animateTo(double.parse("${-a}00"),
                            curve: const FlippedCurve(Easing.legacy),
                            duration: const Duration(seconds: 1));
                        setState(() {
                          a = a - 4;
                        });
                      });
                    },
                    child: Image.asset('assets/Icons/arrowlefticon.png',height: 8,color: notifier.subgreycolor,),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pg.animateTo(double.parse("${a}00"),
                            curve: const FlippedCurve(Easing.legacy),
                            duration: const Duration(seconds: 1));
                        setState(() {
                          a = a + 4;
                        });
                      });
                    },
                    child: Image.asset('assets/Icons/arrowrighticon.png',height: 8,color: notifier.subgreycolor,),
                  ),
                ],
              ),
            ],
          ),
    );
  }
}

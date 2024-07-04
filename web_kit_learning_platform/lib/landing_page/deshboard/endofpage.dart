// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/constant/dimens_constant.dart';
import 'package:webkit/base/widgets/static_view/static_view.dart';

import '../components/colornotifier.dart';
import '../mediaquery/mq.dart';

class EndOfPage extends StatefulWidget {
  const EndOfPage({super.key});

  @override
  State<EndOfPage> createState() => _EndOfPageState();
}

class _EndOfPageState extends State<EndOfPage> {
  late ColorNotifier notifier;
  List chips = [
    'Stays',
    'Flights',
    'Support',
    'JOIN OUR COMMUNITY 🔥',
    'Cars',
    'Things to do',
    '',
    ''
  ];
  List chips2 = [
    'Stays',
    'Flights',
    'JOIN OUR COMMUNITY 🔥',
    'Cars',
    'Things to do',
    '',
    'Support'
  ];
  List chips3 = [
    'Stays',
    'Flights',
    'Cars',
    'Things to do',
    'Support',
    '',
    'JOIN OUR COMMUNITY 🔥'
  ];

  List logos = [
    'assets/logo/linkdinLogo.svg',
    'assets/logo/twitterxLogo.svg',
    'assets/logo/facebookLogo.svg'
  ];

  List logosDark = [
    'assets/logo/linkdinLogoDark.svg',
    'assets/logo/twitterxLogoDark.svg',
    'assets/logo/facebookLogoDark.svg'
  ];

  List endElements = [
    L10nX.getStr.overview,
    L10nX.getStr.quick_links,
    L10nX.getStr.utilities,
    L10nX.getStr.home,
    L10nX.getStr.blog,
    L10nX.getStr.style_guide,
    L10nX.getStr.company,
    L10nX.getStr.contact,
    L10nX.getStr.licensing,
    L10nX.getStr.pricing,
    '',
    L10nX.getStr.change_log,
    '',
    '',
    '404'
  ];
  bool tfHover = false;

  List contactsImage = [
    'assets/Icons/emailicon.svg',
    'assets/Icons/phoneicon.svg',
    'assets/Icons/gpsicon.svg'
  ];
  List contacts = [
    'hello@pulse.com',
    '+33 455 67 89 00',
    'Innovation St. 767,CA - USA'
  ];

  List<bool> elementsHover = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        return eop(constraints);
      },
    );
  }

  Widget eop(constraints) {
    return Padding(
      padding: EdgeInsets.only(
          left: constraints.maxWidth < 500
              ? 10
              : constraints.maxWidth < 900
              ? constraints.maxWidth / 20
              : constraints.maxWidth < 1300
              ? constraints.maxWidth / 15
              : constraints.maxWidth / 8,
          right: constraints.maxWidth < 500
              ? 10
              : constraints.maxWidth < 900
              ? constraints.maxWidth / 20
              : constraints.maxWidth < 1300
                  ? constraints.maxWidth / 15
                  : constraints.maxWidth / 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          constraints.maxWidth < 900
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ImageManager().getPngImage(ImageManager.logo, height: constraints.maxWidth < Dimens.size300 ? Dimens.size27 : Dimens.size35),
                          const SizedBox(width: 5),
                          Text(
                            L10nX.getStr.app_name,
                            style: TextStyle(
                                fontFamily: 'gilroybold',
                                color: notifier.blackcolor,
                                fontSize: constraints.maxWidth < 300 ? 16 : 24),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: constraints.maxWidth < 300 ? 10 : 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/Icons/lightbulbicon.png',
                              height: constraints.maxWidth < 300 ? 14 : 20,
                              color: notifier.subgreycolor),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            L10nX.getStr.dark_theme,
                            style: TextStyle(
                                fontFamily: 'gilroysemi',
                                fontSize: constraints.maxWidth < 300 ? 12 : 14,
                                color: notifier.subgreycolor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          SizedBox(
                            height: 29,
                            child: FlutterSwitch(
                              height: 23.0,
                              width: constraints.maxWidth < 300 ? 40.0 : 45.0,
                              padding: 4.0,
                              toggleSize: 16.0,
                              borderRadius: 15.0,
                              inactiveToggleColor: notifier.buttoncolor,
                              activeColor: notifier.buttoncolor,
                              inactiveColor: notifier.sugestionbutton,
                              value: notifier.isDark,
                              onToggle: (bool value) {
                                setState(() {
                                  notifier.isAvailable(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                      width: width / 1,
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(contactsImage[index],
                                  height: 20),
                              const SizedBox(width: 10),
                              Text(contacts[index],
                                  style: TextStyle(
                                      fontFamily: 'gilroysemi',
                                      color: notifier.subgreycolor,
                                      fontSize: 16)),
                              const SizedBox(width: 20),
                            ],
                          );
                        },
                      )),
                Text(L10nX.getStr.subcribe_to_our_news_letter,
                  style: TextStyle(
                      fontFamily: 'gilroysemi',
                      color: notifier.blackcolor),
                ),
                const SizedBox(height: 10),
                ])
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              StaticView.buildLogo(),
                              //ImageManager().getPngImage(ImageManager.logo, height: Dimens.size35),
                              const SizedBox(width: 5),
                              Text(
                                L10nX.getStr.app_name,
                                style: TextStyle(
                                  fontFamily: 'gilroybold',
                                  color: notifier.blackcolor,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/Icons/lightbulbicon.png',
                                  height: 20, color: notifier.subgreycolor),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                L10nX.getStr.dark_theme,
                                style: TextStyle(
                                    fontFamily: 'gilroysemi',
                                    fontSize: 14,
                                    color: notifier.subgreycolor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              SizedBox(
                                height: 29,
                                child: FlutterSwitch(
                                  height: 23.0,
                                  width: 45.0,
                                  padding: 4.0,
                                  toggleSize: 16.0,
                                  borderRadius: 15.0,
                                  inactiveToggleColor: notifier.buttoncolor,
                                  activeColor: notifier.buttoncolor,
                                  inactiveColor: notifier.sugestionbutton,
                                  value: notifier.isDark,
                                  onToggle: (bool value) {
                                    notifier.isAvailable(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(L10nX.getStr.subcribe_to_our_news_letter,
                              style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  color: notifier.blackcolor)),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 60,
                            width: 300,
                            child: TextField(
                              style: TextStyle(fontFamily: 'gilroysemi',color: notifier.blackcolor),
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: notifier.isDark
                                          ? const Color(0xFF353945)
                                          : const Color(0xFFE6E8EC)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: notifier.isDark
                                          ? const Color(0xFF353945)
                                          : const Color(0xFFE6E8EC)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      width: 1, color: notifier.subgreycolor),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: notifier.isDark
                                          ? const Color(0xFF23262F)
                                          : const Color(0xFFE6E8EC)),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {},
                                  onHover: (value) {
                                    setState(() {
                                      tfHover = value;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    width: 70,
                                    height: 40,
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      color: tfHover
                                          ? Colors.indigoAccent.shade700
                                          : notifier.buttoncolor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(L10nX.getStr.send,
                                        style: TextStyle(
                                            fontFamily: 'gilroysemi',
                                            color: Colors.white,
                                            fontSize: 16)),
                                  ),
                                ),
                                hintText: L10nX.getStr.enter_your_email,
                                hintStyle: TextStyle(
                                    fontFamily: 'gilroy',
                                    color: notifier.subgreycolor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          constraints.maxWidth < 900
              ? SizedBox(
                  height: 60,
                  width: constraints.maxWidth / 1,
                  child: TextField(
                    style: TextStyle(fontFamily: 'gilroysemi',color: notifier.blackcolor),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                            width: 1,
                            color: notifier.isDark
                                ? const Color(0xFF353945)
                                : const Color(0xFFE6E8EC)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                            width: 2,
                            color: notifier.isDark
                                ? const Color(0xFF353945)
                                : const Color(0xFFE6E8EC)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            BorderSide(width: 1, color: notifier.subgreycolor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                            width: 1,
                            color: notifier.isDark
                                ? const Color(0xFF23262F)
                                : const Color(0xFFE6E8EC)),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {},
                        onHover: (value) {
                          setState(() {
                            tfHover = value;
                          });
                        },
                        child: AnimatedContainer(
                          width: 70,
                          height: 40,
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: tfHover
                                ? Colors.indigoAccent.shade700
                                : notifier.buttoncolor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(L10nX.getStr.send,
                              style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  color: Colors.white,
                                  fontSize: 16)),
                        ),
                      ),
                      hintText: L10nX.getStr.enter_your_email,
                      hintStyle: TextStyle(
                          fontFamily: 'gilroy', color: notifier.subgreycolor),
                    ),
                  ),
                )
              : const SizedBox(),
          constraints.maxWidth < 900
              ? const SizedBox()
              : SizedBox(
                  width: width / 1,
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(contactsImage[index], height: 20),
                          const SizedBox(width: 10),
                          Text(contacts[index],
                              style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  color: notifier.subgreycolor,
                                  fontSize: 16)),
                          const SizedBox(width: 20),
                        ],
                      );
                    },
                  )),
          const SizedBox(height: 30),
          Divider(
            color: notifier.isDark
                ? notifier.subgreycolor
                : notifier.sugestionbutton,
          ),
          const SizedBox(height: 30),
          constraints.maxWidth < 900
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          // width: 300,
                          child: ListView.builder(
                            itemCount: logos.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Container(
                                    height: 40,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: notifier.subgreycolor,
                                      ),
                                    ),
                                    child: SvgPicture.asset(notifier.isDark ? logosDark[index] : logos[index],
                                        height: 20),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Copyright © Make it ${L10nX.getStr.app_name}\n| Designed by Make it Services - Powered by ${L10nX.getStr.app_name}',
                          style: TextStyle(
                              fontSize: constraints.maxWidth < 500 ? 12 : 14,
                              fontFamily: 'gilroymed',
                              color: notifier.isDark
                                  ? notifier.subgreycolor
                                  : notifier.blackcolor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 200,
                      width: width / 1,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: endElements.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 40,
                          crossAxisSpacing: constraints.maxWidth < 500 ? constraints.maxWidth / 10 : constraints.maxWidth / 5,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            onHover: (value) {
                              setState(() {
                                elementsHover[index] = value;
                              });
                            },
                            child: Text(
                              endElements[index],
                              style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  fontSize: constraints.maxWidth < 500 ? 14 : 16,
                                  color: elementsHover[index] ? notifier.buttoncolor : notifier.subgreycolor),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          // width: 300,
                          child: ListView.builder(
                            itemCount: logos.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Container(
                                    height: 40,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: notifier.subgreycolor,
                                      ),
                                    ),
                                    child: SvgPicture.asset(notifier.isDark ? logosDark[index] : logos[index],
                                        height: 20),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Copyright © Make it ${L10nX.getStr.app_name}\n| Designed by Make it Services - Powered by ${L10nX.getStr.app_name}',
                          style: TextStyle(
                              fontSize: constraints.maxWidth < 300 ? 10 : 14,
                              fontFamily: 'gilroymed',
                              color: notifier.isDark
                                  ? notifier.subgreycolor
                                  : notifier.blackcolor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      width:  400,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: endElements.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 40,
                            crossAxisSpacing: 50),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            onHover: (value) {
                              setState(() {
                                elementsHover[index] = value;
                              });
                            },
                            child: Text(
                              endElements[index],
                              style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  fontSize: 16,
                                  color: elementsHover[index] ? notifier.buttoncolor : notifier.subgreycolor),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
// // ignore_for_file: camel_case_types
//
// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:provider/provider.dart';
//
// import '../helper/colornotifier.dart';
// import '../mediaquery/mq.dart';
//
// class endofpage extends StatefulWidget {
//   const endofpage({Key? key}) : super(key: key);
//
//   @override
//   State<endofpage> createState() => _endofpageState();
// }

// class _endofpageState extends State<endofpage> {
//
//   late ColorNotifier notifier;
//   List chips = ['Stays','Flights','Support','JOIN OUR COMMUNITY 🔥','Cars','Things to do','',''];
//   List chips2 = ['Stays','Flights','JOIN OUR COMMUNITY 🔥','Cars','Things to do','','Support'];
//   List chips3 = ['Stays','Flights','Cars','Things to do','Support','','JOIN OUR COMMUNITY 🔥'];
//
//   bool tfHover = false;
//   @override
//   Widget build(BuildContext context) {
//     notifier = Provider.of<ColorNotifier>(context, listen: true);
//     height = MediaQuery
//         .of(context)
//         .size
//         .height;
//     width = MediaQuery
//         .of(context)
//         .size
//         .width;
//     return LayoutBuilder(builder: (context, constraints) {
//       return eop(constraints);
//     },);
//   }
//   Widget eop(constraints){
//     return Padding(
//       padding: EdgeInsets.only(left: constraints.maxWidth < 900 ? constraints.maxWidth / 15 : constraints.maxWidth < 1300 ? constraints.maxWidth / 10 : constraints.maxWidth / 8,right: constraints.maxWidth < 900 ? constraints.maxWidth / 20 : constraints.maxWidth < 1300 ? constraints.maxWidth / 10 : constraints.maxWidth / 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           constraints.maxWidth < 900 ? Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Image.asset('assets/logo/travellylogo.png',height: constraints.maxWidth < 300 ? 27 : 35),
//                         const SizedBox(width: 5),
//                         Text('Voyage',style: TextStyle(fontFamily: 'gilroybold',color: notifier.blackcolor,fontSize: constraints.maxWidth < 300 ? 16 : 24
//                         ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: constraints.maxWidth < 300 ? 10 : 20,),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Image.asset('assets/Icons/lightbulbicon.png',height: constraints.maxWidth < 300 ? 14 : 20,color: notifier.subgreycolor),
//                         const SizedBox(width: 7,),
//                         Text('Dark theme',style: TextStyle(fontFamily: 'gilroysemi',fontSize: constraints.maxWidth < 300 ? 12 : 14,color: notifier.subgreycolor,fontWeight: FontWeight.w600,letterSpacing: 1),),
//                         const SizedBox(width: 7,),
//                         SizedBox(
//                           height: 29,
//                           child: FlutterSwitch(
//                             height: 23.0,
//                             width: constraints.maxWidth < 300 ? 40.0 : 45.0,
//                             padding: 4.0,
//                             toggleSize: 16.0,
//                             borderRadius: 15.0,
//                             inactiveToggleColor: notifier.buttoncolor,
//                             activeColor: notifier.buttoncolor,
//                             inactiveColor: notifier.sugestionbutton,
//                             value: notifier.isDark,
//                             onToggle: (bool value) {
//                               setState(() {
//                                 notifier.isAvailable(value);
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 50),
//                 SizedBox(
//                   height: 200,
//                   child: Wrap(
//                     children: [
//                       for(int a =0; a < chips3.length;a++)
//                         Padding(padding: const EdgeInsets.only(bottom: 40),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text("${chips3[a]}",style: TextStyle(fontFamily: 'gilroysemi',fontSize: constraints.maxWidth < 300 ? 12 : 14,color: a==6 ? notifier.blackcolor : notifier.subgreycolor,fontWeight: FontWeight.w600,letterSpacing: 1),),
//                               SizedBox(width: constraints.maxWidth < 300 ? 60 : constraints.maxWidth < 700 ? constraints.maxWidth / 4 : constraints.maxWidth /3,),
//                             ],
//                           ),
//                         )
//                     ],
//                   ),
//                 ),
//               ]
//           ) : Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Image.asset('assets/logo/travellylogo.png',height: 35),
//                         const SizedBox(width: 5),
//                         Text('Voyage',style: TextStyle(fontFamily: 'gilroybold',color: notifier.blackcolor,fontSize: 24,
//                         ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20,),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Image.asset('assets/Icons/lightbulbicon.png',height: 20,color: notifier.subgreycolor),
//                         const SizedBox(width: 7,),
//                         Text('Dark theme',style: TextStyle(fontFamily: 'gilroysemi',fontSize: 14,color: notifier.subgreycolor,fontWeight: FontWeight.w600,letterSpacing: 1),),
//                         const SizedBox(width: 7,),
//                         SizedBox(
//                           height: 29,
//                           child: FlutterSwitch(
//                             height: 23.0,
//                             width: 45.0,
//                             padding: 4.0,
//                             toggleSize: 16.0,
//                             borderRadius: 15.0,
//                             inactiveToggleColor: notifier.buttoncolor,
//                             activeColor: notifier.buttoncolor,
//                             inactiveColor: notifier.sugestionbutton,
//                             value: notifier.isDark,
//                             onToggle: (bool value) {
//                               notifier.isAvailable(value);
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 flex: constraints.maxWidth < 900 ? 3 : constraints.maxWidth < 1000 ? 3 : constraints.maxWidth < 1300 ? 4 : 5,
//                 child: Wrap(
//                   children: [
//                     for(int a =0; a < (constraints.maxWidth < 1000 ? chips2.length : chips.length);a++)
//                       Padding(padding: EdgeInsets.only(bottom: (constraints.maxWidth < 1000 ? a==5 : a==7) ? 20 : 40),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             SizedBox(width: constraints.maxWidth / 25,),
//                             Text("${constraints.maxWidth < 1000 ? chips2[a] : chips[a]}",style: TextStyle(fontFamily: 'gilroysemi',fontSize: 14,color: (constraints.maxWidth < 1000 ? a==2 : a==3) ? notifier.blackcolor : notifier.subgreycolor,fontWeight: FontWeight.w600,letterSpacing: 1),),
//                             (constraints.maxWidth < 1000 ? a==5 : a==7) ? SizedBox(
//                               height: 45,
//                               width: constraints.maxWidth / 6,
//                               child:  TextField(
//                                 decoration: InputDecoration(
//                                   disabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25),
//                                     borderSide: BorderSide(width: 1,color: notifier.isDark ? const Color(0xFF353945) : const Color(0xFFE6E8EC)),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25),
//                                     borderSide: BorderSide(width: 2,color: notifier.isDark ? const Color(0xFF353945) : const Color(0xFFE6E8EC)),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25),
//                                     borderSide: BorderSide(width: 1,color: notifier.subgreycolor),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25),
//                                     borderSide: BorderSide(width: 1,color: notifier.isDark ? const Color(0xFF23262F) : const Color(0xFFE6E8EC)),
//                                   ),
//                                   suffixIcon:  InkWell(
//                                     onTap: () {
//
//                                     },
//                                     onHover: (value) {
//                                       setState(() {
//                                         tfHover = value;
//                                       });
//                                     },
//                                     child: AnimatedContainer(
//                                       duration: const Duration(milliseconds: 200),
//                                       margin: const EdgeInsets.only(right: 10),
//                                       decoration: BoxDecoration(
//                                           color: tfHover ? Colors.indigoAccent.shade700 : notifier.buttoncolor,
//                                           shape: BoxShape.circle
//                                       ),
//                                       child: Image.asset('assets/Icons/arrowrighticon.png',scale: 3,width: 3,color: notifier.whitecolor),
//                                     ),
//                                   ),
//                                   hintText: 'Enter youe Email',
//                                   hintStyle: TextStyle(fontFamily: 'gilroy',color: notifier.subgreycolor),
//                                 ),
//                               ),
//                             ) : a==6 ? const SizedBox() : const SizedBox(),
//                             SizedBox(width: constraints.maxWidth / 25,),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           constraints.maxWidth < 900 ? SizedBox(
//             height: constraints.maxWidth < 300 ? 40 : 45,
//             width: constraints.maxWidth / 1,
//             child:  TextField(
//               style: TextStyle(fontFamily: 'gilroysemi',color: notifier.blackcolor),
//               decoration: InputDecoration(
//                   disabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                     borderSide: BorderSide(width: 1,color: notifier.isDark ? const Color(0xFF353945) : const Color(0xFFE6E8EC)),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                     borderSide: BorderSide(width: 2,color: notifier.isDark ? const Color(0xFF353945) : const Color(0xFFE6E8EC)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                     borderSide: BorderSide(width: 1,color: notifier.subgreycolor),
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                     borderSide: BorderSide(width: 1,color: notifier.isDark ? const Color(0xFF23262F) : const Color(0xFFE6E8EC)),
//                   ),
//                   suffixIcon:  Container(
//                     margin: const EdgeInsets.only(right: 10),
//                     decoration: BoxDecoration(
//                         color: notifier.buttoncolor,
//                         shape: BoxShape.circle
//                     ),
//                     child: Image.asset('assets/Icons/arrowrighticon.png',scale: 3,width: 3,color: notifier.whitecolor),
//                   ),
//                   hintText: 'Enter youe email',
//                   hintStyle: TextStyle(fontFamily: 'gilroy',color: notifier.subgreycolor)
//               ),
//             ),
//           ) : const SizedBox(),
//           const SizedBox(height: 30),
//           Divider(
//             color: notifier.isDark ? notifier.subgreycolor : notifier.sugestionbutton,
//           ),
//           // const SizedBox(height: 20),
//           // SizedBox(
//           //   height: 50,
//           // ),
//           const SizedBox(height: 20),
//           Text('Copyright © 2021 UI8 LLC. All rights reserved',style: TextStyle(fontSize: constraints.maxWidth < 300 ? 10 : 14,fontFamily: 'gilroymed',color: notifier.isDark ? notifier.subgreycolor : notifier.blackcolor),),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }

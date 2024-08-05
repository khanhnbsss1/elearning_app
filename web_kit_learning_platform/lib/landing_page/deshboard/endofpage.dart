// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/responsive/ui_responsive.dart';
import 'package:webkit/base/widgets/static_view/static_view.dart';

import '../components/colornotifier.dart';
import '../mediaquery/mq.dart';
class EndOfPage extends StatelessWidget with ResponsivePage{
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
    '0932130000',
    'Số 26 Đường 57A, phường Tân Tạo, Quận Bình Tân, TPHCM'
  ];

  List<bool> elementsHover = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return buildUi(context);
    
  }

  @override
  Widget buildDesktop(BuildContext context) {
    // TODO: implement buildDesktop
   return buildTabletUi(context);
  }

  @override
  Widget buildMobile(BuildContext context) {
    // TODO: implement buildMobile
    return buildMobileUi(context);
  }

  @override
  Widget buildTablet(BuildContext context) {
    // TODO: implement buildTablet
    return buildTabletUi(context);
  }

  Widget buildTabletUi(constraints) {
    return StatefulBuilder(
      builder: (BuildContext context, 
          void Function(void Function()) setState) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) { 
            return Column(
              children: [
                Padding(
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
                      Column(
                        children: [
                          Row(
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
                                          style: baseStyle.copyWith(
                                            color: notifier.blackcolor,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(L10nX.getStr.subcribe_to_our_news_letter,
                                      style: baseStyle.copyWith(

                                          color: notifier.blackcolor)),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 60,
                                    width: 300,
                                    child: TextField(
                                      style: baseStyle.copyWith(color: notifier.blackcolor),
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
                                                  ? Color.fromRGBO(134, 16, 14, 1.0)
                                                  : notifier.redcolor,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(L10nX.getStr.send,
                                                style: baseStyle.copyWith(

                                                    color: Colors.white,
                                                    fontSize: 16)),
                                          ),
                                        ),
                                        hintText: L10nX.getStr.enter_your_email,
                                        hintStyle: baseStyle.copyWith(

                                            color: notifier.subgreycolor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(),
                        ],
                      ),
                      Divider(
                        color: notifier.isDark
                            ? notifier.subgreycolor
                            : notifier.sugestionbutton,
                      ),
                    ],
                  )),
                Container(
                  color: notifier.redcolor,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                                decoration:BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                          color: notifier.subgreycolor,
                                        )
                                    )
                                ),
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      buildContactInfoItem(
                                          textColor: Colors.white,
                                          contacts: contacts[0],
                                          icon: contactsImage[0]
                                      ),
                                      SizedBox(height: 20,),
                                      buildContactInfoItem(
                                          textColor: Colors.white,
                                          contacts: contacts[1],
                                          icon: contactsImage[1]
                                      ),
                                      SizedBox(height: 20,),
                                      buildContactInfoItem(
                                          textColor: Colors.white,
                                          contacts: contacts[2],
                                          icon: contactsImage[2]
                                      ),
                                      SizedBox(height: 20,),
                                    ],
                                  )
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              decoration:BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                        color: notifier.subgreycolor,
                                      )
                                  )
                              ),
                              height: 200,
                              child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: endElements.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisExtent: 40,
                                    crossAxisSpacing: 25),
                                itemBuilder: (context, index) {
                                  return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { 
                                    return InkWell(
                                      onTap: () {},
                                      onHover: (value) {
                                        setState(() {
                                          elementsHover[index] = value;
                                        });
                                      },
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            endElements[index],
                                            style: baseStyle.copyWith(
                                                fontSize: 16,
                                                color: elementsHover[index] ? notifier.subgreycolor : notifier.whitecolor),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
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
                                      return StatefulBuilder(
                                        builder: (BuildContext context, void Function(void Function()) setState) {
                                          return Row(
                                            children: [
                                              Container(
                                                height: 40,
                                                padding: const EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: notifier.whitecolor,
                                                  ),
                                                ),
                                                child: SvgPicture.asset(notifier.isDark ? logos[index] : logos[index],color: Colors.white,
                                                    height: 20),
                                              ),
                                              const SizedBox(width: 10),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text( (constraints.maxWidth < 950 && constraints.maxWidth > 550)
                                    ? 'Copyright © Make it ${L10nX.getStr.app_name}\n| Designed by Make it Services  \n Powered by ${L10nX.getStr.app_name}'
                                    : 'Copyright © Make it ${L10nX.getStr.app_name}\n| Designed by Make it Services Powered by ${L10nX.getStr.app_name}',
                                  style: baseStyle.copyWith(
                                      fontSize: constraints.maxWidth < 300 ? 10 : 14,

                                      color: notifier.whitecolor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
    },
    );
  }
  Widget buildMobileUi(constraints) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) { 
          return Column(
            children: [
              Padding(
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
                    Row(
                      children: [
                        StaticView.buildLogo(),
                        const SizedBox(width: 5),
                        Text(
                          L10nX.getStr.app_name,
                          style: baseStyle.copyWith(
                              color: notifier.blackcolor,
                              fontSize: constraints.maxWidth < 300 ? 16 : 24),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(L10nX.getStr.subcribe_to_our_news_letter,
                          style: baseStyle.copyWith(
                              color: notifier.blackcolor),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 60,
                          width: constraints.maxWidth / 1,
                          child: TextField(
                            style: baseStyle.copyWith(color: notifier.blackcolor),
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
                                      style: baseStyle.copyWith(

                                          color: Colors.white,
                                          fontSize: 16)),
                                ),
                              ),
                              hintText: L10nX.getStr.enter_your_email,
                              hintStyle: baseStyle.copyWith(
                                   color: notifier.subgreycolor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 10),
                    // Row(
                    //   mainAxisSize: MainAxisSize.max,
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Image.asset('assets/Icons/lightbulbicon.png',
                    //         height: constraints.maxWidth < 300 ? 14 : 20,
                    //         color: notifier.subgreycolor),
                    //     const SizedBox(
                    //       width: 7,
                    //     ),
                    //     Text(
                    //       L10nX.getStr.dark_theme,
                    //       style: baseStyle.copyWith(
                    //
                    //           fontSize: constraints.maxWidth < 300 ? 12 : 14,
                    //           color: notifier.subgreycolor,
                    //           fontWeight: FontWeight.w600,
                    //           letterSpacing: 1),
                    //     ),
                    //     const SizedBox(
                    //       width: 7,
                    //     ),
                    //     SizedBox(
                    //       height: 29,
                    //       child: FlutterSwitch(
                    //         height: 23.0,
                    //         width: constraints.maxWidth < 300 ? 40.0 : 45.0,
                    //         padding: 4.0,
                    //         toggleSize: 16.0,
                    //         borderRadius: 15.0,
                    //         inactiveToggleColor: notifier.buttoncolor,
                    //         activeColor: notifier.buttoncolor,
                    //         inactiveColor: notifier.sugestionbutton,
                    //         value: notifier.isDark,
                    //         onToggle: (bool value) {
                    //           setState(() {
                    //             notifier.isAvailable(value);
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(),
                    const SizedBox(height: 30),
                    Divider(
                      color: notifier.isDark
                          ? notifier.subgreycolor
                          : notifier.sugestionbutton,
                    ),
                    const SizedBox(height: 30),
                  ],
                )),
              Container(
                color: notifier.redcolor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildContactInfoItem(
                              textColor: Colors.white,
                              contacts: contacts[0],
                              icon: contactsImage[0]
                          ),
                          SizedBox(height: 20,),
                          buildContactInfoItem(
                              textColor: Colors.white,
                              contacts: contacts[1],
                              icon: contactsImage[1]
                          ),
                          SizedBox(height: 20,),
                          buildContactInfoItem(
                              textColor: Colors.white,
                              contacts: contacts[2],
                              icon: contactsImage[2]
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                      SizedBox(height: 8,),
                      SizedBox(
                        height: 40,
                        // width: 300,
                        child: ListView.builder(
                          itemCount: logos.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) { 
                                return Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white
                                        ),
                                      ),
                                      child: SvgPicture.asset(logos[index], color: Colors.white,
                                          height: 20),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 8,),
                      SizedBox(
                        height: 200,
                        width: width / 1,
                        child: GridView.builder(
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: endElements.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 40,
                            crossAxisSpacing: constraints.maxWidth < 500 ? constraints.maxWidth / 10 : constraints.maxWidth / 5,
                          ),
                          itemBuilder: (context, index) {
                            return StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) { 
                                return InkWell(
                                  onTap: () {},
                                  onHover: (value) {
                                    setState(() {
                                      elementsHover[index] = value;
                                    });
                                  },
                                  child: Text(
                                    endElements[index],
                                    style: baseStyle.copyWith(
                                        fontSize: constraints.maxWidth < 500 ? 14 : 16,
                                        color: Colors.white),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Copyright © Make it ${L10nX.getStr.app_name}\n| Designed by Make it Services - Powered by ${L10nX.getStr.app_name}',
                        style: baseStyle.copyWith(
                            fontSize: constraints.maxWidth < 500 ? 12 : 14,
                            color: notifier.whitecolor),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
    );
  }
  static Widget buildContactInfoItem({required String contacts, required String icon, required Color textColor}){
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {  
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              SvgPicture.asset(icon, height: 20, color: Colors.white,),
              const SizedBox(width: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(contacts,
                    style: baseStyle.copyWith(
                        color: textColor,
                        fontSize: 16),
                    maxLines: 2,),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}



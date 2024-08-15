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

  Widget buildTabletUi(context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            color: notifier.redcolor,
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                        ),
                      ),
                      Text('Copyright © Make it ${L10nX.getStr.app_name}\n| Designed by Make it Services Powered by ${L10nX.getStr.app_name}',
                        style: TextStyleConstant.bodyMedium.copyWith(
                            color: notifier.whitecolor),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildContactInfoItem(
                          textColor: Colors.white,
                          contacts: contacts[0],
                          icon: contactsImage[0]
                      ),
                      SizedBox(width: 20,),
                      buildContactInfoItem(
                          textColor: Colors.white,
                          contacts: contacts[1],
                          icon: contactsImage[1]
                      ),
                      SizedBox(width: 20,),
                      buildContactInfoItem(
                          textColor: Colors.white,
                          contacts: contacts[2],
                          icon: contactsImage[2]
                      ),
                      SizedBox(width: 20,),
                    ],
                  ),
                  // SizedBox(
                  //   height: 40,
                  //   // width: 300,
                  //   child: ListView.builder(
                  //     itemCount: logos.length,
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       return Row(
                  //         children: [
                  //           Container(
                  //             height: 40,
                  //             padding: const EdgeInsets.all(6),
                  //             decoration: BoxDecoration(
                  //               shape: BoxShape.circle,
                  //               border: Border.all(
                  //                 color: notifier.whitecolor,
                  //               ),
                  //             ),
                  //             child: SvgPicture.asset(notifier.isDark ? logos[index] : logos[index],color: Colors.white,
                  //                 height: 20),
                  //           ),
                  //           const SizedBox(width: 10),
                  //         ],
                  //       );
                  //     },
                  //   ),
                  // ),
                  SizedBox(width: 50),
                ],
              ),
            ),
          ),
        ),
      ],
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
                  children: const [
                    SizedBox(height: 30),
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
                          SizedBox(height: 12,),
                          buildContactInfoItem(
                              textColor: Colors.white,
                              contacts: contacts[1],
                              icon: contactsImage[1]
                          ),
                          SizedBox(height: 12,),
                          buildContactInfoItem(
                              textColor: Colors.white,
                              contacts: contacts[2],
                              icon: contactsImage[2]
                          ),
                          SizedBox(height: 12,),
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
                      Text(
                        'Copyright © Make it ${L10nX.getStr.app_name}\n| Designed by Make it Services - Powered by ${L10nX.getStr.app_name}',
                        style: TextStyleConstant.bodySmall.copyWith(
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SvgPicture.asset(icon, height: 20, color: textColor,),
          const SizedBox(width: 10),
          Text(contacts,
            style: TextStyleConstant.bodyMedium.copyWith(
                color: textColor,
            ),
            maxLines: 10,
          ),
        ],
      ),
    );
  }

}



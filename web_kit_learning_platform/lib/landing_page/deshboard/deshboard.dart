// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/localizations/language_helper.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/landing_page/components/review_list/review_list.dart';
import 'package:webkit/landing_page/deshboard/tabs.dart';
import 'package:webkit/services/apis/review/models/review_list_response_model.dart';
import 'package:webkit/views/auth/login/login.dart';
import 'package:webkit/views/auth/register.dart';

import '../components/colornotifier.dart';
import '../components/course_list/course_list.dart';
import '../components/review_list/review_list.dart';
import '../components/helperwidget.dart';
import '../mediaquery/mq.dart';
import 'endofpage.dart';
import '../components/teachet_list/teacher_list.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

enum SampleItem2 { itemOne, itemTwo, itemThree, itemfour }

class DeshScreen extends StatefulWidget {
  const DeshScreen({super.key});

  @override
  State<DeshScreen> createState() => _DeshScreenState();
}

class _DeshScreenState extends State<DeshScreen> {
  late ColorNotifier notifier;
  SampleItem? selectedMenu;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedvalue = Travelerstype[0];
    sv = Travelerstype[0];
  }

  late TabController t1;

  List pinIcon = [
    'assets/Icons/locationicon.png',
    'assets/Icons/calendaricon.png',
    'assets/Icons/calendaricon.png',
    'assets/Icons/profileicon.png'
  ];
  List pins = ['Location', 'Check in', 'Check out', 'Travelers'];
  List hints = ['Where are you doing?', 'Add date', 'Add date', 'Travelers'];
  List chips = ['Round-trip', 'One-way', '1 guest'];

  List sugimage = [
    'assets/deshboard/experience/paris.png',
    'assets/deshboard/experience/singapore.png',
    'assets/deshboard/experience/pattaya.png',
    'assets/deshboard/experience/roma.png',
    'assets/deshboard/experience/phuket.png',
    'assets/deshboard/experience/bangkok.png'
  ];
  List sug = [
    'Paris',
    'Singapore',
    'Pattaya',
    'Roma',
    'Phuket',
    'Bangkok'
  ];
  List places = [
    '200+ Tours',
    '400+ Tours',
    '500+ Tours',
    '100+ Tours',
    '700+ Tours',
    '600+ Tours'
  ];
  List places2 = [
    '200+\nTours',
    '400+\n Tours',
    '500+\n Tours',
    '100+\n Tours',
    '700+\n Tours',
    '600+\n Tours'
  ];
  int selectedindex = 0;
  int sugindex = 0;
  double a = 2;
  ScrollController sugcon = ScrollController();

  List<Color> suColor = [
    const Color(0xFF8BC5E5),
    const Color(0xFF92A5EF),
    const Color(0xFF58C27D)
  ];
  List sunumber = ['01', '02', '03'];
  List su1 = [
    'Explore Beyond Boundaries',
    'Book Your Journey with Ease!',
    'Book, Pack, Explore'
  ];
  List s2 = [
    'Immerse yourself in a world of seamless travel experiences with our intuitive booking platform.',
    'Our platform lets you wander wisely, offering a streamlined booking experience for your dream destinations.',
    'Book your adventure, pack your bags, and let the exploration begin.'
  ];
  List su2 = [
    'Stacks is a production-ready library of stackable\ncontent blocks built in React Native.',
    'Stacks is a production-ready library of stackable\ncontent blocks built in React Native.',
    'Stacks is a production-ready library of stackable\ncontent blocks built in React Native.'
  ];


  List abouttitle = ['Book & relax', 'Smart checklist', 'Save more'];
  List aboutsubtitle = [
    'We realize ideas from simple to complex, everything becomes easy to use.',
    'We realize ideas from simple to complex, everything becomes easy to use.',
    'We realize ideas from simple to complex, everything becomes easy to use.',
  ];

  String selectedvalue = '';
  List Travelerstype = ['Flights', 'Hotels', 'Homestays & Villas', 'Holiday Packages','Trains','Buses','Cabs'];

  List profilemenuImages = [
    'assets/Icons/ticketIcon.svg',
    'assets/Icons/heartIcon.svg',
    'assets/Icons/messageIcon.svg',
    'assets/Icons/teacherIcon.svg',
    'assets/Icons/flagIcon.svg',
    'assets/Icons/securityuserIcon.svg'
  ];
  List profilemenuImagesDark = [
    'assets/Icons/ticketIconDark.svg',
    'assets/Icons/heartIconDark.svg',
    'assets/Icons/messageIconDark.svg',
    'assets/Icons/teacherIconDark.svg',
    'assets/Icons/flagIconDark.svg',
    'assets/Icons/securityuserIconDark.svg'
  ];
  List profilemenuTags = [
    'Booking',
    'Wishlist',
    'Message',
    'Host your home',
    'Host an experience',
    'Help'
  ];
  List notNumber = ['2', '4', '6', '', '', ''];

  int selectedlang = 0;
  int ind = 0;
  String sv = '';
  int inde = 0;

  bool buttonhover = false;
  bool supportHover = false;

  bool isHover = false;
  bool isHover2 = false;
  bool searchHover = false;
  bool searchHover2 = false;
  bool searchHover3 = false;
  bool bHover = false;
  bool langHover = false;

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
    return Scaffold(
      backgroundColor: notifier.backgroundColor,
      body: SafeArea(child: LayoutBuilder(
        builder: (context, constraints) {
          return appbarleft(constraints);
        },
      )),
    );
  }
  int tabHover = 0;

  Widget appbarleft(constraints) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 12,
                left: constraints.maxWidth / 10 < 800
                    ? constraints.maxWidth / 15
                    : constraints.maxWidth / 10,
                right: constraints.maxWidth / 10 < 800
                    ? constraints.maxWidth / 15
                    : constraints.maxWidth / 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        ImageManager().getPngImage(ImageManager.logo, height: constraints.maxWidth < 300 ? 20 : height / 22),
                        const SizedBox(width: 5),
                        Text(L10nX.getStr.app_name, style: TextStyle(
                          fontFamily: 'gilroybold',
                          color: notifier.blackcolor,
                          fontSize: constraints.maxWidth < 300 ? 20 : 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    constraints.maxWidth < 1000
                        ? const SizedBox()
                        : Row(
                      children: [
                        PopupMenuButton(
                          tooltip: '',
                          padding: const EdgeInsets.all(0),
                          offset: const Offset(120, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // initialValue: selectedMenu,
                          constraints: const BoxConstraints(
                            maxWidth:  315,
                            maxHeight: 270,
                          ),
                          color: notifier.whitecolor,
                          child: Text(
                            'Application',
                            style: TextStyle(
                                color: supportHover
                                    ? notifier.blackcolor
                                    : notifier.subgreycolor,
                                fontFamily: 'gilroysemi',
                                fontSize: 16),
                          ),
                          itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<SampleItem2>>[
                            PopupMenuItem<SampleItem2>(
                              enabled: true,
                              value: SampleItem2.itemOne,
                              onTap: () {},
                              child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        const SizedBox(height: 20),
                                        Text('Downloads', style: TextStyle(
                                            fontSize: 16,
                                            color: notifier.subgreycolor,
                                            fontFamily: 'gilroysemi')),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          height: 100,
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              SvgPicture.asset(
                                                  'assets/deshboard/support/AppStoreBadge.svg',
                                                  height: 40),
                                              const SizedBox(height: 10),
                                              SvgPicture.asset(
                                                  'assets/deshboard/support/GooglePlayStoreBadge.svg',
                                                  height: 40),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20),
                                          Text('Scan Code', style: TextStyle(
                                              fontSize: 16,
                                              color: notifier.subgreycolor,
                                              fontFamily: 'gilroysemi')),
                                          const SizedBox(height: 12),
                                          SizedBox(
                                            height: 100,
                                            child: Image.asset(
                                                'assets/deshboard/support/qrCode.png',
                                                height: 100),
                                          ),
                                          const SizedBox(height: 20),
                                        ]
                                    ),
                                    const SizedBox(width: 10),
                                  ]
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                      ],
                    ),
                    if (constraints.maxWidth < 800) const SizedBox() else Row(
                      children: [
                        PopupMenuButton(
                          tooltip: '',
                          padding: const EdgeInsets.all(0),
                          offset: const Offset(10, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // initialValue: selectedMenu,
                          constraints: const BoxConstraints(
                            maxWidth: 200,
                            maxHeight: 250,
                          ),
                          color: notifier.whitecolor,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/Icons/langicon.png',
                                  height: height / 45,
                                  color: langHover
                                      ? notifier.blackcolor
                                      : notifier.subgreycolor,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(L10nX.getStr.language_text, style: TextStyle(
                                    color: langHover
                                        ? notifier.blackcolor
                                        : notifier.subgreycolor,
                                    fontSize: 14,
                                    fontFamily: 'gilroysemi')),
                              ],
                            ),
                          ),
                          itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<SampleItem2>>[
                            PopupMenuItem<SampleItem2>(
                                enabled: true,
                                value: SampleItem2.itemOne,
                                onTap: () {},
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    return Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 25),
                                                for(LanguageInfo language in LanguageHelper().supportedLanguages)
                                                  InkWell(
                                                    onTap: () {
                                                      LanguageHelper().changeLanguage(language, context);
                                                    },
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              ClipRRect(
                                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                  borderRadius: BorderRadius.circular(2),
                                                                  child: Image.asset(
                                                                    "assets/lang/${language.languageCode}.png",
                                                                    width: 18,
                                                                    height: 14,
                                                                    fit: BoxFit.cover,
                                                                  )),
                                                              MySpacing.width(8),
                                                              MyText.labelMedium(language.language??"")
                                                            ],
                                                          ),
                                                          const SizedBox(height: 20),
                                                        ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                    );
                                  },
                                ),
                            ),
                          ],
                        ),
                      /*  const SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: () {

                          },
                          onHover: (value) {
                            setState(() {
                              bHover = value;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: height / 21,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                WidgetStatePropertyAll(
                                    bHover
                                        ? (notifier.isDark ? notifier
                                        .sugestionbutton : notifier.blackcolor)
                                        : Colors
                                        .transparent),
                                elevation:
                                const WidgetStatePropertyAll(0),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      side: BorderSide(
                                          color: bHover
                                              ? Colors.transparent
                                              : (notifier.isDark ? notifier
                                              .sugestionbutton : Colors.grey
                                              .shade300),
                                          width: 2)),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'List your property',
                                style: TextStyle(
                                    fontFamily: 'gilroysemi',
                                    fontSize: 16,
                                    color: bHover
                                        ? Colors.white
                                        : notifier.blackcolor),
                              ),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                    SizedBox(
                      width: constraints.maxWidth < 500 ? 10 : 25,
                    ),
                    PopupMenuButton(
                      tooltip: '',
                      padding: const EdgeInsets.all(0),
                      offset: const Offset(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),),
                      // initialValue: selectedMenu,
                      constraints: const BoxConstraints(
                        maxWidth: 310,
                        maxHeight: 540,
                      ),
                      color: notifier.whitecolor,
                      child: SizedBox(
                        child: notifier.isDark ? Image.asset(
                            'assets/Icons/darkBellIcon.png', height: constraints.maxWidth < 300 ? 25 : 30) : Image
                            .asset('assets/Icons/bellicon.png', height: constraints.maxWidth < 300 ? 25 : 30),
                      ),
                      itemBuilder: (context) =>
                      <PopupMenuEntry<SampleItem2>>[
                        PopupMenuItem(
                            enabled: true,
                            onTap: () {},
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                for(int i = 0; i <
                                    5; i++ )
                                  Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Container(
                                              height: 40,
                                              width:  40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape
                                                    .circle,
                                                color: notifier
                                                    .lightgreencolor,
                                              ),
                                              alignment: Alignment
                                                  .center,
                                              child: SvgPicture
                                                  .asset(
                                                  'assets/Icons/paperIcon.svg',
                                                  height: 20),
                                            ),
                                            const SizedBox(
                                                width: 20),
                                            Flexible(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      'Wrapped Bitcoin is now listed on Unity Exchange',
                                                      style: TextStyle(
                                                          fontFamily: 'gilroysemi',
                                                          fontSize: 14,
                                                          color: notifier
                                                              .blackcolor),
                                                      maxLines: 2,
                                                      softWrap: true),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(
                                                          '24m ago',
                                                          style: TextStyle(
                                                              fontFamily: 'gilroysemi',
                                                              fontSize: 12,
                                                              color: notifier
                                                                  .subgreycolor)),
                                                      Text(
                                                          '●',
                                                          style: TextStyle(
                                                              color: notifier
                                                                  .buttoncolor,
                                                              fontSize: 10)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                            height: 10),
                                        i == 4
                                            ? const SizedBox()
                                            : Divider(
                                            color: notifier
                                                .subgreycolor
                                        ),
                                        const SizedBox(
                                            height: 10),
                                      ]
                                  ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 40,
                                  width: width / 1,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: const WidgetStatePropertyAll(
                                          0),
                                      backgroundColor: WidgetStatePropertyAll(
                                          notifier.buttoncolor),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: notifier
                                                  .buttoncolor,
                                              width: 2),
                                          borderRadius: const BorderRadius
                                              .all(
                                              Radius
                                                  .circular(
                                                  10)),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {

                                    },
                                    child: const Text(
                                        'See all notifications',
                                        style: TextStyle(
                                            fontFamily: 'gilroysemi',
                                            fontSize: 12,
                                            color: Colors.white)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            )
                        )
                      ],),
                    SizedBox(
                      width: constraints.maxWidth < 500 ? 10 : 25,
                    ),
                    PopupMenuButton(
                      tooltip: '',
                      padding: const EdgeInsets.all(0),
                      offset: const Offset(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // initialValue: selectedMenu,
                      constraints: BoxConstraints(
                        maxWidth: width / 1,
                        maxHeight: 400,
                      ),
                      color: notifier.whitecolor,
                      child: Container(
                        height: height / 19,
                        decoration: BoxDecoration(
                          color: notifier.lightgreencolor,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/Icons/profileicon.png',
                          height: constraints.maxWidth < 300 ? 30 : height / 45,
                          scale: 2.5,
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

                          },
                          child: SizedBox(
                            height: 380,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 330,
                                  width: 300,
                                  child: ListView.builder(
                                    itemCount: profilemenuImages.length,
                                    itemBuilder: (context, inde) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    notifier.isDark ? profilemenuImagesDark[inde] : profilemenuImages[inde],
                                                    height: 20,
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Text(
                                                    profilemenuTags[inde],
                                                    style: TextStyle(
                                                        color: notifier
                                                            .blackcolor,
                                                        fontFamily: 'gilroymed',
                                                        fontSize: 16,
                                                        // fontWeight: FontWeight
                                                        //     .w600,
                                                        letterSpacing: 1),
                                                  ),
                                                  const SizedBox(
                                                      height: 30),
                                                ],
                                              ),
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: inde <= 2
                                                        ? notifier.pinkcolor
                                                        : Colors.transparent
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(notNumber[inde],
                                                    style: const TextStyle(
                                                        fontFamily: 'gilroy',
                                                        color: Colors.white,
                                                        fontSize: 10)),
                                              ),
                                            ],
                                          ),
                                          inde == 5
                                              ? const SizedBox(height: 10)
                                              : const SizedBox(height: 20),
                                          inde == 2 ? Divider(
                                              color: notifier.sugestionbutton
                                          ) : const SizedBox(),
                                          inde == 2
                                              ? const SizedBox(height: 20)
                                              : const SizedBox()
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 145,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          elevation: const WidgetStatePropertyAll(
                                              0),
                                          backgroundColor: WidgetStatePropertyAll(
                                              notifier.buttoncolor),
                                          shape: const WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          LoginPage().show(context);
                                          //Get.toNamed(Paths.dashboardPath);
                                        },
                                        child:  Text(L10nX.getStr.login, style: TextStyle(
                                            fontFamily: 'gilroymed',
                                            fontSize: 12,
                                            color: Colors.white)),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      height: 40,
                                      width: 145,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          elevation: const WidgetStatePropertyAll(
                                              0),
                                          backgroundColor: WidgetStatePropertyAll(
                                              notifier.whitecolor),
                                          shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: notifier.buttoncolor,
                                                  width: 2),
                                              borderRadius: const BorderRadius
                                                  .all(Radius.circular(20)),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Register().show(context);
                                        },
                                        child: Text(L10nX.getStr.sign_up,
                                            style: TextStyle(
                                            fontFamily: 'gilroymed',
                                            fontSize: 12,
                                            color: notifier.buttoncolor)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: constraints.maxWidth < 500 ? 10 : 25,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: height / 45,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 10,
                left: constraints.maxWidth < 760
                    ? 10
                    : constraints.maxWidth < 1000
                    ? 0
                    : constraints.maxWidth / 15,
                right: constraints.maxWidth < 760
                    ? 10
                    : constraints.maxWidth < 1000
                    ? 0
                    : constraints.maxWidth / 15),
            child: SizedBox(
              width: width / 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  clipBehavior: Clip.none,
                    children: [
                      constraints.maxWidth < 800
                          ? Image.asset('assets/deshboard/winterlandscape.png',
                          height: constraints.maxWidth < 500 ? 400 : 600,
                          fit: BoxFit.fill)
                          : Image.asset('assets/deshboard/winterlandscape.png',
                          height: 600,
                          width: constraints.maxWidth,
                          fit: BoxFit.fill),
                      /*Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: constraints.maxWidth < 800
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(flex: 1, child: Container()),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: constraints.maxWidth < 800
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: constraints.maxWidth < 800
                                          ? constraints.maxWidth / 6.5
                                          : constraints.maxWidth / 10,
                                    ),
                                    Text(
                                      'Discover,\n Book, Enjoy',
                                      style: TextStyle(
                                          fontFamily: 'gilroybold',
                                          fontSize: constraints.maxWidth < 800
                                              ? constraints.maxWidth / 12
                                              : constraints.maxWidth / 18.5,
                                          color: notifier.textcolor,
                                          height: 0.9,
                                          letterSpacing: 2),
                                      textAlign: constraints.maxWidth < 800
                                          ? TextAlign.center
                                          : TextAlign.end,
                                    ),
                                    SizedBox(
                                      height: constraints.maxWidth < 500 ? 10 : 20,
                                    ),
                                    Text('Effortless travel start with.',
                                        style: TextStyle(
                                            fontFamily: 'gilroymed',
                                            fontSize: constraints.maxWidth < 800
                                                ? constraints.maxWidth / 30
                                                : constraints.maxWidth / 57,
                                            color: notifier.textcolor)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      onHover: (value) {
                                        setState(() {
                                          searchHover3 = value;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 200),
                                        height: 45,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              elevation: WidgetStateProperty.all(0),
                                              shape: WidgetStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(25))),
                                              backgroundColor: WidgetStateProperty
                                                  .all(
                                                  searchHover3 ? Colors.indigoAccent
                                                      .shade700 : notifier.buttoncolor),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              'Book Now',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'gilroysemi',
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth < 800
                                    ? constraints.maxWidth / 5.5
                                    : width / 12,
                              ),
                            ],
                          ),
                          SizedBox(
                              height: constraints.maxWidth < 700
                                  ? constraints.maxWidth / 5.55
                                  : constraints.maxWidth < 800
                                  ? constraints.maxWidth / 10.25
                                  : constraints.maxWidth < 1000
                                  ? constraints.maxWidth / 7
                                  : constraints.maxWidth < 2000
                                  ? constraints.maxWidth / 6
                                  : constraints.maxWidth / 5.5),
                          constraints.maxWidth < 800
                              ? const help()
                              : const Tabsbar(),
                      ],
                    ),*/
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxWidth < 550
                ? constraints.maxWidth / 5
                : constraints.maxWidth / 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: constraints.maxWidth < 500 ? 10 : 0,right: constraints.maxWidth < 500 ? 10 : 0),
            child: Column(
                children: [
                  Text("Enjoy the travel experience with us",
                      style: TextStyle(
                          fontFamily: 'gilroysemi',
                          fontSize: constraints.maxWidth < 550
                              ? 28
                              : 45,
                          color: notifier.blackcolor),
                      textAlign: TextAlign.center),
                  Text(
                    "Book your adventure, pack your bags and let the exploration begin.",
                    style: TextStyle(
                        fontFamily: 'gilroy',
                        fontSize: constraints.maxWidth < 700 ? 18 : 20,
                        color: notifier.greycolor),
                    textAlign: TextAlign.center,
                  ),
                ],
            ),
          ),
          SizedBox(
            height: constraints.maxWidth < 550
                ? 0
                : constraints.maxWidth / 30,
          ),
          SizedBox(
            height: 200,
            width: constraints.maxWidth < 750
                ? 410
                : constraints.maxWidth < 1000
                ? 780
                : constraints.maxWidth > 1800
                ? constraints.maxWidth / 1.1
                : 1000,
            child: ListView.builder(
              shrinkWrap: true,
              controller: sugcon,
              scrollDirection: Axis.horizontal,
              itemCount: sugimage.length,
              itemBuilder: (context, sugindex) {
                return SizedBox(
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth < 750
                            ? (sugindex==0 ? 10 : 0)
                            : (sugindex==0 ? 10 : 0),
                      ),
                      Image.asset(sugimage[sugindex],
                          height: constraints.maxWidth < 750
                              ? 110
                              : constraints.maxWidth < 1000
                              ? 130
                              : 150),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth < 750
                                ? 90
                                : constraints.maxWidth < 1000
                                ? 220
                                : 140,
                            child: Text(
                              sug[sugindex],
                              style: TextStyle(
                                  color: notifier.blackcolor,
                                  fontSize: 18, fontFamily: 'gilroymed'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: constraints.maxWidth < 750 ? 55 : 25,
                            width: constraints.maxWidth < 750 ? 70 : 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: notifier.sugestionbutton,
                            ),
                            alignment: Alignment.center,
                            child: Text(constraints.maxWidth < 500 ? places2[sugindex] : places[sugindex],
                                style: TextStyle(
                                    fontFamily: 'gilroybold',
                                    fontSize: 12,
                                    color: notifier.blackcolor),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: constraints.maxWidth < 750
                            ? (sugindex==5 ? 0 : 16)
                            : (sugindex==5 ? 0 : constraints.maxWidth / 24),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: constraints.maxWidth / 30,
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
                      color: (isHover) ? notifier.sugestionbutton : Colors
                          .transparent),
                ),
                child: InkWell(
                  onTap: () {
                    sugcon.animateTo(double.parse("${a}00"),
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
                  child: Padding(padding: const EdgeInsets.all(13),
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
                      color: (isHover2) ? notifier.sugestionbutton : Colors
                          .transparent),
                ),
                child: InkWell(
                  onTap: () {
                    sugcon.animateTo(double.parse("${a}00"),
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
                  child: Padding(padding: const EdgeInsets.all(13),
                    child: Image.asset(
                        'assets/Icons/arrowrighticon.png',
                        width: 15,
                        color: notifier.subgreycolor
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: constraints.maxWidth / 30,
          ),
          Text('Why choose us',
              style: TextStyle(
                  fontFamily: 'gilroysemi',
                  fontSize: constraints.maxWidth < 550
                      ? 28
                      : 45,
                  color: notifier.blackcolor),
              textAlign: TextAlign.center),
          Text(
            "These popular destinations have a lot to offer",
            style: TextStyle(
                fontFamily: 'gilroy',
                fontSize: constraints.maxWidth < 700 ? 18 : 20,
                color: notifier.greycolor),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: constraints.maxWidth < 550 ? 0 : constraints.maxWidth < 800
                ? constraints.maxWidth / 30
                : constraints.maxWidth / 30,
          ),
          constraints.maxWidth < 800 ? Container(
            alignment: Alignment.center,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount:  lottiecontent.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(lottiecontent[index].lottiefile,
                            height: 200),
                        const SizedBox(height: 10),
                        Text(lottiecontent[index].title,
                            style: TextStyle(
                                fontFamily: 'gilroysemi',
                                fontSize: constraints.maxWidth < 500
                                    ? 24
                                    : constraints.maxWidth < 800
                                    ? 28
                                    : 24,
                                color: notifier.blackcolor),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: constraints.maxWidth < 800 ? 200 : 240,
                          child: Text(lottiecontent[index].subtitle,
                              style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  fontSize:
                                  constraints.maxWidth < 500 ? 16 : constraints.maxWidth < 800 ? 18 : 14,
                                  color: notifier.greycolor),
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(
                          height: constraints.maxWidth < 1000 ? 50 : 0,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ) :
          Container(
            height: 400,
            width: width / 1,
            alignment: Alignment.center,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: lottiecontent.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      right: index == 0 ? 50 : 0, left: index == 2 ? 50 : 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(lottiecontent[index].lottiefile,
                              height: 200),
                          const SizedBox(height: 10),
                          Text(lottiecontent[index].title,
                              style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  fontSize: constraints.maxWidth < 800
                                      ? 18
                                      : 24,
                                  color: notifier.blackcolor),
                              textAlign: TextAlign.center),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: constraints.maxWidth < 800 ? 200 : 240,
                            child: Text(lottiecontent[index].subtitle,
                                style: TextStyle(
                                    fontFamily: 'gilroysemi',
                                    fontSize:
                                    constraints.maxWidth < 800 ? 18 : 14,
                                    color: notifier.greycolor),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(
                            height: constraints.maxWidth < 1000 ? 50 : 0,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                    height: constraints.maxWidth < 550 ? 70 : constraints.maxWidth / 50),
                const CourseList(),
                SizedBox(
                  height: constraints.maxWidth < 550 ? 50 : constraints.maxWidth < 800
                      ? constraints.maxWidth / 30
                      : constraints.maxWidth / 30,
                ),
                const TeacherList(),
                SizedBox(
                  height: constraints.maxWidth < 550 ? 50 : constraints.maxWidth < 800
                      ? constraints.maxWidth / 30
                      : constraints.maxWidth / 30,
                ),
                ReviewList(
                  key: UniqueKey(),
                  typeName: UserTypeName.teacher,),
                SizedBox(
                  height: constraints.maxWidth < 550 ? 50 : constraints.maxWidth < 800
                      ? constraints.maxWidth / 30
                      : constraints.maxWidth / 30,
                ),
                ReviewList(
                  key: UniqueKey(),
                  typeName: UserTypeName.user,),
                SizedBox(
                  height: constraints.maxWidth < 550 ? 50 : constraints.maxWidth < 800
                      ? constraints.maxWidth / 30
                      : constraints.maxWidth / 30,
                ),
              ],
            ),
          ),
         
         // const ReviewList(),
          SizedBox(height: constraints.maxWidth < 550 ? 60 : constraints.maxWidth / 16),
          constraints.maxWidth < 800
              ? memory(constraints)
              : Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/deshboard/latestdeals.png',
                    height: constraints.maxWidth < 1100
                        ? height / 1.7
                        : height / 1.2,
                  ),
                  SizedBox(
                    width: constraints.maxWidth / 12,
                  ),
                  SizedBox(
                    width: constraints.maxWidth / 2.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enjoy the trip with exciting discount',
                            style: TextStyle(
                                fontFamily: 'gilroybold',
                                fontSize: constraints.maxWidth < 1000
                                    ? constraints.maxWidth / 80
                                    : constraints.maxWidth / 90,
                                color: notifier.greycolor)),
                        Text(
                            'We recommend beautiful destionation every month',
                            style: TextStyle(
                                color: notifier.blackcolor,
                                fontFamily: 'gilroysemi',
                                fontSize: constraints.maxWidth / 30)),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Effortless travels start with us.Book your adventure,pack your bags, and let the exploration begin',
                          style: TextStyle(
                              fontFamily: 'gilroysemi',
                              fontSize: constraints.maxWidth / 90,
                              color: notifier.subgreycolor),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                          width: constraints.maxWidth / 5,
                          child: TextField(
                            decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: notifier.isDark ? const Color(
                                          0xFF353945) : const Color(
                                          0xFFE6E8EC)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(width: 2,
                                      color: notifier.isDark ? const Color(
                                          0xFF353945) : const Color(
                                          0xFFE6E8EC)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: notifier.subgreycolor),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(width: 1,
                                      color: notifier.isDark ? const Color(
                                          0xFF23262F) : const Color(
                                          0xFFE6E8EC)),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {

                                  },
                                  onHover: (value) {
                                    setState(() {
                                      buttonhover = value;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: buttonhover ? Colors.blueAccent
                                            .shade700 : notifier.buttoncolor,
                                        shape: BoxShape.circle),
                                    child: Image.asset(
                                        'assets/Icons/arrowrighticon.png',
                                        scale: 3,
                                        width: 3,
                                        color: notifier.whitecolor),
                                  ),
                                ),
                                hintText: 'Enter your phone number',
                                hintStyle: TextStyle(
                                    fontFamily: 'gilroy',
                                    color: notifier.subgreycolor)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: constraints.maxWidth < 1100
                    ? 330
                    : constraints.maxWidth > 1600
                    ? constraints.maxWidth / 2.1
                    : 480,
                left: constraints.maxWidth < 900
                    ? constraints.maxWidth / 3.4
                    : constraints.maxWidth < 1100
                    ? constraints.maxWidth / 3.5
                    : constraints.maxWidth < 1300
                    ? constraints.maxWidth / 3.4
                    : constraints.maxWidth / 3.4,
                child: Container(
                  height: constraints.maxWidth < 1100
                      ? 53
                      : constraints.maxWidth > 1600
                      ? constraints.maxWidth / 25
                      : 75,
                  width: constraints.maxWidth < 1000
                      ? constraints.maxWidth / 5
                      : constraints.maxWidth > 1600
                      ? constraints.maxWidth / 5
                      : 220,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/deshboard/avatar.png',
                          height: constraints.maxWidth < 1100 ? constraints
                              .maxWidth / 25 : constraints.maxWidth / 28,
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Antone Heller',
                              style: TextStyle(
                                fontSize: constraints.maxWidth / 100,
                                fontFamily: 'gilroysemi',
                                color: notifier.textcolor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star_rounded,
                                    color: notifier.yellowcolor,
                                    size: constraints.maxWidth / 125),
                                const SizedBox(width: 5),
                                Text(
                                  '4.8',
                                  style: TextStyle(
                                      fontSize:
                                      constraints.maxWidth / 125,
                                      fontFamily: 'gilroysemi'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: notifier.isDark ? notifier.subgreycolor : notifier
                .sugestionbutton,
          ),
          SizedBox(height: constraints.maxWidth / 20),
          const EndOfPage(),
        ],
      ),
    );
  }
  Widget memory(constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            // width: constraints.maxWidth / 1.35,
            child: Column(
              crossAxisAlignment: constraints.maxWidth < 550
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text('Enjoy the Trip with exciting Discount',
                  style: TextStyle(
                    fontFamily: 'gilroybold',
                    fontSize: 16,
                    color: notifier.greycolor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: constraints.maxWidth < 550 ? 10 : 20,
                ),
                Text('We Recommend Beautiful Destination Every Month',
                    style: TextStyle(
                        fontFamily: 'gilroysemi',
                        color: notifier.blackcolor,
                        fontWeight: FontWeight.w600,
                        fontSize: constraints.maxWidth < 550 ? 28 : 38),
                    textAlign: constraints.maxWidth < 550
                        ? TextAlign.center
                        : TextAlign.start),
                SizedBox(
                  height: constraints.maxWidth < 550 ? 18 : 20,
                ),
                Text(
                  'Effortless travel starts with us. Book your adventure, pack your bags, and let the exploration begin.',
                  style: TextStyle(
                      fontFamily: 'gilroysemi',
                      fontSize: 16,
                      color: notifier.subgreycolor),
                  textAlign: constraints.maxWidth < 550
                      ? TextAlign.center
                      : TextAlign.start,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: TextField(
                    style: TextStyle(
                      fontFamily: 'gilroysemi',
                      color: notifier.blackcolor,
                    ),
                    decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              width: 1, color: notifier.isDark ? const Color(
                              0xFF353945) : const Color(0xFFE6E8EC)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              width: 2, color: notifier.isDark ? const Color(
                              0xFF353945) : const Color(0xFFE6E8EC)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              width: 1, color: notifier.subgreycolor),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              width: 1, color: notifier.isDark ? const Color(
                              0xFF23262F) : const Color(0xFFE6E8EC)),
                        ),
                        suffixIcon: Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: notifier.buttoncolor,
                              shape: BoxShape.circle),
                          child: Image.asset('assets/Icons/arrowrighticon.png',
                              scale: 3, width: 3, color: notifier.whitecolor),
                        ),
                        hintText: 'Enter youe phone number',
                        hintStyle: TextStyle(
                            fontFamily: 'gilroy',
                            color: notifier.subgreycolor)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: SizedBox(
                width: width / 1,
                child: Image.asset('assets/deshboard/latestdeals.png',
                    fit: BoxFit.fill),
              ),
            ),
            Positioned(
              top: constraints.maxWidth < 600
                  ? constraints.maxWidth / 1.1
                  : constraints.maxWidth < 700
                  ? constraints.maxWidth / 1.07
                  : constraints.maxWidth / 1.03,
              right: constraints.maxWidth < 550
                  ? constraints.maxWidth / 5
                  : constraints.maxWidth < 600
                  ? constraints.maxWidth / 4
                  : constraints.maxWidth < 700
                  ? constraints.maxWidth / 4
                  : constraints.maxWidth / 4,
              child: Container(
                height: constraints.maxWidth < 550
                    ? constraints.maxWidth / 8.3
                    : constraints.maxWidth < 600
                    ? constraints.maxWidth / 9
                    : constraints.maxWidth < 700
                    ? constraints.maxWidth / 10
                    : constraints.maxWidth / 12,
                width: constraints.maxWidth < 550
                    ? constraints.maxWidth / 2.7
                    : constraints.maxWidth < 600
                    ? constraints.maxWidth / 3
                    : constraints.maxWidth / 3.5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color(0xFFFCFDFD),
                  gradient: const LinearGradient(
                      colors: [Color(0xFFFCFDFD), Colors.white70]),
                ),
                child: Padding(
                  padding: EdgeInsets.all(constraints.maxWidth < 550 ? 5 : 14),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/deshboard/avatar.png',
                        height: constraints.maxWidth < 550 ? constraints
                            .maxWidth / 6 : constraints.maxWidth / 20,
                      ),
                      SizedBox(width: constraints.maxWidth < 300 ? 7 : 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Antone Heller',
                            style: TextStyle(
                              fontSize: constraints.maxWidth < 550 ? constraints
                                  .maxWidth / 30 : constraints.maxWidth / 50,
                              fontFamily: 'gilroysemi',
                              color: notifier.textcolor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star_rounded,
                                  color: notifier.yellowcolor,
                                  size: constraints.maxWidth < 550 ? constraints
                                      .maxWidth / 40 : constraints.maxWidth /
                                      70),
                              const SizedBox(width: 5),
                              Text(
                                '4.8',
                                style: TextStyle(
                                    fontSize: constraints.maxWidth < 550
                                        ? constraints.maxWidth / 50
                                        : constraints.maxWidth / 70,
                                    fontFamily: 'gilroysemi'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget flamrating(constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(
                bottom: 20,
                left: constraints.maxWidth < 550 ? 10 : constraints.maxWidth <
                    1000 ? 40 : 0,
                right: constraints.maxWidth < 550 ? 10 : constraints.maxWidth <
                    1000 ? 40 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width / 1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: su1.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 25,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: suColor[index],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(sunumber[index],
                                style: TextStyle(
                                    fontFamily: 'gilroysemi',
                                    fontSize: 14,
                                    color: notifier.whitecolor)),
                          ),
                          SizedBox(
                            height: constraints.maxWidth < 550 ? 20 : 30,
                          ),
                          Text(su1[index],
                              style: TextStyle(
                                  fontFamily: 'gilroysemi',
                                  fontSize: constraints.maxWidth < 550
                                      ? 22
                                      : 26,
                                  color: notifier.blackcolor)),
                          SizedBox(
                            height: constraints.maxWidth < 550 ? 20 : 30,
                          ),
                          Text(s2[index],
                              style: TextStyle(
                                  fontFamily: 'gilroy',
                                  fontSize: constraints.maxWidth < 550
                                      ? 14
                                      : 16,
                                  color: notifier.blackcolor)),
                          SizedBox(
                            height: constraints.maxWidth < 550 ? 30 : 40,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: WidgetStateProperty.all(0),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                        backgroundColor:
                        WidgetStateProperty.all(notifier.buttoncolor),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Start Your Search',
                         style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'gilroysemi',
                            color: Colors.white),
                      )),
                ),
              ],
            )),
        Stack(children: [
          Padding(
            padding: EdgeInsets.only(
                top: 40,
                bottom: 20,
                left: constraints.maxWidth < 1000 ? 40 : 0,
                right: constraints.maxWidth < 1000 ? 40 : 0),
            child: SizedBox(
              width: width / 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child:
                Image.asset(
                  'assets/deshboard/beachwalk.png', fit: BoxFit.cover,),
              ),
            ),
          ),
          Positioned(
            top: constraints.maxWidth / 1.8,
            right: constraints.maxWidth < 750
                ? constraints.maxWidth / 1.75
                : constraints.maxWidth < 800
                ? constraints.maxWidth / 1.5
                : constraints.maxWidth < 900
                ? constraints.maxWidth / 1.5
                : constraints.maxWidth < 1000
                ? constraints.maxWidth / 1.5
                : 770,
            child: Container(
                height: constraints.maxWidth < 750
                    ? constraints.maxWidth / 8
                    : constraints.maxWidth / 10,
                width: constraints.maxWidth < 750
                    ? constraints.maxWidth / 2.6
                    : constraints.maxWidth / 3.2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(constraints.maxWidth < 750
                      ? constraints.maxWidth / 3
                      : constraints.maxWidth / 18),
                  color: const Color(0xFFFCFDFD),
                  gradient: const LinearGradient(
                      colors: [Color(0xFFFCFDFD), Colors.white70]),
                ),
                child: Padding(
                  padding: EdgeInsets.all(constraints.maxWidth / 50),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/deshboard/avatar.png',
                        height: constraints.maxWidth < 750
                            ? constraints.maxWidth / 15
                            : constraints.maxWidth / 14,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Antone Heller',
                            style: TextStyle(
                              fontSize: constraints.maxWidth / 38,
                              fontFamily: 'gilroysemi',
                              color: notifier.textcolor,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.star_rounded,
                                  color: notifier.yellowcolor,
                                  size: constraints.maxWidth / 45),
                              const SizedBox(width: 5),
                              Text(
                                '4.8',
                                style: TextStyle(
                                    fontSize: constraints.maxWidth / 50,
                                    fontFamily: 'gilroysemi'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          Positioned(
            top: constraints.maxWidth / 1.15,
            right: constraints.maxWidth < 1000 ? constraints.maxWidth / 8 : 700,
            child: Container(
                height: constraints.maxWidth < 750
                    ? constraints.maxWidth / 8
                    : constraints.maxWidth / 10,
                width: constraints.maxWidth < 750
                    ? constraints.maxWidth / 2.6
                    : constraints.maxWidth / 3.2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        constraints.maxWidth < 750
                            ? constraints.maxWidth / 3
                            : constraints.maxWidth / 18),
                    color: const Color(0xFFFCFDFD),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black38, blurStyle: BlurStyle.normal)
                    ]),
                child: Padding(
                  padding: EdgeInsets.all(constraints.maxWidth / 50),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/deshboard/avatar.png',
                        height: constraints.maxWidth < 750
                            ? constraints.maxWidth / 15
                            : constraints.maxWidth / 14,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Antone Heller',
                            style: TextStyle(
                              fontSize: constraints.maxWidth / 38,
                              fontFamily: 'gilroysemi',
                              color: notifier.textcolor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star_rounded,
                                  color: notifier.yellowcolor,
                                  size: constraints.maxWidth / 45),
                              const SizedBox(width: 5),
                              Text(
                                '4.8',
                                style: TextStyle(
                                    fontSize: constraints.maxWidth / 50,
                                    fontFamily: 'gilroysemi'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ]),
      ],
    );
  }
}

class lottieAnim {
  final String lottiefile;
  final String title;
  final String subtitle;

  lottieAnim({
    required this.lottiefile,
    required this.title,
    required this.subtitle,
  });
}

List<lottieAnim> lottiecontent = [
  lottieAnim(
    lottiefile: 'assets/deshboard/travel1.json',
    title: 'Exclusive trip',
    subtitle: 'From exotic destinations to hidden gems, our user-friendly interface makes planning your next adventure a breeze',
  ),
  lottieAnim(
    lottiefile: 'assets/deshboard/travel2.json',
    title: 'Your journey',
    subtitle: 'From dreamy destinations to personalized itineraries, we empower you to shape your journey.',
  ),
  lottieAnim(
    lottiefile: 'assets/deshboard/travel3.json',
    title: 'Book simply',
    subtitle: 'Our platform lets you wander wisely, offering a streamlined booking experience for your dream destinations.',
  ),
];
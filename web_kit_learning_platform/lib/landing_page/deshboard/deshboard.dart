// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/constant/dimens_constant.dart';
import 'package:webkit/base/widgets/static_view/static_view.dart';
import 'package:webkit/helpers/localizations/language_helper.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/landing_page/components/review_list/review_list.dart';
import 'package:webkit/routes/app_pages.dart';
import 'package:webkit/services/apis/landing_page/review/models/landing_page_review_list_response_model.dart';
import 'package:webkit/views/auth/login/login.dart';
import 'package:webkit/views/auth/register.dart';

import '../components/colornotifier.dart';
import '../components/course_list/landing_page_course_list.dart';
import '../components/who_this_course_is_for/who_this_course_is_for.dart';
import '../mediaquery/mq.dart';
import 'endofpage.dart';
import '../components/teachet_list/teacher_list.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

enum SampleItem2 { itemOne, itemTwo, itemThree, itemfour }

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({super.key});

  @override
  State<LandingPageScreen> createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  late ColorNotifier notifier;
  SampleItem? selectedMenu;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late TabController t1;

  List sugimage = [
    'assets/deshboard/experience/difference_conversation1.svg',
    'assets/deshboard/experience/difference_conversation2.svg',
    'assets/deshboard/experience/difference_conversation3.svg',
    'assets/deshboard/experience/difference_conversation4.svg',
    'assets/deshboard/experience/difference_conversation5.svg',
    'assets/deshboard/experience/difference_conversation6.svg'
  ];
  List differentimage = [
    'assets/deshboard/experience/difference_conversation1.svg',
    'assets/deshboard/experience/difference_conversation2.svg',
    'assets/deshboard/experience/difference_conversation3.svg',
    'assets/deshboard/experience/difference_conversation4.svg',
  ];

  int selectedindex = 0;
  int sugindex = 0;
  double a = 2;
  ScrollController mainController = ScrollController();
  ScrollController differrentController = ScrollController();
  ScrollController whyChooseUsController = ScrollController();

  List<String> landingPageTitles = [
    'Trang chủ',
    'Phương pháp',
    'Thành tựu',
    'Đối tượng dạy học',
    'Giảng viên',
    'Khóa học',
    'Cảm nhận'
  ];

  List<Color> suColor = [
    const Color(0xFF8BC5E5),
    const Color(0xFF92A5EF),
    const Color(0xFF58C27D)
  ];

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

  bool buttonhover = false;
  bool supportHover = false;

  bool isHover = false;
  bool isHover2 = false;
  bool isHover3 = false;
  bool isHover4 = false;
  bool searchHover = false;
  bool searchHover2 = false;
  bool searchHover3 = false;
  bool bHover = false;
  bool langHover = false;

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
    return Stack(
      children: [
        SingleChildScrollView(
        controller: mainController,
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              key: GlobalObjectKey(0),
            ),
            buildTabBar(constraints: constraints),
            SizedBox(
              height: height / 45,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth < 760
                    ? 10
                    : constraints.maxWidth < 1000
                        ? 0
                        : constraints.maxWidth / 15,
                vertical: 10,
              ),
              child: SizedBox(
                width: width / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      constraints.maxWidth < 800
                          ? Image.asset('assets/deshboard/winterlandscape.png',
                              height: constraints.maxWidth < 500 ? 250 : 400,
                              width: constraints.maxWidth,
                              fit: BoxFit.fill)
                          : Image.asset('assets/deshboard/winterlandscape.png',
                              height: 600,
                              width: constraints.maxWidth,
                              fit: BoxFit.fill),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              key: GlobalObjectKey(1),
              height: constraints.maxWidth / 30,
            ),
            buildDifferentListWidget(constraints: constraints),
            SizedBox(
              height: constraints.maxWidth / 30,
            ),
            buildWhyChooseUsListWidget(constraints: constraints),
            Column(
              children: [
                SizedBox(
                    key: GlobalObjectKey(2),
                    height: constraints.maxWidth < 550
                        ? 70
                        : constraints.maxWidth / 50),
                const WhoThisCourseIsFor(),
                SizedBox(
                    key: GlobalObjectKey(3),
                    height: constraints.maxWidth < 550
                        ? 70
                        : constraints.maxWidth / 50),
                const TeacherList(),
                SizedBox(
                  key: GlobalObjectKey(4),
                  height: constraints.maxWidth < 550
                      ? 50
                      : constraints.maxWidth < 800
                          ? constraints.maxWidth / 30
                          : constraints.maxWidth / 30,
                ),
                const LandingPageCourseList(),
                SizedBox(
                  key: GlobalObjectKey(5),
                  height: constraints.maxWidth < 550
                      ? 50
                      : constraints.maxWidth < 800
                          ? constraints.maxWidth / 30
                          : constraints.maxWidth / 30,
                ),
                ReviewList(
                  //key: UniqueKey(),
                  typeName: UserTypeName.teacher,
                ),
                SizedBox(
                  key: GlobalObjectKey(6),
                  height: constraints.maxWidth < 550
                      ? 50
                      : constraints.maxWidth < 800
                          ? constraints.maxWidth / 30
                          : constraints.maxWidth / 30,
                ),
                ReviewList(
                  // key: UniqueKey(),
                  typeName: UserTypeName.user,
                ),
                SizedBox(
                  height: constraints.maxWidth < 550
                      ? 50
                      : constraints.maxWidth < 800
                          ? constraints.maxWidth / 30
                          : constraints.maxWidth / 30,
                ),
              ],
            ),
            Divider(
              color: notifier.isDark
                  ? notifier.subgreycolor
                  : notifier.sugestionbutton,
            ),
            SizedBox(height: constraints.maxWidth / 20),
            // Container(
            //   color: Colors.red,
            //   height: 50, // fixed height
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal, // make it horizontal
            //     itemCount: 7,
            //     itemBuilder: (context, index) {
            //       return InkWell(
            //           onTap: () {
            //             Scrollable.ensureVisible(
            //                 GlobalObjectKey(index).currentContext!,
            //                 duration: Duration(seconds: 1),
            //                 curve: Curves.easeInOutCubic);
            //           },
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: TextButton(
            //                 onPressed: () {  },
            //                 child: Text('$index')),
            //           ),
            //         );
            //     },
            //   ),
            // ),
            Wrap(
              spacing: 20,
              children: List<Widget>.generate( 7,
                (int index) {
                  return FloatingActionButton(
                    elevation: 0,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    // change text color
                    onPressed: () {
                      Scrollable.ensureVisible(
                          GlobalObjectKey(index).currentContext!,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOutCubic);
                    },
                    child: Expanded(
                      child: Text(landingPageTitles[index], style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),),
                    ),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 30,),
            EndOfPage(),
          ],
        ),
      ),
      Positioned(
        right: 20,
        bottom: 20,
        child: FloatingActionButton(
          backgroundColor: notifier.redcolor,
            onPressed: () {
              Scrollable.ensureVisible(GlobalObjectKey(0).currentContext!,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOutCubic);
            },
            child: Icon(Icons.arrow_upward),
            ),
      )]
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
                Text(
                  'Enjoy the Trip with exciting Discount',
                  style: baseStyle.copyWith(
                    fontSize: 16,
                    color: notifier.greycolor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: constraints.maxWidth < 550 ? 10 : 20,
                ),
                Text('We Recommend Beautiful Destination Every Month',
                    style: baseStyle.copyWith(
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
                  style: baseStyle.copyWith(
                      fontSize: 16, color: notifier.subgreycolor),
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
                    style: baseStyle.copyWith(
                      color: notifier.blackcolor,
                    ),
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
                        suffixIcon: Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: notifier.buttoncolor,
                              shape: BoxShape.circle),
                          child: Image.asset('assets/Icons/arrowrighticon.png',
                              scale: 3, width: 3, color: notifier.whitecolor),
                        ),
                        hintText: 'Enter youe phone number',
                        hintStyle:
                            baseStyle.copyWith(color: notifier.subgreycolor)),
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
                        height: constraints.maxWidth < 550
                            ? constraints.maxWidth / 6
                            : constraints.maxWidth / 20,
                      ),
                      SizedBox(width: constraints.maxWidth < 300 ? 7 : 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Antone Heller',
                            style: baseStyle.copyWith(
                              fontSize: constraints.maxWidth < 550
                                  ? constraints.maxWidth / 30
                                  : constraints.maxWidth / 50,
                              color: notifier.textcolor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star_rounded,
                                  color: notifier.yellowcolor,
                                  size: constraints.maxWidth < 550
                                      ? constraints.maxWidth / 40
                                      : constraints.maxWidth / 70),
                              const SizedBox(width: 5),
                              Text(
                                '4.8',
                                style: baseStyle.copyWith(
                                  fontSize: constraints.maxWidth < 550
                                      ? constraints.maxWidth / 50
                                      : constraints.maxWidth / 70,
                                ),
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

  Widget buildTabBar({required BoxConstraints constraints}) {
    Locale currentLocale = LanguageHelper.getInstance.getCurrentLocale();
    return FutureBuilder(
      future: UserManager().getUserProfile(),
      builder: (context, snapshot) {
        UserProfile? userProfile;
        if (snapshot.hasData) {
          userProfile = snapshot.data as UserProfile;
        }
        return Padding(
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
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StaticView.buildLogo(),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        L10nX.getStr.app_name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: baseStyle.copyWith(
                          color: notifier.blackcolor,
                          fontSize: constraints.maxWidth < 300 ? 20 : 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Visibility(
                    visible: userProfile != null && ResponsiveInfo.isTablet(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
                      child: PopupMenuButton(
                        onOpened: () {
                          AppPages.routeName(Routes.dashboardRoute);
                        },
                        tooltip: L10nX.getStr.auth_manager,
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                                enabled: false,
                                value: '',
                                onTap: () {},
                                child: SizedBox()),
                          ];
                        },
                        child: Text(L10nX.getStr.auth_manager,
                            style: baseStyle.copyWith(
                              fontSize: 16,
                              color: supportHover
                                  ? notifier.blackcolor
                                  : notifier.subgreycolor,
                            )),
                      ),
                    ),
                  ),
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
                                maxWidth: 315,
                                maxHeight: 270,
                              ),
                              color: notifier.whitecolor,
                              child: Text(
                                L10nX.getStr.application,
                                style: baseStyle.copyWith(
                                    color: supportHover
                                        ? notifier.blackcolor
                                        : notifier.subgreycolor,
                                    fontSize: 16),
                              ),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<SampleItem2>>[
                                PopupMenuItem<SampleItem2>(
                                  enabled: true,
                                  value: SampleItem2.itemOne,
                                  onTap: () {},
                                  child: Row(children: [
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        Text(L10nX.getStr.download,
                                            style: baseStyle.copyWith(
                                              fontSize: 16,
                                              color: notifier.subgreycolor,
                                            )),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20),
                                          Text(L10nX.getStr.scan_code,
                                              style: baseStyle.copyWith(
                                                fontSize: 16,
                                                color: notifier.subgreycolor,
                                              )),
                                          const SizedBox(height: 12),
                                          SizedBox(
                                            height: 100,
                                            child: Image.asset(
                                                'assets/deshboard/support/qrCode.png',
                                                height: 100),
                                          ),
                                          const SizedBox(height: 20),
                                        ]),
                                    const SizedBox(width: 10),
                                  ]),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                          ],
                        ),
                  if (constraints.maxWidth < 800)
                    const SizedBox()
                  else
                    Row(
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
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Image.asset(
                                  //   'assets/Icons/langicon.png',
                                  //   height: height / 45,
                                  //   color: langHover
                                  //       ? notifier.blackcolor
                                  //       : notifier.subgreycolor,
                                  // ),
                                  // const SizedBox(
                                  //   width: 4,
                                  // ),
                                  // Text(L10nX.getStr.language_text, style: baseStyle.copyWith(
                                  //     color: langHover
                                  //         ? notifier.blackcolor
                                  //         : notifier.subgreycolor,
                                  //     fontSize: 14,
                                  // )),
                                  ClipRRect(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      borderRadius: BorderRadius.circular(2),
                                      child: Image.asset(
                                        "assets/lang/${currentLocale.languageCode}.png",
                                        width: 18,
                                        height: 14,
                                        fit: BoxFit.cover,
                                      )),
                                  MySpacing.width(8),
                                  MyText.labelMedium(
                                      currentLocale.countryCode ?? "")
                                ],
                              ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          for (LanguageInfo language
                                              in LanguageHelper()
                                                  .supportedLanguages)
                                            InkWell(
                                              onTap: () {
                                                LanguageHelper().changeLanguage(
                                                    language, context);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: Dimens.size10,
                                                    horizontal: Dimens.size8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        child: Image.asset(
                                                          "assets/lang/${language.languageCode}.png",
                                                          width: 18,
                                                          height: 14,
                                                          fit: BoxFit.cover,
                                                        )),
                                                    MySpacing.width(8),
                                                    MyText.labelMedium(
                                                        language.language ?? "")
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  SizedBox(
                    width: constraints.maxWidth < 500 ? 10 : 25,
                  ),
                  // Visibility(
                  //   visible: userProfile!=null,
                  //   child: PopupMenuButton(
                  //     tooltip: '',
                  //     padding: const EdgeInsets.all(0),
                  //     offset: const Offset(0, 50),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(20),),
                  //     // initialValue: selectedMenu,
                  //     constraints: const BoxConstraints(
                  //       maxWidth: 310,
                  //       maxHeight: 540,
                  //     ),
                  //     color: notifier.whitecolor,
                  //     child: SizedBox(
                  //       child: notifier.isDark ? Image.asset(
                  //           'assets/Icons/darkBellIcon.png', height: constraints.maxWidth < 300 ? 25 : 30) : Image
                  //           .asset('assets/Icons/bellicon.png', height: constraints.maxWidth < 300 ? 25 : 30),
                  //     ),
                  //     itemBuilder: (context) =>
                  //     <PopupMenuEntry<SampleItem2>>[
                  //       PopupMenuItem(
                  //           enabled: true,
                  //           onTap: () {},
                  //           child: Column(
                  //             children: [
                  //               const SizedBox(height: 10),
                  //               for(int i = 0; i <
                  //                   5; i++ )
                  //                 Column(
                  //                     children: [
                  //                       Row(
                  //                         crossAxisAlignment: CrossAxisAlignment
                  //                             .start,
                  //                         children: [
                  //                           Container(
                  //                             height: 40,
                  //                             width:  40,
                  //                             decoration: BoxDecoration(
                  //                               shape: BoxShape
                  //                                   .circle,
                  //                               color: notifier
                  //                                   .lightgreencolor,
                  //                             ),
                  //                             alignment: Alignment
                  //                                 .center,
                  //                             child: SvgPicture
                  //                                 .asset(
                  //                                 'assets/Icons/paperIcon.svg',
                  //                                 height: 20),
                  //                           ),
                  //                           const SizedBox(
                  //                               width: 20),
                  //                           Flexible(
                  //                             child: Column(
                  //                               children: [
                  //                                 Text(
                  //                                     'Wrapped Bitcoin is now listed on Unity Exchange',
                  //                                     style: baseStyle.copyWith(
                  //                                         fontSize: 14,
                  //                                         color: notifier
                  //                                             .blackcolor),
                  //                                     maxLines: 2,
                  //                                     softWrap: true),
                  //                                 const SizedBox(height: 8),
                  //                                 Row(
                  //                                   mainAxisAlignment: MainAxisAlignment
                  //                                       .spaceBetween,
                  //                                   children: [
                  //                                     Text(
                  //                                         '24m ago',
                  //                                         style: baseStyle.copyWith(
                  //                                             fontSize: 12,
                  //                                             color: notifier
                  //                                                 .subgreycolor)),
                  //                                     Text(
                  //                                         '●',
                  //                                         style: baseStyle.copyWith(
                  //                                             color: notifier
                  //                                                 .buttoncolor,
                  //                                             fontSize: 10)),
                  //                                   ],
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       const SizedBox(
                  //                           height: 10),
                  //                       i == 4
                  //                           ? const SizedBox()
                  //                           : Divider(
                  //                           color: notifier
                  //                               .subgreycolor
                  //                       ),
                  //                       const SizedBox(
                  //                           height: 10),
                  //                     ]
                  //                 ),
                  //               const SizedBox(height: 10),
                  //               SizedBox(
                  //                 height: 40,
                  //                 width: width / 1,
                  //                 child: ElevatedButton(
                  //                   style: ButtonStyle(
                  //                     elevation: const WidgetStatePropertyAll(
                  //                         0),
                  //                     backgroundColor: WidgetStatePropertyAll(
                  //                         notifier.buttoncolor),
                  //                     shape: WidgetStatePropertyAll(
                  //                       RoundedRectangleBorder(
                  //                         side: BorderSide(
                  //                             color: notifier
                  //                                 .buttoncolor,
                  //                             width: 2),
                  //                         borderRadius: const BorderRadius
                  //                             .all(
                  //                             Radius
                  //                                 .circular(
                  //                                 10)),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   onPressed: () {
                  //
                  //                   },
                  //                   child:  Text(
                  //                       'See all notifications',
                  //                       style: baseStyle.copyWith(
                  //                           fontSize: 12,
                  //                           color: Colors.white)),
                  //                 ),
                  //               ),
                  //               const SizedBox(height: 10),
                  //             ],
                  //           )
                  //       )
                  //     ],),
                  // ),
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
                      maxHeight: 450,
                    ),
                    color: notifier.whitecolor,
                    child: Container(
                      height: height / 19,
                      decoration: BoxDecoration(
                        color: notifier.lightgreencolor,
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: userProfile != null &&
                              (userProfile.avatar ?? "").isNotEmpty
                          ? ImageManager()
                              .getImageByUrl(userProfile.avatar ?? "")
                          : Image.asset(
                              'assets/Icons/profileicon.png',
                              height:
                                  constraints.maxWidth < 300 ? 30 : height / 45,
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
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Visibility(
                              visible: userProfile != null &&
                                  ResponsiveInfo.isPhone(),
                              child: InkWell(
                                onTap: () {
                                  AppPages.routeName(Routes.dashboardRoute);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.home_outlined,
                                      size: Dimens.size25,
                                      color: ColorConst.blackColor,
                                    ),
                                    const SizedBox(width: 20),
                                    Text(L10nX.getStr.auth_manager,
                                        style: baseStyle.copyWith(
                                          fontSize: 16,
                                          color: notifier.blackcolor,
                                        )),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                                visible: ResponsiveInfo.isPhone(),
                                child: Column(
                                  children: [
                                    for (LanguageInfo language
                                        in LanguageHelper().supportedLanguages)
                                      InkWell(
                                        onTap: () {
                                          LanguageHelper().changeLanguage(
                                              language, context);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: Dimens.size12,
                                              horizontal: Dimens.size30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  child: Image.asset(
                                                    "assets/lang/${language.languageCode}.png",
                                                    width: 18,
                                                    height: 14,
                                                    fit: BoxFit.cover,
                                                  )),
                                              MySpacing.width(8),
                                              MyText.labelMedium(
                                                  language.language ?? "")
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                )),
                            const SizedBox(height: 20),
                            // Visibility(
                            //   visible: userProfile!=null,
                            //   child: SizedBox(
                            //     height: 330,
                            //     width: 300,
                            //     child: ListView.builder(
                            //       itemCount: profilemenuImages.length,
                            //       itemBuilder: (context, index) {
                            //         return Column(
                            //           children: [
                            //             Row(
                            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 Row(
                            //                   mainAxisAlignment: MainAxisAlignment.start,
                            //                   crossAxisAlignment: CrossAxisAlignment.center,
                            //                   children: [
                            //                     SvgPicture.asset(
                            //                       notifier.isDark ? profilemenuImagesDark[index] : profilemenuImages[index],
                            //                       height: Dimens.size20
                            //                     ),
                            //                     const SizedBox(width: 20),
                            //                     Text(
                            //                       profilemenuTags[index],
                            //                       style: baseStyle.copyWith(
                            //                           color: notifier.blackcolor,
                            //                           fontSize: 16,
                            //                           // fontWeight: FontWeight
                            //                           //     .w600,
                            //                           letterSpacing: 1),
                            //                     ),
                            //                     const SizedBox(
                            //                         height: 30),
                            //                   ],
                            //                 ),
                            //                 Container(
                            //                   height: 20,
                            //                   width: 20,
                            //                   decoration: BoxDecoration(
                            //                       shape: BoxShape.circle,
                            //                       color: index <= 2
                            //                           ? notifier.pinkcolor
                            //                           : Colors.transparent
                            //                   ),
                            //                   alignment: Alignment.center,
                            //                   child: Text(notNumber[index],
                            //                       style: baseStyle.copyWith(
                            //
                            //                           color: Colors.white,
                            //                           fontSize: 10)),
                            //                 ),
                            //               ],
                            //             ),
                            //             index == 5
                            //                 ? const SizedBox(height: 10)
                            //                 : const SizedBox(height: 20),
                            //             index == 2 ? Divider(
                            //                 color: notifier.sugestionbutton
                            //             ) : const SizedBox(),
                            //             index == 2
                            //                 ? const SizedBox(height: 20)
                            //                 : const SizedBox()
                            //           ],
                            //         );
                            //       },
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: Dimens.size10),
                              child: Stack(children: [
                                Visibility(
                                  visible: userProfile == null,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 145,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            elevation:
                                                const WidgetStatePropertyAll(0),
                                            backgroundColor:
                                                WidgetStatePropertyAll(
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
                                            //AppPages.route(Paths.dashboardPath);
                                          },
                                          child: Text(L10nX.getStr.login,
                                              style: baseStyle.copyWith(
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
                                            elevation:
                                                const WidgetStatePropertyAll(0),
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    notifier.whitecolor),
                                            shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: notifier.buttoncolor,
                                                    width: 2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20)),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Register().show(context);
                                          },
                                          child: Text(L10nX.getStr.sign_up,
                                              style: baseStyle.copyWith(
                                                  fontSize: 12,
                                                  color: notifier.buttoncolor)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: userProfile != null,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 145,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            elevation:
                                                const WidgetStatePropertyAll(0),
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    ColorConst.whiteColor),
                                            shape: const WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            AuthorManager().handleLogout();
                                            AppPages.routeName(
                                                Routes.landingPageRoute,
                                                isReplace: true);
                                          },
                                          child: Text(
                                              L10nX.getStr.sign_out_text,
                                              style: baseStyle.copyWith(
                                                  fontSize: 12,
                                                  color: Colors.red)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ],
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
        );
      },
    );
  }

  Widget buildDifferentListWidget({required BoxConstraints constraints}) {
    List<Widget> listItem = List.empty(growable: true);
    for (int index = 0; index < sugimage.length; index++) {
      listItem.add(buildSuggestItem(
        constraints: constraints,
        imageAssetName: sugimage[index],
        content: L10nX().getStringByKey("medthod_content${index + 1}"),
        title: L10nX().getStringByKey("medthod_title${index + 1}"),
      ));
    }
    return Container(
      // color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   color: Colors.red,
          //   height:  ResponsiveInfo.isPhone()
          //       ? constraints.maxWidth / 5
          //       : constraints.maxWidth / 15,
          // ),
          Padding(
            padding: EdgeInsets.only(
                left: constraints.maxWidth < 500 ? 10 : 0,
                right: constraints.maxWidth < 500 ? 10 : 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(L10nX.getStr.differences_in_teaching_methods_1,
                        style: TextStyleConstant
                            .titleTextColorOnBackgroundColorStyle14w400
                            .copyWith(
                          color: notifier.blackcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: ResponsiveInfo.isPhone() ? 28 : 45,
                        ),
                        textAlign: TextAlign.center),
                    Text(L10nX.getStr.differences_in_teaching_methods_2,
                        style: TextStyleConstant
                            .titleTextColorOnBackgroundColorStyle14w400
                            .copyWith(
                          color: notifier.redcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: ResponsiveInfo.isPhone() ? 28 : 45,
                        ),
                        textAlign: TextAlign.center),
                    Text(L10nX.getStr.differences_in_teaching_methods_3,
                        style: TextStyleConstant
                            .titleTextColorOnBackgroundColorStyle14w400
                            .copyWith(
                          color: notifier.blackcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: ResponsiveInfo.isPhone() ? 28 : 45,
                        ),
                        textAlign: TextAlign.center),
                  ],
                ),
                Text(
                  L10nX.getStr
                      .we_are_different_because_we_understand_what_you_need,
                  style: TextStyleConstant
                      .titleTextColorOnBackgroundColorStyle14w400
                      .copyWith(
                          fontSize: ResponsiveInfo.isPhone() ? 18 : 20,
                          color: notifier.greycolor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            height: ResponsiveInfo.isPhone() ? 0 : constraints.maxWidth / 30,
          ),
          Container(
            // height: Dimens.size240,
            constraints: BoxConstraints(
              maxWidth: ResponsiveInfo.isPhone()
                  ? constraints.maxWidth - Dimens.size20
                  : constraints.maxWidth * 3 / 4,
            ),
            child: SingleChildScrollView(
              controller: differrentController,
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: listItem,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    if (differrentController.offset >= 0) {
                      differrentController.animateTo(
                        (constraints.maxWidth < 750)
                            ? differrentController.offset - 225
                            : differrentController.offset - 370,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    }
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
                    if (differrentController.offset >= 0) {
                      differrentController.animateTo(
                        (constraints.maxWidth < 750)
                            ? differrentController.offset + 225
                            : differrentController.offset + 370,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  onHover: (val) {
                    setState(() {
                      isHover2 = val;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Image.asset('assets/Icons/arrowrighticon.png',
                        width: 15, color: notifier.subgreycolor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSuggestItem(
      {required BoxConstraints constraints,
      required String imageAssetName,
      String? title,
      String? content}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.size36, vertical: Dimens.size20),
      child: SizedBox(
        width: ResponsiveInfo.isPhone()
            ? (constraints.maxWidth - Dimens.size36 * 2 - Dimens.size20)
            : Dimens.size340,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageManager().getSvgImage(imageAssetName,
                isSvgFolder: false,
                height: constraints.maxWidth < 750
                    ? 80
                    : constraints.maxWidth < 1000
                        ? 100
                        : 120),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? "",
                  style: TextStyleConstant.textStyleBlack18w600.copyWith(
                    fontSize: ResponsiveInfo.isPhone() ? 16 : 18,
                    color: notifier.blackcolor,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  content ?? "",
                  style: TextStyleConstant.textStyleBlack12w400.copyWith(
                    fontSize: ResponsiveInfo.isPhone() ? 16 : 18,
                    color: notifier.blackcolor,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ],
            ),
            SizedBox(
              width: ResponsiveInfo.isPhone()
                  ? (sugindex == 5 ? 0 : 16)
                  : (sugindex == 5 ? 0 : constraints.maxWidth / 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWhyChooseUsListWidget({
    required BoxConstraints constraints,
  }) {
    List<Widget> listItem = List.empty(growable: true);
    for (int index = 0; index < differentimage.length; index++) {
      listItem.add(buildSuggestItem(
        constraints: constraints,
        imageAssetName: differentimage[index],
        content: L10nX().getStringByKey("why_choose_content${index + 1}"),
        title: L10nX().getStringByKey("why_choose_title${index + 1}"),
      ));
    }
    return Container(
      // color: Colors.green,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(L10nX.getStr.why_choose_us_1,
                    style: TextStyleConstant
                        .titleTextColorOnBackgroundColorStyle14w400
                        .copyWith(
                      fontSize: ResponsiveInfo.isPhone() ? 28 : 45,
                      color: notifier.blackcolor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
                Text(L10nX.getStr.why_choose_us_2,
                    style: TextStyleConstant
                        .titleTextColorOnBackgroundColorStyle14w400
                        .copyWith(
                      fontSize: ResponsiveInfo.isPhone() ? 28 : 45,
                      color: notifier.redcolor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
                Text(L10nX.getStr.why_choose_us_3,
                    style: TextStyleConstant
                        .titleTextColorOnBackgroundColorStyle14w400
                        .copyWith(
                      fontSize: ResponsiveInfo.isPhone() ? 28 : 45,
                      color: notifier.blackcolor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
              ],
            ),
            Text(
              L10nX.getStr.why_choose_us_sub_title,
              style: TextStyleConstant
                  .titleTextColorOnBackgroundColorStyle14w400
                  .copyWith(
                      fontSize: constraints.maxWidth < 700 ? 16 : 18,
                      color: notifier.greycolor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: constraints.maxWidth < 550
                  ? 0
                  : constraints.maxWidth < 800
                      ? constraints.maxWidth / 30
                      : constraints.maxWidth / 30,
            ),
            Container(
              // height: Dimens.size240,
              constraints: BoxConstraints(
                maxWidth: ResponsiveInfo.isPhone()
                    ? constraints.maxWidth - Dimens.size20
                    : constraints.maxWidth * 3 / 4,
              ),
              child: SingleChildScrollView(
                controller: whyChooseUsController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listItem,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 2,
                        color: (isHover3)
                            ? notifier.sugestionbutton
                            : Colors.transparent),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (whyChooseUsController.offset > 0) {
                        whyChooseUsController.animateTo(
                          (constraints.maxWidth < 750)
                              ? whyChooseUsController.offset - 225 * 2
                              : whyChooseUsController.offset - 325 * 2,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    onHover: (val) {
                      setState(() {
                        isHover3 = val;
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
                        color: (isHover4)
                            ? notifier.sugestionbutton
                            : Colors.transparent),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (whyChooseUsController.offset >= 0) {
                        whyChooseUsController.animateTo(
                          (constraints.maxWidth < 750)
                              ? whyChooseUsController.offset + 225 * 2
                              : whyChooseUsController.offset + 325 * 2,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    onHover: (val) {
                      setState(() {
                        isHover4 = val;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Image.asset('assets/Icons/arrowrighticon.png',
                          width: 15, color: notifier.subgreycolor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
    subtitle:
        'From exotic destinations to hidden gems, our user-friendly interface makes planning your next adventure a breeze',
  ),
  lottieAnim(
    lottiefile: 'assets/deshboard/travel2.json',
    title: 'Your journey',
    subtitle:
        'From dreamy destinations to personalized itineraries, we empower you to shape your journey.',
  ),
  lottieAnim(
    lottiefile: 'assets/deshboard/travel3.json',
    title: 'Book simply',
    subtitle:
        'Our platform lets you wander wisely, offering a streamlined booking experience for your dream destinations.',
  ),
];

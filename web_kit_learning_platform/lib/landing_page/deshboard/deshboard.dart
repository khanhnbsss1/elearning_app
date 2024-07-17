// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/static_view/static_view.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/controller/ui/landing_controller.dart';
import 'package:webkit/helpers/localizations/language_helper.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/landing_page/components/review_list/review_list.dart';
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

class _LandingPageScreenState extends State<LandingPageScreen>
    with
        SingleTickerProviderStateMixin,
        UIMixin,
        AutomaticKeepAliveClientMixin {
  late ColorNotifier notifier;
  SampleItem? selectedMenu;

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
  ScrollController differrentController = ScrollController();
  ScrollController whyChooseUsController = ScrollController();

  List<Color> suColor = [
    const Color(0xFF8BC5E5),
    const Color(0xFF92A5EF),
    const Color(0xFF58C27D)
  ];

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
  int tabHover = 0;

  List<String> landingPageTitles = [
    'Trang chủ',
    'Phương pháp',
    'Đối tượng',
    'Giảng viên',
    'Khóa học',
    'Cảm nhận',
    'Thành tựu',
  ];

  ShowCardModel showCardModel = ShowCardModel();
  ScrollController _mainController = ScrollController();
  List<Widget>listWiget= [];
  late double oldWidth=0;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    if (ResponsiveInfo.isPhone()) {
      return buildMobile(context);
    } else {
      return buildDesktop(context);
    }
  }

  Widget buildMobile(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: buildTabBar(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width)),
        )
      ),
      endDrawer: CustomDrawer(),
      backgroundColor: notifier.backgroundColor,
      body: SafeArea(child: LayoutBuilder(
        builder: (context, constraints) {
          return appbarleft(constraints);
        },
      )),
    );
  }

  Widget buildDesktop(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: Container(),
      ),
      backgroundColor: notifier.backgroundColor,
      body: SafeArea(child: LayoutBuilder(
        builder: (context, constraints) {
          return appbarleft(constraints);
        },
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    _mainController.addListener(() {
      if (_mainController.offset > 300) {
        if(showCardModel.showCard==false)
          {
            showCardModel.onChangerShowCard(true);
          }

      } else {
        if(showCardModel.showCard==true)
          {
            showCardModel.onChangerShowCard(false);

          }
      }
    });
  }
  Widget appbarleft(constraints) {
    double width = MediaQuery.of(context).size.width;
    double itemCardWidth = (width < 1100) ? 90 : 140;
    if(oldWidth!= width || listWiget.isEmpty)
    {
      oldWidth = width;
      listWiget.clear();
      listWiget.addAll({
        SizedBox(
          key: GlobalObjectKey(0),
        ),
        (width > 550) ? buildTabBar(constraints: constraints) : SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth < 760
                ? 10
                : constraints.maxWidth < 1000
                ? 0
                : constraints.maxWidth / 15,
            vertical: 10,
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) { 
              return  SizedBox(
                width: width / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { 
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ResponsiveInfo.isPhone()?
                        Image.asset('assets/deshboard/winterlandscape.png',
                            height: constraints.maxWidth < 500 ? 250 : 400,
                            width: constraints.maxWidth,
                            fit: BoxFit.cover)
                            : Image.asset('assets/deshboard/winterlandscape.png',
                            height: 600,
                            width: constraints.maxWidth,
                            fit: BoxFit.cover),
                      ],
                    );
                  },
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 1/4),
          child: Divider(
            color: Colors.black12,
          ),
        ),
        SizedBox(
          key: GlobalObjectKey(1),
          height: width < 550 ? 10 : 100,
        ),
        buildDifferentListWidget(constraints: constraints),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 1/4),
          child: Divider(
            color: Colors.black12,
          ),
        ),
        SizedBox(
          key: GlobalObjectKey(2),
          height: width < 550 ? 10 : 100,
        ),
        WhoThisCourseIsFor(),
        SizedBox(
          key: GlobalObjectKey(3),
          height: width < 550 ? 10 : 100,
        ),
        const TeacherList(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 1/4),
          child: Divider(
            color: Colors.black12,
          ),
        ),
        SizedBox(
          key: GlobalObjectKey(4),
          height: width < 550 ? 10 : 100,
        ),
        const LandingPageCourseList(),
        SizedBox(
          key: GlobalObjectKey(5),
          height: width < 550 ? 10 : 100,
        ),
        ReviewList(
          //key: UniqueKey(),
          typeName: UserTypeName.teacher,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 1/4),
          child: Divider(
            color: Colors.black12,
          ),
        ),
        SizedBox(
          key: GlobalObjectKey(6),
          height: width < 550 ? 50 : 100,
        ),
        buildWhyChooseUsListWidget(constraints: constraints),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 1/4),
          child: Divider(
            color: Colors.black12,
          ),
        ),
        SizedBox(
          key: GlobalObjectKey(7),
          height: width < 550 ? 10 : 100,
        ),
        ReviewList(
          // key: UniqueKey(),
          typeName: UserTypeName.user,
        ),
        Divider(
          color: notifier.isDark
              ? notifier.subgreycolor
              : notifier.sugestionbutton,
        ),
        SizedBox(height: 30,),
        EndOfPage(),
      });
    }
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _mainController,
          child: Column(
            children:  listWiget,
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            heroTag: "arrow_upward",
            backgroundColor: Color.fromRGBO(143, 20, 17, 1.0),
              hoverColor: Color.fromRGBO(134, 16, 14, 1.0),
              onPressed: () {
                Scrollable.ensureVisible(GlobalObjectKey(0).currentContext!,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOutCubic);
              },
              child: Icon(Icons.arrow_upward),
              ),
        ),
        ListenableBuilder(
          listenable: showCardModel, 
          builder: (BuildContext context, Widget? child) { 
            return Visibility(
              visible: showCardModel.showCard && width > 750,
              child: Align(
                 alignment: Alignment.topCenter,
                child: Card(
                  margin: EdgeInsets.only(top: width < 1100 ? 10 : 20),
                  shadowColor: Colors.red,
                  surfaceTintColor: Colors.green,
                  elevation: 5,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 10,),
                      StaticView.buildLogo(size: 28),
                      SizedBox(width: 10,),
                      Wrap(
                        children: List<Widget>.generate( 7, (int index) {
                            return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { 
                              return  SizedBox(
                                height: 50,
                                //width: itemCardWidth,
                                child: OnHoverWidget(
                                  builder: (isHovered) {
                                    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { 
                                      return Center(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            overlayColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            Scrollable.ensureVisible(
                                                GlobalObjectKey(index).currentContext!,
                                                duration: Duration(seconds: 1),
                                                curve: Curves.easeInOutCubic);
                                          },
                                          child: Text(landingPageTitles[index],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: (width < 1100) ? 10 : 18,
                                                color: (isHovered) ? notifier.redcolor : Colors.black,
                                                decoration: (isHovered) ? TextDecoration.underline : TextDecoration.none,
                                                decorationColor: notifier.redcolor,
                                                decorationThickness: 2
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    );
                                  },
                                ),
                              );
                            },
                              
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },),
      ]
      );
  }
  
  Widget buildTabBar({required BoxConstraints constraints}) {
    Locale currentLocale = LanguageHelper.getInstance.getCurrentLocale();
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {  
        return FutureBuilder(
          future: UserManager().getUserProfile(),
          builder: (context, snapshot) {
            UserProfile? userProfile;
            if (snapshot.hasData) {
              userProfile = snapshot.data as UserProfile;
            }
            return Padding(
              padding: EdgeInsets.only(
                  top: constraints.maxWidth < 550 ? 0 : 12,
                  left: constraints.maxWidth < 550 ? 0
                      : constraints.maxWidth / 10 < 800
                      ? constraints.maxWidth / 15
                      : constraints.maxWidth / 10,
                  right: constraints.maxWidth < 550 ? 0
                      : constraints.maxWidth / 10 < 800
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
                        (constraints.maxWidth < 550) ? SizedBox() : Expanded(
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
                            tooltip: L10nX.getStr.lets_study,
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<String>(
                                    enabled: false,
                                    value: '',
                                    onTap: () {},
                                    child: SizedBox()),
                              ];
                            },
                            child: Text(L10nX.getStr.lets_study,
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
                                        Text(L10nX.getStr.lets_study,
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
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {  
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: constraints.maxWidth < 500 ? 10 : 0,
                  right: constraints.maxWidth < 500 ? 10 : 0),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: L10nX.getStr.differences_in_teaching_methods_1,
                          style: TextStyleConstant
                              .titleTextColorOnBackgroundColorStyle14w400
                              .copyWith(
                            fontSize: ResponsiveInfo.isPhone() ? 28 : 45,
                            color: notifier.blackcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: L10nX.getStr.differences_in_teaching_methods_2,
                          style: TextStyleConstant
                              .titleTextColorOnBackgroundColorStyle14w400
                              .copyWith(
                            fontSize: ResponsiveInfo.isPhone() ? 28 : 45,
                            color: notifier.redcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: L10nX.getStr.differences_in_teaching_methods_3,
                          style: TextStyleConstant
                              .titleTextColorOnBackgroundColorStyle14w400
                              .copyWith(
                            fontSize: ResponsiveInfo.isPhone() ? 28 : 45,
                            color: notifier.blackcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
                      double itemWidth = ResponsiveInfo.isPhone()
                          ? (constraints.maxWidth - Dimens.size36 * 2 - Dimens.size20)
                          : (constraints.maxWidth < 1100)
                          ? ((constraints.maxWidth) * 3/4 - Dimens.size36 * 4) / 2
                          :(constraints.maxWidth < 1600)
                          ? ((constraints.maxWidth) * 3/4 - Dimens.size36 * 6) / 3
                          :Dimens.size340;
                      if (differrentController.offset >= 0) {
                        differrentController.animateTo(differrentController.offset - itemWidth - 36*2,
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
                      double itemWidth = ResponsiveInfo.isPhone()
                          ? (constraints.maxWidth - Dimens.size36 * 2 - Dimens.size20)
                          : (constraints.maxWidth < 1100)
                          ? ((constraints.maxWidth) * 3/4 - Dimens.size36 * 4) / 2
                          :(constraints.maxWidth < 1600)
                          ? ((constraints.maxWidth) * 3/4 - Dimens.size36 * 6) / 3
                          :Dimens.size340;
                      if (differrentController.offset >= 0) {
                        differrentController.animateTo(differrentController.offset + itemWidth + 36*2,
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
        );
      },
    );
  }

  Widget buildSuggestItem(
      {required BoxConstraints constraints,
      required String imageAssetName,
      String? title,
      String? content}) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.size36, vertical: Dimens.size20),
          child: SizedBox(
            width: ResponsiveInfo.isPhone()
                ? (constraints.maxWidth - Dimens.size36 * 2 - Dimens.size20)
                : (constraints.maxWidth < 1100)
                ? ((constraints.maxWidth) * 3/4 - Dimens.size36 * 4) / 2
                :(constraints.maxWidth < 1600)
                ? ((constraints.maxWidth) * 3/4 - Dimens.size36 * 6) / 3
                :Dimens.size340,
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
          ));
      },
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
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) { 
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
          child: Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: L10nX.getStr.why_choose_us_1,
                      style: TextStyleConstant
                          .titleTextColorOnBackgroundColorStyle14w400
                          .copyWith(
                        fontSize: ResponsiveInfo.isPhone() ? 28 : 45,
                        color: notifier.blackcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: L10nX.getStr.why_choose_us_2,
                      style: TextStyleConstant
                          .titleTextColorOnBackgroundColorStyle14w400
                          .copyWith(
                        fontSize: ResponsiveInfo.isPhone() ? 28 : 45,
                        color: notifier.redcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: L10nX.getStr.why_choose_us_3,
                      style: TextStyleConstant
                          .titleTextColorOnBackgroundColorStyle14w400
                          .copyWith(
                        fontSize: ResponsiveInfo.isPhone() ? 28 : 45,
                        color: notifier.blackcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
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

class CustomDrawer extends StatelessWidget {
  List logos = [
    'assets/logo/linkdinLogo.svg',
    'assets/logo/twitterxLogo.svg',
    'assets/logo/facebookLogo.svg'
  ];

  List contactsImage = [
    'assets/Icons/emailicon.svg',
    'assets/Icons/phoneicon.svg',
    'assets/Icons/gpsicon.svg'
  ];

  List contacts = [
    'hello@pulse.com',
    '0932130000',
    'Số 26 Đường 57A, phường Tân \nTạo, Quận Bình Tân, TPHCM'
  ];

  List<String> landingPageTitles = [
    'Trang chủ',
    'Phương pháp',
    'Đối tượng',
    'Giảng viên',
    'Khóa học',
    'Cảm nhận',
    'Thành tựu',
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              child: StaticView.buildLogo(size: 30),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List<Widget>.generate(
                7,
                    (int index) {
                  return Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0XD9D9D9FF),
                        )
                      )
                    ),
                    height: 30,
                    child: GestureDetector(
                      child: OnHoverWidget(
                        builder: (isHovered) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                overlayColor: Colors.black,
                              ),
                              onPressed: () {
                                Scrollable.ensureVisible(
                                    GlobalObjectKey(index).currentContext!,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInOutCubic);
                                Navigator.of(context).pop();
                              },
                              child: Text(landingPageTitles[index],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 12,),
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
                              color: Colors.black
                          ),
                        ),
                        child: SvgPicture.asset(logos[index], color: Colors.black,
                            height: 20),
                      ),
                      const SizedBox(width: 10),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 12,),
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: contacts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Container(
                        child: EndOfPage.buildContactInfoItem(
                            textColor: Colors.black,
                            contacts: contacts[index],
                            icon: contactsImage[index]
                        ),
                      ),
                      SizedBox(height: 12,),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
class ShowCardModel with ChangeNotifier {
  bool  _showCard = false;
  bool get showCard => _showCard;

  void onChangerShowCard(bool showCard) {
    _showCard = showCard;
    notifyListeners();
  }
}
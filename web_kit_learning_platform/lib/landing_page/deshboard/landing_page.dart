// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/static_view/static_view.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
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

class _LandingPageScreenState extends State<LandingPageScreen> with SingleTickerProviderStateMixin, UIMixin, AutomaticKeepAliveClientMixin {
  late ColorNotifier notifier;
  SampleItem? selectedMenu;

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

  int sugindex = 0;
  double a = 2;
  ScrollController differrentController = ScrollController();
  ScrollController whyChooseUsController = ScrollController();

  List<Color> suColor = [const Color(0xFF8BC5E5), const Color(0xFF92A5EF), const Color(0xFF58C27D)];

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

  List<String> landingPageTitles = ["home_str", "method_str", "subject_str", "instructor_str", "course_str", "feelings_str", "achievements_str"];
  
  ShowCardModel showCardModel = ShowCardModel();
  ScrollController _mainController = ScrollController();
  List<Widget> listWiget = [];
  late double oldWidth = 0;

  List<GlobalObjectKey> navigationKey = List.generate(9, (index) => GlobalObjectKey(index));

  @override
  Widget build(BuildContext context) {
    super.build(context);
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    if (width < Dimens.size550) {
      return buildMobile(context);
    } else {
      return buildDesktop(context);
    }
  }

  Widget buildMobile(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: buildTabBar(
                constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            )),
          )),
      drawer: CustomDrawer(),
      backgroundColor: notifier.backgroundColor,
      body: SafeArea(child: LayoutBuilder(
        builder: (context, constraints) {
          return appbarLeft(constraints);
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
          return appbarLeft(constraints);
        },
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    _mainController.addListener(() {
      if (_mainController.offset > Dimens.size300) {
        if (showCardModel.showCard == false) {
          showCardModel.onChangerShowCard(true);
        }
      } else {
        if (showCardModel.showCard == true) {
          showCardModel.onChangerShowCard(false);
        }
      }
    });
  }

  Widget appbarLeft(constraints) {
    double width = MediaQuery.of(context).size.width;
    double itemCardWidth = (width < Dimens.size1100) ? Dimens.size90 : Dimens.size140;
    bool isHovered = false;

    if (oldWidth != width || listWiget.isEmpty) {
      oldWidth = width;
      _mainController = ScrollController();
      _mainController.addListener(() {
        if (_mainController.offset > Dimens.size200) {
          if (showCardModel.showCard == false) {
            showCardModel.onChangerShowCard(true);
          }
        } else {
          if (showCardModel.showCard == true) {
            showCardModel.onChangerShowCard(false);
          }
        }
      });
      listWiget.clear();
      listWiget.addAll({
        SizedBox(
          key: navigationKey[0],
        ),
        (width > Dimens.size550) ? buildTabBar(constraints: constraints) : SizedBox(),
        Gap(Dimens.size24),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal:  Dimens.size15,
            vertical: Dimens.size10,
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              UserProfile? userProfile = UserManager().getUserProfile();
              return Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimens.size20),
                        ),
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.topCenter,
                        child: ResponsiveInfo.isPhone()
                            ? Image.asset('assets/deshboard/background.jpg',
                               height:  Dimens.size250 , width: constraints.maxWidth, fit: BoxFit.cover)
                            : Image.asset('assets/deshboard/background.jpg', height: Dimens.size600, width: constraints.maxWidth, fit: BoxFit.cover),
                      );
                    },
                  ),
                  Positioned(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Visibility(
                        visible: width > Dimens.size550,
                        child: buildNavigatorBar(),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        SizedBox(
          height: Dimens.size20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 1 / 4),
          child: Divider(
            color: Colors.black12,
          ),
        ),
        SizedBox(
          key: navigationKey[1],
          height: width < Dimens.size550 ? Dimens.size24 : Dimens.size100,
        ),
        buildDifferentListWidget(constraints: constraints),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 1 / 4),
          child: Divider(
            color: Colors.black12,
          ),
        ),
        SizedBox(
          key: navigationKey[2],
          height: width < Dimens.size550 ? Dimens.size50 : Dimens.size100,
        ),
        WhoThisCourseIsFor(),
        SizedBox(
          key: navigationKey[3],
          height: width < Dimens.size550 ? Dimens.size50 : Dimens.size100,
        ),
        const TeacherList(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 1 / 4),
          child: Divider(
            color: Colors.black12,
          ),
        ),
        SizedBox(
          key: navigationKey[4],
          height: width < Dimens.size550 ? Dimens.size50 : Dimens.size100,
        ),
        const LandingPageCourseList(),
        SizedBox(
          key: navigationKey[5],
          height: width < Dimens.size550 ? Dimens.size50 : Dimens.size100,
        ),
        ReviewList(
          //key: UniqueKey(),
          typeName: UserTypeName.teacher,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 1 / 4),
          child: Divider(
            color: Colors.black12,
          ),
        ),
        SizedBox(
          key: navigationKey[6],
          height: width < Dimens.size550 ? 50 : 100,
        ),
        buildWhyChooseUsListWidget(constraints: constraints),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 1 / 4),
          child: Divider(
            color: Colors.black12,
          ),
        ),
        SizedBox(
          key: navigationKey[7],
          height: width < Dimens.size550 ? 50 : 100,
        ),
        ReviewList(
          // key: UniqueKey(),
          typeName: UserTypeName.user,
        ),
        SizedBox(
          key: navigationKey[8],
          height: width < Dimens.size550 ? Dimens.size50 : Dimens.size100,
        ),
        EndOfPage(),
      });
    }
    return Stack(children: [
      SingleChildScrollView(
        controller: _mainController,
        //scrollSpeed: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: listWiget,
        ),
      ),
      Positioned(
        right: Dimens.size20,
        bottom: Dimens.size20,
        child: StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return FloatingActionButton(
              heroTag: "arrow_upward",
              backgroundColor: Color.fromRGBO(143, 20, 17, 1.0),
              hoverColor: Color.fromRGBO(134, 16, 14, 1.0),
              onPressed: () {
                Scrollable.ensureVisible(GlobalObjectKey(0).currentContext!, duration: Duration(seconds: 1), curve: Curves.easeInOutCubic);
              },
              child: Icon(Icons.arrow_upward),
            );
          },
        ),
      ),
      ListenableBuilder(
          listenable: showCardModel,
          builder: (BuildContext context, Widget? child) {
            return Visibility(
              visible: showCardModel.showCard && width > Dimens.size550,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(padding: EdgeInsets.only(top: Dimens.size20), child: buildNavigatorBar()),
              ),
            );
          }),
    ]);
  }

  Widget buildNavigatorBar() {
    return Card(
      margin: EdgeInsets.only(top: Dimens.size20),
      shadowColor: Colors.red,
      surfaceTintColor: Colors.green,
      elevation: 5,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 10,
          ),
          (width > 750) ? StaticView.buildLogo(size: 28) : SizedBox(),
          SizedBox(
            width: 10,
          ),
          Wrap(
            children: List<Widget>.generate(
              7,
              (int index) {
                return StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setState) {
                    return SizedBox(
                      height: 50,
                      //width: itemCardWidth,
                      child: OnHoverWidget(
                        builder: (isHovered) {
                          return StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) setState) {
                              return Center(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    overlayColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Scrollable.ensureVisible(GlobalObjectKey(index).currentContext!, duration: Duration(seconds: 1), curve: Curves.easeInOutCubic);
                                  },
                                  child: Text(
                                    L10nX().getStringByKey(landingPageTitles[index]),
                                    style: TextStyleConstant.textStyleBlack14w400.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: (isHovered) ? notifier.redcolor : Colors.black,
                                        decoration: (isHovered) ? TextDecoration.underline : TextDecoration.none,
                                        decorationColor: notifier.redcolor,
                                        decorationThickness: 2),
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
    );
  }

  Widget buildTabBar({required BoxConstraints constraints}) {
    Locale currentLocale = LanguageHelper.getInstance.getCurrentLocale();
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        UserProfile? userProfile = UserManager().getUserProfile();
        return Padding(
          padding: EdgeInsets.only(
              top: constraints.maxWidth < Dimens.size550 ? 0 : Dimens.size12,
              left: constraints.maxWidth < Dimens.size550
                  ? Dimens.size0
                  : constraints.maxWidth < Dimens.size1050
                      ? Dimens.size20
                      : Dimens.size40,
              right: constraints.maxWidth < Dimens.size550
                  ? 0
                  : constraints.maxWidth < Dimens.size1050
                      ? Dimens.size20
                      : Dimens.size40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    InkWell(
                        hoverColor: Colors.transparent,
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: StaticView.buildLogo()),
                    const SizedBox(width: 5),
                    (constraints.maxWidth < Dimens.size550)
                        ? SizedBox()
                        : Expanded(
                            child: Text(
                              L10nX.getStr.app_name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleConstant.titleMedium.copyWith(
                                color: notifier.blackcolor,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: Dimens.size16,
                  ),
                  PopupMenuButton(
                    tooltip: '',
                    padding: const EdgeInsets.all(0),
                    offset: Offset(Dimens.size10, Dimens.size30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.size20),
                    ),
                    // initialValue: selectedMenu,
                    constraints: BoxConstraints(
                      maxWidth: Dimens.size130,
                      maxHeight: Dimens.size150,
                    ),
                    color: notifier.whitecolor,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                borderRadius: BorderRadius.circular(2),
                                child: Image.asset(
                                  "assets/lang/${currentLocale.languageCode}.png",
                                  width: Dimens.size18,
                                  height: Dimens.size14,
                                  fit: BoxFit.cover,
                                )),
                            MySpacing.width(Dimens.size8),
                            MyText.labelMedium(currentLocale.countryCode ?? "")
                          ],
                        ),
                      ),
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem2>>[
                      PopupMenuItem<SampleItem2>(
                        enabled: true,
                        value: SampleItem2.itemOne,
                        onTap: () {},
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (LanguageInfo language in LanguageHelper().supportedLanguages)
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: Dimens.size8),
                                    child: InkWell(
                                      hoverColor: Colors.transparent,
                                      onTap: () {
                                        LanguageHelper().changeLanguage(language, context);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: Dimens.size10, horizontal: Dimens.size8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                borderRadius: BorderRadius.circular(2),
                                                child: Image.asset(
                                                  "assets/lang/${language.languageCode}.png",
                                                  width: Dimens.size18,
                                                  height: Dimens.size14,
                                                  fit: BoxFit.cover,
                                                )),
                                            MySpacing.width(Dimens.size8),
                                            MyText.labelMedium(language.language ?? "")
                                          ],
                                        ),
                                      ),
                                    ),
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
                width: constraints.maxWidth < Dimens.size500 ? Dimens.size10 : Dimens.size25,
              ),
              PopupMenuButton(
                constraints: BoxConstraints(
                  maxWidth: Dimens.size140,
                  maxHeight: Dimens.size100,
                ),
                tooltip: '',
                padding: const EdgeInsets.all(0),
                offset: Offset(0, Dimens.size50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.size20),
                ),
                // initialValue: selectedMenu,
                color: notifier.whitecolor,
                child: Container(
                  height: constraints.maxWidth < Dimens.size550 ? Dimens.size30 : Dimens.size50,
                  width: Dimens.size50,
                  decoration: BoxDecoration(
                    color: notifier.lightgreencolor,
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: userProfile != null && (userProfile.avatar ?? "").isNotEmpty
                      ? ImageManager().getImageByUrl(width: Dimens.size20, height: Dimens.size20, userProfile.avatar ?? "")
                      : Image.asset(
                          'assets/deshboard/profile.png',
                          fit: BoxFit.fill,
                        ),
                ),
                onSelected: (SampleItem2 item) {
                  setState(() {
                    // selectedMenu = item;
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem2>>[
                  PopupMenuItem<SampleItem2>(
                    enabled: true,
                    value: SampleItem2.itemOne,
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                          visible: userProfile == null,
                          child: Center(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    LoginPage().show(context);
                                    //AppPages.route(Paths.dashboardPath);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: Dimens.size8),
                                    child: Text(L10nX.getStr.login, style: baseStyle.copyWith(fontSize: Dimens.size12, color: notifier.buttoncolor)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Register().show(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: Dimens.size8),
                                    child: Text(L10nX.getStr.sign_up, style: baseStyle.copyWith(fontSize: Dimens.size12, color: notifier.buttoncolor)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: userProfile != null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  userProfile == null ? LoginPage().show(context) : AppPages.routeName(Routes.dashboardRoute);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_outlined,
                                      size: Dimens.size20,
                                      color: ColorConst.mainColor,
                                    ),
                                    SizedBox(width: Dimens.size8),
                                    Text(
                                      L10nX.getStr.lets_study,
                                      style: baseStyle,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              InkWell(
                                onTap: () {
                                  AuthorManager().handleLogout();
                                  AppPages.routeName(Routes.landingPageRoute, isReplace: true);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      size: Dimens.size25,
                                      color: ColorConst.mainColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(L10nX.getStr.sign_out_text, style: baseStyle),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: constraints.maxWidth < Dimens.size500 ? Dimens.size10 : Dimens.size25,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSuggestItem({required BoxConstraints constraints, required String imageAssetName, String? title, String? content}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.size36, vertical: Dimens.size20),
        child: SizedBox(
          width: ResponsiveInfo.isPhone()
              ? (constraints.maxWidth - Dimens.size36 * 2 - Dimens.size20)
              : (constraints.maxWidth < Dimens.size1100)
                  ? ((constraints.maxWidth) * 3 / 4 - Dimens.size36 * 4) / 2
                  : (constraints.maxWidth < Dimens.size1600)
                      ? ((constraints.maxWidth) * 3 / 4 - Dimens.size36 * 6) / 3
                      : Dimens.size340,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                ImageManager().getSvgImage(imageAssetName,
                    isSvgFolder: false,
                    height: constraints.maxWidth < Dimens.size750
                        ? Dimens.size80
                        : constraints.maxWidth < Dimens.size1000
                            ? Dimens.size100
                            : Dimens.size120),
                Text(
                  title ?? "",
                  style: TextStyleConstant.titleSmall.copyWith(
                    color: notifier.blackcolor,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(
                  height: (ResponsiveInfo.isPhone())?Dimens.size10 : Dimens.size20,
                ),
                Text(
                  content ?? "",
                  style: TextStyleConstant.bodyMedium.copyWith(
                    color: notifier.blackcolor,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
                SizedBox(
                  width: ResponsiveInfo.isPhone() ? (sugindex == 5 ? 0 : Dimens.size16) : (sugindex == 5 ? 0 : constraints.maxWidth / 24),
                ),
              ],
            ),
          ),
        ));
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
              padding: EdgeInsets.only(left: constraints.maxWidth < Dimens.size500 ? Dimens.size10 : 0, right: constraints.maxWidth < Dimens.size500 ? Dimens.size10 : 0),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: L10nX.getStr.differences_in_teaching_methods_1,
                          style: TextStyleConstant.titleTextColorOnBackgroundColorStyle14w400
                              .copyWith(fontWeight: FontWeight.bold, fontSize: constraints.maxWidth < Dimens.size550 ? Dimens.size28 : Dimens.size45, color: notifier.blackcolor),
                        ),
                        TextSpan(
                            text: L10nX.getStr.differences_in_teaching_methods_2,
                            style: TextStyleConstant.titleTextColorOnBackgroundColorStyle14w400
                                .copyWith(fontWeight: FontWeight.bold, fontSize: constraints.maxWidth < Dimens.size550 ? Dimens.size28 : Dimens.size45, color: notifier.redcolor)),
                        TextSpan(
                          text: L10nX.getStr.differences_in_teaching_methods_3,
                          style: TextStyleConstant.titleTextColorOnBackgroundColorStyle14w400
                              .copyWith(fontWeight: FontWeight.bold, fontSize: constraints.maxWidth < Dimens.size550 ? Dimens.size28 : Dimens.size45, color: notifier.blackcolor),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    L10nX.getStr.we_are_different_because_we_understand_what_you_need,
                    style: TextStyleConstant.titleSmall.copyWith(fontWeight: FontWeight.w400, color: ColorConst.blackColor45),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ResponsiveInfo.isPhone() ? 0 : Dimens.size16,
            ),
            Container(
              // height: Dimens.size240,
              constraints: BoxConstraints(
                maxWidth: ResponsiveInfo.isPhone() ? constraints.maxWidth - Dimens.size20 : constraints.maxWidth * 3 / 4,
                // maxHeight:  350
              ),
              child: Column(
                children: [
                  SingleChildScrollView(
                    controller: differrentController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: listItem,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StatefulBuilder(
                        builder: (context, setState) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: (isHover) ? notifier.sugestionbutton : Colors.transparent),
                            ),
                            child: InkWell(
                              hoverColor: Colors.transparent,
                              onTap: () {
                                double itemWidth = ResponsiveInfo.isPhone()
                                    ? (constraints.maxWidth - Dimens.size36 * 2 - Dimens.size20)
                                    : (constraints.maxWidth < Dimens.size1100)
                                        ? ((constraints.maxWidth) * 3 / 4 - Dimens.size36 * 4) / 2
                                        : (constraints.maxWidth < Dimens.size1600)
                                            ? ((constraints.maxWidth) * 3 / 4 - Dimens.size36 * 6) / 3
                                            : Dimens.size340;
                                if (differrentController.offset >= 0) {
                                  differrentController.animateTo(
                                    differrentController.offset - itemWidth - Dimens.size36 * 2,
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
                                padding: EdgeInsets.all(Dimens.size13),
                                child: Image.asset(
                                  'assets/Icons/arrowlefticon.png',
                                  width: 15,
                                  color: notifier.subgreycolor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: Dimens.size10),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: (isHover2) ? notifier.sugestionbutton : Colors.transparent),
                            ),
                            child: InkWell(
                              hoverColor: Colors.transparent,
                              onTap: () {
                                double itemWidth = ResponsiveInfo.isPhone()
                                    ? (constraints.maxWidth - Dimens.size36 * 2 - Dimens.size20)
                                    : (constraints.maxWidth < Dimens.size1100)
                                        ? ((constraints.maxWidth) * 3 / 4 - Dimens.size36 * 4) / 2
                                        : (constraints.maxWidth < Dimens.size1600)
                                            ? ((constraints.maxWidth) * 3 / 4 - Dimens.size36 * 6) / 3
                                            : Dimens.size340;
                                if (differrentController.offset >= 0) {
                                  differrentController.animateTo(
                                    differrentController.offset + itemWidth + Dimens.size36 * 2,
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
                                padding: EdgeInsets.all(Dimens.size13),
                                child: Image.asset('assets/Icons/arrowrighticon.png', width: Dimens.size15, color: notifier.subgreycolor),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: constraints.maxWidth < Dimens.size500 ? Dimens.size10 : 0, right: constraints.maxWidth < Dimens.size500 ? Dimens.size10 : 0),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: L10nX.getStr.why_choose_us_1,
                          style: TextStyleConstant.titleTextColorOnBackgroundColorStyle14w400
                              .copyWith(fontWeight: FontWeight.bold, fontSize: constraints.maxWidth < Dimens.size550 ? Dimens.size28 : Dimens.size45, color: notifier.blackcolor),
                        ),
                        TextSpan(
                          text: L10nX.getStr.why_choose_us_2,
                          style: TextStyleConstant.titleTextColorOnBackgroundColorStyle14w400.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: constraints.maxWidth < Dimens.size550 ? Dimens.size28 : Dimens.size45,
                            color: notifier.redcolor,
                          ),
                        ),
                        TextSpan(
                          text: L10nX.getStr.why_choose_us_3,
                          style: TextStyleConstant.titleTextColorOnBackgroundColorStyle14w400.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: constraints.maxWidth < Dimens.size550 ? Dimens.size28 : Dimens.size45,
                            color: ColorConst.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    L10nX.getStr.why_choose_us_sub_title,
                    style: TextStyleConstant.titleSmall.copyWith(fontWeight: FontWeight.w400, color: ColorConst.blackColor45),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ResponsiveInfo.isPhone() ? 0 : Dimens.size16,
            ),
            Container(
              // height: Dimens.size240,
              constraints: BoxConstraints(maxWidth: ResponsiveInfo.isPhone() ? constraints.maxWidth - Dimens.size20 : constraints.maxWidth * 3 / 4, maxHeight: Dimens.size340),
              child: Column(
                children: [
                  SingleChildScrollView(
                    controller: whyChooseUsController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: listItem,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StatefulBuilder(
                        builder: (context, setState) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: (isHover) ? notifier.sugestionbutton : Colors.transparent),
                            ),
                            child: InkWell(
                              hoverColor: Colors.transparent,
                              onTap: () {
                                double itemWidth = ResponsiveInfo.isPhone()
                                    ? (constraints.maxWidth - Dimens.size36 * 2 - Dimens.size20)
                                    : (constraints.maxWidth < Dimens.size1100)
                                        ? ((constraints.maxWidth) * 3 / 4 - Dimens.size36 * 4) / 2
                                        : (constraints.maxWidth < Dimens.size1600)
                                            ? ((constraints.maxWidth) * 3 / 4 - Dimens.size36 * 6) / 3
                                            : Dimens.size340;
                                if (whyChooseUsController.offset >= 0) {
                                  whyChooseUsController.animateTo(
                                    whyChooseUsController.offset - itemWidth - Dimens.size36 * 2,
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
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: (isHover2) ? notifier.sugestionbutton : Colors.transparent),
                            ),
                            child: InkWell(
                              hoverColor: Colors.transparent,
                              onTap: () {
                                double itemWidth = ResponsiveInfo.isPhone()
                                    ? (constraints.maxWidth - Dimens.size36 * 2 - Dimens.size20)
                                    : (constraints.maxWidth < Dimens.size1100)
                                        ? ((constraints.maxWidth) * 3 / 4 - Dimens.size36 * 4) / 2
                                        : (constraints.maxWidth < Dimens.size1600)
                                            ? ((constraints.maxWidth) * 3 / 4 - Dimens.size36 * 6) / 3
                                            : Dimens.size340;
                                if (whyChooseUsController.offset >= 0) {
                                  whyChooseUsController.animateTo(
                                    whyChooseUsController.offset + itemWidth + Dimens.size36 * 2,
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
                                padding: EdgeInsets.all(Dimens.size13),
                                child: Image.asset('assets/Icons/arrowrighticon.png', width: Dimens.size15, color: notifier.subgreycolor),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
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

class CustomDrawer extends StatelessWidget {
  List logos = ['assets/logo/linkdinLogo.svg', 'assets/logo/twitterxLogo.svg', 'assets/logo/facebookLogo.svg'];

  List contactsImage = ['assets/Icons/emailicon.svg', 'assets/Icons/phoneicon.svg', 'assets/Icons/gpsicon.svg'];

  List contacts = ['hello@pulse.com', '0932130000', 'Số 26 Đường 57A, phường Tân Tạo, Quận Bình Tân, TPHCM'];

  List<String> landingPageTitles = ["home_str", "method_str", "subject_str", "instructor_str", "course_str", "feelings_str", "achievements_str"];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 5 / 7,
      child: Container(
        color: ColorConst.mainColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.size12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Dimens.size70,
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          L10nX.getStr.app_name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConstant.textStyleBlack18w600.copyWith(color: ColorConst.whiteColor),
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(hoverColor: Colors.transparent, child: StaticView.buildLogo()),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 7,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) setState) {
                            return Container(
                              // width: 250,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                width: 1,
                                color: Color(0XD9D9D9FF),
                              ))),
                              //height: 30,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextButton(
                                    iconAlignment: IconAlignment.end,
                                    style: TextButton.styleFrom(overlayColor: Colors.black, iconColor: ColorConst.blackColor),
                                    onPressed: () {
                                      Scrollable.ensureVisible(GlobalObjectKey(index).currentContext!, duration: Duration(seconds: 1), curve: Curves.easeInOutCubic);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      L10nX().getStringByKey(landingPageTitles[index]),
                                      textAlign: TextAlign.start,
                                      style: TextStyleConstant.textStyleBlack16w600.copyWith(color: ColorConst.whiteColor),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: Dimens.size12,
                    ),
                    SizedBox(
                      height: Dimens.size40,
                      // width:Dimens.size300,
                      child: ListView.builder(
                        itemCount: logos.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: Dimens.size40,
                            padding: EdgeInsets.symmetric(vertical: Dimens.size8, horizontal: Dimens.size8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: ColorConst.whiteColor),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: Dimens.size8),
                            child: SvgPicture.asset(logos[index], color: ColorConst.whiteColor, height: Dimens.size20),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: Dimens.size12,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EndOfPage.buildContactInfoItem(textColor: Colors.white, contacts: contacts[0], icon: contactsImage[0]),
                        SizedBox(
                          height: Dimens.size8,
                        ),
                        EndOfPage.buildContactInfoItem(textColor: Colors.white, contacts: contacts[1], icon: contactsImage[1]),
                        SizedBox(
                          height: Dimens.size8,
                        ),
                        EndOfPage.buildContactInfoItem(textColor: Colors.white, contacts: contacts[2], icon: contactsImage[2]),
                        SizedBox(
                          height: Dimens.size8,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowCardModel with ChangeNotifier {
  bool _showCard = false;

  bool get showCard => _showCard;

  void onChangerShowCard(bool showCard) {
    _showCard = showCard;
    notifyListeners();
  }
}

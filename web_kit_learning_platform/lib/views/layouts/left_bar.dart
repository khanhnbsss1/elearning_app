import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/constant/dimens_constant.dart';
import 'package:webkit/base/widgets/static_view/static_view.dart';
import 'package:webkit/helpers/services/url_service.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/theme/theme_customizer.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/images.dart';
import 'package:webkit/widgets/custom_pop_menu.dart';

typedef LeftbarMenuFunction = void Function(String key);

class LeftbarObserver {
  static Map<String, LeftbarMenuFunction> observers = {};

  static attachListener(String key, LeftbarMenuFunction fn) {
    observers[key] = fn;
  }

  static detachListener(String key) {
    observers.remove(key);
  }

  static notifyAll(String key) {
    for (var fn in observers.values) {
      fn(key);
    }
  }
}

class LeftBar extends StatefulWidget {
  final bool isCondensed;

  const LeftBar({Key? key, this.isCondensed = false}) : super(key: key);

  @override
  _LeftBarState createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar>
    with SingleTickerProviderStateMixin, UIMixin {
  final ThemeCustomizer customizer = ThemeCustomizer.instance;

  bool isCondensed = false;
  String path = UrlService.getCurrentUrl();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isCondensed = widget.isCondensed;
    Color textColor = ColorConst.whiteColor;
    return MyCard(
      paddingAll: 0,
      color: ColorConst.whiteColor,
      shadow: MyShadow(position: MyShadowPosition.centerRight, elevation: 0.2),
      child: AnimatedContainer(
        color: leftBarTheme.background,
        width: isCondensed ? 70 : 254,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: Dimens.size16, vertical: Dimens.size8),
              child: Center(
                child: InkWell(
                  onTap: () {
                    AppPages.routeName(Routes.dashboardRoute);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        //height: Dimens.size30,
                        width: Dimens.size40,
                        child:  StaticView.buildLogo(),
                      ),
                     
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(L10nX.getStr.app_name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConstant.textStyleBlack18w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              physics: const PageScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavigationItem(
                    iconData: LucideIcons.layoutDashboard,
                    title: L10nX.getStr.dashboard,
                    isCondensed: isCondensed,
                    route: Routes.dashboardRoute,
                  ),
                  labelWidget(L10nX.getStr.apps),
                  //-----------------Course-----------------//
                  MenuWidget(
                    iconData: Icons.library_books,
                    isCondensed: isCondensed,
                    title: L10nX.getStr.course_str,
                    children: [
                      MenuItem(
                        title: L10nX.getStr.your_course,
                        route:  Routes.courseMyList,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.courses_list,
                        route:  Routes.courseList,
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),
                  
                  //-----------------CALENDAR-----------------//
                  NavigationItem(
                    iconData: LucideIcons.calendarDays,
                    title: L10nX.getStr.str_calendar,
                    route: Routes.calenderRoute,
                    isCondensed: isCondensed,
                  ),
                  //-----------------Chat-----------------//
                  NavigationItem(
                    iconData: LucideIcons.messageSquare,
                    title: L10nX.getStr.str_chat,
                    route: Routes.uiChatRoute,
                    isCondensed: isCondensed,
                  ),
                  
                  //-----------------LandingPage-----------------//
                  MenuWidget(
                    iconData: LucideIcons.planeLanding,
                    isCondensed: isCondensed,
                    title: L10nX.getStr.landing_page,
                    children: [
                      MenuItem(
                        title: L10nX.getStr.landing_page,
                        route:  Routes.uiLandingRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.landing_page,
                        route:  Routes.landingPageRoute,
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),
                  //-----------------Login-----------------//
                  MenuWidget(
                    iconData: LucideIcons.logIn,
                    isCondensed: isCondensed,
                    title: L10nX.getStr.login,
                    children: [
                      MenuItem(
                        title: L10nX.getStr.login,
                        route:  Routes.lockedRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "${L10nX.getStr.login}1",
                        route:  Routes.loginRoute1,
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),
                  //-----------------Contact-----------------//
                  MenuWidget(
                    iconData: LucideIcons.contact,
                    isCondensed: isCondensed,
                    title: L10nX.getStr.str_contacts,
                    children: [
                      MenuItem(
                        title: L10nX.getStr.str_members,
                        route:  Routes.contactsMembersRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.profile,
                        route:  Routes.contactsProfileRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_edit_profile,
                        route:  Routes.contactsEditProfileRoute,
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),

                  //-----------------CRM-----------------//
                  MenuWidget(
                    iconData: LucideIcons.users,
                    isCondensed: isCondensed,
                    title: L10nX.getStr.str_CRM,
                    children: [
                      MenuItem(
                        title: L10nX.getStr.str_contacts,
                        route:  Routes.crmContactsRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_opportunities,
                        route:  Routes.crmOpportunitiesPathRoute,
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),

                  // -----------------Ecommerce-----------------//
                  MenuWidget(
                    iconData: LucideIcons.store,
                    isCondensed: isCondensed,
                    title: L10nX.getStr.ecommerce,
                    children: [
                      MenuItem(
                        title: L10nX.getStr.products,
                        isCondensed: isCondensed,
                        route:  Routes.appsEcommerceProductsRoute,
                      ),
                      MenuItem(
                        title: L10nX.getStr.add_product,
                        isCondensed: isCondensed,
                        route:  Routes.appsEcommerceAddProductRoute,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_product_detail,
                        isCondensed: isCondensed,
                        route:  Routes.appsEcommerceAddProductRoute,
                      ),
                      MenuItem(
                        title: L10nX.getStr.customers,
                        isCondensed: isCondensed,
                        route:  Routes.appsEcommerceCustomersRoute,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_invoice,
                        isCondensed: isCondensed,
                        route:  Routes.appsEcommerceInvoiceRoute,
                      ),
                    ],
                  ),
                  //-----------------File-----------------//
                  MenuWidget(
                    iconData: LucideIcons.folderPlus,
                    isCondensed: isCondensed,
                    title: "File",
                    children: [
                      MenuItem(
                        title: L10nX.getStr.str_manager,
                        route:  Routes.appsFilesRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_upload,
                        route:  Routes.appsFileUploaderRoute,
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),

                  //-----------------Project-----------------//
                  MenuWidget(
                    iconData: LucideIcons.briefcase,
                    isCondensed: isCondensed,
                    title: L10nX.getStr.str_projects,
                    children: [
                      MenuItem(
                        title: L10nX.getStr.str_project_list,
                        route:  Routes.projectsProjectListRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_project_detail,
                        route:  Routes.projectsProjectDetailRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_create_project,
                        route:  Routes.projectsCreateProjectRoute,
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),

                  //-----------------KanBan-----------------//
                  NavigationItem(
                    iconData: LucideIcons.squareKanban,
                    title: "Kanban",
                    route:  Routes.kanbanRoute,
                    isCondensed: isCondensed,
                  ),

                  //-----------------NFT Dashboard-----------------//
                  NavigationItem(
                    iconData: LucideIcons.circleDollarSign,
                    title: L10nX.getStr.str_NFT_dashboard,
                    route: Routes.nFTDashboardRoute,
                    isCondensed: isCondensed,
                  ),
                  NavigationItem(
                    iconData: LucideIcons.shoppingCart,
                    title: L10nX.getStr.str_customer,
                    route:  Routes.shoppingCustomerRoute,
                    isCondensed: isCondensed,
                  ),
                  NavigationItem(
                    iconData: LucideIcons.dumbbell,
                    title: L10nX.getStr.str_fitness,
                    route:  Routes.fitnessRoute,
                    isCondensed: isCondensed,
                  ),
                  NavigationItem(
                    iconData: LucideIcons.mailbox,
                    title: L10nX.getStr.str_mailbox,
                    route:  Routes.milaBoxRoute,
                    isCondensed: isCondensed,
                  ),

                  labelWidget(L10nX.getStr.pages),

                  //-----------------Landing-----------------//
                  NavigationItem(
                    iconData: LucideIcons.presentation,
                    title: L10nX.getStr.str_Landing,
                    route:  Routes.uiLandingRoute,
                    isCondensed: isCondensed,
                  ),

                  //-----------------Auth-----------------//
                  MenuWidget(
                    iconData: LucideIcons.shieldAlert,
                    isCondensed: isCondensed,
                    title: L10nX.getStr.auth,
                    children: [
                      MenuItem(
                        title: L10nX.getStr.login,
                        route: Routes.loginRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.login,
                        route:  Routes.loginRoute1,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.register,
                        route:  Routes.signupRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.register,
                        route:  Routes.signupRoute1,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.forgot_password,
                        route:  Routes.forgotPasswordRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.forgot_password,
                        route:  Routes.forgotPasswordRoute1,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.reset_password,
                        route:  Routes.resetPasswordRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.reset_password,
                        route:  Routes.resetPasswordRoute1,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.locked,
                        route:  Routes.lockedRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.locked,
                        route:  Routes.lockedRoute1,
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),

                  //-----------------Error-----------------//
                  MenuWidget(
                    iconData: LucideIcons.alertCircle,
                    isCondensed: isCondensed,
                    title: 'Error',
                    children: [
                      MenuItem(
                        title: "ERROR-404",
                        route:  Routes.uiError404Route,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "ERROR-500",
                        route:  Routes.uiError500Route,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_coming_soon,
                        route:  Routes.comingSoonRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_maintenance,
                        route: Routes.maintenanceRoute,
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),

                  //-----------------Extra Pages-----------------//
                  MenuWidget(
                    iconData: LucideIcons.bookOpenCheck,
                    isCondensed: isCondensed,
                    title: L10nX.getStr.str_extra_pages,
                    children: [
                      MenuItem(
                        title: L10nX.getStr.FAQs,
                        route: Routes.faqsRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_pricing,
                        route: Routes.pricingRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_timeLine,
                        isCondensed: isCondensed,
                        route: Routes.timelineRoute,
                      ),
                    ],
                  ),

                  //-----------------Forms-----------------//
                  MenuWidget(
                    iconData: LucideIcons.formInput,
                    isCondensed: isCondensed,
                    title: L10nX.getStr.form,
                    children: [
                      MenuItem(
                        title: L10nX.getStr.basic,
                        route: Routes.formBasicRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_form_mask,
                        route: Routes.formFormMaskRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_quill_editor,
                        route: Routes.formQuillEditorRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.validation,
                        route: Routes.formValidationRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.wizard,
                        route: Routes.formWizardRoute,
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),
                  //-----------------UI Widget-----------------//
                  MenuWidget(
                    iconData: LucideIcons.layoutGrid,
                    isCondensed: isCondensed,
                    title: L10nX.getStr.widgets,
                    children: [
                      MenuItem(
                        title: L10nX.getStr.buttons,
                        route: Routes.uiButtonsRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.cards,
                        route: Routes.uiCardsRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.tabs,
                        route: Routes.uiTabsRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.dialogs,
                        route: Routes.uiDialogsRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.carousels,
                        route: Routes.uiCarouselsRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.str_drag_drop,
                        route: Routes.uiDragDropRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: L10nX.getStr.notifications,
                        route: Routes.uiNotificationRoute,
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),

                  NavigationItem(
                    iconData: LucideIcons.file,
                    title: L10nX.getStr.starter,
                    route: Routes.starterRoute,
                    isCondensed: isCondensed,
                  ),
                  //-----------------Other-----------------//
                  labelWidget(L10nX.getStr.other),
                  NavigationItem(
                    iconData: LucideIcons.table2,
                    title: L10nX.getStr.basic_tables,
                    route: Routes.otherBasicTablesRoute,
                    isCondensed: isCondensed,
                  ),
                  NavigationItem(
                    iconData: LucideIcons.barChartBig,
                    title: L10nX.getStr.syncfusion_charts,
                    route: Routes.otherSyncfusionChartsRoute,
                    isCondensed: isCondensed,
                  ),
                  NavigationItem(
                    iconData: LucideIcons.barChart,
                    title: "fl_chart",
                    route: Routes.otherFlChartRoute,
                    isCondensed: isCondensed,
                  ),
                  //-----------------Maps-----------------//
                  MenuWidget(
                    iconData: LucideIcons.map,
                    isCondensed: isCondensed,
                    title: L10nX.getStr.map,
                    children: [
                      MenuItem(
                        title: "Sf Maps",
                        route: Routes.mapsSfMapsRoute,
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Google Maps",
                        route: Routes.mapsGoogleMapsRoute,
                        isCondensed: widget.isCondensed,
                      ),
                    ],
                  ),

                  MySpacing.height(16),
                  if (!isCondensed)
                    Center(
                      child: MyButton(
                          borderRadiusAll: AppStyle.buttonRadius.small,
                          elevation: 0,
                          padding: MySpacing.xy(12, 16),
                          onTap: () {
                            UrlService.goToPurchase();
                          },
                          backgroundColor: theme.colorScheme.primary,
                          child: MyText.labelMedium(
                            L10nX.getStr.purchase_now,
                            color: theme.colorScheme.onPrimary,
                          )),
                    ),
                  MySpacing.height(32),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget labelWidget(String label) {
    return isCondensed
        ? MySpacing.empty()
        : Container(
            padding: MySpacing.xy(24, 8),
            child: MyText.labelSmall(
              label.toUpperCase(),
              color: leftBarTheme.labelColor,
              muted: true,
              maxLines: 1,
              overflow: TextOverflow.clip,
              fontWeight: 700,
            ),
          );
  }
}

class MenuWidget extends StatefulWidget {
  final IconData iconData;
  final String title;
  final bool isCondensed;
  final bool active;
  final List<MenuItem> children;

  const MenuWidget(
      {super.key,
      required this.iconData,
      required this.title,
      this.isCondensed = false,
      this.active = false,
      this.children = const []});

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget>
    with UIMixin, SingleTickerProviderStateMixin {
  bool isHover = false;
  bool isActive = false;
  late Animation<double> _iconTurns;
  late AnimationController _controller;
  bool popupShowing = true;
  Function? hideFn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5)
        .chain(CurveTween(curve: Curves.easeIn)));
    LeftbarObserver.attachListener(widget.title, onChangeMenuActive);
  }

  void onChangeMenuActive(String key) {
    if (key != widget.title) {
      // onChangeExpansion(false);
    }
  }

  void onChangeExpansion(value) {
    isActive = value;
    if (isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var route = UrlService.getCurrentUrl();
    isActive = widget.children.any((element) => element.route == route);
    onChangeExpansion(isActive);
    if (hideFn != null) {
      hideFn!();
    }
    // popupShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    // var route = Uri.base.fragment;
    // isActive = widget.children.any((element) => element.route == route);

    if (widget.isCondensed) {
      return CustomPopupMenu(
        backdrop: true,
        show: popupShowing,
        hideFn: (_) => hideFn = _,
        onChange: (_) {
          // popupShowing = _;
        },
        placement: CustomPopupMenuPlacement.right,
        menu: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              isHover = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHover = false;
            });
          },
          child: MyContainer.transparent(
            margin: MySpacing.fromLTRB(16, 0, 16, 8),
            color: isActive || isHover
                ? leftBarTheme.activeItemBackground
                : Colors.transparent,
            padding: MySpacing.xy(8, 8),
            child: Center(
              child: Icon(
                widget.iconData,
                color: (isHover || isActive)
                    ? leftBarTheme.activeItemColor
                    : leftBarTheme.onBackground,
                size: 20,
              ),
            ),
          ),
        ),
        menuBuilder: (_) => MyContainer.bordered(
          paddingAll: 8,
          width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: widget.children,
          ),
        ),
      );
    } else {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(24, 0, 16, 0),
          paddingAll: 0,
          child: ListTileTheme(
            contentPadding: const EdgeInsets.all(0),
            dense: true,
            horizontalTitleGap: 0.0,
            minLeadingWidth: 0,
            child: ExpansionTile(
                tilePadding: MySpacing.zero,
                initiallyExpanded: isActive,
                maintainState: true,
                onExpansionChanged: (_) {
                  LeftbarObserver.notifyAll(widget.title);
                  onChangeExpansion(_);
                },
                trailing: RotationTransition(
                  turns: _iconTurns,
                  child: Icon(
                    LucideIcons.chevronDown,
                    size: 18,
                    color: leftBarTheme.onBackground,
                  ),
                ),
                iconColor: leftBarTheme.activeItemColor,
                childrenPadding: MySpacing.x(12),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      widget.iconData,
                      size: 20,
                      color: isHover || isActive
                          ? leftBarTheme.activeItemColor
                          : leftBarTheme.onBackground,
                    ),
                    MySpacing.width(18),
                    Expanded(
                      child: MyText.labelLarge(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        color: isHover || isActive
                            ? leftBarTheme.activeItemColor
                            : leftBarTheme.onBackground,
                      ),
                    ),
                  ],
                ),
                collapsedBackgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                backgroundColor: Colors.transparent,
                children: widget.children),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    // LeftbarObserver.detachListener(widget.title);
  }
}

class MenuItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const MenuItem({
    Key? key,
    this.iconData,
    required this.title,
    this.isCondensed = false,
    this.route,
  }) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          AppPages.routeName(widget.route!);

          // MyRouter.pushReplacementNamed(context, widget.route!, arguments: 1);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(4, 0, 8, 4),
          color: isActive || isHover
              ? leftBarTheme.activeItemBackground
              : Colors.transparent,
          width: MediaQuery.of(context).size.width,
          padding: MySpacing.xy(18, 7),
          child: MyText.bodySmall(
            "${widget.isCondensed ? "" : "- "}  ${widget.title}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            textAlign: TextAlign.left,
            fontSize: 12.5,
            color: isActive || isHover
                ? leftBarTheme.activeItemColor
                : leftBarTheme.onBackground,
            fontWeight: isActive || isHover ? 600 : 500,
          ),
        ),
      ),
    );
  }
}

class NavigationItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const NavigationItem(
      {Key? key,
      this.iconData,
      required this.title,
      this.isCondensed = false,
      this.route})
      : super(key: key);

  @override
  _NavigationItemState createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          AppPages.routeName(widget.route!);

          // MyRouter.pushReplacementNamed(context, widget.route!, arguments: 1);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(16, 0, 16, 8),
          color: isActive || isHover
              ? leftBarTheme.activeItemBackground
              : Colors.transparent,
          padding: MySpacing.xy(8, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.iconData != null)
                Center(
                  child: Icon(
                    widget.iconData,
                    color: (isHover || isActive)
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                    size: 20,
                  ),
                ),
              if (!widget.isCondensed)
                Flexible(
                  fit: FlexFit.loose,
                  child: MySpacing.width(16),
                ),
              if (!widget.isCondensed)
                Expanded(
                  flex: 3,
                  child: MyText.labelLarge(
                    widget.title,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    color: isActive || isHover
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

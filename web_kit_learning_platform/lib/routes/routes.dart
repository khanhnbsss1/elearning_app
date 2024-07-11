import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/landing_page/splash.dart';
import 'package:webkit/views/apps/CRM/contacts_page.dart';
import 'package:webkit/views/apps/CRM/opportunities.dart';
import 'package:webkit/views/apps/calender.dart';
import 'package:webkit/views/apps/chat_page.dart';
import 'package:webkit/views/apps/contacts/edit_profile.dart';
import 'package:webkit/views/apps/contacts/member_list.dart';
import 'package:webkit/views/apps/contacts/profile.dart';
import 'package:webkit/views/apps/ecommerce/add_product.dart';
import 'package:webkit/views/apps/ecommerce/customers.dart';
import 'package:webkit/views/apps/ecommerce/invoice_page.dart';
import 'package:webkit/views/apps/ecommerce/product_detail.dart';
import 'package:webkit/views/apps/ecommerce/products.dart';
import 'package:webkit/views/apps/file/file_manager.dart';
import 'package:webkit/views/apps/file/file_uploader.dart';
import 'package:webkit/views/apps/fitness/fitness_screen.dart';
import 'package:webkit/views/apps/kanban_page.dart';
import 'package:webkit/views/apps/mail_box_screen.dart';
import 'package:webkit/views/apps/projects/create_project.dart';
import 'package:webkit/views/apps/projects/project_detail.dart';
import 'package:webkit/views/apps/projects/project_list.dart';
import 'package:webkit/views/apps/shopping_customer/shopping_customer_screen.dart';
import 'package:webkit/views/auth/forgot_password.dart';
import 'package:webkit/views/auth/forgot_password_2.dart';
import 'package:webkit/views/auth/locked.dart';
import 'package:webkit/views/auth/login/login.dart';
import 'package:webkit/views/auth/login/login_2.dart';
import 'package:webkit/views/auth/register.dart';
import 'package:webkit/views/auth/register_2.dart';
import 'package:webkit/views/auth/reset_password.dart';
import 'package:webkit/views/auth/reset_password_2.dart';
import 'package:webkit/views/course/course_list/course_list.dart';
import 'package:webkit/views/course/my_course/my_course_list.dart';
import 'package:webkit/views/forms/basic_page.dart';
import 'package:webkit/views/forms/form_mask.dart';
import 'package:webkit/views/forms/quill_editor.dart';
import 'package:webkit/views/forms/validation.dart';
import 'package:webkit/views/forms/wizard.dart';
import 'package:webkit/views/other/basic_table.dart';
import 'package:webkit/views/other/fl_chart_screen.dart';
import 'package:webkit/views/other/google_map.dart';
import 'package:webkit/views/other/sfmap_page.dart';
import 'package:webkit/views/other/synsfusion_chart.dart';
import 'package:webkit/views/starter.dart';
import 'package:webkit/views/ui/buttons_page.dart';
import 'package:webkit/views/ui/cards_page.dart';
import 'package:webkit/views/ui/carousels.dart';
import 'package:webkit/views/ui/dialogs.dart';
import 'package:webkit/views/ui/drag_drop.dart';
import 'package:webkit/views/ui/notifications.dart';
import 'package:webkit/views/ui/reviews_page.dart';
import 'package:webkit/views/ui/tabs_page.dart';
import 'package:webkit/views/video_player/model/video_model.dart';
import 'package:webkit/views/video_player/video_player.dart';

import '../views/auth/locked_2.dart';
import '../views/dashboard.dart';
import '../views/error_pages/coming_soon_page.dart';
import '../views/error_pages/error_404.dart';
import '../views/error_pages/error_500.dart';
import '../views/error_pages/maintenance_page.dart';
import '../views/extra_pages/faqs_page.dart';
import '../views/extra_pages/pricing.dart';
import '../views/extra_pages/time_line_page.dart';
import '../views/ui/landing_page.dart';
import '../views/ui/nft_dashboard.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    
    return AuthorManager().getLoggedInUser()
        ? null
        :  RouteSettings(name: Routes.landingPageRoute,);
  }
}

getPageRoute() {
  var routes = [

    GetPage(
        name: Routes.homeRoute,
        page: () =>  DashboardPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.landingPageRoute,
        page: () =>  LandingPageSplash(key: UniqueKey(),),),
    GetPage(name: Routes.faqsRoute, page: () =>  FaqsPage()),
    
    ///--------------- Course ---------------///
    GetPage(
        name: Routes.courseList,
        page: () =>  CourseList(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.videoPlayer,
        page: () {
          final arguments = Get.arguments;
          return VideoPlayer(videoPlayerModel: VideoPlayerModel(
            title: "Test youtube player",
            link: "https://www.youtube.com/watch?v=E-Iv7YqHMJ0&list=RDE-Iv7YqHMJ0&start_radio=1"
          ));

          //return VideoPlayer(videoPlayerModel: arguments['videoPlayerModel'],);
        },
        middlewares: [AuthMiddleware()]),
    
    GetPage(
        name: Routes.courseMyList,
        page: () =>  MyCourseList(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.courseDetail,
        page: () =>  MyCourseList(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.pricingRoute,
        page: () =>  Pricing(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.starterRoute,
        page: () =>  Starter(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.dashboardRoute,
        page: () =>  DashboardPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]
    ),
    
    
    ///--------------- Ecommerce ---------------///
    GetPage(
        name: Routes.appsEcommerceProductsRoute,
        page: () =>  ProductPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.appsEcommerceAddProductRoute,
        page: () =>  AddProduct(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.appsEcommerceProductsDetailRoute,
        page: () =>  ProductDetail(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.appsEcommerceCustomersRoute,
        page: () =>  Customers(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.appsEcommerceInvoiceRoute,
        page: () =>  InvoicePage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.timelineRoute,
        page: () =>  TimeLinePage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    ///---------------- File ----------------///

    GetPage(
        name: Routes.appsFilesRoute,
        page: () =>  FileManager(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.appsFileUploaderRoute,
        page: () =>  FileUploader(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    ///---------------- Ntf ----------------///

    GetPage(
        name: Routes.nFTDashboardRoute,
        page: () =>  NFTDashboardScreen(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.calenderRoute,
        page: () =>  Calender(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.shoppingCustomerRoute,
        page: () =>  ShoppingCustomerScreen(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.fitnessRoute,
        page: () =>  FitnessScreen(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.milaBoxRoute,
        page: () =>  MailBoxScreen(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    ///---------------- KanBan ----------------///

    GetPage(
        name: Routes.kanbanRoute,
        page: () =>  KanBanPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    ///---------------- Projects ----------------///
    GetPage(
        name: Routes.projectsProjectListRoute,
        page: () =>  ProjectListPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.projectsProjectDetailRoute,
        page: () =>  ProjectDetail(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.projectsCreateProjectRoute,
        page: () =>  CreateProject(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    ///---------------- Contacts ----------------///

    GetPage(
        name: Routes.contactsProfileRoute,
        page: () =>  ProfilePage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.contactsMembersRoute,
        page: () =>  MemberList(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.contactsEditProfileRoute,
        page: () =>  EditProfile(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    ///---------------- CRM ----------------///

    GetPage(
        name: Routes.crmContactsRoute,
        page: () =>  ContactsPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.crmOpportunitiesPathRoute,
        page: () =>  OpportunitiesPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    ///---------------- Auth ----------------///

    GetPage(name: Routes.loginRoute, page: () =>  LoginPage(key: UniqueKey(),)),
    GetPage(name: Routes.loginRoute1, page: () =>  Login2(key: UniqueKey(),)),
    GetPage(name: Routes.forgotPasswordRoute, page: () =>  ForgotPassword(key: UniqueKey(),)),
    GetPage(
        name: Routes.forgotPasswordRoute1, page: () =>  ForgotPassword2(key: UniqueKey(),)),
    GetPage(name: Routes.signupRoute, page: () =>  Register(key: UniqueKey(),)),
    GetPage(name: Routes.signupRoute1, page: () =>  Register2(key: UniqueKey(),)),
    GetPage(name: Routes.resetPasswordRoute, page: () =>  ResetPassword(key: UniqueKey(),)),
    GetPage(name: Routes.resetPasswordRoute1, page: () =>  ResetPassword2(key: UniqueKey(),)),
    GetPage(
        name: Routes.lockedRoute,
        page: () =>  LockedPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name:  Routes.lockedRoute1,
        page: () =>  LockedPage2(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    ///---------------- UI ----------------///

    GetPage(
        name: Routes.uiButtonsRoute,
        page: () =>  ButtonsPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.uiCardsRoute,
        page: () =>  CardsPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.uiTabsRoute,
        page: () =>  TabsPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.uiDialogsRoute,
        page: () =>  Dialogs(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.uiCarouselsRoute,
        page: () =>  Carousels(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.uiDragDropRoute,
        page: () =>  DragDropPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.uiNotificationRoute,
        page: () =>  Notifications(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.uiReviewsRoute,
        page: () =>  ReviewsPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    // GetPage(
    //     name: '/ui/discover',
    //     page: () =>  DiscoverJobs(),
    //     middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.uiLandingRoute,
        page: () =>  LandingPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    ///---------------- Error ----------------///

    GetPage(
        name: Routes.comingSoonRoute,
        page: () =>  ComingSoonPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.uiError404Route,
        page: () =>  Error404(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.uiError500Route,
        page: () =>  Error500(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.maintenanceRoute,
        page: () =>  MaintenancePage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    ///---------------- Chat ----------------///

    GetPage(
        name: Routes.uiChatRoute,
        page: () =>  ChatPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    ///---------------- Form ----------------///

    GetPage(
        name: Routes.formBasicRoute,
        page: () =>  BasicPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.formValidationRoute,
        page: () =>  ValidationPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.formQuillEditorRoute,
        page: () =>  QuillEditor(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.formFormMaskRoute,
        page: () =>  FormMaskPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.formWizardRoute,
        page: () =>  Wizard(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    ///---------------- Other ----------------///

    GetPage(
        name: Routes.formBasicRoute,
        page: () =>  BasicTable(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.otherSyncfusionChartsRoute,
        page: () =>  SyncFusionChart(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.otherFlChartRoute,
        page: () =>  FlChartScreen(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    ///---------------- Maps ----------------///

    GetPage(
        name: Routes.mapsSfMapsRoute,
        page: () =>  SfMapPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: Routes.mapsGoogleMapsRoute,
        page: () =>  GoogleMapPage(key: UniqueKey(),),
        middlewares: [AuthMiddleware()]),
  ];
  return routes
      .map(
        (e) => GetPage(
            name: e.name,
            page: e.page,
            middlewares: e.middlewares,
            transition: Transition.noTransition),
      )
      .toList();
}

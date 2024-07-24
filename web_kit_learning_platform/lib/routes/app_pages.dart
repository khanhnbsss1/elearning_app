
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/auth/login/login.dart';
class AppPages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.loginRoute: (context) => const LoginPage(),

  };

  static routeName(String route,
      {
        dynamic arguments,
        //int? id,
        bool? preventDuplicates,
        bool? isReplace,
        Map<String, String>? parameters,
        Function(dynamic)? callback
      }) {
    if (isReplace ?? false) {
      Get.offAllNamed(
          route,
          arguments: arguments,
          parameters: parameters)?.then((value) {
        if (callback != null) {
          callback(value);
        }
      },);
      // Get.reset(clearRouteBindings: true);

    }
    else {
      
      Get.toNamed(
          route,
          arguments: arguments,
         // id: id, 
          preventDuplicates: preventDuplicates ?? false, parameters: parameters)?.then((value) {
        if (callback != null) {
          callback(value);
        }
      },);
    }
  }

  void goBackLogin() {
    routeName(
        Routes.loginRoute,
    );
  }
}
abstract class Routes {
  static const landingPageRoute = Paths.landingPagePath;
  static const homeRoute = Paths.homePath;
  static const loginRoute = Paths.loginPath;
  static const loginRoute1 = Paths.loginPath1;
  static const forgotPasswordRoute = Paths.forgotPasswordPath;
  static const forgotPasswordRoute1 = Paths.forgotPasswordPath1;

  static const signupRoute = Paths.singUpPath;
  static const signupRoute1 = Paths.singUpPath1;
  static const resetPasswordRoute = Paths.resetPasswordPath;
  static const resetPasswordRoute1 = Paths.resetPasswordPath1;
  static const lockedRoute = Paths.lockedPath;
  static const lockedRoute1 = Paths.lockedPath1;

  static const courseList = Paths.courseList;
  static const courseMyList = Paths.courseMyList;
  static const courseDetail = Paths.courseDetail;
  static const vocabularyList = Paths.vocabularyList;
  
  static const vocabularyDetail = Paths.vocabularyDetail;
  static const videoPlayer = Paths.videoPlayer;
  static const lessonList = Paths.lessonList;
  static const uiButtonsRoute = Paths.uiButtonsPath;
  static const uiCardsRoute = Paths.uiCardsPath;
  static const uiTabsRoute = Paths.uiTabsPath;
  static const uiDialogsRoute = Paths.uiDialogsPath;
  static const uiCarouselsRoute = Paths.uiCarouselsPath;
  static const uiDragDropRoute = Paths.uiDragDropPath;

  static const uiNotificationRoute = Paths.uiNotificationPath ;
  static const uiReviewsRoute = Paths.uiReviewsPath ;
  static const uiLandingRoute = Paths.uiLandingPath;
  static const comingSoonRoute = Paths.uiComingSoonPath ;
  static const uiError404Route = Paths.uiError404Path ;
  static const uiError500Route = Paths.uiError500Path ;
  static const maintenanceRoute = Paths.uiMaintenancePath ;
  static const uiChatRoute = Paths.uiChatPath ;
  static const formBasicRoute = Paths.uiFormBasicPath ;
  static const formValidationRoute = Paths.uiFormValidationPath ;
  static const formQuillEditorRoute = Paths.uiFormQuillEditorPath ;
  static const formFormMaskRoute = Paths.uiFormFormMaskPath;
  static const formWizardRoute = Paths.uiFormWizardPath ;
  static const otherBasicTablesRoute = Paths.uiOtherBasicTablesPath ;
  static const otherSyncfusionChartsRoute = Paths.uiOtherSyncfusionChartsPath ;
  static const otherFlChartRoute = Paths.uiOtherFlChartPath ;
  static const mapsSfMapsRoute = Paths.uiMapsSfMapsPath ;
  static const mapsGoogleMapsRoute = Paths.uiMapsGoogleMapsPath ;

  static const faqsRoute = Paths.faqsPath ;
  static const pricingRoute = Paths.pricingPath ;
  static const starterRoute = Paths.starterPath ;
  static const dashboardRoute = Paths.dashboardPath ;
  static const appsEcommerceProductsRoute = Paths.appsEcommerceProductsPath ;
  static const appsEcommerceAddProductRoute = Paths.appsEcommerceAddProductPath ;
  static const appsEcommerceProductsDetailRoute = Paths.appsEcommerceProductsDetailPath ;
  static const appsEcommerceCustomersRoute = Paths.appsEcommerceCustomersPath ;
  static const appsEcommerceInvoiceRoute = Paths.appsEcommerceInvoicePath ;
  static const timelineRoute = Paths.timelinePath ;
  static const appsFilesRoute = Paths.appsFilesPath ;
  static const appsFileUploaderRoute = Paths.appsFileUploaderPath ;
  static const nFTDashboardRoute = Paths.nFTDashboardPath ;
  static const calenderRoute = Paths.calenderPath ;
  static const shoppingCustomerRoute = Paths.shoppingCustomerPath ;
  static const fitnessRoute = Paths.fitnessPath ;
  static const milaBoxRoute = Paths.milaBoxPath ;
  static const kanbanRoute = Paths.kanbanPath ;
  static const projectsProjectListRoute = Paths.projectsProjectListPath ;
  static const projectsProjectDetailRoute = Paths.projectsProjectdetailPath ;
  static const projectsCreateProjectRoute = Paths.projectsCreateProjectPath ;
  static const contactsProfileRoute = Paths.contactsProfilePath ;
  static const contactsMembersRoute = Paths.contactsMembersPath ;
  static const contactsEditProfileRoute = Paths.contactsEditProfilePath ;
  static const crmContactsRoute = Paths.crmContactsPath ;
  static const crmOpportunitiesPathRoute = Paths.crmOpportunitiesPath ;
}

abstract class Paths {
  static const landingPagePath = "/landing_page";
  static const homePath = "/";
  static const loginPath = "/auth/login";
  static const loginPath1 = "/auth/login1";
  static const courseList = '/course/list';
  static const courseMyList = '/course/mylist';
  static const courseDetail = '/course/detail';
  static const videoPlayer = '/videoPlayer';
  static const vocabularyList = '/vocabulary/list';
  static const vocabularyDetail = '/vocabulary/detail';
  static const lessonList = '/lessonList/list';


  static const forgotPasswordPath = '/auth/forgot_password';
  static const forgotPasswordPath1 = '/auth/forgot_password1';
  static const resetPasswordPath = '/auth/reset_password';
  static const resetPasswordPath1 = '/auth/reset_password1';

  static const singUpPath = '/auth/register';
  static const singUpPath1 = '/auth/register1';

  static const lockedPath = '/auth/locked';
  static const lockedPath1 = '/auth/locked1';

  static const uiButtonsPath = '/ui/buttons';
  static const uiCardsPath = '/ui/cards';
  static const uiTabsPath = '/ui/tabs';
  static const uiDialogsPath = '/ui/dialogs';
  static const uiCarouselsPath = '/ui/carousels';
  static const uiDragDropPath = '/ui/drag-drop';
  static const uiNotificationPath = '/ui/notification';
  static const uiReviewsPath = '/ui/reviews';
  static const uiLandingPath = '/ui/landing';
  static const uiComingSoonPath = '/ui/coming-soon';
  static const uiError404Path = '/ui/error-404';
  static const uiError500Path = '/ui/error-500';
  static const uiMaintenancePath = '/maintenance';
  static const uiChatPath = '/chat';

  static const uiFormBasicPath = '/form/basic';
  static const uiFormValidationPath = '/form/validation';
  static const uiFormQuillEditorPath = '/form/quill-editor';
  static const uiFormFormMaskPath = '/form/form-mask';
  static const uiFormWizardPath = '/form/wizard';
  static const uiOtherBasicTablesPath = '/other/basic_tables';
  static const uiOtherSyncfusionChartsPath = '/other/syncfusion_charts';
  static const uiOtherFlChartPath = '/other/fl_chart';
  static const uiMapsSfMapsPath = '/maps/sf-maps';
  static const uiMapsGoogleMapsPath = '/maps/google-maps';

  static const faqsPath = '/faqs';
  static const pricingPath = '/pricing';
  static const starterPath = '/starter';
  static const dashboardPath = '/dashboard';
  static const appsEcommerceProductsPath = '/apps/ecommerce/products';
  static const appsEcommerceAddProductPath = '/apps/ecommerce/add_product';
  static const appsEcommerceProductsDetailPath = '/apps/ecommerce/product-detail';
  static const appsEcommerceCustomersPath = '/apps/ecommerce/customers';
  static const appsEcommerceInvoicePath = '/apps/ecommerce/invoice';
  static const timelinePath = '/timeline';
  static const appsFilesPath = '/apps/files';
  static const appsFileUploaderPath = '/apps/file-uploader';

  static const nFTDashboardPath = '/NFTDashboard';
  static const calenderPath = '/calender';
  static const shoppingCustomerPath = '/shopping-customer';
  static const fitnessPath = '/fitness';
  static const milaBoxPath = '/mila_box';
  static const kanbanPath = '/kanban';
  static const projectsProjectListPath = '/projects/project-list';
  static const projectsProjectdetailPath = '/projects/project-detail';
  static const projectsCreateProjectPath = '/projects/create-project';

  static const contactsProfilePath = '/contacts/profile';
  static const contactsMembersPath = '/contacts/members';
  static const contactsEditProfilePath = '/contacts/edit-profile';

  static const crmContactsPath = '/crm/contacts';
  static const crmOpportunitiesPath = '/crm/opportunities';


}
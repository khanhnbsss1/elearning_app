import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lms_app/base/base.export.dart';

import 'instance_mananger/instance_mananger.dart';

class Constant {
  static String assetImageSvgPath = "assets/svg/";
  static String assetImagePngPath = "assets/png/";

  static bool isDriverApp = false;
  static const String fontsFamily = "Inter";
  static const String fromLogin = "getFromLoginClick";
  static const String homePos = "getTabPos";
  static const int stepStatusNone = 0;
  static const int stepStatusActive = 1;
  static const int stepStatusDone = 2;
  static const int stepStatusWrong = 3;

  static double getPercentSize(double total, double percent) {
    return (percent * total) / 100;
  }

  static backToPrev(BuildContext context) {
    Navigator.pop(context);
  }

  static getCurrency(BuildContext context) {
    return "ETH";
  }

  static pushToPage(BuildContext context, String route, {Object? arguments}) {
    if (arguments != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: AppPages.routes[route]!,
          settings: RouteSettings(name: route, arguments: arguments)
        ),
      );
      //Navigator.pushNamed(context, route, arguments: arguments);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: AppPages.routes[route]!,
            settings: RouteSettings(name: route)
        ),
      );
     // Navigator.pushNamed(context, route);
    }
  }
  static replaceToPage(BuildContext context, String route, {Object? arguments}) {
    if (arguments != null) {
      Navigator.pushReplacementNamed(context, route, arguments: arguments);
    } else {
      Navigator.pushReplacementNamed(context, route);
    }
  }
  Future<dynamic>? route(
      {
        BuildContext? context,
        required String pageName,
        required Widget page,
        bool ?isReplace,
        Object? arguments
      }) async{
    context ??= InstanceManager.getInstance.rootContext;
    isReplace??=true;
    if(context!=null)
    {
      String? name = ModalRoute.of(context)?.settings.name;
      if(name == pageName) {
        /// neu da o trang hien tai thi khong reload nua
        return null;
      }
      Route route = MaterialPageRoute(
          builder: (context) {
            InstanceManager.getInstance.rootContext = context;
            return page;
          },
          settings: RouteSettings(name: pageName, arguments: arguments)
      );
      // WebRouter.setHistoryState(title: pageName,url: pageName, data: null );
      if(isReplace)
      {
        Navigator.pushReplacement(context, route,).then((value) {
          return value;
        },);
      }
      else
      {
        Navigator.push(context, route,).then((value) {
          return value;
        },);
      }

    }
  }

  static double getToolbarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + kToolbarHeight;
  }

  static double getToolbarTopHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static pushToScreen(Widget widget, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  static backToFinish(BuildContext context) {
    Navigator.of(context).pop();
  }

  static closeApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }
}

class IdentifierConst{
  static BiometricTypeDevice biometricType = BiometricTypeDevice.none;
  static String username = "";
  static String password = "";

}
// Loại sinh trắc được hỗ trợ trong device_elearning
enum BiometricTypeDevice {
  fingerprint, face, none
}
class ConstantDefine {
  static const String tokenFireBase =
      "crNX79KY8wk:APA91bH3aO4McSmRHvWpczUy6EQGZpjqmKIhvvQmiOX7o7N39ZbhGe93v09RR9dWXDxZ24EGFgeX8c0YOKpbQXC84xX4RzckWygo7m8XMGtIWgBSIsuF_P08VwXggWqUFAPOW1EMOaK1";
  static const String IMAGE_RESOURCE_ROOT = "assets/images/";

  static const String IMAGE_RESOURCE_CAR_TYPES_STATUS_PNG =
      "${IMAGE_RESOURCE_ROOT}car_types_status/";

  static const String IMAGE_RESOURCE_CAR_TYPES_STATUS_IN_MAP_PNG =
      "${IMAGE_RESOURCE_ROOT}car_types_status_map/";
  static const String PNG_EXTENTION = ".png";

  static const String KEY_ZOOM_VALUE_GOOGLE_MAP = "key_zoom_value_google_map";
  static const String KEY_DEVICEID_TRACKING_ONE = "KEY_DEVICEID_TRACKING_ONE";
  static const String KEY_DEVICEID_TRACKING_ONE_PAGE_INDEX = "KEY_DEVICEID_TRACKING_ONE_PAGE_INDEX";
  static const String KEY_GOOGLE_MAP_KEY = "AIzaSyDtbHgmTaVdV3viQG3mLysPLjhkqo5Pl_8";
  static const String KEY_SETTING_MAP_TYPE = "KEY_SETTING_MAP_TYPE";
  static const String KEY_SETTING_NOTIFY = "key_setting_notify";
  static const String KEY_SETTING_LOCK_APP_IN_BACK_GROUND = "key_setting_LockAppInBackground";
  static const String KEY_SETTING_ENVIROMENT = "key_setting_enviroment";

  static const String KEY_ENABLE_SAVE_ACCOUNT = "key_enable_save_account";
  static const String KEY_LOGOUT_ACCOUNT = "key_logout_account";
  static const String KEY_SHOW_HIDE_MAP_SETTING_PAGE = "KEY_SHOW_HIDE_MAP_SETTING_PAGE";
  static const int GSM_SIGNAL_STANDARD = 1;
  static const int GPS_SIGNAL_STANDARD = 16;
  static const int BATTERY_SIGNAL_STANDARD = 25;
  static const int LIMIT_TRACKING_DATA_BY_DATE_STANDARD = 2;
  static const double ZOOM_DEFAULT_VALUE = 12.0;
  static  double TOOL_BAR_HEIGHT_DEFAULT_VALUE = Dimens.size50;
  static  double SIDE_BAR_WIDTH_DEFAULT_VALUE = Dimens.size70;

  static const bool DEBUG_ENABLE = kDebugMode;
  static const bool route = DEBUG_ENABLE? true: false;

}
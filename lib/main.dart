import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms_app/routes/app_routes.dart';
import 'package:lms_app/screens/home/home_view.dart';
import 'package:lms_app/screens/intro.dart';
import 'package:lms_app/screens/splash.dart';
import 'package:lms_app/services/app_service.dart';
import 'package:lms_app/services/hive_service.dart';
import 'base/author/author_manager.dart';
import 'base/device_elearning/device_manager.dart';
import 'base/firebase_manager/firebase_options.dart';
import 'base/resizer/fetch_pixels.dart';
import 'base/store/cache_storage.dart';
import 'base/theme/colors_app.dart';
import 'base/utils/file_utils.dart';
import 'configs/app_config.dart';
import 'configs/language_config.dart';
import 'core/app.dart';
import 'enviroments/flavor_settings.dart';
import 'generated/l10n.dart';
import 'helper_elearning/localizations/language_helper.dart';
import 'l10n/l10n_extention.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  initialService();
  HiveService.initHive();
  AppService.svgPrecacheImage();
  DeviceInfoModel? deviceInfoModel = await DeviceManager().getDeviceInfo();
  runApp(ProviderScope(
      child:
      EasyLocalization(
        supportedLocales: LanguageConfig.supportedLocales,
        path: 'assets/translations',
        fallbackLocale: LanguageConfig.fallbackLocale,
        startLocale: LanguageConfig.startLocale,
        child: const MyApp(),
      ),
  ));
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FileUtils.PrintLog("Handling a background message: ${message.messageId}");
}

Future<void> initialService() async {
  await SharedPreferencesStorage().initSharedPreferences();
  //FirebaseManager.getInstance.initialFirebase();
  await FlavorSettings().setProductTypeByFlavor();
  await AuthorManager().init();
  await ScreenUtil.ensureScreenSize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    ColorConst.setColorByFlavorType();
    return GetMaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [firebaseObserver],
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      initialRoute: Routes.splashRoute,
      // getPages: getPageRoute(),
      routingCallback: (value) {
        /// call back moi lan chuyen page url
        print(value);
      },
      home: const SplashScreen(),
    );
  }
}
// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lms_app/services/app_service.dart';
// import 'package:lms_app/services/hive_service.dart';
// import 'base/firebase_manager/firebase_options.dart';
// import 'core/app.dart';
// import 'configs/language_config.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   initialService();
//   await EasyLocalization.ensureInitialized();
//   HiveService.initHive();
//   AppService.svgPrecacheImage();
//
//   runApp(
//     ProviderScope(
//       child: EasyLocalization(
//         supportedLocales: LanguageConfig.supportedLocales,
//         path: 'assets/translations',
//         fallbackLocale: LanguageConfig.fallbackLocale,
//         startLocale: LanguageConfig.startLocale,
//         child: const MyApp(),
//       ),
//     ),
//   );
// }

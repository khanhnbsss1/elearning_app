import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms_app/helper/navigator_key.dart';
import 'package:lms_app/helper/services/navigation_service.dart';
import 'package:lms_app/routes/app_routes.dart';
import 'package:lms_app/screens/auth/login.dart';
import 'package:lms_app/screens/intro.dart';
import 'package:lms_app/services/app_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base/author/author_manager.dart';
import 'base/base.export.dart';
import 'base/firebase_manager/firebase_options.dart';
import 'base/resizer/fetch_pixels.dart';
import 'base/store/cache_storage.dart';
import 'base/theme/colors_app.dart';
import 'configs/app_config.dart';
import 'configs/language_config.dart';
import 'core/app.dart';
import 'enviroments/flavor_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'helper/localizations/bloc/main_bloc.dart';
import 'helper/localizations/language_helper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "YAX Chinese",
      options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  initialService();
  AppService.svgPrecacheImage();
  bool firstTimeCheck = await getFirstTime();
  runApp(ProviderScope(
    child: EasyLocalization(
      supportedLocales: LanguageConfig.supportedLocales,
      path: 'assets/translations',
      fallbackLocale: LanguageConfig.fallbackLocale,
      startLocale: LanguageConfig.startLocale,
      child: MyApp(
        firstTimeCheck: firstTimeCheck,
      ),
    ),
  ));
}

Future<void> initialService() async {
  await SharedPreferencesStorage().initSharedPreferences();
  await FlavorSettings().setProductTypeByFlavor();
  await AuthorManager().init();
  await ScreenUtil.ensureScreenSize();
}

Future<bool> getFirstTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? firstTime = prefs.getBool('first_time');

  if (firstTime != null && !firstTime) {
    return true;
  } else {
    return false;
  }
}

class MyApp extends StatefulWidget {
  final bool firstTimeCheck;
  final Function(bool)? onUpdate;

  const MyApp({super.key, required this.firstTimeCheck, this.onUpdate});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Get.updateLocale(context.locale);
    return GetMaterialApp(
          navigatorKey: NavigationService().navigationKey,
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [firebaseObserver],
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: LanguageHelper().getCurrentLocale(),
          routingCallback: (value) {
            if (kDebugMode) {
              print(value);
            }
          },
          home: widget.firstTimeCheck
              ? const LoginScreen(
                  popUpScreen: false,
                )
              : const IntroScreen(),
        );
  }
}

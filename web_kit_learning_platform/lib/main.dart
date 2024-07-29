import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:webkit/routes/app_pages.dart';
import 'package:webkit/routes/routes.dart';
import 'base/author/author_manager.dart';
import 'base/device/device_manager.dart';
import 'base/enviroments/flavor_settings.dart';
import 'base/firebase_manager/firebase_options.dart';
import 'base/resizer/fetch_pixels.dart';
import 'base/store/cache_storage.dart';
import 'base/theme/colors_app.dart';
import 'base/utils/file_utils.dart';
import 'base/widgets/common/responsive_info.dart';
import 'generated/l10n.dart';
import 'helpers/localizations/bloc/main_bloc.dart';
import 'helpers/localizations/language_helper.dart';
import 'helpers/services/navigation_service.dart';
import 'helpers/theme/app_notifier.dart';
import 'helpers/theme/app_style.dart';
import 'helpers/theme/theme_customizer.dart';
import 'l10n/l10n_extention.dart';
import 'package:firebase_core/firebase_core.dart';
import 'landing_page/components/colornotifier.dart';

Future<void> main() async {
  //SmoothWidgetsFlutterBinding.ensureInitialized(); // add this line
  setPathUrlStrategy();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  await initialService();
  AppStyle.init();
  await ThemeCustomizer.init();

  ColorConst.setColorByFlavorType();
  DeviceInfoModel? deviceInfoModel =await DeviceManager().getDeviceInfo();
  // await Translator.clearTrans();
  // Translator.getUnTrans();
  runApp( 
      MultiBlocProvider(
        providers: [
          BlocProvider<MainBloc>(create: (_) => MainBloc(MainState(mainStatus: MainStatus.initial))..add(MainInitEvent()))
        ],
        child:
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ColorNotifier()), 
            ChangeNotifierProvider<AppNotifier>(create: (context) => AppNotifier()),
          ],
          builder: (context, child) {
            return const MyApp();
          },
        )
        
      ));
}
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  FileUtils.PrintLog("Handling a background message: ${message.messageId}");
}
Future<void> initialService()async {
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
    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {
        switch(state.mainStatus){
    
          case MainStatus.initial:
    
            break;
          case MainStatus.onchangeLanguage:
            state.mainStatus = MainStatus.unKnown;
            break;
          case MainStatus.unKnown:
            break;
          case MainStatus.onEnableDarkMode:
          // TODO: Handle this case.
            ColorConst.setColorByFlavorType();
            state.mainStatus = MainStatus.unKnown;
            break;
        }
      },
      builder: (BuildContext context, state)  {
        return GetMaterialApp(
          key: Key(LanguageHelper().getCurrentLocale().languageCode),
          useInheritedMediaQuery: true,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false,
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
              PointerDeviceKind.stylus
            },
          ),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeCustomizer.instance.theme,
          navigatorKey: NavigationService.navigatorKey,
          initialRoute: Routes.dashboardRoute,
          getPages: getPageRoute(),
          routingCallback: (value) {
            /// call back moi lan chuyen page url
            print(value);
          },
          builder: (context, child) {
            ScreenUtil.init(context);
            ResponsiveInfo().init(context);
            NavigationService.registerContext(context, update: true);
            return EasyLoading.init(builder: (context, child) {
              return Directionality(
                textDirection: AppTheme.textDirection,
                child: Overlay(
                  initialEntries: [
                    OverlayEntry(builder: (context) {
                      return Consumer<AppNotifier>(
                          builder: (_, notifier, ___) {
                            return SelectionArea (
                              //key: UniqueKey(),
                                selectionControls: materialTextSelectionControls,
                                child: child ?? Container());
                          });
                    })
                  ],
                ),
              );
            },)(context,child);
            
          },
          localizationsDelegates: const [
            S.delegate,
            L10nX.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: LanguageHelper().supportedLanguages
              .map((language) => (language.scripCode==null)?Locale(language.languageCode!, language.country!):
          Locale.fromSubtags(languageCode: language.languageCode!, countryCode: language.country!,scriptCode: language.scripCode) )
              .toList(),
          locale: LanguageHelper().getCurrentLocale(),
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          // home: ButtonsPage(),
        );
      },
    );


  }
  
}

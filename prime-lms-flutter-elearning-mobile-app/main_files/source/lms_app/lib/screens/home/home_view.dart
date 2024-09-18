import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/screens/home/home_bottom_bar.dart';
import 'package:lms_app/screens/tabs/home_tab/home_tab.dart';
import 'package:lms_app/screens/tabs/profile_tab/profile_tab.dart';
import 'package:lms_app/screens/tabs/search_tab/search_tab.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../theme/theme_provider.dart';
import '../tabs/dictionary/dictionary.dart';
import '../tabs/home_tab/phone_call_button.dart';
import '../tabs/my_courses_tab/my_courses_tab.dart';

final homeTabControllerProvider =
    StateProvider<PageController>((ref) => PageController(initialPage: 0));

final homeShowTelProvider = StateProvider<bool>((ref) => true);

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = ref.watch(homeTabControllerProvider);
    final showTel = ref.watch(homeShowTelProvider);
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      body: Stack(children: [
        PageView(
          allowImplicitScrolling: true,
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeTab(),
            SearchTab(),
            MyCoursesTab(),
            Dictionary(),
            ProfileTab(),
          ],
        ),
        if (showTel) Positioned(
            bottom: 0,
            right: 0,
            child: Stack(children: [
              Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.green,
                  ),
                  child: const PhoneCallButton()),
              Positioned(
                top: 3,
                right: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                      color: Colors.transparent
                    )
                  ),
                  height: 20,
                  width: 20,
                  child: InkWell(
                    onTap: () {
                      ref.read(homeShowTelProvider.notifier).state = false;
                    },
                    child: Icon(Icons.close, size: 16,color: Colors.white,),
                  ),
                ),
              ),
            ])),
      ]),
    );
  }
}

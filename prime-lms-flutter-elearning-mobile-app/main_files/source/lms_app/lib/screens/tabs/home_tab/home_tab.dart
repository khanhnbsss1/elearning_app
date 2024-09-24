import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/screens/tabs/dictionary/dictionary.dart';
import 'package:lms_app/screens/tabs/home_tab/featured_courses_slide.dart';
import 'package:lms_app/screens/tabs/home_tab/top_authors.dart';
import 'package:lms_app/screens/search/search_view.dart';
import 'package:lms_app/screens/tabs/my_courses_tab/my_courses_tab.dart';
import 'package:lms_app/screens/test/test_list_screen.dart';
import 'package:lms_app/utils/next_screen.dart';
import '../../../providers/app_settings_provider.dart';
import '../../../theme/theme_provider.dart';
import '../../all_authors.dart';
import '../../all_courses.dart/courses_view.dart';
import 'featured_courses.dart';
import 'free_courses.dart';
import 'home_categories.dart';
import 'home_latest_courses.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    ref.invalidate(featuredCoursesProvider);
    ref.invalidate(homeCategoriesProvider);
    ref.invalidate(freeCoursesProvider);
    ref.invalidate(topAuthorsProvider);
    ref.invalidate(homeLatestCoursesProvider);
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    int padding = 30;
    double spacing = 12;
    double itemWidth =
        (MediaQuery.of(context).size.width - spacing - padding * 2) / 2;
    List<String> title = [
      'all-courses',
      'free-courses',
      'lets-study',
      'tests',
      'instructor',
      'dictionary',
    ];
    List<Image> images = [
      Image.asset('assets/images/online-course.png'),
      Image.asset('assets/images/free (2).png'),
      Image.asset('assets/images/reading.png'),
      Image.asset('assets/images/test.png'),
      Image.asset('assets/images/teacher1.png'),
      Image.asset('assets/images/dictionary (1).png'),
    ];
    List<Widget> func = [
      AllCoursesView(),
      AllCoursesView(mode: "Free",),
      MyCoursesTab(),
      TestListScreen(),
      AllAuthors(),
      Dictionary(),
    ];
    return RefreshIndicator.adaptive(
      displacement: 60,
      onRefresh: () async {
        ref.invalidate(featuredCoursesProvider);
        ref.invalidate(homeCategoriesProvider);
        ref.invalidate(freeCoursesProvider);
        ref.invalidate(topAuthorsProvider);
        ref.invalidate(homeLatestCoursesProvider);
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            // title: const AppLogo(
            //   size: 45,
            // ),
            pinned: false,
            floating: true,
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                style: IconButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                onPressed: () {
                  NextScreen.iOS(context, const SearchScreen());
                },
                icon: const Icon(FeatherIcons.search, size: 22),
              ),
              // IconButton(
              //   style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              //   onPressed: () {
              //     NextScreen.iOS(context, const Wishlist());
              //   },
              //   icon: const Icon(FeatherIcons.heart, size: 22),
              // ),
              // IconButton(
              //   // style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              //   onPressed: () {
              //     NextScreen.iOS(context, const Notifications());
              //   },
              //   icon: const Icon(LineIcons.bell),
              // ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  spacing: 30,
                  runSpacing: spacing,
                  direction: Axis.horizontal,
                  children: List.generate(
                      6,
                      (index) => functionItem(
                            context: context,
                            isDarkMode: isDarkMode,
                            width: itemWidth,
                            text: title[index].tr(),
                            image: images[index],
                            func: () => NextScreen.iOS(context, func[index]),
                          )),
                ),
                Visibility(
                    visible: settings?.featured ?? false,
                    child: const FeaturedCourses()),
                Visibility(
                    visible: settings?.featured ?? true,
                    child: const FeaturedCoursesSlide()),
                // Visibility(visible: settings?.categories ?? true, child: const HomeCategories()),
                Visibility(
                    visible: settings?.freeCourses ?? true,
                    child: const FreeCourses()),
                // if (settings != null && settings.homeCategory1 != null) Category1Courses(category: settings.homeCategory1!),
                // if (settings != null && settings.homeCategory2 != null) Category2Courses(category: settings.homeCategory2!),
                // if (settings != null && settings.homeCategory3 != null) Category3Courses(category: settings.homeCategory3!),
                Visibility(
                    visible: settings?.topAuthors ?? true,
                    child: const TopAuthors()),
                Visibility(
                    visible: settings?.latestCourses ?? true,
                    child: const HomeLatestCourses()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget functionItem(
      {required BuildContext context,
      bool? isDarkMode,
      double? height,
      double? width,
      String? text,
      IconData? icon,
      Image? image,
      required Function() func}) {
    return GestureDetector(
        onTap: func,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: (isDarkMode != true)
                  ? Theme.of(context).primaryColor.withOpacity(0.05)
                  : Colors.black.withOpacity(0.1)),
          height: height ?? 120,
          width: width == null
              ? 150
              : width > 200
                  ? 200
                  : width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 75,
                  width: width == null
                      ? 100
                      : width > 200
                          ? 100
                          : width * 2/3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (image == null)
                        ? Icon(
                            icon ?? Icons.add_alert_sharp,
                            size: 50,
                            color: Theme.of(context).primaryColor,
                          )
                        : image,
                  )),
              Container(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  text ?? "",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      // color: (isDarkMode != true) ? Colors.black : Colors.white
                      color: Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
        ));
  }
}

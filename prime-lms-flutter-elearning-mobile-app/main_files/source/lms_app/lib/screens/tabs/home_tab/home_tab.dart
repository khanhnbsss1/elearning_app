import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/components/app_logo.dart';
import 'package:lms_app/screens/tabs/dictionary/dictionary.dart';
import 'package:lms_app/screens/tabs/home_tab/top_authors.dart';
import 'package:lms_app/screens/notifications/notifications.dart';
import 'package:lms_app/screens/search/search_view.dart';
import 'package:lms_app/screens/tabs/my_courses_tab/my_courses_tab.dart';
import 'package:lms_app/screens/test/test_list_screen.dart';
import 'package:lms_app/screens/wishlist.dart';
import 'package:lms_app/utils/next_screen.dart';
import '../../../providers/app_settings_provider.dart';
import '../../all_authors.dart';
import '../../all_courses.dart/courses_view.dart';
import 'category1_courses.dart';
import 'category2_courses.dart';
import 'category3_courses.dart';
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
    int padding = 30;
    double spacing = 12;
    double itemWidth =
        (MediaQuery.of(context).size.width - spacing - padding * 2) / 2;
    List<String> title = [
      'all-courses',
      'free-courses',
      'dictionary',
      'tests',
      'instructors',
      'my-courses',
    ];
    List<IconData> icons = [
      FeatherIcons.fileText,
      FeatherIcons.dollarSign,
      FeatherIcons.book,
      FeatherIcons.edit,
      FeatherIcons.users,
      FeatherIcons.bookOpen,
    ];
    List<dynamic> func = const [
      AllCoursesView(filter: 'All'),
      AllCoursesView(filter: 'free_course'),
      Dictionary(),
      TestListScreen(),
      AllAuthors(),
      MyCoursesTab(),
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
      child: Container(
        color: Colors.black.withOpacity(0.05),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const AppLogo(
                size: 55,
              ),
              pinned: false,
              floating: true,
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              foregroundColor: Colors.white,
              actions: [
                IconButton(
                  // style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
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
                    spacing: spacing,
                    runSpacing: spacing,
                    direction: Axis.horizontal,
                    children: List.generate(
                        6,
                        (index) => functionItem(
                              context: context,
                              width: itemWidth,
                              text: title[index].tr(),
                              icon: icons[index], func: () => NextScreen.iOS(context,func[index] ),
                            )),
                  ),
                  Visibility(
                      visible: settings?.featured ?? true,
                      child: const FeaturedCourses()),
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
      ),
    );
  }

  Widget functionItem(
      {required BuildContext context,
      double? height,
      double? width,
      String? text,
      IconData? icon,
        required Function() func}) {
    return InkWell(
      onTap: func,
        child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      height: height ?? 120,
      width: width == null ? 150 : width > 200 ? 200 : width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              child: Icon(
            icon ?? Icons.add_alert_sharp,
            size: 50,
            color: Theme.of(context).primaryColor,
          )),
          Container(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              text ?? "",
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.clip,
            ),
          )
        ],
      ),
    ));
  }
}

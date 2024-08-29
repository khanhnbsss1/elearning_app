import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/screens/all_courses.dart/seach_courses_view.dart';
import 'package:lms_app/services/api_service.dart';
import '../../../services/apis/course/course_fillter/models/course_filtter_info.dart';
import '../../../utils/next_screen.dart';
import '../../all_courses.dart/courses_view.dart';
import '../../home/home_bottom_bar.dart';
import '../../home/home_view.dart';
import 'home_categories.dart';

final courseFilterInfoProvider =
    StateProvider<CourseFilterInfo>((ref) => CourseFilterInfo());

class SearchCategories extends ConsumerWidget {
  const SearchCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseFilterInfo = ref.watch(courseFilterInfoProvider);
    SubFilterInfo? subFilterInfo = SubFilterInfo();
    final categories = ref.watch(homeCategoriesProvider);
    return (categories.hasValue == true)
        ? Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'categories',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ).tr(),
                      // TextButton(
                      //   onPressed: () {
                      //     ref.read(navBarIndexProvider.notifier).state = 1;
                      //     ref
                      //         .read(homeTabControllerProvider.notifier)
                      //         .state
                      //         .animateToPage(1,
                      //             duration: const Duration(milliseconds: 250),
                      //             curve: Curves.easeIn);
                      //   },
                      //   style: TextButton.styleFrom(
                      //       padding: const EdgeInsets.all(0)),
                      //   child: Text(
                      //     'view-all',
                      //     style: Theme.of(context).textTheme.bodyMedium,
                      //   ).tr(),
                      // )
                    ],
                  ),
                  const SizedBox(height: 10),
                  categories.when(
                      skipLoadingOnRefresh: false,
                      data: (categories) {
                        return Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: categories!
                                    .map((e) => Padding(
                                      padding: const EdgeInsets.only(right: 4.0),
                                      child: ActionChip(
                                            // onPressed: () =>
                                            // NextScreen.iOS(
                                            //   context,
                                            //   AllCoursesView(
                                            //     filter: e.name ?? "",
                                            //   ),
                                            // ),
                                            onPressed: () {
                                              ref.read(courseFilterInfoProvider.notifier).state = e;
                                              if (e.subFilter?.length == 0) {
                                                return NextScreen.normal(
                                                  context,
                                                  AllCoursesView(
                                                    filter: e.name ?? "",
                                                  ));
                                              }
                                            },
                                            backgroundColor: (e.name == courseFilterInfo.name) ? Theme.of(context).primaryColor.withOpacity(0.5) : Colors.white,
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 6),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            label: Text(
                                              e.name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                    ))
                                    .toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            (courseFilterInfo.subFilter != [] &&
                                    courseFilterInfo.subFilter != null)
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: courseFilterInfo.subFilter!
                                          .map((e1) => Padding(
                                            padding: const EdgeInsets.only(right: 4.0),
                                            child: ActionChip(
                                                  onPressed: () {
                                                    subFilterInfo = e1;
                                                    NextScreen.iOS(
                                                      context,
                                                      AllCoursesView(
                                                        filter: courseFilterInfo
                                                            .name ?? "ALL",
                                                        subFilterInfo: e1,
                                                      ),
                                                    );
                                                  },
                                                  elevation: 0,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 2,
                                                          horizontal: 2),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                                                    label: Text(
                                                    e1.name!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600),
                                                  ),
                                                ),
                                          ))
                                          .toList(),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        );
                      },
                      error: (e, x) => Text('error: $e, $x'),
                      loading: () => const LoadingTile(height: 100, padding: 0)),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}

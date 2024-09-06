import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/screens/all_courses.dart/seach_courses_view.dart';
import 'package:lms_app/screens/all_courses.dart/search_result.dart';
import 'package:lms_app/services/api_service.dart';
import '../../../services/apis/course/course_fillter/models/course_filtter_info.dart';
import '../../../utils/next_screen.dart';
import '../../all_courses.dart/courses_view.dart';
import '../../home/home_bottom_bar.dart';
import '../../home/home_view.dart';
import 'home_categories.dart';

final courseFilterInfoProvider =
    StateProvider<CourseFilterInfo>((ref) => CourseFilterInfo(name: "All"));

final subFilterInfoProvider =
    StateProvider<SubFilterInfo>((ref) => SubFilterInfo());

final authorFilterProvider =
    StateProvider<SubFilterInfo>((ref) => SubFilterInfo());

class SearchCategories extends ConsumerStatefulWidget {
  const SearchCategories({super.key});

  @override
  ConsumerState<SearchCategories> createState() => _SearchCategoriesState();
}

class _SearchCategoriesState extends ConsumerState<SearchCategories> {
  bool showCategories = true;

  @override
  Widget build(BuildContext context) {
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
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showCategories = !showCategories;
                            });
                          },
                          child: Text(
                            'Categories',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showCategories = !showCategories;
                            });
                          },
                          child: Text(
                            'Author',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                      ),
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
                        return showCategories
                            ? getCategories(categories)
                            : getAuthor(categories);
                      },
                      error: (e, x) => Text('error: $e, $x'),
                      loading: () =>
                          const LoadingTile(height: 100, padding: 0)),
                ],
              ),
            ),
          )
        : const SizedBox();
  }

  Widget getCategories(List<CourseFilterInfo>? categories) {
    final courseFilterInfo = ref.watch(courseFilterInfoProvider);
    final subFilterInfo = ref.watch(subFilterInfoProvider);
    final authorFilterInfo = ref.watch(authorFilterProvider);
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories!
                .map((e) => (e.filterType != "AUTHOR")
                    ? Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: ActionChip(
                          onPressed: () {
                            if (e.id == courseFilterInfo.id) {
                              ref
                                  .refresh(courseFilterInfoProvider.notifier)
                                  .state;
                              ref.refresh(subFilterInfoProvider.notifier).state;
                            } else {
                              ref
                                  .read(courseFilterInfoProvider.notifier)
                                  .state = e;
                              ref.read(subFilterInfoProvider.notifier).state =
                                  SubFilterInfo();
                            }
                          },
                          backgroundColor: (e.name == courseFilterInfo.name)
                              ? Theme.of(context).primaryColor.withOpacity(0.5)
                              : Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          label: Text(
                            e.name!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    : const SizedBox())
                .toList(),
          ),
        ),
        (courseFilterInfo.subFilter != [] && courseFilterInfo.subFilter != null)
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: courseFilterInfo.subFilter!
                      .map((e1) => Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: ActionChip(
                              onPressed: () {
                                if (e1.id == subFilterInfo.id) {
                                  ref
                                      .refresh(subFilterInfoProvider.notifier)
                                      .state;
                                } else {
                                  ref
                                      .read(subFilterInfoProvider.notifier)
                                      .state = e1;
                                }
                              },
                              backgroundColor: (e1.id == subFilterInfo.id)
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5)
                                  : Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              label: Text(
                                e1.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )
            : const SizedBox(),
        const SizedBox(
          height: 8,
        ),
        SearchResult(
          paddingAll: 0,
          producerId: authorFilterInfo.id,
          filter: courseFilterInfo.name ?? "All",
          subFilterInfo: subFilterInfo,
          gridStyle: GridStyle.grid,
        )
      ],
    );
  }

  Widget getAuthor(List<CourseFilterInfo>? categories) {
    final courseFilterInfo = ref.watch(courseFilterInfoProvider);
    final subFilterInfo = ref.watch(subFilterInfoProvider);
    final authorFilterInfo = ref.watch(authorFilterProvider);
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories!
                .map((e) => (e.filterType == "AUTHOR")
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: e.subFilter!
                              .map((e1) => Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: ActionChip(
                                      onPressed: () {
                                        if (e1.id == authorFilterInfo.id) {
                                          ref
                                              .refresh(
                                                  authorFilterProvider.notifier)
                                              .state;
                                        } else {
                                          ref
                                              .read(
                                                  authorFilterProvider.notifier)
                                              .state = e1;
                                        }
                                      },
                                      backgroundColor:
                                          (e1.id == authorFilterInfo.id)
                                              ? Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.5)
                                              : Colors.white,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 2),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      label: Text(
                                        e1.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      )
                    : const SizedBox())
                .toList(),
          ),
        ),
        SearchResult(
          paddingAll: 0,
          producerId: authorFilterInfo.id,
          filter: courseFilterInfo.name ?? "All",
          subFilterInfo: subFilterInfo,
          gridStyle: GridStyle.grid,
        )
      ],
    );
  }
}

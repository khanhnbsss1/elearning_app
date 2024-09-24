import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/screens/all_courses.dart/search_result.dart';
import '../../../services/apis/course/course_fillter/models/course_filtter_info.dart';
import '../../all_courses.dart/courses_view.dart';
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

class _SearchCategoriesState extends ConsumerState<SearchCategories>
    with TickerProviderStateMixin {
  int selectedCategory = 0;

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  final _tabs = [
    const Tab(text: 'Categories'),
    const Tab(text: 'Author'),
  ];

  List<String> items = [
    "Category",
    "Author",
  ];

  /// List of body icon
  List<String> icons = ["assets/png/tag.png", "assets/png/school.png"];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(homeCategoriesProvider);
    return (categories.hasValue == true)
        ? categories.when(
            skipLoadingOnRefresh: false,
            data: (categories) {
              return Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: kToolbarHeight + 8.0,
                        padding: const EdgeInsets.only(
                            top: 16.0, right: 16.0, left: 16.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                        ),
                        child: TabBar(
                          onTap: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                          controller: _controller,
                          indicator: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0)),
                              color: Colors.white),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.white,
                          tabs: const [
                            Tab(text: 'Categories'),
                            Tab(text: 'Author'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      selectedCategory == 0
                          ? getCategories(categories)
                          : getAuthor(categories),
                    ],
                  ),
                ),
              );
            },
            error: (e, x) => Text('error: $e, $x'),
            loading: () => Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: const LoadingTile(height: 100, padding: 0)),
          )
        : const SizedBox();
  }

  Widget getCategories(List<CourseFilterInfo>? categories) {
    final courseFilterInfo = ref.watch(courseFilterInfoProvider);
    final subFilterInfo = ref.watch(subFilterInfoProvider);
    final authorFilterInfo = ref.watch(authorFilterProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories!
                .map((e) => (e.filterType != "AUTHOR")
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
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
                            padding: const EdgeInsets.symmetric(horizontal: 4),
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
                                  vertical: 6, horizontal: 6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              label: Text(
                                e1.name!,
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
              )
            : const SizedBox(),
        const SizedBox(
          height: 10,
        ),
        SearchResult(
          paddingAll: 0,
          gradeId: (courseFilterInfo.name == "Grade" && subFilterInfo.id != null) ? subFilterInfo.id : null,
          categoryId: (courseFilterInfo.name == "Category" && subFilterInfo.id != null) ? subFilterInfo.id : null,
          typePayment: (courseFilterInfo.name == "High Payment" || courseFilterInfo.name == "Low Payment") ? courseFilterInfo.name : null,
          mode: (courseFilterInfo.name == "Free" || courseFilterInfo.name == "Premium") ? courseFilterInfo.name : null,
          producerName: authorFilterInfo.name,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ActionChip(
                  onPressed: () {
                    ref.read(authorFilterProvider.notifier).state =
                        SubFilterInfo();
                  },
                  backgroundColor: (authorFilterInfo.id == SubFilterInfo().id)
                      ? Theme.of(context).primaryColor.withOpacity(0.5)
                      : Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: Text(
                    "All",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Row(
                children: categories!
                    .map((e) => (e.filterType == "AUTHOR")
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: e.subFilter!
                                  .map((e1) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: ActionChip(
                                          onPressed: () {
                                            if (e1.id == authorFilterInfo.id) {
                                              ref
                                                  .refresh(authorFilterProvider
                                                      .notifier)
                                                  .state;
                                            } else {
                                              ref
                                                  .read(authorFilterProvider
                                                      .notifier)
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
                                              vertical: 6, horizontal: 6),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          label: Text(
                                            e1.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          )
                        : const SizedBox())
                    .toList(),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SearchResult(
          paddingAll: 0,
          producerName: authorFilterInfo.name,
          gridStyle: GridStyle.grid,
        )
      ],
    );
  }
}

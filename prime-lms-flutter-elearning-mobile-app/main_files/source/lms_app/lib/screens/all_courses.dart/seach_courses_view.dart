import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/ads/ad_manager.dart';
import 'package:lms_app/ads/banner_ad.dart';
import 'package:lms_app/components/loading_grid_tile.dart';
import 'package:lms_app/configs/app_assets.dart';
import 'package:lms_app/constants/custom_colors.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/screens/all_courses.dart/grid_list_course_tile.dart';
import 'package:lms_app/screens/search/search_view.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/theme/theme_provider.dart';
import 'package:lms_app/utils/empty_animation.dart';
import 'package:lms_app/utils/loading_widget.dart';
import 'package:lms_app/utils/next_screen.dart';
import '../../services/apis/course/course_fillter/models/course_filtter_info.dart';
import 'courses_view.dart';
import 'grid_course_tile.dart';

final gridStyleProvider = StateProvider<GridStyle>((ref) => GridStyle.grid);

class SearchCoursesView extends ConsumerStatefulWidget {
  const SearchCoursesView({super.key, required this.filter, this.subFilterInfo});

  // final CourseFilterInfo courseFilterInfo;
  final String filter;
  final SubFilterInfo? subFilterInfo;

  @override
  ConsumerState<SearchCoursesView> createState() => _SearchCoursesViewState();
}

class _SearchCoursesViewState extends ConsumerState<SearchCoursesView> {
  List<CourseInfo> _courses = [];
  bool _hasData = false;
  bool _isLoading = true;
  int _pageNumber = 0;
  bool lastPage = false;
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: 0.0);
    _controller.addListener(_scrollListener);
    if (widget.subFilterInfo != null) {
      _getCourse(widget.filter, _pageNumber, widget.subFilterInfo!.id.toString());
    } else {
      _getCourse(widget.filter, _pageNumber, "");
    }
  }

  _scrollListener() async {
    var isEnd = _controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange;
    if (isEnd) {
      if (!lastPage) _loadMore();
    }
  }

  Future<void> _loadMore() async {
    setState(() {
      _pageNumber++;
      if (widget.subFilterInfo != null) {
        _getCourse(widget.filter, _pageNumber, widget.subFilterInfo!.id.toString());
      } else {
        _getCourse(widget.filter, _pageNumber, "");
      }
    });
  }

  Future<void> _getCourse(
      String filter, int pageNumber, String subFilterId) async {
    final List<CourseInfo>? courses = await ApiService()
        .getCourseByCategories(
        pageNumber: pageNumber, filter: filter.replaceAll(" ", "_"), subFilterId: subFilterId);
    if (_courses != [] && courses != [] && courses != null) {
      setState(() {
        _isLoading = false;
        _courses = _courses + courses;
      });
    } else {
      lastPage = true;
      setState(() {
        _isLoading = false;
        courses ?? [];
      });
    }
  }

  _onRefresh() async {
    _isLoading = true;
    _courses.clear();
    _hasData = false;
    setState(() {});
    await _getCourse(widget.filter, 0, "");
  }

  @override
  Widget build(BuildContext context) {
    print("rebuilt");
    final gridStyle = ref.watch(gridStyleProvider);
    return RefreshIndicator(
        onRefresh: () async => await _onRefresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _controller,
          child: Column(
            children: [
              FilterContainer(gridStyle: gridStyle, ref: ref),
              _isLoading
                  ? LoadingGridTile(gridStyle: gridStyle)
                  : _courses.isEmpty
                  ? EmptyAnimation(
                  animationString: emptyAnimation,
                  title: 'no-course'.tr())
                  : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridStyle == GridStyle.grid ? 2 : 1,
                  mainAxisExtent: gridStyle == GridStyle.grid
                      ? 250
                      : gridStyle == GridStyle.box
                      ? 300
                      : 170,
                  childAspectRatio: gridStyle == GridStyle.grid
                      ? 0.68
                      : gridStyle == GridStyle.box
                      ? 1.3
                      : 2.1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: _courses.length,
                itemBuilder: (BuildContext context, int index) {
                  final CourseInfo course = _courses[index];
                  if (gridStyle == GridStyle.list) {
                    return GridListCourseTile(course: course);
                  }
                  return GridCourseTile(
                      course: course, gridStyle: gridStyle);
                },
              ),
              Opacity(
                opacity: _hasData ? 1.0 : 0.0,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: LoadingIndicatorWidget(),
                ),
              ),
            ],
          ),
        ),
      );
  }
}

class FilterContainer extends StatelessWidget {
  const FilterContainer({
    super.key,
    required this.gridStyle,
    required this.ref,
  });

  final GridStyle gridStyle;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    return Container(
      height: 50,
      color: isDarkMode ? CustomColor.containerDark : CustomColor.container,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              FeatherIcons.grid,
              size: 22,
              color: gridStyle == GridStyle.grid
                  ? Colors.blueAccent
                  : Colors.blueGrey,
            ),
            onPressed: () => ref
                .read(gridStyleProvider.notifier)
                .update((state) => GridStyle.grid),
          ),
          IconButton(
            icon: Icon(
              FeatherIcons.square,
              size: 22,
              color: gridStyle == GridStyle.box
                  ? Colors.blueAccent
                  : Colors.blueGrey,
            ),
            onPressed: () => ref
                .read(gridStyleProvider.notifier)
                .update((state) => GridStyle.box),
          ),
          IconButton(
            icon: Icon(
              FeatherIcons.list,
              size: 22,
              color: gridStyle == GridStyle.list
                  ? Colors.blueAccent
                  : Colors.blueGrey,
            ),
            onPressed: () => ref
                .read(gridStyleProvider.notifier)
                .update((state) => GridStyle.list),
          ),
        ],
      ),
    );
  }
}

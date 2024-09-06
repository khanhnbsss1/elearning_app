import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/loading_grid_tile.dart';
import '../../configs/app_assets.dart';
import '../../constants/custom_colors.dart';
import '../../services/api_service.dart';
import '../../services/apis/course/course_detail/models/course_detail_model.dart';
import '../../services/apis/course/course_fillter/models/course_filtter_info.dart';
import '../../theme/theme_provider.dart';
import '../../utils/empty_animation.dart';
import '../../utils/loading_widget.dart';
import '../tabs/home_tab/search_categories.dart';
import 'courses_view.dart';
import 'grid_course_tile.dart';
import 'grid_list_course_tile.dart';

class SearchResult extends ConsumerStatefulWidget {
  SearchResult(
      {super.key,
        this.paddingAll,
      required this.filter,
      required this.subFilterInfo,
        this.producerId,
      required this.gridStyle});

  double? paddingAll;
  int? producerId;
  final String filter;
  final SubFilterInfo? subFilterInfo;
  final GridStyle gridStyle;

  @override
  ConsumerState<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends ConsumerState<SearchResult> {
  List<CourseInfo> _courses = [];
  bool _hasData = false;
  bool _isLoading = true;
  int _pageNumber = 0;
  bool lastPage = false;
  late ScrollController _controller;

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filter != widget.filter || oldWidget.subFilterInfo != widget.subFilterInfo || oldWidget.producerId != widget.producerId) {
      _onRefresh();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: 0.0);
    _controller.addListener(_scrollListener);
    _getCourse(widget.filter, _pageNumber);
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
      _getCourse(widget.filter, _pageNumber);
    });
  }

  Future<void> _getCourse(
      String filter, int pageNumber, ) async {
    final List<CourseInfo>? courses = await ApiService().getCourseByCategories(
        pageNumber: pageNumber,
        filter: filter.replaceAll(" ", "_"),
        producerId: widget.producerId,
        subFilterId: widget.subFilterInfo!.id == null ? "" : widget.subFilterInfo!.id.toString());
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
    await _getCourse(widget.filter, 0);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await _onRefresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _controller,
        child: Column(
          children: [
            // FilterContainer(gridStyle: widget.gridStyle, ref: ref),
            _isLoading
                ? LoadingGridTile(gridStyle: widget.gridStyle, paddingAll: widget.paddingAll,)
                : _courses.isEmpty
                    ? EmptyAnimation(
                        animationString: emptyAnimation,
                        title: 'no-course'.tr())
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(widget.paddingAll??20),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              widget.gridStyle == GridStyle.grid ? 2 : 1,
                          mainAxisExtent: widget.gridStyle == GridStyle.grid
                              ? 250
                              : widget.gridStyle == GridStyle.box
                                  ? 300
                                  : 170,
                          childAspectRatio: widget.gridStyle == GridStyle.grid
                              ? 0.68
                              : widget.gridStyle == GridStyle.box
                                  ? 1.3
                                  : 2.1,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: _courses.length,
                        itemBuilder: (BuildContext context, int index) {
                          final CourseInfo course = _courses[index];
                          if (widget.gridStyle == GridStyle.list) {
                            return GridListCourseTile(course: course);
                          }
                          return GridCourseTile(
                              course: course, gridStyle: widget.gridStyle);
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

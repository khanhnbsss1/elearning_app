import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/ads/ad_manager.dart';
import 'package:lms_app/ads/banner_ad.dart';
import 'package:lms_app/screens/all_courses.dart/search_result.dart';
import 'package:lms_app/screens/search/search_view.dart';
import 'package:lms_app/utils/next_screen.dart';
import '../../services/apis/course/course_fillter/models/course_filtter_info.dart';

enum GridStyle { grid, box, list }

final gridStyleProvider = StateProvider<GridStyle>((ref) => GridStyle.grid);

class AllCoursesView extends ConsumerStatefulWidget {
  const AllCoursesView({super.key, required this.filter, this.subFilterInfo});

  // final CourseFilterInfo courseFilterInfo;
  final String filter;
  final SubFilterInfo? subFilterInfo;

  @override
  ConsumerState<AllCoursesView> createState() => _AllCoursesViewState();
}

class _AllCoursesViewState extends ConsumerState<AllCoursesView> {
  Widget build(BuildContext context) {
    final gridStyle = ref.watch(gridStyleProvider);
    return Scaffold(
      appBar: AppBar(
        title: (widget.filter == "All") ? Text('latest-courses'.tr()) : (widget.subFilterInfo == null) ? Text(widget.filter.replaceAll("_", " ")) : Text(widget.subFilterInfo!.name!.toUpperCase()),
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
        centerTitle: true,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(FeatherIcons.chevronLeft)),
        actions: [
          IconButton(
            style:
                IconButton.styleFrom(padding: const EdgeInsets.only(right: 10)),
            icon: const Icon(FeatherIcons.search),
            onPressed: () => NextScreen.normal(context, const SearchScreen()),
          ),
        ],
      ),
      bottomNavigationBar:
          AdManager.isBannerEnbaled(ref) ? const BannerAdWidget() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FilterContainer(gridStyle: gridStyle, ref: ref),
            SearchResult(filter: widget.filter, subFilterInfo: widget.subFilterInfo??SubFilterInfo(), gridStyle: gridStyle,),
          ],
        )
      ),
    );
  }
}


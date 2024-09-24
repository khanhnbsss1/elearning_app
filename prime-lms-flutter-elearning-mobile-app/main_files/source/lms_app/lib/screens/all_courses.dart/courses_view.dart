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
  AllCoursesView(
      {super.key,
      this.gradeId,
      this.categoryId,
      this.typePayment,
      this.mode,
      this.keyword,
      this.producerName,
      this.title});

  int? gradeId;
  int? categoryId;
  String? typePayment;
  String? mode;
  String? keyword;
  String? producerName;
  String? title;

  @override
  ConsumerState<AllCoursesView> createState() => _AllCoursesViewState();
}

class _AllCoursesViewState extends ConsumerState<AllCoursesView> {
  Widget build(BuildContext context) {
    final gridStyle = ref.watch(gridStyleProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title ?? ""}'),
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
          SearchResult(
            gradeId: widget.gradeId,
            categoryId: widget.categoryId,
            typePayment: widget.typePayment,
            mode: widget.mode,
            keyword: widget.keyword,
            gridStyle: gridStyle,
          ),
        ],
      )),
    );
  }
}

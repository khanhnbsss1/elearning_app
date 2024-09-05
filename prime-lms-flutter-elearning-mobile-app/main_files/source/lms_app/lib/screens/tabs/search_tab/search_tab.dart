import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/models/tag.dart';
import 'package:lms_app/screens/search/search_view.dart';
import 'package:lms_app/screens/tabs/home_tab/home_categories.dart';
import 'package:lms_app/screens/tabs/home_tab/search_categories.dart';
import 'package:lms_app/screens/tabs/home_tab/search_categories_2.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/screens/tabs/search_tab/popular_tags.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/services/apis/tags/models/tag_info.dart';
import 'package:lms_app/utils/next_screen.dart';
import '../../../components/loading_tile.dart';

// final searchTagsProvider = FutureProvider.autoDispose<List<Tag>>((ref) async {
//   final tags = await FirebaseService().getAllTags(10);
//   return tags;
// });

// final categoriesProvider =
//     FutureProvider.autoDispose<List<TagsInfo>>((ref) async {
//   final List<TagsInfo> categories = await ApiService().getAllCategories();
//   return categories;
// });

class SearchTab extends ConsumerWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final categories = ref.watch(categoriesProvider);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: InkWell(
            onTap: () => NextScreen.iOS(context, const SearchScreen()),
            child: Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey, width: 0.5),
                borderRadius: BorderRadius.circular(120),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'search-course',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ).tr(),
                  const Icon(FeatherIcons.search, size: 20),
                ],
              ),
            ),
          ),
        ),
        // body: categories.when(
        //   data: (categories) {
        //     return RefreshIndicator.adaptive(
        //       onRefresh: () async {
        //         ref.invalidate(categoriesProvider);
        //       },
        //       child: SingleChildScrollView(
        //         physics: const AlwaysScrollableScrollPhysics(),
        //         padding: const EdgeInsets.all(20),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Visibility(
        //               visible: true,
        //               child: PopularTags(tags: categories),
        //             ),
        //             // CategoriesLayout2(categories: category)
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        //   error: (e, x) => Text('error: $e, $x'),
        //   loading: () => const LoadingTile(height: 260),
        // )
      body: const SearchCategories2(),
    );
  }
}

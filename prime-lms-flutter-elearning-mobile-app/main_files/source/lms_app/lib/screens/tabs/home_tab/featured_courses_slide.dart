import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/screens/tabs/home_tab/featured_courses.dart';
import 'package:lms_app/services/api_service.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/utils/next_screen.dart';
import '../../../components/featured_course_tile.dart';
import '../../../components/horizontal_course_tile.dart';
import '../../../theme/theme_provider.dart';
import '../../all_courses.dart/courses_view.dart';

class FeaturedCoursesSlide extends ConsumerWidget {
  const FeaturedCoursesSlide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(featuredCoursesProvider);
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    return courses.when(
        skipLoadingOnRefresh: false,
        data: (courses) {
          return (courses.isNotEmpty && courses != []) ? Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RichText(
                            text: TextSpan(
                              text: 'course-interest'.tr(),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                            )
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () => NextScreen.iOS(context, AllCoursesView(typePayment: "High Payment",title: 'featured-courses'.tr(),)),
                      //   // onPressed: () {},
                      //   style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                      //   child: Text(
                      //     'view-all',
                      //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      //         // color: (isDarkMode != true) ? Colors.black : Colors.white
                      //         color: Colors.black,
                      //     ),
                      //   ).tr(),
                      // )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: courses.take(5).map((course) {
                      return HorizontalCourseTile(course: course,widthPercentage: 0.60, imageHeight: 130, isDarkMode: isDarkMode, isFeatured: true,);
                    }).toList(),
                  ),
                )
              ],
            ),
          ) : const SizedBox();
        },
        error: (e, x) => Text('error: $e, $x'),
        loading: () => const LoadingTile(height: 200));
  }
}

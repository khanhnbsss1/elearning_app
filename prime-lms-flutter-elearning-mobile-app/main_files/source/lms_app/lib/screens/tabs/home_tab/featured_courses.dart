import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/services/api_service.dart';
import '../../../components/featured_course_tile.dart';
import '../../../services/apis/course/course_detail/models/course_detail_model.dart';

final featuredCoursesProvider = FutureProvider.autoDispose<List<CourseInfo>?>((ref) async {
  final List<CourseInfo>? courses = await ApiService().getFeaturedCourses();
  return courses;
});

class FeaturedCourses extends ConsumerWidget {
  const FeaturedCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(featuredCoursesProvider);
    return courses.when(
      skipLoadingOnRefresh: false,
      data: (courses) {
        return (courses != null && courses != []) ?
        carousel_slider.CarouselSlider(
          items: courses.map((course) {
            return FeaturedCourseTile(course: course);
          }).toList(),
          options: carousel_slider.CarouselOptions(
            height: 300,
            enableInfiniteScroll: true,
            pageSnapping: true,
            viewportFraction: 0.8,
            enlargeFactor: 0.2,
            autoPlay: true,
            enlargeCenterPage: true,
            enlargeStrategy: carousel_slider.CenterPageEnlargeStrategy.zoom,
          ),
        ) : const SizedBox();
      },
      error: (e, x) => Text('error: $e, $x'),
      loading: () => const LoadingTile(height: 260),
    );
  }
}
